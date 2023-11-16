# An eggdrop TCL script to bind commands to callsign and grid lookup.

# 2-clause BSD license.
# Copyright (c) 2018, 2019, 2020, 2022 molo1134@github. All rights reserved.
# Copyright (c) 2020 Andrew Rodland. All rights reserved.

bind pub - !qrz qrz
bind pub - !call qrz
bind pub - !dox dox_pub

bind msg - !qrz msg_qrz
bind msg - !call msg_qrz
bind msg - !dox msg_qrz

bind pub - !setgeo qrz_setgeo_pub
bind msg - !setgeo qrz_setgeo_msg

bind pub - !getgeo qrz_getgeo_pub
bind msg - !getgeo qrz_getgeo_msg

bind pub - !grid grid
bind pub - !qth grid

bind msg - !grid msg_grid
bind msg - !qth msg_grid

bind pub - !drive drive_pub
bind msg - !drive drive_msg
bind pub - !transit transit_pub
bind msg - !transit transit_msg

bind pub - !time timezone
bind pub - !tz timezone
bind msg - !time msg_timezone
bind msg - !tz msg_timezone

bind pub - !elev elev
bind msg - !elev msg_elev

bind pub - !bands bands
bind msg - !bands msg_bands

bind pub - !solar solar
bind msg - !solar msg_solar

bind pub - !solarforecast solarforecast
bind msg - !solarforecast msg_solarforecast
bind pub - !forecast solarforecast
bind msg - !forecast msg_solarforecast
bind pub - !longterm longtermforecast
bind msg - !longterm msg_longtermforecast

bind pub - !xray xray
bind msg - !xray msg_xray

bind pub - !lotw lotw
bind msg - !lotw msg_lotw
bind pub - !lotwstatus lotwstatus_pub
bind msg - !lotwstatus lotwstatus_msg
bind pub - !lotwqueue lotwstatus_pub
bind msg - !lotwqueue lotwstatus_msg

bind pub - !eqsl eqsl
bind msg - !eqsl msg_eqsl

bind pub - !oqrs pub_clublog
bind msg - !oqrs msg_clublog
bind pub - !clublog pub_clublog
bind msg - !clublog msg_clublog
bind pub - !league pub_league
bind msg - !league msg_league

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

bind pub - !rxwidth rxwidth_pub
bind msg - !rxwidth rxwidth_msg

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
bind msg - !iono iono_msg
bind pub - !iono iono_pub

bind msg - !blitz blitz_msg
bind pub - !blitz blitz_pub
bind msg - !lightning blitz_msg
bind pub - !lightning blitz_pub
bind msg - !zap blitz_msg
bind pub - !zap blitz_pub

bind msg - !eme eme_msg
bind pub - !eme eme_pub
bind msg - !moon moon_msg
bind pub - !moon moon_pub
bind msg - !sun sun_msg
bind pub - !sun sun_pub
bind msg - !graves graves_msg
bind pub - !graves graves_pub
bind msg - !solarquarter solarquarter_msg
bind pub - !solarquarter solarquarter_pub
bind msg - !equinox solarquarter_msg
bind pub - !equinox solarquarter_pub
bind msg - !solstice solarquarter_msg
bind pub - !solstice solarquarter_pub

bind msg - !sat sat_msg
bind pub - !sat sat_pub
bind msg - !satpass satpass_msg
bind pub - !satpass satpass_pub
bind msg - !satinfo satinfo_msg
bind pub - !satinfo satinfo_pub

bind msg - !qcode qcode_msg
bind pub - !qcode qcode_pub
bind msg - !q qcode_msg
bind pub - !q qcode_pub

bind pub - !qsl qslcheck_pub
bind msg - !qsl qslcheck_msg

bind pub - !dxped dxpeditions_pub
bind msg - !dxped dxpeditions_msg

bind msg - !atten atten_msg
bind pub - !atten atten_pub
bind msg - !coax atten_msg
bind pub - !coax atten_pub

bind msg - !pota pota_msg
bind pub - !pota pota_pub

bind msg - !potaspots potaspots_msg
bind pub - !potaspots potaspots_pub
bind msg - !pspots potaspots_msg
bind pub - !pspots potaspots_pub
bind msg - !pspot potaspots_msg
bind pub - !pspot potaspots_pub

bind msg - !sota sota_msg
bind pub - !sota sota_pub

bind msg - !iota iota_msg
bind pub - !iota iota_pub

bind msg - !1x1 onebyone_msg
bind pub - !1x1 onebyone_pub

bind msg - !wrtc wrtc_msg
bind pub - !wrtc wrtc_pub

