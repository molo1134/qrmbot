# Some stuff just for fun

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !phonetics phoneticise
bind pub - !phoneticise phoneticise
bind pub - !phoneticize phoneticise
bind pub - !metard metard
bind pub - !brexit brexit
bind pub - !christmas christmas
bind pub - !translate translate
bind raw - "PRIVMSG" encodingdebug

set phoneticsbin "/home/eggdrop/bin/phoneticise"
set brexitbin "/home/eggdrop/bin/brexit"
set christmasbin "/home/eggdrop/bin/christmas"
set translatebin "/home/eggdrop/bin/translate"

# load utility methods
source scripts/util.tcl

proc phoneticise { nick host hand chan text } {
	global phoneticsbin
	set param [sanitize_string [string trim ${text}]]

	putlog "phonetics pub: $nick $host $hand $chan $param"

	set fd [open "|${phoneticsbin} ${param}" r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
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
	set fd [open "|${colortestbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

bind pub - !debt debt_pub
bind msg - !debt debt_msg

set debtbin "/home/eggdrop/bin/debt"
proc debt_msg {nick uhand handle input} {
	global debtbin
	putlog "debt msg: $nick $uhand $handle $input"
	set fd [open "|${debtbin}" r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}
proc debt_pub { nick host hand chan text } {
	global debtbin
	putlog "debt pub: $nick $host $hand $chan"
	set fd [open "|${debtbin}" r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

bind msg - !spacex spacex_msg
bind pub - !spacex spacex_pub
set spacexbin "/home/eggdrop/bin/spacex"
proc spacex_pub { nick host hand chan text } {
	global spacexbin
	putlog "spacex pub: $nick $host $hand $chan $text"
	set fd [open "|${spacexbin}" r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc spacex_msg {nick uhand handle input} {
	global spacexbin
	putlog "spacex msg: $nick $uhand $handle $input"
	set fd [open "|${spacexbin}" r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

bind pub - !stock stock_pub
bind msg - !stock stock_msg
set stockbin "/home/eggdrop/bin/stock"
proc stock_pub { nick host hand chan text } {
	global stockbin
	set param [sanitize_string [string trim ${text}]]

	putlog "stock pub: $nick $host $hand $chan $param"

	set fd [open "|${stockbin} ${param} " r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc stock_msg {nick uhand handle input} {
	global stockbin
	set param [sanitize_string [string trim ${input}]]
	putlog "stock msg: $nick $uhand $handle $param"
	set fd [open "|${stockbin} ${param} " r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
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

proc brexit { nick host hand chan text } {
	global brexitbin
	putlog "brexit: $nick $host $hand $chan"
	set fd [open "|${brexitbin}" r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc christmas { nick host hand chan text } {
	global christmasbin
	putlog "christmas: $nick $host $hand $chan"
	set fd [open "|${christmasbin}" r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc chars2hexlist {string} {
	binary scan $string c* ints
	set list {}
	foreach i $ints {
		lappend list [format %0.2X [expr {$i & 0xFF}]]
	}
	set list; # faster than return...
}

proc encodingdebug { from keyword text } {
	return 0;
#	putlog "encoding: [encoding system]"
#	putlog ${text}
#	putlog [chars2hexlist ${text}]
#	set text [encoding convertto utf-8 "${text}"]
#	putlog [chars2hexlist ${text}]
#	return 0
}

proc translate { nick host hand chan text } {
	global translatebin

	#putlog "encoding: [encoding system]"
	#putlog ${text}
	#putlog [chars2hexlist ${text}]
	set cleantext [sanitize_string [string trim ${text}]]
	#putlog [chars2hexlist ${cleantext}]

	putlog "translate pub: $nick $host $hand $chan $cleantext"

	set fd [open "|${translatebin} ${cleantext}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "${line}"
	}
	close $fd
}


putlog "fun.tcl loaded."

