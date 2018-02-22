# Some stuff just for fun

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !phonetics phoneticise
bind pub - !phoneticise phoneticise
bind pub - !phoneticize phoneticise

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

putlog "fun.tcl loaded."