set qrzbin "/home/eggdrop/bin/qrz"
set gridbin "/home/eggdrop/bin/grid"
set drivebin "/home/eggdrop/bin/drivetime"
set tzbin "/home/eggdrop/bin/timezone"
set elevbin "/home/eggdrop/bin/elev"
set bandsbin "/home/eggdrop/bin/bands"
set xraybin "/home/eggdrop/bin/xray"
set forecastbin "/home/eggdrop/bin/solarforecast"
set longtermforecastbin "/home/eggdrop/bin/longtermforecast"
set lotwbin "/home/eggdrop/bin/lotwcheck"
set lotwstatusbin "/home/eggdrop/bin/lotwstatus"
set eqslbin "/home/eggdrop/bin/eqslcheck"
set clublogbin "/home/eggdrop/bin/checkclublog"
set leaguebin "/home/eggdrop/bin/league"
set dxccbin "/home/eggdrop/bin/dxcc"
set spotsbin "/home/eggdrop/bin/spots"
set contestsbin "/home/eggdrop/bin/contests"
set activitybin "/home/eggdrop/bin/activity"
set rxwidthbin "/home/eggdrop/bin/rxwidth"
set kindexbin "/home/eggdrop/bin/kindex"
set morsebin "/home/eggdrop/bin/morse"
set unmorsebin "/home/eggdrop/bin/unmorse"
set repeaterbin "/home/eggdrop/bin/repeater"
set aprsbin "/home/eggdrop/bin/aprs"
set mufbin "/home/eggdrop/bin/muf"
set ionobin "/home/eggdrop/bin/iono"
set astrobin "/home/eggdrop/bin/astro"
set satbin "/home/eggdrop/bin/sat"
set qcodebin "/home/eggdrop/bin/qcode"
set dxpedbin "/home/eggdrop/bin/dxpeditions"
set blitzbin "/home/eggdrop/bin/blitz"
set attenbin "/home/eggdrop/bin/atten"
set potaspotsbin "/home/eggdrop/bin/potaspots"
set potabin "/home/eggdrop/bin/pota"
set sotabin "/home/eggdrop/bin/sota"
set iotabin "/home/eggdrop/bin/iota"
set onebyonebin "/home/eggdrop/bin/1x1"
set wrtcbin "/home/eggdrop/bin/wrtc"

set spotfile spotlist

# load utility methods
source scripts/util.tcl


