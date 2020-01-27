# Display prices of crypto currencies

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !crypto crypto_pub
bind msg - !crypto crypto_msg

bind pub - !bitcoin btc_pub
bind pub - !btc btc_pub
bind msg - !bitcoin btc_msg
bind msg - !btc btc_msg

bind pub - !litecoin ltc_pub
bind pub - !ltc ltc_pub
bind msg - !litecoin ltc_msg
bind msg - !ltc ltc_msg

bind pub - !etherium eth_pub
bind pub - !eth eth_pub
bind msg - !etherium eth_msg
bind msg - !eth eth_msg

bind pub - !doge doge_pub
bind msg - !doge doge_msg

# load utility methods
source scripts/util.tcl

set btcbin "/home/eggdrop/bin/btc"

proc btc_msg {nick uhand handle input} {
	crypto_msg $nick $uhand $handle "BTC $input"
}
proc ltc_msg {nick uhand handle input} {
	crypto_msg $nick $uhand $handle "LTC $input"
}
proc eth_msg {nick uhand handle input} {
	crypto_msg $nick $uhand $handle "ETH $input"
}
proc doge_msg {nick uhand handle input} {
	crypto_msg $nick $uhand $handle "DOGE $input"
}

proc crypto_msg {nick uhand handle input} {
	global btcbin
	set input [sanitize_string [string trim ${input}]]

	putlog "crypto msg: $nick $uhand $handle $input"

	set fd [open "|${btcbin} ${input}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

proc btc_pub { nick host hand chan input } {
	crypto_pub $nick $host $hand $chan "BTC $input"
}
proc ltc_pub { nick host hand chan input } {
	crypto_pub $nick $host $hand $chan "LTC $input"
}
proc eth_pub { nick host hand chan input } {
	crypto_pub $nick $host $hand $chan "ETH $input"
}
proc doge_pub { nick host hand chan input } {
	crypto_pub $nick $host $hand $chan "DOGE $input"
}

proc crypto_pub { nick host hand chan input } {
	global btcbin
	set input [sanitize_string [string trim ${input}]]

	putlog "crypto pub: $nick $host $hand $chan $input"

	set fd [open "|${btcbin} ${input}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

putlog "Crypto utils loaded."

