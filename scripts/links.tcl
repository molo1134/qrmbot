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

bind msgm - *http://* http_msg
bind pubm - *http://* http_pub
bind msgm - *https://* http_msg
bind pubm - *https://* http_pub

set linkbin "/home/eggdrop/bin/linksummary"

proc http_msg { nick host hand text } {
	global linkbin
	set params [sanitize_url [string trim ${text}]]
	putlog "http msg: $nick $host $hand $params"
	catch {exec ${linkbin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

# TODO FIXME XXX: add a blacklist of users that we don't process.
# Add spaceweatherbot to the blacklist

proc http_pub { nick host hand chan text } {
	global linkbin
	set params [sanitize_url [string trim ${text}]]
	putlog "http pub: $nick $host $hand $chan $params"
	catch {exec ${linkbin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
