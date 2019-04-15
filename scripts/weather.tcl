# Wunderground weather reports.

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !wx wx
bind msg - !wx msg_wx

bind pub - !wxfull wxfull
bind msg - !wxfull msg_wxfull

bind pub - !wxf wxf
bind msg - !wxf msg_wxf

#bind pub - !wxflong wxflong
bind pub - !wxflong msg_wxflong_pub
bind msg - !wxflong msg_wxflong

bind pub - !metar metar
bind msg - !metar msg_metar

bind pub - !taf taf
bind msg - !taf msg_taf

set wxbin "/home/eggdrop/bin/wx"
set wxfbin "/home/eggdrop/bin/wxf"
set metarbin "/home/eggdrop/bin/metar"
set tafbin "/home/eggdrop/bin/taf"

# load utility methods
source scripts/util.tcl

proc wx { nick host hand chan text } {
	global wxbin
	set loc [sanitize_string [string trim ${text}]]
	# from util.tcl:
	set geo [qrz_getgeo $hand]

	putlog "wx pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wxbin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wxbin} ${geo} " r]
		} else {
			set fd [open "|${wxbin} ${loc} " r]
		}
	}
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wx {nick uhand handle input} {
	global wxbin
	set loc [sanitize_string [string trim ${input}]]
	# from util.tcl:
	set geo [qrz_getgeo $handle]

	putlog "wx msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wxbin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wxbin} ${geo} " r]
		} else {
			set fd [open "|${wxbin} ${loc} " r]
		}
	}
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

proc wxfull { nick host hand chan text } {
	global wxbin
	set loc [sanitize_string [string trim ${text}]]
	# from util.tcl:
	set geo [qrz_getgeo $hand]

	putlog "wxfull pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wxbin} --full ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wxbin} --full ${geo} " r]
		} else {
			set fd [open "|${wxbin} --full ${loc} " r]
		}
	}
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wxfull {nick uhand handle input} {
	global wxbin
	set loc [sanitize_string [string trim ${input}]]
	# from util.tcl:
	set geo [qrz_getgeo $handle]

	putlog "wxfull msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wxbin} --full ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wxbin} --full ${geo} " r]
		} else {
			set fd [open "|${wxbin} --full ${loc} " r]
		}
	}
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

proc wxf { nick host hand chan text } {
	global wxfbin
	set loc [sanitize_string [string trim ${text}]]
	# from util.tcl:
	set geo [qrz_getgeo $hand]

	putlog "wxf pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wxfbin} --short ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wxfbin} --short ${geo} " r]
		} else {
			set fd [open "|${wxfbin} --short ${loc} " r]
		}
	}
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wxf {nick uhand handle input} {
	global wxfbin
	set loc [sanitize_string [string trim ${input}]]
	# from util.tcl:
	set geo [qrz_getgeo $handle]

	putlog "wxf msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wxfbin} --short ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wxfbin} --short ${geo} " r]
		} else {
			set fd [open "|${wxfbin} --short ${loc} " r]
		}
	}
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

proc wxflong { nick host hand chan text } {
	global wxfbin
	set loc [sanitize_string [string trim ${text}]]
	# from util.tcl:
	set geo [qrz_getgeo $hand]

	putlog "wxflong pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wxfbin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wxfbin} ${geo} " r]
		} else {
			set fd [open "|${wxfbin} ${loc} " r]
		}
	}
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wxflong_pub { nick host hand chan text } {
	msg_wxflong $nick $host $hand $text
}

proc msg_wxflong {nick uhand handle input} {
	global wxfbin
	set loc [sanitize_string [string trim ${input}]]
	# from util.tcl:
	set geo [qrz_getgeo $handle]

	putlog "wxflong msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wxfbin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wxfbin} ${geo} " r]
		} else {
			set fd [open "|${wxfbin} ${loc} " r]
		}
	}
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

proc metar {nick host hand chan text} {
	global metarbin 
	set loc [sanitize_string [string trim ${text}]]

	putlog "metar pub: $nick $host $hand $chan $loc"
	
	set fd [open "|${metarbin} ${loc} " r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_metar {nick uhand handle input} { 
	global metarbin 
	set loc [sanitize_string [string trim ${input}]]
	
	putlog "metar msg: $nick $uhand $handle $loc"

	set fd [open "|${metarbin} ${loc} " r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

proc taf {nick host hand chan text} {
	global tafbin 
	set loc [sanitize_string [string trim ${text}]]

	putlog "taf pub: $nick $host $hand $chan $loc"
	
	set fd [open "|${tafbin} ${loc} " r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_taf {nick uhand handle input} { 
	global tafbin 
	set loc [sanitize_string [string trim ${input}]]
	
	putlog "taf msg: $nick $uhand $handle $loc"

	set fd [open "|${tafbin} ${loc} " r]
	fconfigure $fd -translation binary
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}


