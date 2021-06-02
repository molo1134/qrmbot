# Some stuff just for fun

# 2-clause BSD license.
# Copyright (c) 2018, 2019, 2020, 2021 molo1134@github. All rights reserved.
# Copyright (c) 2019 W9VFR. All rights reserved.
# Copyright (c) 2019 OliverUK. All rights reserved.

bind pub - !phonetics phoneticise
bind pub - !phoneticise phoneticise
bind pub - !phoneticize phoneticise
bind pub - !metard metard
bind pub - !truck truck
bind pub - !brexit brexit
bind pub - !christmas christmas
bind pub - !translate translate
bind pub - !primaries primaries
bind pub - !fivethirtyeight fivethirtyeight_pub
bind pub - !538 fivethirtyeight_pub
bind msg - !fivethirtyeight fivethirtyeight_msg
bind msg - !538 fivethirtyeight_msg
bind pub - !senate senate_pub
bind msg - !senate senate_msg
bind pub - !house house_pub
bind msg - !house house_msg

set phoneticsbin "/home/eggdrop/bin/phoneticise"
set brexitbin "/home/eggdrop/bin/brexit"
set christmasbin "/home/eggdrop/bin/christmas"
set translatebin "/home/eggdrop/bin/translate"
set primariesbin "/home/eggdrop/bin/primaries"
set fivethirtyeightbin "/home/eggdrop/bin/fivethirtyeight"

# load utility methods
source scripts/util.tcl

