#
# Steam game info lookup.
#
# 2-clause BSD license.
# Copyright (c) 2025 cjh@github. All rights reserved.
#

bind pub - !steam steam_pub
bind msg - !steam steam_msg

set steambin "/home/eggdrop/bin/steam"

# load utility methods
source scripts/util.tcl

proc steam_pub { nick host hand chan text } {
	global steambin
	set query [sanitize_string [string trim "${text}"]]
	putlog "steam pub: $nick $host $hand $chan $query"
	if [string equal "" $query] then {
		putchan $chan "usage: !steam <game name>"
		return
	}
	set fd [open "|${steambin} ${query}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc steam_msg { nick uhand handle input } {
	global steambin
	set query [sanitize_string [string trim "${input}"]]
	putlog "steam msg: $nick $uhand $handle $query"
	if [string equal "" $query] then {
		putmsg "$nick" "usage: !steam <game name>"
		return
	}
	set fd [open "|${steambin} ${query}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
