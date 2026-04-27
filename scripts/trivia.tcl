# 2-clause BSD license.
#
# ============================================================================
# !trivia — Multi-round IRC trivia game using Open Trivia Database
#
# Commands:
#   !trivia      — start a game (30-second countdown, then 3 rounds of 10s)
#   !answer <n>, !a <n> — submit answer during a round
#   !triviastop  — abort a game (molo/Crossbar only)
#
# Cooldown: 30 minutes per channel. molo and Crossbar are exempt.
# Tie-break: keep asking questions; players who answer wrong are eliminated
#            until one player remains.
# ============================================================================

set triviabin          "/home/eggdrop/bin/trivia"
set trivia_rounds      3
set trivia_round_secs  20
set trivia_start_delay 30
set trivia_cooldown_secs 1800

array set trivia_active        {}
array set trivia_starting      {}
array set trivia_questions     {}
array set trivia_qindex        {}
array set trivia_round         {}
array set trivia_scores        {}
array set trivia_answered      {}
array set trivia_correct       {}
array set trivia_round_correct {}
array set trivia_tiebreak      {}
array set trivia_tienicks      {}
array set trivia_tb_noanswer   {}
array set trivia_last_game     {}

proc trivia_is_exempt {nick} {
    set exempt {molo Crossbar}
    foreach e $exempt {
        if {[string equal -nocase $nick $e]} {
            if {[llength [info procs isRegistered]] > 0} {
                return [isRegistered $nick]
            }
            return 1
        }
    }
    return 0
}

proc trivia_clear {chan} {
    global trivia_active trivia_starting trivia_questions trivia_qindex
    global trivia_round trivia_scores trivia_answered trivia_correct
    global trivia_tiebreak trivia_tienicks trivia_round_correct trivia_tb_noanswer
    set trivia_active($chan)        0
    set trivia_starting($chan)      0
    set trivia_questions($chan)     {}
    set trivia_qindex($chan)        0
    set trivia_round($chan)         0
    set trivia_scores($chan)        {}
    set trivia_answered($chan)      {}
    set trivia_correct($chan)       0
    set trivia_tiebreak($chan)      0
    set trivia_tienicks($chan)      {}
    set trivia_round_correct($chan) {}
    set trivia_tb_noanswer($chan)   0
}

proc trivia_pub {nick host hand chan text} {
    global trivia_active trivia_starting trivia_last_game
    global trivia_cooldown_secs trivia_rounds trivia_round_secs trivia_start_delay
    global hamtrivia_active hamtrivia_starting

    if {[info exists hamtrivia_active($chan)] && $hamtrivia_active($chan)} {
        putchan $chan "⚠️ A Ham Radio Trivia game is in progress. Use !a <number> to play!"
        return
    }
    if {[info exists hamtrivia_starting($chan)] && $hamtrivia_starting($chan)} {
        putchan $chan "⚠️ A Ham Radio Trivia game is starting soon. Get ready!"
        return
    }
    if {[info exists trivia_active($chan)] && $trivia_active($chan)} {
        putchan $chan "⚠️ A trivia game is already in progress. Use !a <number> to play!"
        return
    }
    if {[info exists trivia_starting($chan)] && $trivia_starting($chan)} {
        putchan $chan "⚠️ A trivia game is starting soon. Get ready!"
        return
    }

    if {![trivia_is_exempt $nick]} {
        if {[info exists trivia_last_game($chan)]} {
            set elapsed [expr {[clock seconds] - $trivia_last_game($chan)}]
            if {$elapsed < $trivia_cooldown_secs} {
                set remaining [expr {$trivia_cooldown_secs - $elapsed}]
                set nexttime [clock format [expr {[clock seconds] + $remaining}] -format "%H:%M UTC" -gmt 1]
                putchan $chan "⏳ $nick: Trivia is on cooldown. Next game allowed at $nexttime."
                return
            }
        }
    }

    trivia_clear $chan
    set trivia_starting($chan) 1
    putchan $chan "🎬 Trivia starting in ${trivia_start_delay}s! $trivia_rounds rounds, ${trivia_round_secs}s each. Type !a <number> to play."
    utimer $trivia_start_delay [list trivia_start $chan]
}

