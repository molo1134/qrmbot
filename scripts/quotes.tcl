# Maintain a quote list
#
# 2-clause BSD license.
# Copyright (c) 2018, 2019, 2020 molo1134@github. All rights reserved.

#bind pub o|o !addquote q_addquote
bind pub - !addquote q_addquote
bind pub - !quote q_pubquote
bind pub - !quotesearch q_pubquotesearch
bind pub - !pebus q_pebus

proc q_addquote { nick uhost hand chan arg } {
  set quotefile "quotelist-$chan"

  putlog "addquote pub: $nick $uhost $hand $chan"

  set newarg [string trim "$arg"]
  if { [string length "$newarg"] == 0 } {
    putchan $chan "usage: !addquote <msg>"
    return
  }

  if { [file exists $quotefile] } {
    set qf [open $quotefile a]
  } else {
    set qf [open $quotefile w]
  }
  fconfigure $qf -encoding utf-8

  set entry [list]
  lappend entry "$arg"

  puts $qf $entry

  putmsg "$nick" "added quote for $chan: $arg"

  close $qf
}


proc q_pubquote { nick uhost hand chan arg } {
  set quotefile "quotelist-$chan"

  putlog "quote pub: $nick $uhost $hand $chan"

  if { [file exists $quotefile] } {

    set qf [open $quotefile r]
    fconfigure $qf -encoding utf-8

    set fd [open "|wc -l $quotefile" r]
    while {![eof $fd]} {
      scan [gets $fd] " %d " tmp
      if {[eof $fd]} {break}
    }
    close $fd

    if { $tmp == 0 } {
      putchan $chan "no quotes recorded for $chan"
      return
    }

    set i 0

    if { ! [string is integer -strict [string trim "$arg"]] } {
      set j [rand $tmp]
      #putmsg "$nick" "picked quote [expr $j + 1] of $tmp"
    } else {
      set j "$arg"
      if { ( $j >= 1 ) && ( $j <= $tmp ) } {
        #putmsg "$nick" "displaying quote $j of $tmp"
        incr j -1
      } else {
        putmsg "$nick" "valid quotes number from 1 to $tmp"
        close $qf
        return
      }
    }

    while { $j >= $i } {
      set line [gets $qf]
      incr i
    }

    close $qf

    putchan $chan "\[quote #[expr $j + 1]\] [lindex $line 0]"

  } else {
    putmsg "$nick" "error, $quotefile not found!"
  }
}

proc q_pebus { nick uhost hand chan arg } {
    putlog "pebus pub: $nick $uhost $hand $chan"

    set quotefile "quotelist-$chan"

    if { [file exists $quotefile] } {
        set qf [open $quotefile r]
	fconfigure $qf -encoding utf-8

        set fd [open "|wc -l $quotefile" r]
        while {![eof $fd]} {
          scan [gets $fd] " %d " tmp
          if {[eof $fd]} {break}
        }
        close $fd

        set i 0

        while {$i < $tmp} {
            set line [gets $qf]
	    if { [regexp -nocase {n0rua|ae0kw|tonyc} [lindex $line 0]] } then {
		lappend found [expr $i + 1]
	    }
            incr i
        }
	close $qf

	if { [llength $found] == 0 } {
	    putchan $chan "no relevant quotes found for $chan"
	    return
	}

	set quotenum [lindex $found [expr int(rand() * [llength $found])]]

	return [q_pubquote $nick $uhost $hand $chan $quotenum]
    }
}

proc q_pubquotesearch { nick uhost hand chan arg } {
    set quotefile "quotelist-$chan"

    set newarg [string trim "$arg"]

    putlog "quotesearch pub: $nick $uhost $hand $chan $arg"

    if { [string length "$newarg"] < 3 } {
	putmsg "$nick" "error, search string too short"
    } elseif { [file exists $quotefile] } {
        set qf [open $quotefile r]

        set fd [open "|wc -l $quotefile" r]
        while {![eof $fd]} {
          scan [gets $fd] " %d " tmp
          if {[eof $fd]} {break}
        }
        close $fd

        set newarg [string tolower "$newarg"]

        set i 0
        set j 0

        while {$i < $tmp} {
            set line [gets $qf]
            if { [string first $newarg [string tolower [lindex $line 0] ] ] != -1 } {
                putmsg "$nick" "\[quote #[expr $i+1]\] [lindex $line 0]"
                incr j
            }
            incr i
        }
        close $qf

	putmsg "$nick" "found $j hit(s) for $arg"

    } else {
        putmsg "$nick" "error, $quotefile not found!"
    }
}

putlog "Quotes loaded."
