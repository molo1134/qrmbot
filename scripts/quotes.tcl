# Maintain a quote list
#
# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

#bind pub o|o !addquote q_addquote
bind pub - !addquote q_addquote
bind pub - !quote q_pubquote
bind pub - !quotesearch q_pubquotesearch

proc q_addquote { nick uhost hand chan arg } {
  set quotefile "quotelist-$chan"

  if { [file exists $quotefile] } {
    set qf [open $quotefile a]
  } else {
    set qf [open $quotefile w]
  }
  
  set entry [list]
  lappend entry $arg

  puts $qf $entry

  putnotc $nick $entry

  close $qf
}


proc q_pubquote { nick uhost hand chan arg } {
  set quotefile "quotelist-$chan"

  if { [file exists $quotefile] } {

    set qf [open $quotefile r]
    set done 0

    set fd [open "|wc -l $quotefile" r]
    while {![eof $fd]} {
      scan [gets $fd] " %d " tmp
      if {[eof $fd]} {break}
    }
    close $fd

    set i 0

    if { [string trim $arg] == "" } {
      set j [rand $tmp]
      putnotc $nick "picked quote [expr $j + 1] of $tmp"
    } else {
      set j $arg
      if { ( $j >= 1 ) && ( $j <= $tmp ) } {
        putnotc $nick "displaying quote $j of $tmp"
        incr j -1
      } else {
        putnotc $nick "valid quotes number from 1 to $tmp"
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
    putnotc $nick "error, $quotefile not found!"
  }
}


proc q_pubquotesearch { nick uhost hand chan arg } {
    set quotefile "quotelist-$chan"

    set newarg [string trim $arg]

    if { [string length $newarg] < 3 } {
	putnotc $nick "error, search string too short"
    } elseif { [file exists $quotefile] } {
        set qf [open $quotefile r]
        
        set fd [open "|wc -l $quotefile" r]
        while {![eof $fd]} {
          scan [gets $fd] " %d " tmp
          if {[eof $fd]} {break}
        }
        close $fd
        
        set newarg [string tolower $newarg]
        
        set i 0
        set j 0
        
        while {$i < $tmp} {
            set line [gets $qf]
            if { [string first $newarg [string tolower [lindex $line 0] ] ] != -1 } {
                putnotc $nick "found quote [expr $i+1]:"
                putnotc $nick "[lindex $line 0]"
                incr j
            }
            incr i
        }

	putnotc $nick "found $j hit(s) for $arg"
        
    } else {
        putnotc $nick "error, $quotefile not found!"
    }
}

putlog "Quotes loaded."