proc trivia_start {chan} {
    global triviabin trivia_starting trivia_active trivia_questions
    global trivia_qindex trivia_round trivia_last_game

    # Bail if game was cancelled during countdown
    if {![info exists trivia_starting($chan)] || !$trivia_starting($chan)} { return }
    set trivia_starting($chan) 0

    set lines {}
    if {[catch {
        set fd [open "|${triviabin} --fetch --count 10" r]
        fconfigure $fd -encoding utf-8
        while {[gets $fd line] >= 0} {
            if {$line ne ""} { lappend lines $line }
        }
        close $fd
    } err]} {
        putchan $chan "❌ Trivia error: could not fetch questions. Try again later."
        putlog "trivia_start error: $err"
        return
    }

    if {[llength $lines] == 0} {
        putchan $chan "❌ Trivia error: no questions returned. Try again later."
        return
    }

    set trivia_active($chan)    1
    set trivia_questions($chan) $lines
    set trivia_qindex($chan)    0
    set trivia_round($chan)     1
    set trivia_last_game($chan) [clock seconds]

    trivia_ask $chan
}

proc trivia_ask {chan} {
    global trivia_questions trivia_qindex trivia_correct trivia_answered trivia_round_correct
    global trivia_round trivia_rounds trivia_round_secs trivia_tiebreak trivia_tienicks

    set qlist $trivia_questions($chan)
    set idx   $trivia_qindex($chan)

    if {$idx >= [llength $qlist]} {
        # Ran out of questions (shouldn't happen with 10 fetched)
        putchan $chan "❌ Trivia: ran out of questions. Game over!"
        trivia_end_game $chan
        return
    }

    set line [lindex $qlist $idx]
    incr trivia_qindex($chan)

    set parts   [split $line "|"]
    set correct [lindex $parts 0]
    set question [lindex $parts 1]
    set options  [lrange $parts 2 end]

    set trivia_correct($chan)       $correct
    set trivia_answered($chan)     {}
    set trivia_round_correct($chan) {}

    if {$trivia_tiebreak($chan)} {
        set label "⚡ Tiebreaker (still in: [join $trivia_tienicks($chan) {, }])"
    } else {
        set label "❓ Round $trivia_round($chan)/$trivia_rounds"
    }

    putchan $chan "\002$label\002 — $question"

    set i 1
    set optline ""
    foreach opt $options {
        append optline "  \002${i})\002 $opt"
        incr i
    }
    putchan $chan $optline

    utimer $trivia_round_secs [list trivia_round_end $chan]
}

proc trivia_answer_pub {nick host hand chan text} {
    global trivia_active trivia_tiebreak trivia_tienicks
    global trivia_answered trivia_correct trivia_scores trivia_questions trivia_round_correct trivia_qindex

    if {![info exists trivia_active($chan)] || !$trivia_active($chan)} { return }

    if {$trivia_tiebreak($chan)} {
        if {[lsearch -exact $trivia_tienicks($chan) $nick] == -1} { return }
    }

    if {[lsearch -exact $trivia_answered($chan) $nick] != -1} {
        putchan $chan "$nick: you already answered this round!"
        return
    }

    set ans [string trim $text]
    if {![string is integer -strict $ans] || $ans < 1} {
        putchan $chan "$nick: please answer with a number (e.g. !a 2)"
        return
    }

    set parts   [split [lindex $trivia_questions($chan) [expr {$trivia_qindex($chan) - 1}]] "|"]
    set nopts   [expr {[llength $parts] - 2}]
    if {$ans > $nopts} {
        putchan $chan "$nick: answer must be between 1 and $nopts"
        return
    }

    lappend trivia_answered($chan) $nick

    if {$ans == $trivia_correct($chan)} {
        if {![dict exists $trivia_scores($chan) $nick]} {
            set trivia_scores($chan) [dict set trivia_scores($chan) $nick 0]
        }
        dict incr trivia_scores($chan) $nick
        lappend trivia_round_correct($chan) $nick
    }
}

