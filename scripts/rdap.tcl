# Domain registration lookup via RDAP (RFC 9082/9083), falling back to WHOIS.
# !whois is an alias for !rdap.

# 2-clause BSD license.
# Copyright (c) 2026 molo1134@github. All rights reserved.

# load utility methods
source scripts/util.tcl

bind pub - !rdap rdap_pub
bind msg - !rdap rdap_msg
bind pub - !whois rdap_pub
bind msg - !whois rdap_msg

set rdapbin "/home/eggdrop/bin/rdap"

# keep shell metacharacters from reaching the rdap command line
proc rdap_valid { query } {
	if [string equal "" $query] then {
		return 0
	}
	return [regexp {^[A-Za-z0-9][A-Za-z0-9._-]*$} $query]
}

proc rdap_pub { nick host hand chan text } {
	global rdapbin
	set query [sanitize_string [string trim "${text}"]]
	putlog "rdap pub: $nick $host $hand $chan $query"
	if ![rdap_valid $query] then {
		putchan $chan "usage: !rdap <domain>"
		return
	}
	set fd [open "|${rdapbin} ${query}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc rdap_msg { nick uhand handle input } {
	global rdapbin
	set query [sanitize_string [string trim "${input}"]]
	putlog "rdap msg: $nick $uhand $handle $query"
	if ![rdap_valid $query] then {
		putmsg "$nick" "usage: !rdap <domain>"
		return
	}
	set fd [open "|${rdapbin} ${query}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
