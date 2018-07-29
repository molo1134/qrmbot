
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
}