proc trivia_round_end {chan} {
    global trivia_correct trivia_questions trivia_qindex trivia_round trivia_rounds
    global trivia_tiebreak trivia_answered trivia_scores trivia_active

    # Bail if game was stopped while this timer was pending
    if {![info exists trivia_active($chan)] || !$trivia_active($chan)} { return }

    set parts   [split [lindex $trivia_questions($chan) [expr {$trivia_qindex($chan) - 1}]] "|"]
    set correct $trivia_correct($chan)
    set answer  [lindex $parts [expr {$correct + 1}]]

    putchan $chan "⏰ Time! The correct answer was \002${correct}) ${answer}\002."

    if {$trivia_tiebreak($chan)} {
        trivia_tiebreaker_eval $chan
        return
    }

    incr trivia_round($chan)
    if {$trivia_round($chan) <= $trivia_rounds} {
        utimer 3 [list trivia_ask $chan]
    } else {
        trivia_end_game $chan
    }
}

proc trivia_end_game {chan} {
    global trivia_scores

    set scores $trivia_scores($chan)

    if {[dict size $scores] == 0} {
        putchan $chan "Game over! No one scored any points. Better luck next time."
        trivia_clear $chan
        return
    }

    set pairs {}
    dict for {nick score} $scores { lappend pairs [list $nick $score] }
    set pairs [lsort -integer -decreasing -index 1 $pairs]

    set board ""
    set place 1
    foreach p $pairs {
        set n [lindex $p 0]
        set s [lindex $p 1]
        append board " | ${place}. $n: $s"
        incr place
    }
    putchan $chan "📊 Final scores: [string range $board 3 end]"

    set maxscore [lindex [lindex $pairs 0] 1]
    set winners {}
    foreach p $pairs {
        if {[lindex $p 1] == $maxscore} { lappend winners [lindex $p 0] }
    }

    if {[llength $winners] == 1} {
        putchan $chan "🏆 Winner: \002[lindex $winners 0]\002! Congratulations!"
        trivia_clear $chan
    } else {
        putchan $chan "🤝 It's a tie between: \002[join $winners {, }]\002! Starting tiebreaker..."
        global trivia_tiebreak trivia_tienicks
        set trivia_tiebreak($chan)  1
        set trivia_tienicks($chan)  $winners
        utimer 3 [list trivia_ask $chan]
    }
}

proc trivia_tiebreaker_eval {chan} {
    global trivia_tienicks trivia_round_correct trivia_tb_noanswer trivia_answered

    set correct_nicks $trivia_round_correct($chan)

    # Determine who is eliminated (in tiebreaker pool but did not answer correctly)
    set eliminated {}
    foreach nick $trivia_tienicks($chan) {
        if {[lsearch -exact $correct_nicks $nick] == -1} {
            lappend eliminated $nick
        }
    }

    # If nobody is eliminated (all correct or all wrong), ask another question
    if {[llength $eliminated] == 0 || [llength $eliminated] == [llength $trivia_tienicks($chan)]} {
        if {[llength $correct_nicks] == 0} {
            if {[llength $trivia_answered($chan)] == 0} {
                # Nobody answered at all
                incr trivia_tb_noanswer($chan)
                if {$trivia_tb_noanswer($chan) >= 2} {
                    putchan $chan "🤝 Nobody answered for 2 rounds. It's a draw between: \002[join $trivia_tienicks($chan) {, }]\002!"
                    trivia_clear $chan
                    return
                }
                putchan $chan "😴 Nobody answered — no change! Another tiebreaker..."
            } else {
                # Everyone answered wrong — ask another question
                putchan $chan "💀 Nobody answered correctly — no change! Another tiebreaker..."
            }
        } else {
            set trivia_tb_noanswer($chan) 0
            putchan $chan "🎯 Everyone answered correctly — no change! Another tiebreaker..."
        }
        utimer 3 [list trivia_ask $chan]
        return
    }

    set trivia_tb_noanswer($chan) 0

    # Remove eliminated players from tiebreaker pool
    foreach nick $eliminated {
        set idx [lsearch -exact $trivia_tienicks($chan) $nick]
        if {$idx != -1} {
            set trivia_tienicks($chan) [lreplace $trivia_tienicks($chan) $idx $idx]
        }
    }

    putchan $chan "❌ Eliminated: [join $eliminated {, }]."

    if {[llength $trivia_tienicks($chan)] == 1} {
        putchan $chan "🏆 Winner: \002[lindex $trivia_tienicks($chan) 0]\002! Congratulations!"
        trivia_clear $chan
    } else {
        putchan $chan "🤝 Still tied: \002[join $trivia_tienicks($chan) {, }]\002. Another tiebreaker..."
        utimer 3 [list trivia_ask $chan]
    }
}

