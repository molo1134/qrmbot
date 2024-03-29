# Wunderground weather reports.

# 2-clause BSD license.
# Copyright (c) 2018, 2019, 2020, 2021 molo1134@github. All rights reserved.
# Copyright (c) 2019 W9VFR. All rights reserved.

bind pub - !wx wx
bind msg - !wx msg_wx

bind pub - !wxfull wxfull
bind msg - !wxfull msg_wxfull

bind pub - !darksky darksky
bind msg - !darksky msg_darksky

bind pub - !wttr wttr
bind msg - !wttr msg_wttr

bind pub - !wxf wxf
bind msg - !wxf msg_wxf

#bind pub - !wxflong wxflong
bind pub - !wxflong msg_wxflong_pub
bind msg - !wxflong msg_wxflong

bind pub - !metar metar
bind msg - !metar msg_metar

bind pub - !taf taf
bind msg - !taf msg_taf

bind pub - !quake quake_pub
bind msg - !quake quake_msg
bind pub - !quakef quakef_pub
bind msg - !quakef quakef_msg

bind pub - !fire fire_pub
bind pub - !ev fire_pub
bind msg - !fire fire_msg

set wxbin "/home/eggdrop/bin/aeris"
set wxfbin "/home/eggdrop/bin/aerisf"
set metarbin "/home/eggdrop/bin/metar"
set tafbin "/home/eggdrop/bin/taf"
set quakebin "/home/eggdrop/bin/quake"
set quakefbin "/home/eggdrop/bin/quakef"
set darkskybin "/home/eggdrop/bin/darksky"
set wttrbin "/home/eggdrop/bin/wttr"
set firebin "/home/eggdrop/bin/fire"

# load utility methods
source scripts/util.tcl

proc wx { nick host hand chan text } {
	global wxbin
	set loc [sanitize_string [string trim "${text}"]]
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wx {nick uhand handle input} {
	global wxbin
	set loc [sanitize_string [string trim "${input}"]]
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc wxfull { nick host hand chan text } {
	global wxbin
	set loc [sanitize_string [string trim "${text}"]]
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wxfull {nick uhand handle input} {
	global wxbin
	set loc [sanitize_string [string trim "${input}"]]
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc wxf { nick host hand chan text } {
	global wxfbin
	set loc [sanitize_string [string trim "${text}"]]
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wxf {nick uhand handle input} {
	global wxfbin
	set loc [sanitize_string [string trim "${input}"]]
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc wxflong { nick host hand chan text } {
	global wxfbin
	set loc [sanitize_string [string trim "${text}"]]
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wxflong_pub { nick host hand chan text } {
	msg_wxflong "$nick" $host $hand $text
}

proc msg_wxflong {nick uhand handle input} {
	global wxfbin
	set loc [sanitize_string [string trim "${input}"]]
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc fire_pub { nick host hand chan text } {
	global firebin
	set loc [sanitize_string [string trim "${text}"]]
	# from util.tcl:
	set geo [qrz_getgeo $hand]

	putlog "fire pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${firebin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${firebin} ${geo} " r]
		} else {
			set fd [open "|${firebin} ${loc} " r]
		}
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc fire_msg {nick uhand handle input} {
	global firebin
	set loc [sanitize_string [string trim "${input}"]]
	# from util.tcl:
	set geo [qrz_getgeo $handle]

	putlog "fire msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${firebin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${firebin} ${geo} " r]
		} else {
			set fd [open "|${firebin} ${loc} " r]
		}
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc metar {nick host hand chan text} {
	global metarbin
	set loc [sanitize_string [string trim "${text}"]]

	putlog "metar pub: $nick $host $hand $chan $loc"

	set fd [open "|${metarbin} ${loc} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_metar {nick uhand handle input} {
	global metarbin
	set loc [sanitize_string [string trim "${input}"]]

	putlog "metar msg: $nick $uhand $handle $loc"

	set fd [open "|${metarbin} ${loc} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc taf {nick host hand chan text} {
	global tafbin
	set loc [sanitize_string [string trim "${text}"]]

	putlog "taf pub: $nick $host $hand $chan $loc"

	set fd [open "|${tafbin} ${loc} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_taf {nick uhand handle input} {
	global tafbin
	set loc [sanitize_string [string trim "${input}"]]

	putlog "taf msg: $nick $uhand $handle $loc"

	set fd [open "|${tafbin} ${loc} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc quake_pub {nick host hand chan text} {
	global quakebin
	putlog "quake pub: $nick $host $hand $chan"
	set fd [open "|${quakebin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc quake_msg {nick uhand handle input} {
	global quakebin
	putlog "quake msg: $nick $uhand $handle"
	set fd [open "|${quakebin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc quakef_pub {nick host hand chan text} {
	global quakefbin
	putlog "quakef pub: $nick $host $hand $chan"
	set fd [open "|${quakefbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc quakef_msg {nick uhand handle input} {
	global quakefbin
	putlog "quakef msg: $nick $uhand $handle"
	set fd [open "|${quakefbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc darksky { nick host hand chan text } {
	global darkskybin
	set loc [sanitize_string [string trim "${text}"]]
	# from util.tcl:
	set geo [qrz_getgeo $hand]

	putlog "darksky pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${darkskybin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${darkskybin} ${geo} " r]
		} else {
			set fd [open "|${darkskybin} ${loc} " r]
		}
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_darksky {nick uhand handle input} {
	global darkskybin
	set loc [sanitize_string [string trim "${input}"]]
	# from util.tcl:
	set geo [qrz_getgeo $handle]

	putlog "darksky msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${darkskybin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${darkskybin} ${geo} " r]
		} else {
			set fd [open "|${darkskybin} ${loc} " r]
		}
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc aeris { nick host hand chan text } {
	global aerisbin
	set loc [sanitize_string [string trim "${text}"]]
	# from util.tcl:
	set geo [qrz_getgeo $hand]

	putlog "aeris pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${aerisbin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${aerisbin} ${geo} " r]
		} else {
			set fd [open "|${aerisbin} ${loc} " r]
		}
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_aeris {nick uhand handle input} {
	global aerisbin
	set loc [sanitize_string [string trim "${input}"]]
	# from util.tcl:
	set geo [qrz_getgeo $handle]

	putlog "aeris msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${aerisbin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${aerisbin} ${geo} " r]
		} else {
			set fd [open "|${aerisbin} ${loc} " r]
		}
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc wttr { nick host hand chan text } {
	global wttrbin
	set loc [sanitize_string [string trim "${text}"]]
	# from util.tcl:
	set geo [qrz_getgeo $hand]

	putlog "wttr pub: $nick $host $hand $chan $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wttrbin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wttrbin} ${geo} " r]
		} else {
			set fd [open "|${wttrbin} ${loc} " r]
		}
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_wttr {nick uhand handle input} {
	global wttrbin
	set loc [sanitize_string [string trim "${input}"]]
	# from util.tcl:
	set geo [qrz_getgeo $handle]

	putlog "wttr msg: $nick $uhand $handle $loc $geo"

	if [string equal "" $geo] then {
		set fd [open "|${wttrbin} ${loc} " r]
	} else {
		if [string equal "" ${loc}] then {
			set fd [open "|${wttrbin} ${geo} " r]
		} else {
			set fd [open "|${wttrbin} ${loc} " r]
		}
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
