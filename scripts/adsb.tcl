bind pub - !adsb adsb
bind msg - !adsb adsb_msg 

set adsbbin "/home/eggdrop/bin/adsb"

# load utility methods
source scripts/util.tcl

proc adsb { nick host hand chan text } {
	global adsbbin
	set query [sanitize_string [string trim ${text}]]
	set geo [qrz_getgeo $hand]
	putlog "adsb pub: $nick $host $hand $chan $query $geo"
	if [string equal "" $query] then {
		set fd [open "|${adsbbin} --geo $geo" r]
	} else {
		set fd [open "|${adsbbin} ${query}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc adsb_msg {nick uhand handle input} {
	global adsbbin
	set query [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]
	putlog "adsb msg: $nick $uhand $handle $query $geo"
	if [string equal "" $query] then {
		set fd [open "|${adsbbin} --geo $geo" r]
	} else {
		set fd [open "|${adsbbin} ${query}" r]
	}
	fconfigure $fd -encoding utf-8
	set output [split $data "\n"]
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}