proc trivia_stop_pub {nick host hand chan text} {
    global trivia_active trivia_starting
    if {![trivia_is_exempt $nick]} {
        putchan $chan "🚫 $nick: only molo or Crossbar can stop a trivia game."
        return
    }
    if {([info exists trivia_active($chan)] && $trivia_active($chan)) ||
        ([info exists trivia_starting($chan)] && $trivia_starting($chan))} {
        trivia_clear $chan
        putchan $chan "🛑 Trivia stopped by $nick."
    } else {
        putchan $chan "No trivia game is running."
    }
}

bind pub - !trivia     trivia_pub
bind pub - !answer     trivia_answer_pub
bind pub - !a          trivia_answer_pub
bind pub - !triviastop trivia_stop_pub


# ============================================================================
# !hamtrivia — Multi-round IRC trivia game using FCC amateur radio exam questions
#
# Commands:
#   !hamtrivia      — start a game (30-second countdown, then 3 rounds of 20s)
#   !answer <n>, !a <n> — submit answer during a round
#   !hamtriviastop  — abort a game (molo/Crossbar only)
#
# Cooldown: 30 minutes per channel. molo and Crossbar are exempt.
# Tie-break: keep asking questions; players who answer wrong are eliminated
#            until one player remains.
# Questions sourced from Technician, General, and Extra pools; figure questions
# are excluded since diagrams cannot be shown in IRC.
# ============================================================================

set hamtriviabin            "/home/eggdrop/bin/hamtrivia"
set hamtrivia_rounds        3
set hamtrivia_round_secs    20
set hamtrivia_start_delay   30
set hamtrivia_cooldown_secs 1800

array set hamtrivia_active        {}
array set hamtrivia_starting      {}
array set hamtrivia_questions     {}
array set hamtrivia_qindex        {}
array set hamtrivia_round         {}
array set hamtrivia_scores        {}
array set hamtrivia_answered      {}
array set hamtrivia_correct       {}
array set hamtrivia_round_correct {}
array set hamtrivia_tiebreak      {}
array set hamtrivia_tienicks      {}
array set hamtrivia_tb_noanswer   {}
array set hamtrivia_last_game     {}

proc hamtrivia_clear {chan} {
    global hamtrivia_active hamtrivia_starting hamtrivia_questions hamtrivia_qindex
    global hamtrivia_round hamtrivia_scores hamtrivia_answered hamtrivia_correct
    global hamtrivia_tiebreak hamtrivia_tienicks hamtrivia_round_correct hamtrivia_tb_noanswer
    set hamtrivia_active($chan)        0
    set hamtrivia_starting($chan)      0
    set hamtrivia_questions($chan)     {}
    set hamtrivia_qindex($chan)        0
    set hamtrivia_round($chan)         0
    set hamtrivia_scores($chan)        {}
    set hamtrivia_answered($chan)      {}
    set hamtrivia_correct($chan)       0
    set hamtrivia_tiebreak($chan)      0
    set hamtrivia_tienicks($chan)      {}
    set hamtrivia_round_correct($chan) {}
    set hamtrivia_tb_noanswer($chan)   0
}

