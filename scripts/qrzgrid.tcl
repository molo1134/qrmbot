# An eggdrop TCL script to bind commands to callsign and grid lookup.

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !qrz qrz
bind pub - !call qrz

bind msg - !qrz msg_qrz
bind msg - !call msg_qrz

bind pub - !setgeo qrz_setgeo_pub
bind msg - !setgeo qrz_setgeo_msg

bind pub - !getgeo qrz_getgeo_pub
bind msg - !getgeo qrz_getgeo_msg

bind pub - !grid grid
bind pub - !qth grid

bind msg - !grid msg_grid
bind msg - !qth msg_grid

bind pub - !time timezone
bind pub - !tz timezone
bind msg - !time msg_timezone
bind msg - !tz msg_timezone

bind pub - !bands bands
bind msg - !bands msg_bands

bind pub - !solar solar
bind msg - !solar msg_solar

bind pub - !solarforecast solarforecast
bind msg - !solarforecast msg_solarforecast
bind pub - !forecast solarforecast
bind msg - !forecast msg_solarforecast

bind pub - !xray xray
bind msg - !xray msg_xray

bind pub - !lotw lotw
bind msg - !lotw msg_lotw

bind pub - !eqsl eqsl
bind msg - !eqsl msg_eqsl

bind pub - !dxcc dxcc
bind msg - !dxcc msg_dxcc

bind pub - !spots spots
bind msg - !spots msg_spots

#bind pub - !addspot addspot
#bind msg - !addspot msg_addspot

#bind pub - !delspot delspot
#bind msg - !delspot msg_delspot

#bind pub - !stopspots stop_spots
#bind pub - !startspots start_spots

bind pub - !z utc
bind msg - !z utc_msg
bind pub - !utc utc
bind msg - !utc utc_msg

bind pub - !contests contests
bind msg - !contests contests_msg

bind pub - !activity activity
bind msg - !activity activity_msg

bind pub - !ki kindex
bind pub - !kf kindex
bind pub - !kindex kindex
bind msg - !ki kindex_msg
bind msg - !kf kindex_msg
bind msg - !kindex kindex_msg

bind pub - !cw morse_pub
bind pub - !morse morse_pub
bind pub - !demorse unmorse_pub
bind pub - !unmorse unmorse_pub
bind msg - !cw morse_msg
bind msg - !morse morse_msg
bind msg - !demorse unmorse_msg
bind msg - !unmorse unmorse_msg

bind pub - !repeater repeater_pub
bind pub - !rep repeater_pub
bind msg - !repeater repeater_msg
bind msg - !rep repeater_msg

bind msg - !aprs aprs_msg
bind pub - !aprs aprs_pub

bind msg - !muf muf_msg
bind pub - !muf muf_pub
bind msg - !muf2 muf2_msg
bind pub - !muf2 muf2_pub

bind msg - !eme eme_msg
bind pub - !eme eme_pub
bind msg - !moon moon_msg
bind pub - !moon moon_pub
bind msg - !sun sun_msg
bind pub - !sun sun_pub
bind msg - !graves graves_msg
bind pub - !graves graves_pub

bind msg - !sat sat_msg
bind pub - !sat sat_pub

bind msg - !spacex spacex_msg
bind pub - !spacex spacex_pub

bind msg - !qcode qcode_msg
bind pub - !qcode qcode_pub
bind msg - !q qcode_msg
bind pub - !q qcode_pub

set qrzbin "/home/eggdrop/bin/qrz"
set gridbin "/home/eggdrop/bin/grid"
set tzbin "/home/eggdrop/bin/timezone"
set bandsbin "/home/eggdrop/bin/bands"
set xraybin "/home/eggdrop/bin/xray"
set forecastbin "/home/eggdrop/bin/solarforecast"
set lotwbin "/home/eggdrop/bin/lotwcheck"
set eqslbin "/home/eggdrop/bin/eqslcheck"
set dxccbin "/home/eggdrop/bin/dxcc"
set spotsbin "/home/eggdrop/bin/spots"
set contestsbin "/home/eggdrop/bin/contests"
set activitybin "/home/eggdrop/bin/activity"
set kindexbin "/home/eggdrop/bin/kindex"
set morsebin "/home/eggdrop/bin/morse"
set unmorsebin "/home/eggdrop/bin/unmorse"
set repeaterbin "/home/eggdrop/bin/repeater"
set aprsbin "/home/eggdrop/bin/aprs"
set mufbin "/home/eggdrop/bin/muf"
set muf2bin "/home/eggdrop/bin/muf2"
set astrobin "/home/eggdrop/bin/astro"
set satbin "/home/eggdrop/bin/sat"
set spacexbin "/home/eggdrop/bin/spacex"
set qcodebin "/home/eggdrop/bin/qcode"

