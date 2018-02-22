# IRC channel topic refresh
#
# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !topic report_topic
bind pub - !topicrefresh refresh_topic

proc report_topic { nick hostmask handle channel args } {
    if { [topic $channel] == "" } {
    	putchan $channel "No topic set."
    } else {
    	putchan $channel "I see topic: [topic $channel]"
    }
}

proc refresh_topic { nick hostmask handle channel args } {
    if { [topic $channel] == "" } {
        putchan $channel "No topic set."
    } else {
        putserv "TOPIC $channel :[topic $channel]"
    }
}

putlog "Topic refresh loaded."