proc hamtrivia_pub {nick host hand chan text} {
    global hamtrivia_active hamtrivia_starting hamtrivia_last_game
    global hamtrivia_cooldown_secs hamtrivia_rounds hamtrivia_round_secs hamtrivia_start_delay
    global trivia_active trivia_starting

    if {[info exists trivia_active($chan)] && $trivia_active($chan)} {
        putchan $chan "⚠️ A trivia game is already in progress. Use !a <number> to play!"
        return
    }
    if {[info exists trivia_starting($chan)] && $trivia_starting($chan)} {
        putchan $chan "⚠️ A trivia game is starting soon. Get ready!"
        return
    }
    if {[info exists hamtrivia_active($chan)] && $hamtrivia_active($chan)} {
        putchan $chan "⚠️ A Ham Radio Trivia game is already in progress. Use !a <number> to play!"
        return
    }
    if {[info exists hamtrivia_starting($chan)] && $hamtrivia_starting($chan)} {
        putchan $chan "⚠️ A Ham Radio Trivia game is starting soon. Get ready!"
        return
    }

    if {![trivia_is_exempt $nick]} {
        if {[info exists hamtrivia_last_game($chan)]} {
            set elapsed [expr {[clock seconds] - $hamtrivia_last_game($chan)}]
            if {$elapsed < $hamtrivia_cooldown_secs} {
                set remaining [expr {$hamtrivia_cooldown_secs - $elapsed}]
                set nexttime [clock format [expr {[clock seconds] + $remaining}] -format "%H:%M UTC" -gmt 1]
                putchan $chan "⏳ $nick: Ham Radio Trivia is on cooldown. Next game allowed at $nexttime."
                return
            }
        }
    }

    hamtrivia_clear $chan
    set hamtrivia_starting($chan) 1
    putchan $chan "📡 Ham Radio Trivia starting in ${hamtrivia_start_delay}s! $hamtrivia_rounds rounds, ${hamtrivia_round_secs}s each. Type !a <number> to answer."
    utimer $hamtrivia_start_delay [list hamtrivia_start $chan]
}

proc hamtrivia_start {chan} {
    global hamtriviabin hamtrivia_starting hamtrivia_active hamtrivia_questions
    global hamtrivia_qindex hamtrivia_round hamtrivia_last_game

    if {![info exists hamtrivia_starting($chan)] || !$hamtrivia_starting($chan)} { return }
    set hamtrivia_starting($chan) 0

    set lines {}
    if {[catch {
        set fd [open "|${hamtriviabin} --fetch --count 10" r]
        fconfigure $fd -encoding utf-8
        while {[gets $fd line] >= 0} {
            if {$line ne ""} { lappend lines $line }
        }
        close $fd
    } err]} {
        putchan $chan "❌ Ham Radio Trivia error: could not fetch questions. Try again later."
        putlog "hamtrivia_start error: $err"
        return
    }

    if {[llength $lines] == 0} {
        putchan $chan "❌ Ham Radio Trivia error: no questions returned. Try again later."
        return
    }

    set hamtrivia_active($chan)    1
    set hamtrivia_questions($chan) $lines
    set hamtrivia_qindex($chan)    0
    set hamtrivia_round($chan)     1
    set hamtrivia_last_game($chan) [clock seconds]

    hamtrivia_ask $chan
}

proc hamtrivia_ask {chan} {
    global hamtrivia_questions hamtrivia_qindex hamtrivia_correct hamtrivia_answered hamtrivia_round_correct
    global hamtrivia_round hamtrivia_rounds hamtrivia_round_secs hamtrivia_tiebreak hamtrivia_tienicks

    set qlist $hamtrivia_questions($chan)
    set idx   $hamtrivia_qindex($chan)

    if {$idx >= [llength $qlist]} {
        putchan $chan "❌ Ham Radio Trivia: ran out of questions. Game over!"
        hamtrivia_end_game $chan
        return
    }

    set line [lindex $qlist $idx]
    incr hamtrivia_qindex($chan)

    set parts    [split $line "|"]
    set correct  [lindex $parts 0]
    set question [lindex $parts 1]
    set options  [lrange $parts 2 end]

    set hamtrivia_correct($chan)       $correct
    set hamtrivia_answered($chan)      {}
    set hamtrivia_round_correct($chan) {}

    if {$hamtrivia_tiebreak($chan)} {
        set label "⚡ Tiebreaker (still in: [join $hamtrivia_tienicks($chan) {, }])"
    } else {
        set label "📡 Round $hamtrivia_round($chan)/$hamtrivia_rounds"
    }

    putchan $chan "\002$label\002 — $question"

    set i 1
    set optline ""
    foreach opt $options {
        append optline "  \002${i})\002 $opt"
        incr i
    }
    putchan $chan $optline

    utimer $hamtrivia_round_secs [list hamtrivia_round_end $chan]
}