proc phoneticise { nick host hand chan text } {
	global phoneticsbin
	set param [sanitize_string [string trim "${text}"]]

	putlog "phonetics pub: $nick $host $hand $chan $param"

	set fd [open "|${phoneticsbin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

bind pub - !sandwich sandwich
proc sandwich { nick host hand chan text } {
	set param [sanitize_string [string trim "${text}"]]
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
		putmsg "$nick" "$line"
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
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
proc debt_pub { nick host hand chan text } {
	global debtbin
	putlog "debt pub: $nick $host $hand $chan"
	set fd [open "|${debtbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}


bind msg - !launch launch_msg
bind pub - !launch launch_pub
set launchbin "/home/eggdrop/bin/launch"
proc launch_pub { nick host hand chan text } {
	global launchbin
	set param [sanitize_string [string trim "${text}"]]
	putlog "launch pub: $nick $host $hand $chan $param"
	set fd [open "|${launchbin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc launch_msg {nick uhand handle input} {
	global launchbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "launch msg: $nick $uhand $handle $param"
	set fd [open "|${launchbin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
bind msg - !spacex spacex_msg
bind pub - !spacex spacex_pub
proc spacex_pub { nick host hand chan text } {
	launch_pub "$nick" $host $hand $chan "--spacex"
}
proc spacex_msg {nick uhand handle input} {
	launch_msg "$nick" $uhand $handle "--spacex"
}
bind msg - !wallops wallops_msg
bind pub - !wallops wallops_pub
proc wallops_pub { nick host hand chan text } {
	launch_pub "$nick" $host $hand $chan "--wallops"
}
proc wallops_msg {nick uhand handle input} {
	launch_msg "$nick" $uhand $handle "--wallops"
}
bind msg - !vbg vandenberg_msg
bind pub - !vbg vandenberg_pub
bind msg - !vandenberg vandenberg_msg
bind pub - !vandenberg vandenberg_pub
proc vandenberg_pub { nick host hand chan text } {
	launch_pub "$nick" $host $hand $chan "--vandenberg"
}
proc vandenberg_msg {nick uhand handle input} {
	launch_msg "$nick" $uhand $handle "--vandenberg"
}
bind msg - !cape cape_msg
bind pub - !cape cape_pub
bind msg - !kennedy cape_msg
bind pub - !kennedy cape_pub
bind msg - !canaveral cape_msg
bind pub - !canaveral cape_pub
proc cape_pub { nick host hand chan text } {
	launch_pub "$nick" $host $hand $chan "--cape"
}
proc cape_msg {nick uhand handle input} {
	launch_msg "$nick" $uhand $handle "--cape"
}


bind pub - !stock stock_pub
bind msg - !stock stock_msg
bind pub - !s stock_pub
bind msg - !s stock_msg
bind pub - !stonk stock_pub
bind msg - !stonk stock_msg
set stockbin "/home/eggdrop/bin/stock"
proc stock_pub { nick host hand chan text } {
	global stockbin
	set param [sanitize_string [string trim "${text}"]]
	putlog "stock pub: $nick $host $hand $chan $param"
	set fd [open "|${stockbin} ${param} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc stock_msg {nick uhand handle input} {
	global stockbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "stock msg: $nick $uhand $handle $param"
	set fd [open "|${stockbin} ${param} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
bind pub - !tendies tendies_pub
bind msg - !tendies tendies_msg
proc tendies_pub { nick host hand chan text } {
	stock_pub "$nick" $host $hand $chan "^VIX"
}
proc tendies_msg {nick uhand handle input} {
	stock_msg "$nick" $uhand $handle "^VIX"
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

proc truck { nick host hand chan text} {
	putchan $chan "truck you, $nick"
}

proc brexit { nick host hand chan text } {
	global brexitbin
	putlog "brexit: $nick $host $hand $chan"
	set fd [open "|${brexitbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc christmas { nick host hand chan text } {
	global christmasbin
	putlog "christmas: $nick $host $hand $chan"
	set fd [open "|${christmasbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

bind pub - !potus potus
bind pub - !trumpectomy potus
set potusbin "/home/eggdrop/bin/potus"
proc potus { nick host hand chan text } {
	global potusbin
	putlog "potus: $nick $host $hand $chan"
	set fd [open "|${potusbin}" r]
	fconfigure $fd -encoding utf-8
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

proc translate { nick host hand chan text } {
	global translatebin

	#putlog "encoding: [encoding system]"
	#putlog ${text}
	#putlog [chars2hexlist ${text}]
	set cleantext [sanitize_string [string trim "${text}"]]
	#putlog [chars2hexlist ${cleantext}]

	putlog "translate pub: $nick $host $hand $chan $cleantext"

	set fd [open "|${translatebin} ${cleantext}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "${line}"
	}
	close $fd
}

bind pub - !corona corona_pub
bind pub - !covid corona_pub
bind pub - !covid19 corona_pub
bind pub - !c19 corona_pub
bind msg - !corona corona_msg
bind msg - !covid corona_msg
bind msg - !covid19 corona_msg
bind msg - !c19 corona_msg
set coronabin "/home/eggdrop/bin/corona"
proc corona_pub { nick host hand chan text } {
	global coronabin
	set cleantext [sanitize_string [string trim "${text}"]]
	putlog "corona: $nick $host $hand $chan $cleantext"
	set fd [open "|${coronabin} ${cleantext}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc corona_msg {nick uhand handle input} {
	global coronabin
	set param [sanitize_string [string trim "${input}"]]
	putlog "corona msg: $nick $uhand $handle $param"
	set fd [open "|${coronabin} ${param} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc primaries { nick host hand chan text } {
	global primariesbin
	set cleantext [sanitize_string [string trim "${text}"]]
	putlog "primaries: $nick $host $hand $chan $cleantext"
	set fd [open "|${primariesbin} ${cleantext}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc fivethirtyeight_pub { nick host hand chan text } {
	global fivethirtyeightbin
	set param [sanitize_string [string trim "${text}"]]
	putlog "fivethirtyeight pub: $nick $host $hand $chan $param"
	set fd [open "|${fivethirtyeightbin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc fivethirtyeight_msg {nick uhand handle input} {
	global fivethirtyeightbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "fivethirtyeight msg: $nick $uhand $handle $param"
	set fd [open "|${fivethirtyeightbin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
proc senate_pub { nick host hand chan text } {
	global fivethirtyeightbin
	set param [sanitize_string [string trim "${text}"]]
	putlog "senate pub: $nick $host $hand $chan $param"
	set fd [open "|${fivethirtyeightbin} --senate ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc senate_msg {nick uhand handle input} {
	global fivethirtyeightbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "senate msg: $nick $uhand $handle $param"
	set fd [open "|${fivethirtyeightbin} --senate ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
proc house_pub { nick host hand chan text } {
	global fivethirtyeightbin
	set param [sanitize_string [string trim "${text}"]]
	putlog "house pub: $nick $host $hand $chan $param"
	set fd [open "|${fivethirtyeightbin} --house ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc house_msg {nick uhand handle input} {
	global fivethirtyeightbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "house msg: $nick $uhand $handle $param"
	set fd [open "|${fivethirtyeightbin} --house ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

bind pub - !ammo ammo_pub
bind msg - !ammo ammo_msg
set ammobin "/home/eggdrop/bin/ammo"
proc ammo_pub { nick host hand chan text } {
	global ammobin
	set param [sanitize_string [string trim "${text}"]]
	putlog "ammo pub: $nick $host $hand $chan $param"
	set params [split $param]
	set count [lindex $params 1]
	if { $count > 3 } {
		lset params 1 "3"
		set param [join $params]
	}

	set fd [open "|${ammobin} ${param} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc ammo_msg {nick uhand handle input} {
	global ammobin
	set param [sanitize_string [string trim "${input}"]]
	putlog "ammo msg: $nick $uhand $handle $param"
	set fd [open "|${ammobin} ${param} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

set randobin "/home/eggdrop/bin/rando"
bind pub - !rand rando_pub
proc rando_pub { nick host hand chan text } {
	global randobin
	set param [sanitize_string [string trim "${text}"]]
	putlog "rando pub: $nick $host $hand $chan $param"
	set fd [open "|${randobin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$nick: $line"
	}
	close $fd
}
bind pub - !flip coinflip_pub
bind pub - !coin coinflip_pub
bind pub - !coinflip coinflip_pub
proc coinflip_pub { nick host hand chan text } {
	rando_pub "$nick" $host $hand $chan "--coinflip"
}
bind pub - !dice dice_pub
proc dice_pub { nick host hand chan text } {
	rando_pub "$nick" $host $hand $chan "--dice"
}
bind pub - !8ball eightball_pub
bind pub - !magic8ball eightball_pub
bind pub - !eightball eightball_pub
proc eightball_pub { nick host hand chan text } {
	rando_pub "$nick" $host $hand $chan "--8ball"
}
bind pub - !card card_pub
proc card_pub { nick host hand chan text } {
	rando_pub "$nick" $host $hand $chan "--card"
}
bind pub - !roulette roulette_pub
bind pub - !wheel roulette_pub
proc roulette_pub { nick host hand chan text } {
	rando_pub "$nick" $host $hand $chan "--roulette"
}
bind pub - !draw draw_pub
bind pub - !deal draw_pub
proc draw_pub { nick host hand chan text } {
	global randobin
	set param [sanitize_string [string trim "${text}"]]
	putlog "draw pub: $nick $host $hand $chan $param"
	set fd [open "|${randobin} --draw ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

bind pub - !cat cat_pub
proc cat_pub { nick host hand chan text } {
	set param [sanitize_string [string trim "${text}"]]
	putlog "cat pub: $nick $host $hand $chan $param"
	set msg(0) "cat"
	set msg(1) "kitty"
	set msg(2) "how cute"
	set msg(3) "neko"
	set msg(4) "el gato"
	set msg(5) "katze"
	set msg(6) "fur baby"
	set msg(7) "catto"
	set msg(8) "purr"
	set msg(9) "meow"
	set msg(10) "cats are nice"
	set msg(11) "dogs are better"
	set msg(12) "you're obsessed"
	set msg(13) "seriously, wtf"
	set index [expr {int(rand()*[array size msg])}]
	set command "curl -s -k -L -A foo https://www.reddit.com/r/catpictures/random.json | jq . | grep \\\"url\\\": | grep -E -v \\(preview.redd.it\\|redditstatic.com\\) | head -1 | sed -e s\\|^.*\"\\\\\\(https\\\\?://\[^\"]*\\\\\\)\".*$\\|\\\\1\\|"
	set fd [open "|${command}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$msg($index): $line"
	}
	close $fd
}

putlog "fun.tcl loaded."

