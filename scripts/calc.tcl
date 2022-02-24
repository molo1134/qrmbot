# Use GNU bc as calculator
#
# 2-clause BSD license.
# Copyright (c) 2020,2022 molo1134@github. All rights reserved.

# prevent blocking on input and looping, but don't mess up variable names
proc sanitize_bc {text} {
  regsub -all "read" $text "rd" text
  regsub -all "while" $text "wh" text
  regsub -all "for" $text "fr" text
  return $text
}

bind msg - !calc msg_calc
bind pub - !calc pub_calc

proc msg_calc {nick uhand handle arg} {
  if {![info exists arg]} {
    putmsg "$nick" "syntax: !calc <expression>"
    return
  }
  set term [sanitize_string $arg]
  set expression [sanitize_bc $term]
  putlog "calc msg: $nick $uhand $handle $expression"
  set fd [open "| ulimit -t 5 ; echo \"${expression}\" | /usr/bin/bc -l  2>@1" r]
  fconfigure $fd -encoding utf-8
  while {[gets $fd line] >= 0} {
    putmsg "$nick" "$line"
  }
}

proc pub_calc { nick host hand chan text } {
  if {![info exists text]} {
    putchan $chan "syntax: !calc <expression>"
    return
  }
  set term [sanitize_string $text]
  set expression [sanitize_bc $term]
  putlog "calc pub: $nick $host $hand $chan $expression"
  set fd [open "| ulimit -t 5 ; echo \"${expression}\" | /usr/bin/bc -l  2>@1" r]
  fconfigure $fd -encoding utf-8
  while {[gets $fd line] >= 0} {
    putchan $chan "$line"
  }
}