proc hamtrivia_answer_pub {nick host hand chan text} {
    global hamtrivia_active hamtrivia_tiebreak hamtrivia_tienicks
    global hamtrivia_answered hamtrivia_correct hamtrivia_scores hamtrivia_questions hamtrivia_round_correct hamtrivia_qindex
    global trivia_active

    if {[info exists trivia_active($chan)] && $trivia_active($chan)} {
        trivia_answer_pub $nick $host $hand $chan $text
        return
    }

    if {![info exists hamtrivia_active($chan)] || !$hamtrivia_active($chan)} { return }

    if {$hamtrivia_tiebreak($chan)} {
        if {[lsearch -exact $hamtrivia_tienicks($chan) $nick] == -1} { return }
    }

    if {[lsearch -exact $hamtrivia_answered($chan) $nick] != -1} {
        putchan $chan "$nick: you already answered this round!"
        return
    }

    set ans [string trim $text]
    if {![string is integer -strict $ans] || $ans < 1} {
        putchan $chan "$nick: please answer with a number (e.g. !a 2)"
        return
    }

    set parts [split [lindex $hamtrivia_questions($chan) [expr {$hamtrivia_qindex($chan) - 1}]] "|"]
    set nopts [expr {[llength $parts] - 2}]
    if {$ans > $nopts} {
        putchan $chan "$nick: answer must be between 1 and $nopts"
        return
    }

    lappend hamtrivia_answered($chan) $nick

    if {$ans == $hamtrivia_correct($chan)} {
        if {![dict exists $hamtrivia_scores($chan) $nick]} {
            set hamtrivia_scores($chan) [dict set hamtrivia_scores($chan) $nick 0]
        }
        dict incr hamtrivia_scores($chan) $nick
        lappend hamtrivia_round_correct($chan) $nick
    }
}

proc hamtrivia_round_end {chan} {
    global hamtrivia_correct hamtrivia_questions hamtrivia_qindex hamtrivia_round hamtrivia_rounds
    global hamtrivia_tiebreak hamtrivia_answered hamtrivia_scores hamtrivia_active

    if {![info exists hamtrivia_active($chan)] || !$hamtrivia_active($chan)} { return }

    set parts   [split [lindex $hamtrivia_questions($chan) [expr {$hamtrivia_qindex($chan) - 1}]] "|"]
    set correct $hamtrivia_correct($chan)
    set answer  [lindex $parts [expr {$correct + 1}]]

    putchan $chan "⏰ Time! The correct answer was \002${correct}) ${answer}\002."

    if {$hamtrivia_tiebreak($chan)} {
        hamtrivia_tiebreaker_eval $chan
        return
    }

    incr hamtrivia_round($chan)
    if {$hamtrivia_round($chan) <= $hamtrivia_rounds} {
        utimer 3 [list hamtrivia_ask $chan]
    } else {
        hamtrivia_end_game $chan
    }
}

