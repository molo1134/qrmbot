# Keep track of which nicks are registered.  Suitable for undernet-style
# networks.
#
# 2-clause BSD license.
# Copyright (c) 2018 molo1134@github. All rights reserved.

if { ${net-type} == 2 } {
  # only for undernet type networks
  bind join - * reg_onjoin
  bind nick - * reg_nickchange
  bind raw - 352 rpl_whoreply
  bind notc - "*is not registered*" nickserv_notreg
  bind notc - "Information on *" nickserv_reg
}

# wait this long after a rename or a join to check status
set regdelay 65

# init
if { [info exist registerednicks] == 0 } {
  set registerednicks {}
}

proc discover_nick_reg_timer {nick} {
  global regdelay
  global reg_nick_detect_mode

  if [string equal -nocase "$reg_nick_detect_mode" "who_r"] then {
    utimer $regdelay "putserv {WHO $nick}"
  } elseif [string equal -nocase "$reg_nick_detect_mode" "nickserv_info"] then {
    utimer $regdelay "putserv {PRIVMSG nickserv :info $nick}"
  }
}

proc reg_onjoin {nick uhost hand chan} {
  putlog "join: $chan $nick"

  discover_nick_reg_timer "$nick"
}

proc reg_nickchange {nick uhost hand chan newnick} {
  putlog "nick change: $chan $nick $newnick"
  delFromRegistered "$nick"

  discover_nick_reg_timer "$nick"
}

proc rpl_whoreply {from cmd text} {
  global registerednicks
  #putlog "whoreply called; from: $from cmd: $cmd text: $text"
  set repl [split $text " "]
  #putlog [concat "reply 0: " [lindex $repl 0]]
  #putlog [concat "reply 1: " [lindex $repl 1]]
  #putlog [concat "reply 2: " [lindex $repl 2]]
  #putlog [concat "reply 3: " [lindex $repl 3]]
  #putlog [concat "reply 4: " [lindex $repl 4]]
  #putlog [concat "reply 5: " [lindex $repl 5]]
  #putlog [concat "reply 6: " [lindex $repl 6]]
  #putlog [concat "reply 7: " [lindex $repl 7]]
  #putlog [concat "reply 8: " [lindex $repl 8]]
  set isregistered [string match {*r*} [lindex $repl 6]]
  set nick [lindex $repl 5]
  #putlog "whoreply: $nick is registered? $isregistered"

  if { $isregistered == 0 } {
    return
  }

  if { [lsearch -exact $registerednicks "$nick"] == -1 } {
    lappend registerednicks "$nick"
    putlog "noted registered nick: $nick"
  }
}

proc delFromRegistered {nick} {
  global registerednicks
  set index [lsearch -exact $registerednicks "$nick"]
  if { $index != -1 } {
    # delete from list
    putlog "removing registered nick: $nick #$index"
    set registerednicks [lreplace $registerednicks $index $index]
  }
}

proc isRegistered {nick} {
  global registerednicks
  set retval [expr [lsearch -exact $registerednicks "$nick"] != -1 ]
  #putlog [concat "lsearch: " [lsearch -exact $registerednicks "$nick"]]
  #putlog "registerednicks: $registerednicks"
  putlog "is $nick registered? $retval"
  return $retval
}

proc nickserv_notreg { nick host hand text dest } {
  putlog "nickserv_notreg: called"
  if ![string equal -nocase "$nick" "nickserv"] then { return }
  set text [sanitize_string [string trim "${text}"]]
  set text [regsub -all {[\x00-\x1F]} "${text}" ""]
  set returnedNick [lindex $text 0]

  putlog "nickserv_notreg: $returnedNick is not registered"
  return
}

proc nickserv_reg { nick host hand text dest } {
  global registerednicks
  putlog "nickserv_reg: called"
  if ![string equal -nocase "$nick" "nickserv"] then { return }
  set text [sanitize_string [string trim "${text}"]]
  set text [regsub -all {[\x00-\x1F]} "${text}" ""]
  set returnedNick [lindex $text 2]

  putlog "nickserv_reg: $returnedNick is registered"

  if { [lsearch -exact $registerednicks "$returnedNick"] == -1 } {
    lappend registerednicks "$returnedNick"
    putlog "noted registered nick: $returnedNick"
  }
}


bind flud - * ignore_nickserv_flood
proc ignore_nickserv_flood {nick uhost hand type chan} {
    # Check if the flooding nickname matches the one you want to ignore
    if {[string tolower $nick] == [string tolower "nickserv"]} {
        # Return 1 to suppress/ignore the flood penalty
        return 1
    }

    # Return 0 to allow normal anti-flood punishment for everyone else
    return 0
}


bind join - * scan_channel_on_join
proc scan_channel_on_join {nick uhost hand chan} {
  global botnick
  global reg_nick_detect_mode
  set delay_seconds 15

  # if nickserv_info is not the mode, then skip this
  if ![string equal -nocase "$reg_nick_detect_mode" "nickserv_info"] then { return 0 }

  # Check if the nickname joining is actually the bot itself
  if {$nick eq $botnick} {
    putlog "Bot joined $chan. Starting user scan after $delay_seconds seconds..."

    utimer $delay_seconds [list delayed_scan $chan]
  }
  return 0
}

proc delayed_scan {chan} {
  global botnick
  global regdelay

  # Ensure the bot is still actually in the channel before scanning
  if {![validchan $chan] || ![onchan $botnick $chan]} { return 0 }

  # the list of all nicknames currently in the channel
  set current_users [chanlist $chan]
  set delay $regdelay

  putlog "number of members on $chan: [llength $current_users]"

  foreach user $current_users {
    # Skip the bot itself so it doesn't scan its own profile
    if {$user eq $botnick} { continue }

    # add a timer to check whether the nick is registered via nickserv
    utimer $delay "putserv {PRIVMSG nickserv :info $user}"
    set delay [expr $delay + 2]
  }
  return 0
}
