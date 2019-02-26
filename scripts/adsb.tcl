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
		catch {exec ${adsbbin} --geo $geo } data
	} else {
		catch {exec ${adsbbin} ${query} } data
	}
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}

proc adsb_msg {nick uhand handle input} {
	global adsbbin
	set query [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]
	putlog "adsb msg: $nick $uhand $handle $query $geo"
	if [string equal "" $query] then {
		catch {exec ${adsbbin} --geo $geo } data
	} else {
		catch {exec ${adsbbin} ${query}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}