proc hamtrivia_end_game {chan} {
    global hamtrivia_scores

    set scores $hamtrivia_scores($chan)

    if {[dict size $scores] == 0} {
        putchan $chan "Game over! No one scored. Study that question pool and try again!"
        hamtrivia_clear $chan
        return
    }

    set pairs {}
    dict for {nick score} $scores { lappend pairs [list $nick $score] }
    set pairs [lsort -integer -decreasing -index 1 $pairs]

    set board ""
    set place 1
    foreach p $pairs {
        set n [lindex $p 0]
        set s [lindex $p 1]
        append board " | ${place}. $n: $s"
        incr place
    }
    putchan $chan "📊 Final scores: [string range $board 3 end]"

    set maxscore [lindex [lindex $pairs 0] 1]
    set winners {}
    foreach p $pairs {
        if {[lindex $p 1] == $maxscore} { lappend winners [lindex $p 0] }
    }

    if {[llength $winners] == 1} {
        putchan $chan "🏆 Winner: \002[lindex $winners 0]\002! Elmer of the day! 73!"
        hamtrivia_clear $chan
    } else {
        putchan $chan "🤝 It's a tie between: \002[join $winners {, }]\002! Starting tiebreaker..."
        global hamtrivia_tiebreak hamtrivia_tienicks
        set hamtrivia_tiebreak($chan) 1
        set hamtrivia_tienicks($chan) $winners
        utimer 3 [list hamtrivia_ask $chan]
    }
}

proc hamtrivia_tiebreaker_eval {chan} {
    global hamtrivia_tienicks hamtrivia_round_correct hamtrivia_tb_noanswer hamtrivia_answered

    set correct_nicks $hamtrivia_round_correct($chan)

    set eliminated {}
    foreach nick $hamtrivia_tienicks($chan) {
        if {[lsearch -exact $correct_nicks $nick] == -1} {
            lappend eliminated $nick
        }
    }

    if {[llength $eliminated] == 0 || [llength $eliminated] == [llength $hamtrivia_tienicks($chan)]} {
        if {[llength $correct_nicks] == 0} {
            if {[llength $hamtrivia_answered($chan)] == 0} {
                incr hamtrivia_tb_noanswer($chan)
                if {$hamtrivia_tb_noanswer($chan) >= 2} {
                    putchan $chan "🤝 Nobody answered for 2 rounds. It's a draw between: \002[join $hamtrivia_tienicks($chan) {, }]\002!"
                    hamtrivia_clear $chan
                    return
                }
                putchan $chan "😴 Nobody answered — no change! Another tiebreaker..."
            } else {
                putchan $chan "💀 Nobody answered correctly — no change! Another tiebreaker..."
            }
        } else {
            set hamtrivia_tb_noanswer($chan) 0
            putchan $chan "🎯 Everyone answered correctly — no change! Another tiebreaker..."
        }
        utimer 3 [list hamtrivia_ask $chan]
        return
    }

    set hamtrivia_tb_noanswer($chan) 0

    foreach nick $eliminated {
        set idx [lsearch -exact $hamtrivia_tienicks($chan) $nick]
        if {$idx != -1} {
            set hamtrivia_tienicks($chan) [lreplace $hamtrivia_tienicks($chan) $idx $idx]
        }
    }

    putchan $chan "❌ Eliminated: [join $eliminated {, }]."

    if {[llength $hamtrivia_tienicks($chan)] == 1} {
        putchan $chan "🏆 Winner: \002[lindex $hamtrivia_tienicks($chan) 0]\002! Elmer of the day! 73!"
        hamtrivia_clear $chan
    } else {
        putchan $chan "🤝 Still tied: \002[join $hamtrivia_tienicks($chan) {, }]\002. Another tiebreaker..."
        utimer 3 [list hamtrivia_ask $chan]
    }
}

proc hamtrivia_stop_pub {nick host hand chan text} {
    global hamtrivia_active hamtrivia_starting
    if {![trivia_is_exempt $nick]} {
        putchan $chan "🚫 $nick: only molo or Crossbar can stop a Ham Radio Trivia game."
        return
    }
    if {([info exists hamtrivia_active($chan)] && $hamtrivia_active($chan)) ||
        ([info exists hamtrivia_starting($chan)] && $hamtrivia_starting($chan))} {
        hamtrivia_clear $chan
        putchan $chan "🛑 Ham Radio Trivia stopped by $nick."
    } else {
        putchan $chan "No Ham Radio Trivia game is running."
    }
}

bind pub - !hamtrivia     hamtrivia_pub
bind pub - !a             hamtrivia_answer_pub
bind pub - !answer        hamtrivia_answer_pub
bind pub - !hamtriviastop hamtrivia_stop_pub


