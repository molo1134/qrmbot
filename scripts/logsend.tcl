# Send #hamfest logs via DCC

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !hamfestlog  dcchamfestlog
bind pub - !hamfestlog2 dcchamfestlog2
bind msg - !hamfestlog  dcchamfestlog_msg
bind msg - !hamfestlog2 dcchamfestlog2_msg

set hamfestlogfile "/home/eggdrop/qrm-reddit/logs/hamfest.log"
set hamfestlogfile2 "/home/eggdrop/qrm-reddit/logs/hamfest.log.yesterday"

proc dcchamfestlog { nick host hand chan text } {
	global hamfestlogfile
	putxferlog "!hamfestlog pub $nick $chan"
	dccsend $hamfestlogfile $nick
}
proc dcchamfestlog2 { nick host hand chan text } {
	global hamfestlogfile2
	putxferlog "!hamfestlog2 pub $nick $chan"
	dccsend $hamfestlogfile2 $nick
}

proc dcchamfestlog_msg {nick uhand handle input} {
	global hamfestlogfile
	putxferlog "!hamfestlog msg $nick"
	set result [dccsend $hamfestlogfile $nick]
	if { $result != 0 } {
		putmsg $nick "error: $result"
		putxferlog "hamfestlog error: $result"
	}
}
proc dcchamfestlog2_msg {nick uhand handle input} {
	global hamfestlogfile2
	putxferlog "!hamfestlog2 msg $nick"
	set result [dccsend $hamfestlogfile2 $nick]
	if { $result != 0 } {
		putmsg $nick "error: $result"
		putxferlog "hamfestlog2 error: $result"
	}
}
