# output help message

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind pub - !help pub_help
bind msg - !help msg_help

proc pub_help { nick host hand chan text } {
  putlog "help pub: $nick $host $hand $chan $text"
  send_help $nick
}


proc msg_help {nick uhand handle input} {
  putlog "help msg: $nick $uhand $handle $input"
  send_help $nick
}

proc send_help {nick} {
  putmsg $nick "bot commands:"
  putmsg $nick "  !qrz !call -- lookup callsign on qrz.com"
  putmsg $nick "  !qth !grid -- lookup grid square or qth"
  putmsg $nick [encoding convertto utf-8 "  !setgeo !getgeo -- set your qth for results in the above †"]
  putmsg $nick "  !bands -- display HF propagation information"
  putmsg $nick "  !solar -- display solar ionospheric conditions"
  putmsg $nick "  !kindex !ki -- 3-day k-index forecast"
  putmsg $nick "  !forecast -- 27 day solar forecast"
  putmsg $nick "  !activity -- band activity from pskreporter"
  putmsg $nick "  !dxcc -- display information on a dxcc entity"
  putmsg $nick "  !spots -- display spots for a callsign"
#  putmsg $nick "  !stopspots !startspots -- turn off/on periodic spots"
#  putmsg $nick "  !addspot !delspot -- add/remove a period spot"
  putmsg $nick "  !morse !cw -- convert to morse code"
  putmsg $nick "  !unmorse !demorse -- decode from morse"
  putmsg $nick "  !phoneticise -- random phonetics"
  putmsg $nick "  !repeater -- search for repeater"
  putmsg $nick "  !iono -- report from nearest ionosonde"
  putmsg $nick "  !muf -- GIRO MUF reports from ionosondes"
  putmsg $nick "  !aprs -- APRS station information"
  putmsg $nick "  !eme -- EME prediction"
  putmsg $nick "  !graves -- 143 MHz radar as EME beacon"
  putmsg $nick "  !moon -- Lunar position and phase"
  putmsg $nick "  !sun -- Solar position"
  putmsg $nick "  !sat -- satellite info and pass predictor"
  putmsg $nick "  !satpass -- satellite pass predictor"
  putmsg $nick "  !satinfo -- satellite info"
  putmsg $nick "  !qcode !q -- qcode lookup"
  putmsg $nick "  !utc -- display current UTC time"
  putmsg $nick "  !time !tz -- localtime in the qth or grid specified"
  putmsg $nick "  !wwv -- emulate WWV station (in channel only)"
  putmsg $nick "  !rig -- describe a radio or other gear"
  putmsg $nick "  !lotw -- last upload date to LoTW for a callsign"
  putmsg $nick "  !eqsl -- last login to eqsl.cc for a callsign"
  putmsg $nick "  !clublog !oqrs -- log and OQRS info on clublog.org"
  putmsg $nick "  !qsl -- check all of the above qsl methods"
  putmsg $nick "  !contests -- list current and upcoming contests"
  putmsg $nick "  !wx !wxfull -- show current weather conditions"
  putmsg $nick "  !wxf !wxflong -- weather forecast"
  putmsg $nick "  !quote !quotesearch -- get a quote"
  putmsg $nick "  !addquote -- add a quote"
  putmsg $nick "  !units -- convert values between units"
  putmsg $nick "  !crypto -- cryptocurrency price check:"
  putmsg $nick "  !bitcoin !btc !litecoin !ltc !etherium !eth !doge" 
  putmsg $nick "  !define -- glossary lookup"
  putmsg $nick "  !drive -- compute drive time and distance"
  putmsg $nick "  !transit -- compute transit time and route"
  putmsg $nick "  !stock -- financial quotes"
  putmsg $nick "  !elev -- get elevation data for a place"
  putmsg $nick "  !adsb -- get plane information"
  putmsg $nick "  !ae7q -- get callsign availability info"
  putmsg $nick "  !dxped -- get current dxpedition info"
#  putmsg $nick "  !topic -- print current topic"
#  putmsg $nick "  !topicrefresh -- reset the topic"
#  putmsg $nick [encoding convertto utf-8 "  !myquit -- print your last signoff message †"]
#  putmsg $nick "  !quit -- print the last signoff message of a bot user"
#  putmsg $nick "  !ud -- urban dictionary lookup"
 
  putmsg $nick [encoding convertto utf-8 "† Note: only available to bot users; to create an account: /msg qrm hello"]
  putmsg $nick "For examples, see: https://reddit.com/r/amateurradio/wiki/qrmbot"
  putmsg $nick "Also, /join #hamfest for bot-announced for-sale listings."
  return
  putmsg $nick "test1: †"
  putmsg $nick "test2: \u2020"
  putmsg $nick "test3: \xE2\x80\xA0"
  putmsg $nick [encoding convertto utf-8 "test4: †"]
  putmsg $nick [encoding convertto utf-8 "test5: \u2020"]
  putmsg $nick [encoding convertto utf-8 "test6: \xE2\x80\xA0"]
}
