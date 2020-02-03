# a simple see script

# Returns: Whether or not the bot sees the specified user

bind pub - !see see_pub

proc see_pub { nick host hand chan text } {
	global botnick
	putlog "see pub: $nick $host $hand $chan $text"
	set origQuery [sanitize_string [string trim ${text}]]
	set target [string tolower $origQuery]
	set nick [string tolower $nick]

	if {${target} == ${nick}} {
		putchan $chan "Yes, I see you. UGH."
		return
	}
	if {${target} == [string tolower ${botnick}] } {
		putchan $chan "http://youtu.be/JHAc9nw2qrs?t=381"
		return
	}

	if { [onchan ${target} $chan] } {
		putchan $chan "I SEENT ${origQuery}"
	} elseif { [validuser ${target}] } {
		putchan $chan "Maybe I seent ${origQuery}, maybe I didn't. What's it to you?"
		} else {
			putchan $chan "What's a ${origQuery}?"
		}

	} else {
		putchan $chan "${origQuery}? That's a funny name."
	}
}
