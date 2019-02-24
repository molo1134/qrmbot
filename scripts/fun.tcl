# Some stuff just for fun

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !phonetics phoneticise
bind pub - !phoneticise phoneticise
bind pub - !phoneticize phoneticise
bind pub - !metard metard
bind pub - !whotard whotard

set phoneticsbin "/home/eggdrop/bin/phoneticise"

# load utility methods
source scripts/util.tcl

proc phoneticise { nick host hand chan text } {
	global phoneticsbin
	set param [sanitize_string [string trim ${text}]]

	putlog "phonetics pub: $nick $host $hand $chan $param"

	catch {exec ${phoneticsbin} ${param} } data

	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}

bind pub - !sandwich sandwich
proc sandwich { nick host hand chan text } {
	set param [sanitize_string [string trim ${text}]]
	putlog "sandwich pub: $nick $host $hand $chan $param"
	putchan $chan "sudo make ${nick} a sandwich: https://xkcd.com/149/"
}

bind msg - !colortest msg_colortest
set colortestbin "/home/eggdrop/bin/colortest"
proc msg_colortest {nick uhand handle input} {
	global colortestbin
	putlog "colortest msg: $nick $uhand $handle $input"
	catch {exec ${colortestbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}

bind pub - !debt debt_pub
bind msg - !debt debt_msg

set debtbin "/home/eggdrop/bin/debt"
proc debt_msg {nick uhand handle input} {
	global debtbin
	putlog "debt msg: $nick $uhand $handle $input"
	catch {exec ${debtbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}
proc debt_pub { nick host hand chan text } {
	global debtbin
	putlog "debt pub: $nick $host $hand $chan"
	catch {exec ${debtbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}

bind msg - !spacex spacex_msg
bind pub - !spacex spacex_pub
set spacexbin "/home/eggdrop/bin/spacex"
proc spacex_pub { nick host hand chan text } {
	global spacexbin
	putlog "spacex pub: $nick $host $hand $chan $text"
	catch {exec ${spacexbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc spacex_msg {nick uhand handle input} {
	global spacexbin
	putlog "spacex msg: $nick $uhand $handle $input"
	catch {exec ${spacexbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

bind msg - !canteen canteen_msg

proc canteen_msg {nick uhand handle input} {
	putlog "canteen msg: $nick $uhand $handle $input"
	set cmd [list /usr/bin/elinks {https://www.studierendenwerk-aachen.de/speiseplaene/ahornstrasse-w.html} -dump 1 -dump-width 256 \| sed -e {s/\^ [A-Z0-9,]\+//g} \| perl -lne {use POSIX qw(strftime); $d = strftime("%d.%m.%Y", localtime); $f = 0 if /[0-9]{2}\.[0-9]{2}\.[0-9]{4}/; $f = 1 if /$d/; print if $f == 1} \| grep + \| sed -e {s/  */ /g; s/+/: /g} ]
	catch {exec {*}$cmd } data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

bind pub - !stock stock_pub
bind msg - !stock stock_msg
set stockbin "/home/eggdrop/bin/stock"
proc stock_pub { nick host hand chan text } {
	global stockbin
	set param [sanitize_string [string trim ${text}]]

	putlog "stock pub: $nick $host $hand $chan $param"

	catch {exec ${stockbin} ${param} } data

	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc stock_msg {nick uhand handle input} {
	global stockbin
	set param [sanitize_string [string trim ${input}]]
	putlog "stock msg: $nick $uhand $handle $param"
	catch {exec ${stockbin} ${param} } data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

bind pub - !wwv wwv_pub
proc wwv_pub { nick host hand chan text } {
	set ts [clock microseconds]
	set remaining [expr 60000000 - [expr $ts % 60000000]]
	set usec_remaining [expr $remaining % 1000000]
	set sec_remaining [expr [expr $remaining - $usec_remaining] / 1000000]
	set ut [utimers]
#	putchan $chan "utimers: $ut"
	set i 0
	while { $i < [llength $ut] } {
#		putchan $chan "lindex $i: [lindex $ut $i]"
#		putchan $chan "found? $i: [string match "*_wwv*" [lindex $ut $i]]"
#		putchan $chan "found chan? $i: [string match "*$chan*" [lindex $ut $i]]"
		if { [string match "*_wwv*" [lindex $ut $i]] &&
				[string match "*$chan*" [lindex $ut $i]] } {
			return
		}
		#putchan $chan "double index: [lindex [lindex $ut $i] 1]"
		set i [expr $i + 1]
	}
	utimer [expr $sec_remaining - 4] [list do_wwv_announce_pub $chan]
	utimer $sec_remaining [list do_wwv_beep_pub $chan]
}

proc do_wwv_announce_pub { chan } {
	set ts [clock microseconds]
	putchan $chan [clock format [expr ( $ts / 1000000 ) + 10] -format "At the tone: %H hours %M minutes Coordinated Universal Time:"]
}
proc do_wwv_beep_pub { chan } {
	set ts [clock microseconds]
	#putchan $chan "do_wwv_beep_pub called: $ts"
	while {[expr [expr $ts % 60000000] > 50000000]} {
		set ts [clock microseconds]
	}
	#putchan $chan "<beep> $ts"
	putchan $chan "<beep>"
}

proc metard { nick host hand chan text} {
	putchan $chan "$nick you tard" 
}

proc whotard { nick host hand chan text} {
	putchan $chan "Why the lovely Aram of course"
}
putlog "fun.tcl loaded."

