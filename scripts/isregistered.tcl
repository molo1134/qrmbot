
bind raw - 352 rpl_whoreply

bind join - * who_onjoin
bind nkch - * who_nickchange

proc who_onjoin {nick uhost hand chan} {
	putserv "WHO $nick"
}

proc who_nickchange {nick uhost hand chan newnick} {
	# what about nickserv delay? FIXME
	# do utimer command
	putserv "WHO $newnick"
}

proc rpl_whoreply {from cmd text} {
	putlog "whoreply called; from: $from cmd: $cmd text: $text"
	set repl [split $text " "]
	putlog [append "reply 0: " [lindex $repl 0]]
	putlog [append "reply 1: " [lindex $repl 1]]
	putlog [append "reply 2: " [lindex $repl 2]]
	putlog [append "reply 3: " [lindex $repl 3]]
	putlog [append "reply 4: " [lindex $repl 4]]
	putlog [append "reply 5: " [lindex $repl 5]]
	putlog [append "reply 6: " [lindex $repl 6]]
	putlog [append "reply 7: " [lindex $repl 7]]
	putlog [append "reply 8: " [lindex $repl 8]]
}

