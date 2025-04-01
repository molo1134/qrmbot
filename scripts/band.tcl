# Maintain a quote list across channels
#
# 2-clause BSD license.
# Copyright (c) 2018, 2019 molo1134@github. All rights reserved.

bind pub - !addband b_addquote
bind pub - !band b_pubquote
bind pub - !bandsearch b_pubquotesearch

set bandfile "scripts/bandlist.txt"

proc b_addquote { nick uhost hand chan arg } {
  global bandfile

  if { [file exists $bandfile] } {
    set qf [open $bandfile a]
  } else {
    set qf [open $bandfile w]
  }

  set entry [list]
  lappend entry "$arg"

  puts $qf $entry

  putmsg "$nick" "added band: $arg"

  close $qf
}


proc b_pubquote { nick uhost hand chan arg } {
  global bandfile

  if { [file exists $bandfile] } {

    set qf [open $bandfile r]
    set done 0

    set fd [open "|wc -l $bandfile" r]
    while {![eof $fd]} {
      scan [gets $fd] " %d " tmp
      if {[eof $fd]} {break}
    }
    close $fd

    set i 0

    if { [string trim "$arg"] == "" } {
      set j [rand $tmp]
      #putmsg "$nick" "picked band [expr $j + 1] of $tmp"
    } else {
      set j "$arg"
      if { ( $j >= 1 ) && ( $j <= $tmp ) } {
        #putmsg "$nick" "displaying band $j of $tmp"
        incr j -1
      } else {
        putmsg "$nick" "valid band number from 1 to $tmp"
        return
      }
    }

    while { $j >= $i } {

      set line [gets $qf]
      incr i

    }

    close $qf

    putchan $chan "[lindex $line 0]"


  } else {
    putmsg "$nick" "error, $bandfile not found!"
  }
}


proc b_pubquotesearch { nick uhost hand chan arg } {
    global bandfile

    set newarg [string trim "$arg"]

    if { [string length "$newarg"] < 3 } {
	putmsg "$nick" "error, search string too short"
    } elseif { [file exists $bandfile] } {
        set qf [open $bandfile r]

        set fd [open "|wc -l $bandfile" r]
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
            if { [string first "$newarg" [string tolower [lindex $line 0] ] ] != -1 } {
                putmsg "$nick" "found band [expr $i+1]:"
                putmsg "$nick" "[lindex $line 0]"
                incr j
            }
            incr i
        }

	putmsg "$nick" "found $j hit(s) for $arg"

    } else {
        putmsg "$nick" "error, $bandfile not found!"
    }
}

putlog "band loaded."