proc qrz { nick host hand chan text } {
	global qrzbin
	set callsign [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "qrz pub: $nick $host $hand $chan $callsign $geo"

	if [string equal "" $geo] then {
		set options "--compact"
	} else {
		set options "--compact --geo $geo"
	}
	if [string equal "#amateurradio" $chan] then {
		set options [string cat "$options" " --nodox"]
	}
	set fd [open "|${qrzbin} ${callsign} ${options}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_qrz {nick uhand handle input} {
	global qrzbin
	set callsign [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "qrz msg: $nick $uhand $handle $callsign $geo"

	if [string equal "" $geo] then {
		set fd [open "|${qrzbin} ${callsign}" r]
	} else {
		set fd [open "|${qrzbin} ${callsign} --geo $geo " r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc dox_pub { nick host hand chan text } {
  if [string equal "#amateurradio" $chan] then {
    return
  } else {
    qrz "$nick" "$host" "$hand" "$chan" "$text"
  }
}

proc qrz_setgeo_pub { nick host hand chan text } {
	putlog "setgeo pub: $nick $host $hand $chan $text"
	qrz_setgeo "$nick" $hand $text
}
proc qrz_setgeo_msg { nick uhand handle input } {
	putlog "setgeo msg: $nick $uhand $handle $input"
	qrz_setgeo "$nick" $handle $input
}

proc qrz_getgeo_pub { nick host hand chan text } {
	putlog "getgeo pub: $nick $host $hand $chan $text"
	set geo [qrz_getgeo $hand]
	putchan $chan "$hand: $geo"
}
proc qrz_getgeo_msg { nick uhand handle input } {
	putlog "getgeo msg: $nick $uhand $handle $input"
	set geo [qrz_getgeo $handle]
	putmsg "$nick" "$geo"
}

proc grid_to_coords { grid } {
	set grid [string toupper $grid]

	scan [string index $grid 0] %c pos0
	scan [string index $grid 1] %c pos1
	scan [string index $grid 2] %c pos2
	scan [string index $grid 3] %c pos3
	scan [string index $grid 4] %c pos4
	scan [string index $grid 5] %c pos5

	set lon [expr (($pos0 - 65) * 20) - 180]
	set lat [expr (($pos1 - 65) * 10) - 90]
	set lon [expr $lon + (($pos2 - 48) * 2)]
	set lat [expr $lat + (($pos3 - 48) * 1)]

	if {[info exists pos4]} {
		# have subsquares
		set lon [expr $lon + (($pos4 - 65) * (5.0/60.0))]
		set lat [expr $lat + (($pos5 - 65) * (2.5/60.0))]
		# move to center of subsqure
		set lon [expr $lon + 2.5/60]
		set lat [expr $lat + 1.25/60]
	} else {
		# move to center of square
		set lon [expr $lon + 1]
		set lat [expr $lat + 0.5]
	}

	return "$lat,$lon"
}


proc qrz_setgeo { nick handle input } {
	global geofile

	if {$handle == "*"} {
		putmsg "$nick" "this command is valid only for registered bot users."
		return
	}

	if { $input == {} } {
		putmsg "$nick" "usage  : !setgeo <latitude>,<longitude>|<grid>"
		putmsg "$nick" "example: !setgeo 39.735154,-77.421129"
		putmsg "$nick" "example: !setgeo FN21wb"
		return
	}

	if {[regexp -nocase {[A-R][A-R][0-9][0-9]([a-x][a-x])?} "$input"]} then {
		set input [grid_to_coords $input]
	} elseif {[regexp "^-?\\d+\\.\\d+,\\s*-?\\d+\\.\\d+$" "$input"]} then {
		regsub -all {\s+} $input "" input
	} else {
		putmsg "$nick" "error, invalid input: $input"
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
	putmsg "$nick" "set geo coords: $input"
}

proc grid { nick host hand chan text } {
	global gridbin
	set grid [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "grid pub: $nick $host $hand $chan $grid $geo"

	if [string equal "" $geo] then {
		set fd [open "|${gridbin} ${grid}" r]
	} else {
		set fd [open "|${gridbin} ${grid} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}


proc msg_grid {nick uhand handle input} {
	global gridbin
	set grid [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "grid msg: $nick $uhand $handle $grid $geo"

	if [string equal "" $geo] then {
		set fd [open "|${gridbin} ${grid}" r]
	} else {
		set fd [open "|${gridbin} ${grid} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc drive_msg {nick uhand handle input} {
	global drivebin
	set grid [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "drive msg: $nick $uhand $handle $grid $geo"

	if [string equal "" $geo] then {
		set fd [open "|${drivebin} ${grid}" r]
	} else {
		set fd [open "|${drivebin} ${grid} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc drive_pub { nick host hand chan text } {
	global drivebin
	set grid [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "drive pub: $nick $host $hand $chan $grid $geo"

	if [string equal "" $geo] then {
		set fd [open "|${drivebin} ${grid}" r]
	} else {
		set fd [open "|${drivebin} ${grid} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc transit_msg {nick uhand handle input} {
	global drivebin
	set grid [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "transit msg: $nick $uhand $handle $grid $geo"

	if [string equal "" $geo] then {
		set fd [open "|${drivebin} --transit ${grid}" r]
	} else {
		set fd [open "|${drivebin} --transit ${grid} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc transit_pub { nick host hand chan text } {
	global drivebin
	set grid [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "transit pub: $nick $host $hand $chan $grid $geo"

	if [string equal "" $geo] then {
		set fd [open "|${drivebin} --transit ${grid}" r]
	} else {
		set fd [open "|${drivebin} --transit ${grid} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}


proc timezone { nick host hand chan text } {
	global tzbin
	set timezone [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "timezone pub: $nick $host $hand $chan $timezone $geo"

	if [string equal "" $geo] then {
		set fd [open "|${tzbin} ${timezone}" r]
	} else {
		set fd [open "|${tzbin} ${timezone} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}


proc msg_timezone {nick uhand handle input} {
	global tzbin
	set timezone [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "timezone msg: $nick $uhand $handle $timezone $geo"

	if [string equal "" $geo] then {
		set fd [open "|${tzbin} ${timezone}" r]
	} else {
		set fd [open "|${tzbin} ${timezone} --geo $geo " r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc elev { nick host hand chan text } {
	global elevbin
	set elev [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "elev pub: $nick $host $hand $chan $elev $geo"

	if [string equal "" $geo] then {
		set fd [open "|${elevbin} ${elev}" r]
	} else {
		set fd [open "|${elevbin} ${elev} --geo $geo " r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}


proc msg_elev {nick uhand handle input} {
	global elevbin
	set elev [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "elev msg: $nick $uhand $handle $elev $geo"

	if [string equal "" $geo] then {
		set fd [open "|${elevbin} ${elev}" r]
	} else {
		set fd [open "|${elevbin} ${elev} --geo $geo " r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc bands { nick host hand chan text } {
	global bandsbin
	putlog "bands pub: $nick $host $hand $chan $text"
	set fd [open "|${bandsbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_bands {nick uhand handle input} {
	global bandsbin
	putlog "bands msg: $nick $uhand $handle $input"
	set fd [open "|${bandsbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
##
proc solar { nick host hand chan text } {
	global bandsbin
	putlog "solar pub: $nick $host $hand $chan $text"
	set fd [open "|${bandsbin} -q" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_solar {nick uhand handle input} {
	global bandsbin
	putlog "solar msg: $nick $uhand $handle $input"
	set fd [open "|${bandsbin} -q" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
##
proc solarforecast { nick host hand chan text } {
	global forecastbin
	putlog "forecast pub: $nick $host $hand $chan $text"
	set fd [open "|${forecastbin} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_solarforecast {nick uhand handle input} {
	global forecastbin
	putlog "forecast msg: $nick $uhand $handle $input"
	set fd [open "|${forecastbin} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


bind pub - !usaf usafforecast
bind msg - !usaf msg_usafforecast
bind pub - !45d usafforecast
bind msg - !45d msg_usafforecast
bind pub - !45day usafforecast
bind msg - !45day msg_usafforecast
set usafforecastbin "/home/eggdrop/bin/usaf_forecast"
proc usafforecast { nick host hand chan text } {
	global usafforecastbin
	putlog "usafforecast pub: $nick $host $hand $chan $text"
	set fd [open "|${usafforecastbin} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_usafforecast {nick uhand handle input} {
	global usafforecastbin
	putlog "usafforecast msg: $nick $uhand $handle $input"
	set fd [open "|${usafforecastbin} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc longtermforecast { nick host hand chan text } {
	global longtermforecastbin
	putlog "longterm pub: $nick $host $hand $chan $text"
	set fd [open "|${longtermforecastbin} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
		#putmsg "$nick" "$line"
	}
	close $fd
}

proc msg_longtermforecast {nick uhand handle input} {
	global longtermforecastbin
	putlog "longterm msg: $nick $uhand $handle $input"
	set fd [open "|${longtermforecastbin} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc xray { nick host hand chan text } {
	global xraybin
	putlog "xray pub: $nick $host $hand $chan $text"

	if [string equal -nocase "W2XG" "$nick"] then {
		putchan $chan "🕳️   ⚪          🏌️"
		return
	}

	set fd [open "|${xraybin} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

proc msg_xray {nick uhand handle input} {
	global xraybin
	putlog "xray msg: $nick $uhand $handle $input"
	set fd [open "|${xraybin} " r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc lotw { nick host hand chan text } {
	global lotwbin
	set call [sanitize_string [string trim "${text}"]]
	putlog "lotw pub: $nick $host $hand $chan $call"
	set fd [open "|${lotwbin} ${call}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_lotw {nick uhand handle input} {
	global lotwbin
	set call [sanitize_string [string trim "${input}"]]
	putlog "lotw msg: $nick $uhand $handle $call"
	set fd [open "|${lotwbin} ${call}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
proc lotwstatus_pub { nick host hand chan text } {
	global lotwstatusbin
	putlog "lotwstatus pub: $nick $host $hand $chan $text"
	set fd [open "|${lotwstatusbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc lotwstatus_msg {nick uhand handle input} {
	global lotwstatusbin
	putlog "lotwstatus msg: $nick $uhand $handle $input"
	set fd [open "|${lotwstatusbin} -q" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc eqsl { nick host hand chan text } {
	global eqslbin
	set call [sanitize_string [string trim "${text}"]]
	putlog "eqsl pub: $nick $host $hand $chan $call"
	set fd [open "|${eqslbin} ${call}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_eqsl {nick uhand handle input} {
	global eqslbin
	set call [sanitize_string [string trim "${input}"]]
	putlog "eqsl msg: $nick $uhand $handle $call"
	set fd [open "|${eqslbin} ${call}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc pub_clublog { nick host hand chan text } {
	global clublogbin
	set call [sanitize_string [string trim "${text}"]]
	putlog "clublog pub: $nick $host $hand $chan $call"
	set fd [open "|${clublogbin} ${call}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_clublog {nick uhand handle input} {
	global clublogbin
	set call [sanitize_string [string trim "${input}"]]
	putlog "clublog msg: $nick $uhand $handle $call"
	set fd [open "|${clublogbin} ${call}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc pub_league { nick host hand chan text } {
	global leaguebin
	set param [sanitize_string [string trim "${text}"]]
	putlog "league pub: $nick $host $hand $chan $param"
	if { [string equal -nocase "#redditnet" "$chan" ] || [string equal -nocase "#fakehams" "$chan" ] } then {
		set param "305 $param"
	}
	set fd [open "|${leaguebin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_league {nick uhand handle input} {
	global leaguebin
	set param [sanitize_string [string trim "${input}"]]
	putlog "league msg: $nick $uhand $handle $param"
	set fd [open "|${leaguebin} ${param}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc dxcc { nick host hand chan text } {
	global dxccbin
	set call [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "dxcc pub: $nick $host $hand $chan $call"

	if [string equal "" $geo] then {
		set fd [open "|${dxccbin} ${call}" r]
	} else {
		set fd [open "|${dxccbin} ${call} --geo $geo" r]
	}

	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_dxcc {nick uhand handle input} {
	global dxccbin
	set call [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "dxcc msg: $nick $uhand $handle $call"

	if [string equal "" $geo] then {
		set fd [open "|${dxccbin} ${call}" r]
	} else {
		set fd [open "|${dxccbin} ${call} --geo $geo" r]
	}

	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc spots { nick host hand chan text } {
	global spotsbin
	set input [sanitize_string [string trim "${text}"]]
	putlog "spots pub: $nick $host $hand $chan $input"
	set fd [open "|${spotsbin} ${input}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_spots {nick uhand handle input} {
	global spotsbin
	set input [sanitize_string [string trim "${input}"]]
	putlog "spots msg: $nick $uhand $handle $input"
	set fd [open "|${spotsbin} ${input}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc msg_addspot {nick uhand handle input} {
	global spotfile
	putlog "addspot msg: $nick $uhand $handle $input"
	if {$handle == "*"} {
		putmsg "$nick" "this command is valid only for registered bot users."
		return
	}

	if { $input == {} } {
		putmsg "$nick" "usage  : !addspot <callsign>"
		putmsg "$nick" "periodically checks for new spots for the given callsign"
		return
	}

	set input [string toupper $input]

	if [ regexp {^[A-Z0-9/]+$} "$input" ] then {
	} else {
		putmsg "$nick" "error, invalid input: $input"
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
	putmsg "$nick" "set periodic spot check: $input"
}

proc addspot { nick host handle chan text } {
	global spotfile
	putlog "addspot pub: $nick $host $handle $chan $text"
	if {$handle == "*"} {
		putmsg "$nick" "this command is valid only for registered bot users."
		return
	}

	if { $text == {} } {
		putmsg "$nick" "usage  : !addspot <callsign>"
		putmsg "$nick" "periodically checks for new spots for the given callsign"
		return
	}

	set text [string toupper $text]

	if [ regexp {^[A-Z0-9/]+$} "$text" ] then {
	} else {
		putmsg "$nick" "error, invalid input: $text"
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
		putmsg "$nick" "this command is valid only for registered bot users."
		return
	}

	if { $text == {} } {
		putmsg "$nick" "usage  : !delspot <callsign>"
		putmsg "$nick" "removes periodic check for new spots for the given callsign"
		return
	}

	set text [string toupper $text]

	if [ regexp {^[A-Z0-9/]+$} "$text" ] then {
	} else {
		putmsg "$nick" "error, invalid input: $text"
		return
	}

	if { ![file exists $spotfile] } {
		# no records
		putmsg "$nick" "spot file not found"
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
		putmsg "$nick" "not found"
	} else {
		putlog "removed spot: $text"
		putmsg "$nick" "removed spot: $text"
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
		putmsg "$nick" "this command is valid only for registered bot users."
		return
	}

	if { $input == {} } {
		putmsg "$nick" "usage  : !delspot <callsign>"
		putmsg "$nick" "removes periodic check for new spots for the given callsign"
		return
	}

	set input [string toupper $input]

	if [ regexp {^[A-Z0-9/]+$} "$input" ] then {
	} else {
		putmsg "$nick" "error, invalid input: $input"
		return
	}

	if { ![file exists $spotfile] } {
		# no records
		putmsg "$nick" "spot file not found"
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
		putmsg "$nick" "not found"
	} else {
		putlog "removed spot: $input"
		putmsg "$nick" "removed spot: $input"
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
	#putmsg molo "timer"

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

			#putmsg molo "handle: $handle nick: $nick call: $call chan: $chan"

			if { $chan == "msg" && "$nick" != "" } {
				msg_spots "$nick" "" $handle "--mon $call"
			} else {
				spots "$nick" "" $handle $chan "--mon $call"
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
		putmsg "$nick" "this command is valid only for registered bot users."
		return
	}

	if {[timerexists "check_spots"] != ""} {
		killtimer [timerexists "check_spots"]
	}
	putchan $chan "timer stopped"
}

proc start_spots { nick host handle chan text } {
	if {$handle == "*"} {
		putmsg "$nick" "this command is valid only for registered bot users."
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
	putmsg "$nick" $fmt
}

proc contests { nick host hand chan text } {
	global contestsbin
	putlog "contests pub: $nick $host $hand $chan $text"
	set fd [open "|${contestsbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc contests_msg {nick uhand handle input} {
	global contestsbin
	putlog "contests msg: $nick $uhand $handle $input"
	set fd [open "|${contestsbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc activity { nick host hand chan text } {
	global activitybin
	set params [sanitize_string [string trim "${text}"]]
	putlog "activity pub: $nick $host $hand $chan $params"
	set fd [open "|${activitybin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc activity_msg {nick uhand handle input} {
	global activitybin
	set params [sanitize_string [string trim "${input}"]]
	putlog "activity msg: $nick $uhand $handle $params"
	set fd [open "|${activitybin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc rxwidth_pub { nick host hand chan text } {
	global rxwidthbin
	set params [sanitize_string [string trim "${text}"]]
	putlog "rxwidth pub: $nick $host $hand $chan $params"
	set fd [open "|${rxwidthbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc rxwidth_msg {nick uhand handle input} {
	global rxwidthbin
	set params [sanitize_string [string trim "${input}"]]
	putlog "rxwidth msg: $nick $uhand $handle $params"
	set fd [open "|${rxwidthbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc kindex { nick host hand chan text } {
	global kindexbin
	putlog "kindex pub: $nick $host $hand $chan $text"
	set fd [open "|${kindexbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc kindex_msg {nick uhand handle input} {
	global kindexbin
	putlog "kindex msg: $nick $uhand $handle $input"
	set fd [open "|${kindexbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc morse_pub { nick host hand chan text } {
	global morsebin
	set msg [sanitize_string [string trim "${text}"]]
	putlog "morse pub: $nick $host $hand $chan $msg"
	set fd [open "|${morsebin} ${msg}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc morse_msg {nick uhand handle input} {
	global morsebin
	set msg [sanitize_string [string trim "${input}"]]
	putlog "morse msg: $nick $uhand $handle $msg"
	set fd [open "|${morsebin} ${msg}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc unmorse_pub { nick host hand chan text } {
	global unmorsebin
	set msg [sanitize_string [string trim "${text}"]]
	putlog "unmorse pub: $nick $host $hand $chan $msg"
	set fd [open "|${unmorsebin} ${msg}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc unmorse_msg {nick uhand handle input} {
	global unmorsebin
	set msg [sanitize_string [string trim "${input}"]]
	putlog "unmorse msg: $nick $uhand $handle $msg"
	set fd [open "|${unmorsebin} ${msg}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc repeater_pub { nick host hand chan text } {
	global repeaterbin
	set msg [sanitize_string [string trim "${text}"]]
	putlog "repeater pub: $nick $host $hand $chan $msg"
	set fd [open "|${repeaterbin} ${msg}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc repeater_msg {nick uhand handle input} {
	global repeaterbin
	set msg [sanitize_string [string trim "${input}"]]
	putlog "repeater msg: $nick $uhand $handle $msg"
	set fd [open "|${repeaterbin} ${msg}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc aprs_pub { nick host hand chan text } {
	global aprsbin
	set params [sanitize_string [string trim "${text}"]]
	putlog "aprs pub: $nick $host $hand $chan $params"
	set fd [open "|${aprsbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc aprs_msg {nick uhand handle input} {
	global aprsbin
	set params [sanitize_string [string trim "${input}"]]
	putlog "aprs msg: $nick $uhand $handle $params"
	set fd [open "|${aprsbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc muf_pub { nick host hand chan text } {
	global mufbin
	set params [sanitize_string [string trim "${text}"]]
	putlog "muf pub: $nick $host $hand $chan $params"
	set fd [open "|${mufbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		# list via msg
		if [string equal "list" $params] then {
			putmsg "$nick" "$line"
		} else {
			putchan $chan "$line"
		}
	}
	close $fd
}
proc muf_msg {nick uhand handle input} {
	global mufbin
	set params [sanitize_string [string trim "${input}"]]
	putlog "muf msg: $nick $uhand $handle $params"
	set fd [open "|${mufbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc muf2_pub { nick host hand chan text } {
	set params [sanitize_string [string trim "${text}"]]
	putlog "muf2 pub: $nick $host $hand $chan $params"
	putchan $chan "$nick: please use !muf"
}
proc muf2_msg {nick uhand handle input} {
	set params [sanitize_string [string trim "${input}"]]
	putlog "muf2 msg: $nick $uhand $handle $params"
	putmsg "$nick" "please use !muf"
}

proc eme_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]
	putlog "eme pub: $nick $host $hand $chan $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		set fd [open "|${astrobin} --eme ${params}" r]
	} else {
		set fd [open "|${astrobin} --eme ${params} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc eme_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]
	putlog "eme msg: $nick $uhand $handle $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		set fd [open "|${astrobin} --eme ${params}" r]
	} else {
		set fd [open "|${astrobin} --eme ${params} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc moon_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]
	putlog "moon pub: $nick $host $hand $chan $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		set fd [open "|${astrobin} --moon ${params}" r]
	} else {
		set fd [open "|${astrobin} --moon ${params} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc moon_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]
	putlog "moon msg: $nick $uhand $handle $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		set fd [open "|${astrobin} --moon ${params}" r]
	} else {
		set fd [open "|${astrobin} --moon ${params} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc sun_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]
	putlog "sun pub: $nick $host $hand $chan $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		set fd [open "|${astrobin} --sun ${params}" r]
	} else {
		set fd [open "|${astrobin} --sun ${params} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc sun_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]
	putlog "sun msg: $nick $uhand $handle $geo $params"
	if {(( [string equal "" $geo] ) || !( [string equal "" $params] ) || ( $params != {} ))} then {
		set fd [open "|${astrobin} --sun ${params}" r]
	} else {
		set fd [open "|${astrobin} --sun ${params} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc graves_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim "${text}"]]
	putlog "graves pub: $nick $host $hand $chan $params"
	set fd [open "|${astrobin} --graves ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc graves_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim "${input}"]]
	putlog "graves msg: $nick $uhand $handle $params"
	set fd [open "|${astrobin} --graves ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc solarquarter_pub { nick host hand chan text } {
	global astrobin
	set params [sanitize_string [string trim "${text}"]]
	putlog "solarquarter pub: $nick $host $hand $chan $params"
	set fd [open "|${astrobin} --quarter" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc solarquarter_msg {nick uhand handle input} {
	global astrobin
	set params [sanitize_string [string trim "${input}"]]
	putlog "solarquarter msg: $nick $uhand $handle $params"
	set fd [open "|${astrobin} --quarter" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc sat_pub { nick host hand chan text } {
	global satbin
	set params [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]
	putlog "sat pub: $nick $host $hand $chan $geo $params"
	if {(( [string equal "" $geo] )  )} then {
		set fd [open "|${satbin} ${params}" r]
	} else {
		set fd [open "|${satbin} ${params} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		# list via msg
		if [string equal "list" $params] then {
			putmsg "$nick" "$line"
		} else {
			putchan $chan "$line"
		}
	}
	close $fd
}
proc sat_msg {nick uhand handle input} {
	global satbin
	set params [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]
	putlog "sat msg: $nick $uhand $handle $geo $params"
	if {(( [string equal "" $geo] ))} then {
		set fd [open "|${satbin} ${params}" r]
	} else {
		set fd [open "|${satbin} ${params} --geo ${geo}" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}
proc satpass_msg {nick uhand handle input} {
	sat_msg "$nick" $uhand $handle "--pass $input"
}
proc satinfo_msg {nick uhand handle input} {
	sat_msg "$nick" $uhand $handle "--info $input"
}
proc satpass_pub { nick host hand chan text } {
	sat_pub "$nick" $host $hand $chan "--pass $text"
}
proc satinfo_pub { nick host hand chan text } {
	sat_pub "$nick" $host $hand $chan "--info $text"
}

proc qcode_pub { nick host hand chan text } {
	global qcodebin
	set msg [sanitize_string [string trim "${text}"]]
	putlog "qcode pub: $nick $host $hand $chan $msg"
	set fd [open "|${qcodebin} ${msg}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc qcode_msg {nick uhand handle input} {
	global qcodebin
	set msg [sanitize_string [string trim "${input}"]]
	putlog "qcode msg: $nick $uhand $handle $msg"
	set fd [open "|${qcodebin} ${msg}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc qslcheck_pub { nick host hand chan text } {
     qslcheck_msg "$nick" "$host" "$hand" "$text"
}
proc qslcheck_msg {nick uhand handle input} {
	msg_qrz     "$nick" "$uhand" "$handle" "$input"
	msg_lotw    "$nick" "$uhand" "$handle" "$input"
	msg_eqsl    "$nick" "$uhand" "$handle" "$input"
	msg_clublog "$nick" "$uhand" "$handle" "$input"
}

proc dxpeditions_pub { nick host hand chan text } {
	global dxpedbin
	set params [sanitize_string [string trim "${text}"]]
	putlog "dxped pub: $nick $host $hand $chan $params"
	set fd [open "|${dxpedbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc dxpeditions_msg {nick uhand handle input} {
	global dxpedbin
	set params [sanitize_string [string trim "${input}"]]
	putlog "dxped msg: $nick $uhand $handle $params"
	set fd [open "|${dxpedbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

proc iono_pub { nick host hand chan text } {
	global ionobin
	set iono [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "iono pub: $nick $host $hand $chan $iono $geo"

	if [string equal "" $geo] then {
		set fd [open "|${ionobin} ${iono}" r]
	} else {
		set fd [open "|${ionobin} ${iono} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}


proc iono_msg {nick uhand handle input} {
	global ionobin
	set iono [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "iono msg: $nick $uhand $handle $iono $geo"

	if [string equal "" $geo] then {
		set fd [open "|${ionobin} ${iono}" r]
	} else {
		set fd [open "|${ionobin} ${iono} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg $nick "$line"
	}
	close $fd
}

proc blitz_pub { nick host hand chan text } {
	global blitzbin
	set blitz [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]

	putlog "blitz pub: $nick $host $hand $chan $blitz $geo"

	if [string equal "" $geo] then {
		set fd [open "|${blitzbin} ${blitz}" r]
	} else {
		set fd [open "|${blitzbin} ${blitz} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}


proc blitz_msg {nick uhand handle input} {
	global blitzbin
	set blitz [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]

	putlog "blitz msg: $nick $uhand $handle $blitz $geo"

	if [string equal "" $geo] then {
		set fd [open "|${blitzbin} ${blitz}" r]
	} else {
		set fd [open "|${blitzbin} ${blitz} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

set ae7qbin "/home/eggdrop/bin/ae7q"
bind pub - !ae7q pub_ae7q
bind msg - !ae7q msg_ae7q

proc pub_ae7q { nick host hand chan text } {
	global ae7qbin
	set input [sanitize_string [string trim "${text}"]]
	putlog "ae7q pub: $nick $host $hand $chan $input"
	set fd [open "|${ae7qbin} ${input}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_ae7q {nick uhand handle input} {
	global ae7qbin
	set input [sanitize_string [string trim "${input}"]]
	putlog "ae7q msg: $nick $uhand $handle $input"
	set fd [open "|${ae7qbin} ${input}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

set vanitybin "/home/eggdrop/bin/vanity"
bind pub - !vanity pub_vanity
bind msg - !vanity msg_vanity

proc pub_vanity { nick host hand chan text } {
	global vanitybin
	set input [sanitize_string [string trim "${text}"]]
	putlog "vanity pub: $nick $host $hand $chan $input"
	set fd [open "|${vanitybin} ${input}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc msg_vanity {nick uhand handle input} {
	global vanitybin
	set input [sanitize_string [string trim "${input}"]]
	putlog "vanity msg: $nick $uhand $handle $input"
	set fd [open "|${vanitybin} ${input}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}


proc atten_pub { nick host hand chan text } {
	global attenbin
	set params [sanitize_string [string trim "${text}"]]
	putlog "atten pub: $nick $host $hand $chan $params"
	set fd [open "|${attenbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc atten_msg {nick uhand handle input} {
	global attenbin
	set params [sanitize_string [string trim "${input}"]]
	putlog "atten msg: $nick $uhand $handle $params"
	set fd [open "|${attenbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc pota_pub { nick host hand chan text } {
	global potabin
	set params [sanitize_string [string trim "${text}"]]
	set geo [qrz_getgeo $hand]
	putlog "pota pub: $nick $host $hand $chan $params $geo"
	if [string equal "" $geo] then {
	  set fd [open "|${potabin} ${params}" r]
	} else {
	  set fd [open "|${potabin} ${params} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc pota_msg {nick uhand handle input} {
	global potabin
	set params [sanitize_string [string trim "${input}"]]
	set geo [qrz_getgeo $handle]
	putlog "pota msg: $nick $uhand $handle $params $geo"
	if [string equal "" $geo] then {
	  set fd [open "|${potabin} ${params}" r]
	} else {
	  set fd [open "|${potabin} ${params} --geo $geo" r]
	}
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc potaspots_pub { nick host hand chan text } {
	global potaspotsbin
	set params [sanitize_string [string trim "${text}"]]
	putlog "potaspots pub: $nick $host $hand $chan $params"
	set fd [open "|${potaspotsbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc potaspots_msg {nick uhand handle input} {
	global potaspotsbin
	set params [sanitize_string [string trim "${input}"]]
	putlog "potaspots msg: $nick $uhand $handle $params"
	set fd [open "|${potaspotsbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc sota_pub { nick host hand chan text } {
	global sotabin
	set params [sanitize_string [string trim "${text}"]]
	putlog "sota pub: $nick $host $hand $chan $params"
	set fd [open "|${sotabin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc sota_msg {nick uhand handle input} {
	global sotabin
	set params [sanitize_string [string trim "${input}"]]
	putlog "sota msg: $nick $uhand $handle $params"
	set fd [open "|${sotabin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc iota_pub { nick host hand chan text } {
	global iotabin
	set params [sanitize_string [string trim "${text}"]]
	putlog "iota pub: $nick $host $hand $chan $params"
	set fd [open "|${iotabin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc iota_msg {nick uhand handle input} {
	global iotabin
	set params [sanitize_string [string trim "${input}"]]
	putlog "iota msg: $nick $uhand $handle $params"
	set fd [open "|${iotabin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc onebyone_pub { nick host hand chan text } {
	global onebyonebin
	set params [sanitize_string [string trim "${text}"]]
	putlog "1x1 pub: $nick $host $hand $chan $params"
	set fd [open "|${onebyonebin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc onebyone_msg {nick uhand handle input} {
	global onebyonebin
	set params [sanitize_string [string trim "${input}"]]
	putlog "1x1 msg: $nick $uhand $handle $params"
	set fd [open "|${onebyonebin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

proc wrtc_pub { nick host hand chan text } {
	global wrtcbin
	set params [sanitize_string [string trim "${text}"]]
	putlog "wrtc pub: $nick $host $hand $chan $params"
	set fd [open "|${wrtcbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}
proc wrtc_msg {nick uhand handle input} {
	global wrtcbin
	set params [sanitize_string [string trim "${input}"]]
	putlog "wrtc msg: $nick $uhand $handle $params"
	set fd [open "|${wrtcbin} ${params}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putmsg "$nick" "$line"
	}
	close $fd
}

bind pub - !toby dayton
bind pub - !dayton dayton
bind pub - !xenia dayton
bind pub - !hamvention dayton
set daytonbin "/home/eggdrop/bin/dayton"
proc dayton { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global daytonbin
	putlog "dayton: $nick $host $hand $chan"
	set fd [open "|${daytonbin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

bind pub - !fieldday fieldday
bind pub - !fd fieldday
bind pub - !arrlfd fieldday
set fielddaybin "/home/eggdrop/bin/fieldday"
proc fieldday { nick host hand chan text } {
	if [string equal "#amateurradio" $chan] then {
		return
	}
	global fielddaybin
	putlog "fieldday: $nick $host $hand $chan"
	set fd [open "|${fielddaybin}" r]
	fconfigure $fd -encoding utf-8
	while {[gets $fd line] >= 0} {
		putchan $chan "$line"
	}
	close $fd
}

putlog "Ham utils loaded."

