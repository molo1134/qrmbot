# http link announcer
#

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

# From the eggdrop command reference:

#    (5)  MSGM (stackable)
#         bind msgm <flags> <mask> <proc>
#         procname <nick> <user@host> <handle> <text>
#
#         Description: matches the entire line of text from a /msg with the
#           mask. This is useful for binding Tcl procs to words or phrases
#           spoken anywhere within a line of text. If the proc returns 1,
#           Eggdrop will not log the message that triggered this bind.
#           MSGM binds are processed before MSG binds. If the exclusive-binds
#           setting is enabled, MSG binds will not be triggered by text that
#           a MSGM bind has already handled.
#         Module: server
#
#    (6)  PUBM (stackable)
#         bind pubm <flags> <mask> <proc>
#         procname <nick> <user@host> <handle> <channel> <text>

# needed to check for +r users on undernet-type networks, as an anti-spam
# measure.
source scripts/isregistered.tcl

bind msgm - *://* http_msg
bind pubm - *://* http_pub
#bind msgm - *http://* http_msg
#bind pubm - *http://* http_pub
#bind msgm - *https://* http_msg
#bind pubm - *https://* http_pub

bind pub - !github github
bind msg - !github msg_github

set linkbin "/home/eggdrop/bin/linksummary"
set githublink "https://github.com/molo1134/qrmbot/"

proc http_msg { nick host hand text } {
	global linkbin
	global net-type

	if { ${net-type} == 2 && ! [isRegistered $nick] } { return }

	set params [sanitize_url [string trim ${text}]]
	putlog "http msg: $nick $host $hand $params"
	set fd [open "|${linkbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

# TODO FIXME XXX: add a blacklist of users that we don't process.
# Add spaceweatherbot to the blacklist

proc http_pub { nick host hand chan text } {
	global linkbin
	global net-type

	if { ${net-type} == 2 && ! [isRegistered $nick] } { return }

	if [string equal -nocase "SpaceWeatherBot" $nick] then {
	  return
	}

	set params [sanitize_url [string trim ${text}]]
	putlog "http pub: $nick $host $hand $chan $params"
	set fd [open "|${linkbin} ${params}" r]
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
	putmsg $nick "$githublink"
}
