# Retrieve external IP by using ipify.org.  Use external IP to set eggdrop
# nat-ip.  More on nat-ip follows.   http://api.ipify.org/

#    set nat-ip "127.0.0.1"
#      If you have a NAT firewall (you box has an IP in one of the following
#      ranges: 192.168.0.0-192.168.255.255, 172.16.0.0-172.31.255.255,
#      10.0.0.0-10.255.255.255 and your firewall transparently changes your
#      address to a unique address for your box) or you have IP masquerading
#      between you and the rest of the world, and /dcc chat, /ctcp chat or
#      userfile sharing aren't working, enter your outside IP here. This IP
#      is used for transfers only, and has nothing to do with the vhost4/6 or
#      listen-addr settings. You may still need to set them.

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

putlog "loading ipify..."

proc ipify {args} {
	package require http
	set url "http://api.ipify.org/"
	# timeout in millis 
	set timeout "5000"

	set token [::http::geturl $url -timeout $timeout]

	upvar 0 $token state

	if {[set status $state(status)] != "ok"} {
		putlog "ipify: status $status"
		::http::cleanup $token
		return ""
	}

	set data [::http::data $token]
	::http::cleanup $token
	putlog "ipify success: $data"
	return $data
}

# do lookup upon load
set publicip [ipify]
if {$publicip != ""} {
	putlog "setting nat-ip: $publicip"
	# global
	set nat-ip $publicip
}

