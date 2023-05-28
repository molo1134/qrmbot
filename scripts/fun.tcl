# Some stuff just for fun

# 2-clause BSD license.
# Copyright (c) 2018, 2019, 2020, 2021 molo1134@github. All rights reserved.
# Copyright (c) 2019 W9VFR. All rights reserved.
# Copyright (c) 2019 OliverUK. All rights reserved.
# Copyright (c) 2021, 2022 molo1134@github. All rights reserved.

bind pub - !phonetics phoneticise
bind pub - !phoneticise phoneticise
bind pub - !phoneticize phoneticise
bind pub - !metard metard
bind pub - !truck truck
bind pub - !aaa aaaaaaa
bind pub - !ooo ooooooo
bind pub - !monke robface
bind pub - !robface robface
bind pub - !monkee daveface
bind pub - !burn burn
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
bind pub - !gov gov_pub
bind msg - !gov gov_msg
bind pub - !governor gov_pub
bind msg - !governor gov_msg
bind pub - !github github
bind msg - !github msg_github

set phoneticsbin "/home/eggdrop/bin/phoneticise"
set brexitbin "/home/eggdrop/bin/brexit"
set christmasbin "/home/eggdrop/bin/christmas"
set translatebin "/home/eggdrop/bin/translate"
set primariesbin "/home/eggdrop/bin/primaries"
set fivethirtyeightbin "/home/eggdrop/bin/fivethirtyeight"

set githublink "https://github.com/molo1134/qrmbot/"

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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
bind msg - !ula ula_msg
bind pub - !ula ula_pub
proc ula_pub { nick host hand chan text } {
	launch_pub "$nick" $host $hand $chan "--ula"
}
proc ula_msg {nick uhand handle input} {
	launch_msg "$nick" $uhand $handle "--ula"
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
	putchan $chan "$nick you tard"
}

proc truck { nick host hand chan text} {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	putchan $chan "truck you, $nick"
}

proc ooooooo { nick host hand chan text} {
	if [string equal "#amateurradio" $chan] then {
		return
	}

	if [ expr (rand()*10) <= 1 ] then {
		putchan $chan "https://i.imgur.com/W1a476E.mp4"
	} else {
		putchan $chan "(⊙_⊙)  🔔🔔🔔 (^O^) OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
	}
}

proc aaaaaaa { nick host hand chan text} {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	
	if [ expr (rand()*100) <= 1 ] then {
		putchan $chan "https://i.imgur.com/7grmnJ1.mp4"
	} elseif [ expr (rand()*10) <= 3 ] then {
		putchan $chan "https://i.imgur.com/TtgYcS6.mp4"
	} else {
		putchan $chan "⛰🤠⛰ AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
	}
}

proc robface { nick host hand chan text} {
	if [string equal "#amateurradio" $chan] then {
		return
	}

	putchan $chan "https://i.imgur.com/cS9qmCH.jpg"
}

proc daveface { nick host hand chan text} {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	
	putchan $chan "https://i.imgur.com/diBAl5G.png"
}

proc burn { nick host hand chan text} {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	
	putlog "burn: $nick $host $hand $chan"
	putchan $chan "🔥 sick burn bro [https://i.imgur.com/rK6Oj0P.png]"
}