set spotfile spotlist

# load utility methods
source scripts/util.tcl


proc qrz { nick host hand chan text } {
	global qrzbin
	set callsign [sanitize_string [string trim ${text}]]
	set geo [qrz_getgeo $hand]

	putlog "qrz pub: $nick $host $hand $chan $callsign $geo"

	if [string equal "" $geo] then {
		catch {exec ${qrzbin} ${callsign} --compact } data
	} else {
		catch {exec ${qrzbin} ${callsign} --compact --geo $geo } data
	}

	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}


proc msg_qrz {nick uhand handle input} {
	global qrzbin
	set callsign [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]

	putlog "qrz msg: $nick $uhand $handle $callsign $geo"

	if [string equal "" $geo] then {
		catch {exec ${qrzbin} ${callsign}} data
	} else {
		catch {exec ${qrzbin} ${callsign} --geo $geo } data
	}

	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc qrz_setgeo_pub { nick host hand chan text } {
	putlog "setgeo pub: $nick $host $hand $chan $text"
	qrz_setgeo $nick $hand $text
}
proc qrz_setgeo_msg { nick uhand handle input } {
	putlog "setgeo msg: $nick $uhand $handle $input"
	qrz_setgeo $nick $handle $input
}

proc qrz_getgeo_pub { nick host hand chan text } {
	putlog "getgeo pub: $nick $host $hand $chan $text"
	set geo [qrz_getgeo $hand]
	putchan $chan "$hand: $geo"
}
proc qrz_getgeo_msg { nick uhand handle input } {
	putlog "getgeo msg: $nick $uhand $handle $input"
	set geo [qrz_getgeo $handle]
	putmsg $nick "$geo"
}

proc qrz_setgeo { nick handle input } {
	global geofile

	if {$handle == "*"} {
		putnotc $nick "this command is valid only for registered bot users."
		return
	}

	if { $input == {} } {
		putnotc $nick "usage  : !setgeo <latitude>,<longitude>"
		putnotc $nick "example: !setgeo 39.735154,-77.421129"
		putnotc $nick "(note there is no whitespace)"
		return
	}

	if [ regexp "^-?\\d+\\.\\d+,-?\\d+\\.\\d+$" "$input" ] then {
	} else {
		putnotc $nick "error, invalid input: $input"
		return
	}

	set entry [list]
	lappend entry $handle
	lappend entry [unixtime]
	lappend entry $input

	if { ![file exists $geofile] } {
		# no records, write new file
		set gf [open $geofile w]
		puts $gf $entry
		close $gf
	} else {
		# modify existing file
		# FIXME: beware race condition.  make sure that files are
		# regular and not a symlink, etc.
		set tmpfile "geotmp"
		set orig [open $geofile r]
		set dest [open $tmpfile w+]
		set found 0

		while {![eof $orig]} {
			set line [gets $orig]
			if {[lindex $line 0] == $handle} {
				puts $dest $entry
				set found 1
			} elseif {![eof $orig]} {
				puts $dest $line
			}
		}

		if {$found == 0} {
			puts $dest $entry
		}
		putlog "added geo: $entry"

		close $orig
		close $dest

		file delete -force $geofile
		file copy -force $tmpfile $geofile
		file delete -force $tmpfile
	}
	putnotc $nick "set geo coords: $input"
}

proc grid { nick host hand chan text } {
	global gridbin
	set grid [sanitize_string [string trim ${text}]]
	set geo [qrz_getgeo $hand]

	putlog "grid pub: $nick $host $hand $chan $grid $geo"

	if [string equal "" $geo] then {
		catch {exec ${gridbin} ${grid}} data
	} else {
		catch {exec ${gridbin} ${grid} --geo $geo } data
	}

	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}


proc msg_grid {nick uhand handle input} {
	global gridbin
	set grid [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]

	putlog "grid msg: $nick $uhand $handle $grid $geo"

	if [string equal "" $geo] then {
		catch {exec ${gridbin} ${grid}} data
	} else {
		catch {exec ${gridbin} ${grid} --geo $geo } data
	}

	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc timezone { nick host hand chan text } {
	global tzbin
	set timezone [sanitize_string [string trim ${text}]]
	set geo [qrz_getgeo $hand]

	putlog "timezone pub: $nick $host $hand $chan $timezone $geo"

	if [string equal "" $geo] then {
		catch {exec ${tzbin} ${timezone}} data
	} else {
		catch {exec ${tzbin} ${timezone} --geo $geo } data
	}

	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}


proc msg_timezone {nick uhand handle input} {
	global tzbin
	set timezone [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]

	putlog "timezone msg: $nick $uhand $handle $timezone $geo"

	if [string equal "" $geo] then {
		catch {exec ${tzbin} ${timezone}} data
	} else {
		catch {exec ${tzbin} ${timezone} --geo $geo } data
	}

	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}


proc bands { nick host hand chan text } {
	global bandsbin
	putlog "bands pub: $nick $host $hand $chan $text"
	catch {exec ${bandsbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}

proc msg_bands {nick uhand handle input} {
	global bandsbin
	putlog "bands msg: $nick $uhand $handle $input"
	catch {exec ${bandsbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}
##
proc solar { nick host hand chan text } {
	global bandsbin
	putlog "solar pub: $nick $host $hand $chan $text"
	catch {exec ${bandsbin} "-q"} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}

proc msg_solar {nick uhand handle input} {
	global bandsbin
	putlog "solar msg: $nick $uhand $handle $input"
	catch {exec ${bandsbin} "-q"} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}
##
proc solarforecast { nick host hand chan text } {
	global forecastbin
	catch {exec ${forecastbin} } data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}

proc msg_solarforecast {nick uhand handle input} {
	global forecastbin
	catch {exec ${forecastbin} } data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc xray { nick host hand chan text } {
	global xraybin
	catch {exec ${xraybin} } data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}

proc msg_xray {nick uhand handle input} {
	global xraybin
	catch {exec ${xraybin} } data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc lotw { nick host hand chan text } {
	global lotwbin
	set call [sanitize_string [string trim ${text}]]
	putlog "lotw pub: $nick $host $hand $chan $call"
	catch {exec ${lotwbin} ${call}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}
proc msg_lotw {nick uhand handle input} {
	global lotwbin
	set call [sanitize_string [string trim ${input}]]
	putlog "lotw msg: $nick $uhand $handle $call"
	catch {exec ${lotwbin} ${call}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}

proc eqsl { nick host hand chan text } {
	global eqslbin
	set call [sanitize_string [string trim ${text}]]
	putlog "eqsl pub: $nick $host $hand $chan $call"
	catch {exec ${eqslbin} ${call}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc msg_eqsl {nick uhand handle input} {
	global eqslbin
	set call [sanitize_string [string trim ${input}]]
	putlog "eqsl msg: $nick $uhand $handle $call"
	catch {exec ${eqslbin} ${call}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc dxcc { nick host hand chan text } {
	global dxccbin
	set call [sanitize_string [string trim ${text}]]
	putlog "dxcc pub: $nick $host $hand $chan $call"
	catch {exec ${dxccbin} ${call}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}
proc msg_dxcc {nick uhand handle input} {
	global dxccbin
	set call [sanitize_string [string trim ${input}]]
	putlog "dxcc msg: $nick $uhand $handle $call"
	catch {exec ${dxccbin} ${call}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}

proc spots { nick host hand chan text } {
	global spotsbin
	set input [sanitize_string [string trim ${text}]]
	putlog "spots pub: $nick $host $hand $chan $input"
	catch {exec ${spotsbin} ${input}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}
proc msg_spots {nick uhand handle input} {
	global spotsbin
	set input [sanitize_string [string trim ${input}]]
	putlog "spots msg: $nick $uhand $handle $input"
	catch {exec ${spotsbin} ${input}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}


proc msg_addspot {nick uhand handle input} {
	global spotfile
	putlog "addspot msg: $nick $uhand $handle $input"
	if {$handle == "*"} {
		putnotc $nick "this command is valid only for registered bot users."
		return
	}

	if { $input == {} } {
		putnotc $nick "usage  : !addspot <callsign>"
		putnotc $nick "periodically checks for new spots for the given callsign"
		return
	}

	set input [string toupper $input]

	if [ regexp {^[A-Z0-9/]+$} "$input" ] then {
	} else {
		putnotc $nick "error, invalid input: $input"
		return
	}

	set entry [list]
	lappend entry $handle
	lappend entry $input
	lappend entry "msg"
	lappend entry [unixtime]

	if { ![file exists $spotfile] } {
		# no records, write new file
		set gf [open $spotfile w]
		puts $gf $entry
		close $gf
	} else {
		# modify existing file
		# FIXME: beware race condition.  make sure that files are
		# regular and not a symlink, etc.
		set tmpfile "spottmp"
		set orig [open $spotfile r]
		set dest [open $tmpfile w+]
		set found 0

		while {![eof $orig]} {
			set line [gets $orig]
			if {[lindex $line 0] == $handle && [lindex $line 1] == $input} {
				puts $dest $entry
				set found 1
			} elseif {![eof $orig]} {
				puts $dest $line
			}
		}

		if {$found == 0} {
			puts $dest $entry
		}
		putlog "added spot: $entry"

		close $orig
		close $dest

		file delete -force $spotfile
		file copy -force $tmpfile $spotfile
		file delete -force $tmpfile
	}
	putnotc $nick "set periodic spot check: $input"
}

proc addspot { nick host handle chan text } {
	global spotfile
	putlog "addspot pub: $nick $host $handle $chan $text"
	if {$handle == "*"} {
		putnotc $nick "this command is valid only for registered bot users."
		return
	}

	if { $text == {} } {
		putnotc $nick "usage  : !addspot <callsign>"
		putnotc $nick "periodically checks for new spots for the given callsign"
		return
	}

	set text [string toupper $text]

	if [ regexp {^[A-Z0-9/]+$} "$text" ] then {
	} else {
		putnotc $nick "error, invalid input: $text"
		return
	}

	set entry [list]
	lappend entry $handle
	lappend entry $text
	lappend entry $chan
	lappend entry [unixtime]

	if { ![file exists $spotfile] } {
		# no records, write new file
		set gf [open $spotfile w]
		puts $gf $entry
		close $gf
	} else {
		# modify existing file
		# FIXME: beware race condition.  make sure that files are
		# regular and not a symlink, etc.
		set tmpfile "spottmp"
		set orig [open $spotfile r]
		set dest [open $tmpfile w+]
		set found 0

		while {![eof $orig]} {
			set line [gets $orig]
			if {[lindex $line 1] == $text && [lindex $line 2] == $chan} {
				puts $dest $entry
				set found 1
			} elseif {![eof $orig]} {
				puts $dest $line
			}
		}

		if {$found == 0} {
			puts $dest $entry
		}
		putlog "added spot: $entry"

		close $orig
		close $dest

		file delete -force $spotfile
		file copy -force $tmpfile $spotfile
		file delete -force $tmpfile
	}
}

proc delspot { nick host handle chan text } {
	global spotfile
	putlog "delspot pub: $nick $host $handle $chan $text"
	if {$handle == "*"} {
		putnotc $nick "this command is valid only for registered bot users."
		return
	}

	if { $text == {} } {
		putnotc $nick "usage  : !delspot <callsign>"
		putnotc $nick "removes periodic check for new spots for the given callsign"
		return
	}

	set text [string toupper $text]

	if [ regexp {^[A-Z0-9/]+$} "$text" ] then {
	} else {
		putnotc $nick "error, invalid input: $text"
		return
	}

	if { ![file exists $spotfile] } {
		# no records
		putnotc $nick "spot file not found"
		return
	}

	# modify existing file
	# FIXME: beware race condition.  make sure that files are
	# regular and not a symlink, etc.
	set tmpfile "spottmp"
	set orig [open $spotfile r]
	set dest [open $tmpfile w+]
	set found 0
	while {![eof $orig]} {
		set line [gets $orig]
		if {[lindex $line 1] == $text && [lindex $line 2] == $chan} {
			#puts $dest $entry
			set found 1
		} elseif {![eof $orig]} {
			puts $dest $line
		}
	}
	if {$found == 0} {
		putnotc $nick "not found"
	} else {
		putlog "removed spot: $text"
		putnotc $nick "removed spot: $text"
	}

	close $orig
	close $dest

	file delete -force $spotfile
	file copy -force $tmpfile $spotfile
	file delete -force $tmpfile
}

proc msg_delspot {nick uhand handle input} {
	global spotfile
	putlog "delspot msg: $nick $uhand $handle $input"
	if {$handle == "*"} {
		putnotc $nick "this command is valid only for registered bot users."
		return
	}

	if { $input == {} } {
		putnotc $nick "usage  : !delspot <callsign>"
		putnotc $nick "removes periodic check for new spots for the given callsign"
		return
	}

	set input [string toupper $input]

	if [ regexp {^[A-Z0-9/]+$} "$input" ] then {
	} else {
		putnotc $nick "error, invalid input: $input"
		return
	}

	if { ![file exists $spotfile] } {
		# no records
		putnotc $nick "spot file not found"
		return
	}

	# modify existing file
	# FIXME: beware race condition.  make sure that files are
	# regular and not a symlink, etc.
	set tmpfile "spottmp"
	set orig [open $spotfile r]
	set dest [open $tmpfile w+]
	set found 0
	while {![eof $orig]} {
		set line [gets $orig]
		if {[lindex $line 0] == $handle &&
				[lindex $line 1] == $input &&
				[lindex $line 2] == "msg"} {
			#puts $dest $entry
			set found 1
		} elseif {![eof $orig]} {
			puts $dest $line
		}
	}
	if {$found == 0} {
		putnotc $nick "not found"
	} else {
		putlog "removed spot: $input"
		putnotc $nick "removed spot: $input"
	}

	close $orig
	close $dest

	file delete -force $spotfile
	file copy -force $tmpfile $spotfile
	file delete -force $tmpfile
}

# do periodic spots on startup
#set spottimerperiod 10
#if {[timerexists "check_spots"] == ""} {
#	timer $spottimerperiod check_spots
#}

# periodicly called by timer
proc check_spots {} {
	# do stuff
	#putnotc molo "timer"

	global spotfile
	if { [file exists $spotfile] } {
		set input [open $spotfile r]
		while {![eof $input]} {
			set line [gets $input]

			if { $line == "" } {
				continue
			}

			set handle [lindex $line 0]
			set call [lindex $line 1]
			set chan [lindex $line 2]
			set ts [lindex $line 3]
			set nick [hand2nick $handle]

			#putnotc molo "handle: $handle nick: $nick call: $call chan: $chan"

			if { $chan == "msg" && $nick != "" } {
				msg_spots $nick "" $handle "--mon $call"
			} else {
				spots $nick "" $handle $chan "--mon $call"
			}
		}
		close $input
	}

	global spottimerperiod
	timer $spottimerperiod check_spots
	return 1;
}

proc stop_spots { nick host handle chan text } {
	if {$handle == "*"} {
		putnotc $nick "this command is valid only for registered bot users."
		return
	}

	if {[timerexists "check_spots"] != ""} {
		killtimer [timerexists "check_spots"]
	}
	putchan $chan "timer stopped"
}

proc start_spots { nick host handle chan text } {
	if {$handle == "*"} {
		putnotc $nick "this command is valid only for registered bot users."
		return
	}

	global spottimerperiod
	if {[timerexists "check_spots"] == ""} {
		timer $spottimerperiod check_spots
	}
	putchan $chan "timer started"
}

proc utc { nick host handle chan text } {
	putlog "utc pub: $nick $host $handle $chan $text"
	set time [unixtime]
	set fmt [clock format $time -gmt "true" -format "%Y-%m-%d %T UTC"]
	putchan $chan $fmt
}
proc utc_msg {nick uhand handle input} {
	putlog "utc msg: $nick $uhand $handle $input"
	set time [unixtime]
	set fmt [clock format $time -gmt "true" -format "%Y-%m-%d %T UTC"]
	putmsg $nick $fmt
}

proc contests { nick host hand chan text } {
	global contestsbin
	putlog "contests pub: $nick $host $hand $chan $text"
	catch {exec ${contestsbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}
proc contests_msg {nick uhand handle input} {
	global contestsbin
	putlog "contests msg: $nick $uhand $handle $input"
	catch {exec ${contestsbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}

proc activity { nick host hand chan text } {
	global activitybin
	set params [sanitize_string [string trim ${text}]]
	putlog "activity pub: $nick $host $hand $chan $params"
	catch {exec ${activitybin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc activity_msg {nick uhand handle input} {
	global activitybin
	set params [sanitize_string [string trim ${input}]]
	putlog "activity msg: $nick $uhand $handle $params"
	catch {exec ${activitybin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc kindex { nick host hand chan text } {
	global kindexbin
	putlog "kindex pub: $nick $host $hand $chan $text"
	catch {exec ${kindexbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc kindex_msg {nick uhand handle input} {
	global kindexbin
	putlog "kindex msg: $nick $uhand $handle $input"
	catch {exec ${kindexbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc morse_pub { nick host hand chan text } {
	global morsebin
	set msg [sanitize_string [string trim ${text}]]
	putlog "morse pub: $nick $host $hand $chan $msg"
	catch {exec ${morsebin} ${msg}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}
proc morse_msg {nick uhand handle input} {
	global morsebin
	set msg [sanitize_string [string trim ${input}]]
	putlog "morse msg: $nick $uhand $handle $msg"
	catch {exec ${morsebin} ${msg}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}

proc unmorse_pub { nick host hand chan text } {
	global unmorsebin
	set msg [sanitize_string [string trim ${text}]]
	putlog "unmorse pub: $nick $host $hand $chan $msg"
	catch {exec ${unmorsebin} ${msg}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc unmorse_msg {nick uhand handle input} {
	global unmorsebin
	set msg [sanitize_string [string trim ${input}]]
	putlog "unmorse msg: $nick $uhand $handle $msg"
	catch {exec ${unmorsebin} ${msg}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc repeater_pub { nick host hand chan text } {
	global repeaterbin
	set msg [sanitize_string [string trim ${text}]]
	putlog "repeater pub: $nick $host $hand $chan $msg"
	catch {exec ${repeaterbin} ${msg}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc repeater_msg {nick uhand handle input} {
	global repeaterbin
	set msg [sanitize_string [string trim ${input}]]
	putlog "repeater msg: $nick $uhand $handle $msg"
	catch {exec ${repeaterbin} ${msg}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc aprs_pub { nick host hand chan text } {
	global aprsbin
	set params [sanitize_string [string trim ${text}]]
	putlog "aprs pub: $nick $host $hand $chan $params"
	catch {exec ${aprsbin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc aprs_msg {nick uhand handle input} {
	global aprsbin
	set params [sanitize_string [string trim ${input}]]
	putlog "aprs msg: $nick $uhand $handle $params"
	catch {exec ${aprsbin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc muf_pub { nick host hand chan text } {
	global mufbin
	set params [sanitize_string [string trim ${text}]]
	putlog "muf pub: $nick $host $hand $chan $params"
	catch {exec ${mufbin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		# list via msg
		if [string equal "list" $params] then {
			putmsg $nick [encoding convertto utf-8 "$line"]
		} else {
			putchan $chan [encoding convertto utf-8 "$line"]
		}
	}
}
proc muf_msg {nick uhand handle input} {
	global mufbin
	set params [sanitize_string [string trim ${input}]]
	putlog "muf msg: $nick $uhand $handle $params"
	catch {exec ${mufbin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc muf2_pub { nick host hand chan text } {
	global muf2bin
	set params [sanitize_string [string trim ${text}]]
	putlog "muf2 pub: $nick $host $hand $chan $params"
	catch {exec ${muf2bin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		# list via msg
		if [string equal "list" $params] then {
			putmsg $nick [encoding convertto utf-8 "$line"]
		} else {
			putchan $chan [encoding convertto utf-8 "$line"]
		}
	}
}
proc muf2_msg {nick uhand handle input} {
	global muf2bin
	set params [sanitize_string [string trim ${input}]]
	putlog "muf2 msg: $nick $uhand $handle $params"
	catch {exec ${muf2bin} ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc eme_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim ${text}]]
	set geo [qrz_getgeo $hand]
	putlog "eme pub: $nick $host $hand $chan $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		catch {exec ${astrobin} --eme ${params}} data
	} else {
		catch {exec ${astrobin} --eme ${geo} ${params}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc eme_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]
	putlog "eme msg: $nick $uhand $handle $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		catch {exec ${astrobin} --eme ${params}} data
	} else {
		catch {exec ${astrobin} --eme ${geo} ${params}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc moon_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim ${text}]]
	set geo [qrz_getgeo $hand]
	putlog "moon pub: $nick $host $hand $chan $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		catch {exec ${astrobin} --moon ${params}} data
	} else {
		catch {exec ${astrobin} --moon ${geo} ${params}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc moon_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]
	putlog "moon msg: $nick $uhand $handle $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		catch {exec ${astrobin} --moon ${params}} data
	} else {
		catch {exec ${astrobin} --moon ${geo} ${params}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc sun_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim ${text}]]
	set geo [qrz_getgeo $hand]
	putlog "sun pub: $nick $host $hand $chan $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		catch {exec ${astrobin} --sun ${params}} data
	} else {
		catch {exec ${astrobin} --sun ${geo} ${params}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc sun_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]
	putlog "sun msg: $nick $uhand $handle $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		catch {exec ${astrobin} --sun ${params}} data
	} else {
		catch {exec ${astrobin} --sun ${geo} ${params}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc graves_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim ${text}]]
	putlog "graves pub: $nick $host $hand $chan $params"
	catch {exec ${astrobin} --graves ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc graves_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim ${input}]]
	putlog "graves msg: $nick $uhand $handle $params"
	catch {exec ${astrobin} --graves ${params}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc sat_pub { nick host hand chan text } {
	global satbin
	set params [sanitize_string [string trim ${text}]]
	set geo [qrz_getgeo $hand]
	putlog "sat pub: $nick $host $hand $chan $geo $params"
	if {(( [string equal "" $geo] )  )} then {
		catch {exec ${satbin} ${params}} data
	} else {
		catch {exec ${satbin} ${params} ${geo}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		# list via msg
		if [string equal "list" $params] then {
			putmsg $nick [encoding convertto utf-8 "$line"]
		} else {
			putchan $chan [encoding convertto utf-8 "$line"]
		}
	}
}
proc sat_msg {nick uhand handle input} {
	global satbin
	set params [sanitize_string [string trim ${input}]]
	set geo [qrz_getgeo $handle]
	putlog "sat msg: $nick $uhand $handle $geo $params"
	if {(( [string equal "" $geo] ))} then {
		catch {exec ${satbin} ${params}} data
	} else {
		catch {exec ${satbin} ${params} ${geo}} data
	}
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}

proc spacex_pub { nick host hand chan text } {
	global spacexbin
	putlog "spacex pub: $nick $host $hand $chan $text"
	catch {exec ${spacexbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan [encoding convertto utf-8 "$line"]
	}
}
proc spacex_msg {nick uhand handle input} {
	global spacexbin
	putlog "spacex msg: $nick $uhand $handle $input"
	catch {exec ${spacexbin}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick [encoding convertto utf-8 "$line"]
	}
}


proc qcode_pub { nick host hand chan text } {
	global qcodebin
	set msg [sanitize_string [string trim ${text}]]
	putlog "qcode pub: $nick $host $hand $chan $msg"
	catch {exec ${qcodebin} ${msg}} data
	set output [split $data "\n"]
	foreach line $output {
		putchan $chan "$line"
	}
}
proc qcode_msg {nick uhand handle input} {
	global qcodebin
	set msg [sanitize_string [string trim ${input}]]
	putlog "qcode msg: $nick $uhand $handle $msg"
	catch {exec ${qcodebin} ${msg}} data
	set output [split $data "\n"]
	foreach line $output {
		putmsg $nick "$line"
	}
}

putlog "Ham utils loaded."

