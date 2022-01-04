# Get IMDB data
#
# 2-clause BSD license.
# Copyright (c) 2018, 2019 molo1134@github. All rights reserved.

bind pub - !imdb pub_imdb
bind msg - !imdb msg_imdb

set imdbbin "/home/eggdrop/bin/imdb"

proc msg_imdb { nick uhand handle arg } {
  global imdbbin

  if {![info exists arg]} {
    puts "$nick syntax: !imdb <expression>"
    return
  }

  set samitizedCmd [sanitize_string "${arg}"]

  set fd [open "|${imdbbin} ${samitizedCmd} " r]
  fconfigure $fd -encoding utf-8

  while {[gets $fd line] >= 0} {
    putchan "$nick" "$line"
  }
  close $fd
}

proc pub_imdb { nick host hand chan text } {
  global imdbbin

  if {![info exists arg]} {
    puts "$nick syntax: !imdb <expression>"
    return
  }

  set samitizedCmd [sanitize_string "${arg}"]

  set fd [open "|${imdbbin} ${samitizedCmd} " r]
  fconfigure $fd -encoding utf-8

  while {[gets $fd line] >= 0} {
    putchan $chan "$line"
  }
  close $fd
}
