# Hamfest lookup -- searches ARRL hamfest database for events near the user.
# Uses !setgeo location automatically; accepts an optional location override.
#
# 2-clause BSD license.
# Copyright (c) 2026 cjh@github. All rights reserved.

bind pub - !hamfest hamfest_pub
bind msg - !hamfest hamfest_msg

set hamfestbin "/home/eggdrop/bin/hamfest"

source scripts/util.tcl

proc hamfest_pub { nick host hand chan text } {
	global hamfestbin
	set loc [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "hamfest pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${hamfestbin} ${loc}" r]
	} else {
		set fd [open "|${hamfestbin} ${loc} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc hamfest_msg { nick uhand handle input } {
	global hamfestbin
	set loc [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "hamfest msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${hamfestbin} ${loc}" r]
	} else {
		set fd [open "|${hamfestbin} ${loc} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
