# a simple seen script
#
# 2-clause BSD license.
# Copyright (c) 2018, 2019 molo1134@github. All rights reserved.

# Returns: number of minutes that person has been idle; 0 if the specified user
# isn't on the channel
#getchanidle <nick> <channel>

# returns a list containing the unixtime last seen and the last seen place.
# LASTON #channel returns the time last seen time for the channel or 0 if no
# info exists.
#getuser <handle> LASTON

bind pub - !seen seen_pub

# record all public messages to a per-nick file and record joins/parts/signs
# to a separate actions file. Each line is in the format:
# <nick>|<unix timestamp>|<channel>|<message or action>
# The per-nick record is overwritten on each new event for that nick.
bind pubm - "*" seen_record_pub
bind join - "*" seen_join
bind part - "*" seen_part
bind sign - "*" seen_quit
bind nick - "*" seen_nick

proc _seen_file_paths {} {
    # place the database files next to this script
    set scriptdir [file dirname [info script]]
    set pubfile [file join $scriptdir "seen_public.db"]
    set actfile [file join $scriptdir "seen_action.db"]
    return [list $pubfile $actfile]
}

proc _seen_update_entry {file nick entry} {
    # read existing lines, omit any for this nick, then append the new entry
    set lower [string tolower $nick]
    set lines {}
    if {[file exists $file]} {
        set fh [open $file r]
        while {[gets $fh line] >= 0} {
            if {$line eq ""} continue
            set parts [split $line "|"]
            if {[string tolower [lindex $parts 0]] ne $lower} {
                lappend lines $line
            }
        }
        close $fh
    }
    lappend lines $entry
    set fh [open $file w]
    foreach l $lines {
        puts $fh $l
    }
    close $fh
}

proc _seen_get_record {file target} {
    if {![file exists $file]} { return "" }
    set fh [open $file r]
    set lower [string tolower $target]
    while {[gets $fh line] >= 0} {
        if {$line eq ""} continue
        set parts [split $line "|"]
        if {[string tolower [lindex $parts 0]] eq $lower} {
            close $fh
            return $line
        }
    }
    close $fh
    return ""
}

proc seen_record_pub { nick host hand chan text } {
    # sanitize inputs before use
    set snick [sanitize_string $nick]
    set schan [sanitize_string $chan]
    set msg [sanitize_string [string trim $text]]

    # record the last public message for this nick
    set now [clock seconds]
    set scriptfiles [_seen_file_paths]
    set pubfile [lindex $scriptfiles 0]
    set entry "${snick}|${now}|${schan}|${msg}"
    _seen_update_entry $pubfile $snick $entry
}

proc seen_join { nick host hand chan } {
    # sanitize inputs before use
    set snick [sanitize_string $nick]
    set schan [sanitize_string $chan]

    # record join as an action
    set now [clock seconds]
    set scriptfiles [_seen_file_paths]
    set actfile [lindex $scriptfiles 1]
    set entry "${snick}|${now}|${schan}|joined"
    _seen_update_entry $actfile $snick $entry
}

proc seen_part { nick host hand chan reason } {
    # sanitize inputs before use
    set snick [sanitize_string $nick]
    set schan [sanitize_string $chan]
    set r [sanitize_string [string trim $reason]]
    if {$r eq ""} { set r "parted" }

    set now [clock seconds]
    set scriptfiles [_seen_file_paths]
    set actfile [lindex $scriptfiles 1]
    set entry "${snick}|${now}|${schan}|parted: ${r}"
    _seen_update_entry $actfile $snick $entry
}

proc seen_quit { nick host hand reason } {
    # sanitize inputs before use
    set snick [sanitize_string $nick]
    set r [sanitize_string [string trim $reason]]
    if {$r eq ""} { set r "quit" }

    # sign (quit) typically has no single channel; record channel as "-"
    set now [clock seconds]
    set scriptfiles [_seen_file_paths]
    set actfile [lindex $scriptfiles 1]
    set entry "${snick}|${now}|-|quit: ${r}"
    _seen_update_entry $actfile $snick $entry
}

proc seen_nick { oldnick newnick host hand } {
    # sanitize inputs
    set sold [sanitize_string $oldnick]
    set snew [sanitize_string $newnick]
    putlog "seen nick: $sold -> $snew"
    # Record a new action for the (old) nick indicating the change (do NOT
    # rewrite prior records for the old nick).
    set now [clock seconds]
    set scriptfiles [_seen_file_paths]
    set actfile [lindex $scriptfiles 1]
    set entry "${sold}|${now}|-|${sold} changed nick to ${snew}"
    _seen_update_entry $actfile $sold $entry
}

proc seen_pub { nick host hand chan text } {
    global botnick
    putlog "seen pub: $nick $host $hand $chan $text"
    set origQuery [sanitize_string [string trim "${text}"]]
    set target [string tolower $origQuery]
    set nick [string tolower "$nick"]

    if {${target} == ${nick}} {
        putchan $chan "welp, there you are."
        return
    }
    if {${target} == [string tolower ${botnick}] } {
        putchan $chan "http://youtu.be/JHAc9nw2qrs?t=381"
        return
    }

    # If the target is on the channel, keep previous idle behavior
    if { [onchan ${target} $chan] } {
        set idle [getchanidle ${target} $chan]
        set d [expr ($idle / 1440) ]
        set h [expr (($idle % 1440) / 60) ]
        set m [expr ($idle % 60) ]
        set desc ""
        if { $d > 0 } {
            append desc "${d}d "
        }
        if { $d > 0 || $h > 0 } {
            append desc "${h}h "
        }
        append desc "${m}m "
        putchan $chan "${origQuery} idle ${desc}"
        return
    }

    # Otherwise look up last public message and last action from the record files
    set scriptfiles [_seen_file_paths]
    set pubfile [lindex $scriptfiles 0]
    set actfile [lindex $scriptfiles 1]

    set publine [_seen_get_record $pubfile $origQuery]
    set actline [_seen_get_record $actfile $origQuery]

    if {$publine eq "" && $actline eq ""} {
        putchan $chan "${origQuery} not found"
        return
    }

    # helper to parse a line into a dict
    proc _parse_line {line} {
        set parts [split $line "|"]
        # nick|timestamp|channel|message
        dict create nick [lindex $parts 0] time [lindex $parts 1] chan [lindex $parts 2] msg [lindex $parts 3]
    }

    set bestLine ""
    if {$publine ne "" && $actline ne ""} {
        set pparts [split $publine "|"]
        set aparts [split $actline "|"]
        set ptime [expr {int([lindex $pparts 1])}]
        set atime [expr {int([lindex $aparts 1])}]
        if {$ptime >= $atime} { set bestLine $publine } else { set bestLine $actline }
    } elseif {$publine ne ""} {
        set bestLine $publine
    } else {
        set bestLine $actline
    }

    set parsed [_parse_line $bestLine]
    set stamp [clock format [dict get $parsed time] -gmt 1 -format "%Y-%m-%d %H:%M:%S %Z"]
    set recchan [dict get $parsed chan]
    set recmsg [dict get $parsed msg]
    putchan $chan "${origQuery} last seen at $stamp in $recchan: $recmsg"
}
