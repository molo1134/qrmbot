# twitter announcer
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

bind msgm - *twitter.com/* twitter_msg
bind pubm - *twitter.com/* twitter_pub

bind msgm - */t.co/* twitter_msg
bind pubm - */t.co/* twitter_pub

set twitterbin "/home/eggdrop/bin/twitter"

# load utility methods
source scripts/util.tcl

proc twitter_msg { nick host hand text } {
	global twitterbin
	set params [sanitize_string [string trim ${text}]]
	putlog "twitter msg: $nick $host $hand $params"
	catch {exec ${twitterbin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc twitter_pub { nick host hand chan text } {
	global twitterbin
	set params [sanitize_string [string trim ${text}]]
	putlog "twitter pub: $nick $host $hand $chan $params"
	catch {exec ${twitterbin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
