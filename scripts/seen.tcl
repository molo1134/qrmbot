# a simple seen script

# Returns: number of minutes that person has been idle; 0 if the specified user
# isn't on the channel
#getchanidle <nick> <channel>

# returns a list containing the unixtime last seen and the last seen place.
# LASTON #channel returns the time last seen time for the channel or 0 if no
# info exists.
#getuser <handle> LASTON

bind pub - !seen seen_pub

proc seen_pub { nick host hand chan text } {
	global botnick
	putlog "seen pub: $nick $host $hand $chan $text"
	set target [sanitize_string [string trim ${text}]]
	set target [string tolower $target]
	set nick [string tolower $nick]

	if {${target} == ${nick}} {
		putchan $chan "welp, there you are."
		return
	}
	if {${target} == [string tolower ${botnick}] } {
		putchan $chan "https://www.youtube.com/watch?v=8qpQhBFBhwg&t=6m40s"
		return
	}

	if { [onchan ${target} $chan] } {
		set idle [getchanidle ${target} $chan]
		putchan $chan "${target} idle $idle minutes"
	} elseif { [validuser ${target}] } {
		set laston [getuser ${target} LASTON $chan]
		if {$laston != 0} {
			set stamp [clock format $laston -gmt 1 -format "%Y-%m-%d %H:%M:%S %Z"]
			putchan $chan "${target} last seen at $stamp"
		} else {
			putchan $chan "${target} not found"
		}

	} else {
		putchan $chan "${target} not found"
	}
}