proc brexit { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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

bind pub - !qrm chatgpt
set chatgptbin "/home/eggdrop/bin/chatgpt"
proc chatgpt { nick host hand chan text } {
	global chatgptbin

	set cleantext [sanitize_string [string trim "${text}"]]

	putlog "chatgpt pub: $nick $host $hand $chan $cleantext"

	set fd [open "|${chatgptbin} ${cleantext}" r]
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global coronabin
	set cleantext [sanitize_string [string trim "${text}"]]
	putlog "corona pub: $nick $host $hand $chan $cleantext"
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
proc gov_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global fivethirtyeightbin
	set param [sanitize_string [string trim "${text}"]]
	putlog "gov pub: $nick $host $hand $chan $param"
	set fd [open "|${fivethirtyeightbin} --gov ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc gov_msg {nick uhand handle input} {
	global fivethirtyeightbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "gov msg: $nick $uhand $handle $param"
	set fd [open "|${fivethirtyeightbin} --gov ${param}" r]
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
	if [string equal "#amateurradio" $chan] then {
		return
	}
	rando_pub "$nick" $host $hand $chan "--dice"
}
bind pub - !8ball eightball_pub
bind pub - !magic8ball eightball_pub
bind pub - !eightball eightball_pub
proc eightball_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	rando_pub "$nick" $host $hand $chan "--8ball"
}
bind pub - !card card_pub
proc card_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	rando_pub "$nick" $host $hand $chan "--card"
}
bind pub - !roulette roulette_pub
bind pub - !wheel roulette_pub
proc roulette_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	rando_pub "$nick" $host $hand $chan "--roulette"
}
bind pub - !draw draw_pub
bind pub - !deal draw_pub
proc draw_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
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
bind pub - !zach cat_pub
proc cat_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	set param [sanitize_string [string trim "${text}"]]
	putlog "cat pub: $nick $host $hand $chan $param"
	set msg(0) "cat"
	set msg(1) "kitty"
	set msg(2) "how cute"
	set msg(3) "neko"
	set msg(4) "el gato"
	set msg(5) "katze"
	set msg(6) "Кіт"
	set msg(7) "fur baby"
	set msg(8) "catto"
	set msg(9) "purr"
	set msg(10) "meow"
	set msg(11) "cats are nice"
	set msg(12) "dogs are better"
	set msg(13) "you're obsessed"
	set msg(14) "seriously, wtf"
	set index [expr {int(rand()*[array size msg])}]
	set command "curl -s -k -L -A foo https://www.reddit.com/r/WhatsWrongWithYourCat/random.json | jq -r first(.\[\].data.children\[\].data.url) "
	set fd [open "|${command}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		set jd [clock format [clock seconds] -gmt 1 -format "%j"]
		if { [string equal $jd "045"] } {
			set line "https://i.imgur.com/v0790At.jpg"
		}
		putchan $chan "$msg($index): $line"
	}
	close $fd
}

bind pub - !dog dog_pub
proc dog_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	set param [sanitize_string [string trim "${text}"]]
	putlog "dog pub: $nick $host $hand $chan $param"
	set msg(0) "bark"
	set msg(1) "woof"
	set index [expr {int(rand()*[array size msg])}]
	set command "curl -s -k -L -A foo https://www.reddit.com/r/WhatsWrongWithYourDog/random.json | jq -r first(.\[\].data.children\[\].data.url) "
	set fd [open "|${command}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		set jd [clock format [clock seconds] -gmt 1 -format "%j"]
		if { [string equal $jd "045"] } {
			set line "https://i.imgur.com/usMFstp.png"
		}
		putchan $chan "$msg($index): $line"
	}
	close $fd
}

