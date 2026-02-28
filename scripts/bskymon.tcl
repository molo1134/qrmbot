# Bluesky account monitor -- polls accounts every 5 minutes and announces
# new posts to the configured channels.
#
# To add an account: append a {actor channel} pair to bskymon_accounts below.
#
# 2-clause BSD license.
# Copyright (c) 2025 molo1134@github. All rights reserved.

set bskymonbin "/home/eggdrop/bin/bskymon"
set bskymonperiod 5	;# minutes

# List of {actor channel} pairs to monitor.
# actor  = Bluesky handle (e.g. bnonews.com or someone.bsky.social)
# channel = IRC channel to announce to
set bskymon_accounts {
    {bnonews.com  #redditnet}
}

proc check_bskymon {} {
	global bskymonbin bskymonperiod bskymon_accounts
	foreach entry $bskymon_accounts {
		set actor   [lindex $entry 0]
		set channel [lindex $entry 1]
		set fd [open "|${bskymonbin} --actor ${actor}" r]
		fconfigure $fd -encoding utf-8
		while {[gets $fd line] >= 0} {
			if {[string length $line] > 0} {
				putchan $channel "$line"
			}
		}
		catch { close $fd }
	}
	timer $bskymonperiod check_bskymon
}

# Auto-start on script load; timerexists guard prevents duplicate timer on rehash
if {[timerexists "check_bskymon"] == ""} {
	timer $bskymonperiod check_bskymon
}

putlog "bskymon: loaded, polling [llength $bskymon_accounts] account(s) every ${bskymonperiod} min"
