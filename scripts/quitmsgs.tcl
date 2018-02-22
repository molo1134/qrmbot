# IRC quit message tracking
#
# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind sign - * getsignoff
bind pub - !myquit post_myquit
bind pub - !quit post_theirquit
set quitfile quitlist

proc getsignoff { nick hostmask handle channel reason } {
  global quitfile

  if {$handle != "*"} {
    set orig [open $quitfile r]
    set dest [open quittmp w+]
    
    set found 0
    
    set entry [list]
    lappend entry $handle
    lappend entry [unixtime]
    lappend entry $reason
   
    while {![eof $orig]} {
      set line [gets $orig]
      if {[lindex $line 0] == $handle} {
        puts $dest $entry
	set found 1
      } elseif {![eof $orig]} {
        puts $dest $line
      }
    }

    if {$found == 0} {
      puts $dest $entry
    }
    #putnotc molo $entry
    #putnotc molo "test: $entry"

    close $orig
    close $dest

    file delete -force $quitfile
    file copy -force quittmp $quitfile
    file delete -force quittmp

  }

}

proc post_myquit { nick hostmask handle channel args } {
  report_quit $channel $handle
}

proc post_theirquit { nick hostmask handle channel args } {

	if [string is list $args] {
		report_quit $channel [lindex $args 0]
	} else {
		report_quit $channel $args
	}
}

proc report_quit { channel handle } {
  global quitfile
  set found 0
  
  set handle [string trim "$handle"]

  if {$handle != "*"} {
    set datafile [open $quitfile r]
    set line [gets $datafile]
    while {![eof $datafile]} {
      
      if { [string tolower [lindex $line 0]] == [string tolower $handle] } {
        #putchan $channel "$handle: [ctime [lindex $line 1]]: [lindex $line 2]"
        putchan $channel "$handle: [strftime "%Y-%m-%d %H:%M:%S %Z" [lindex $line 1]]: [lindex $line 2]"
        set found 1
      }
      set line [gets $datafile]
    }
    if {$found == 0} {
      putchan $channel "$handle: Error: No quit message recorded."
    }
  }
}

putlog "Quit message tracking loaded."