set amconbin "/home/eggdrop/bin/amcon"
bind pub - !amcon amcon_pub
bind pub - !amccon amcon_pub
bind pub - !amrron amcon_pub
bind msg - !amcon amcon_msg
bind msg - !amccon amcon_msg
bind msg - !amrron amcon_msg
proc amcon_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global amconbin
	set param [sanitize_string [string trim "${text}"]]
	putlog "amcon pub: $nick $host $hand $chan $param"
	set fd [open "|${amconbin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc amcon_msg {nick uhand handle input} {
	global amconbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "amcon msg: $nick $uhand $handle $param"
	set fd [open "|${amconbin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

set amcornbin "/home/eggdrop/bin/amcorn"
bind pub - !amcorn amcorn_pub
proc amcorn_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global amcornbin
	set param [sanitize_string [string trim "${text}"]]
	putlog "amcorn pub: $nick $host $hand $chan $param"
	set fd [open "|${amcornbin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc github { nick host hand chan text } {
	global githublink
	putlog "github pub: $nick $host $hand $chan"
	putchan $chan "$githublink"
}
proc msg_github { nick uhand handle input } {
	global githublink
	putlog "github msg: $nick $uhand $handle"
	putmsg "$nick" "$githublink"
}

bind pub - !imdb imdb_pub
bind msg - !imdb imdb_msg
set imdbbin "/home/eggdrop/bin/imdb"
proc imdb_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global imdbbin
	set cleantext [sanitize_string [string trim "${text}"]]
	putlog "imdb pub: $nick $host $hand $chan $cleantext"
	set fd [open "|${imdbbin} ${cleantext}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc imdb_msg {nick uhand handle input} {
	global imdbbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "imdb msg: $nick $uhand $handle $param"
	set fd [open "|${imdbbin} ${param} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

bind msg - !gas gas_msg
bind pub - !gas gas_pub
bind msg - !diesel diesel_msg
bind pub - !diesel diesel_pub
set gasbin "/home/eggdrop/bin/gasprice"
proc gas_pub { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global gasbin
	set loc [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]
	putlog "gas pub: $nick $host $hand $chan $loc $geo"
	if [string equal "" $geo] then {
		set fd [open "|${gasbin} ${loc}" r]
	} else {
		set fd [open "|${gasbin} ${loc} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc gas_msg {nick uhand handle input} {
	global gasbin
	set loc [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]
	putlog "gas msg: $nick $uhand $handle $loc $geo"
	if [string equal "" $geo] then {
		set fd [open "|${gasbin} ${loc}" r]
	} else {
		set fd [open "|${gasbin} ${loc} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
proc diesel_pub { nick host hand chan text } {
	gas_pub "$nick" "$host" "$hand" "$chan" "--diesel $text"
}
proc diesel_msg {nick uhand handle input} {
	gas_msg "$nick" "$uhand" "$handle" "--diesel $input"
}

#bind pub - !ud ud_pub
bind msg - !ud ud_msg
set udbin "/home/eggdrop/bin/ud"
proc ud_pub { nick host hand chan text } {
	return
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global udbin
	set cleantext [sanitize_string [string trim "${text}"]]
	putlog "ud pub: $nick $host $hand $chan $cleantext"
	set fd [open "|${udbin} ${cleantext}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc ud_msg {nick uhand handle input} {
	global udbin
	set param [sanitize_string [string trim "${input}"]]
	putlog "ud msg: $nick $uhand $handle $param"
	set fd [open "|${udbin} ${param} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

bind msg - !rad rad_msg
bind pub - !rad rad_pub
set radbin "/home/eggdrop/bin/rad"
proc rad_pub { nick host hand chan text } {
	global radbin
	set query [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "rad pub: $nick $host $hand $chan $query $geo"

	if [string equal "" $geo] then {
		set fd [open "|${radbin} ${query}" r]
	} else {
		set fd [open "|${radbin} ${query} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc rad_msg {nick uhand handle input} {
	global radbin
	set query [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "rad msg: $nick $uhand $handle $query $geo"

	if [string equal "" $geo] then {
		set fd [open "|${radbin} ${query}" r]
	} else {
		set fd [open "|${radbin} ${query} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

bind pub - !ohio ohio
proc ohio { nick host hand chan text} {
	if [string equal "#amateurradio" $chan] then {
		return
	}

	if [ expr (rand()*100) <= 1 ] then {
		putchan $chan "https://www.youtube.com/watch?v=Um7CkufcOJw"
	} elseif [ expr (rand()*10) <= 1 ] then {
		putchan $chan "https://i.imgur.com/26gAZ2O.mp4"
	} else {
		putchan $chan "👬🍃🕺 (^O^) OHIOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
	}
}


putlog "fun.tcl loaded."

