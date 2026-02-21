# output help message

# 2-clause BSD license.
# Copyright (c) 2018, 2019, 2020, 2021 molo1134@github. All rights reserved.

bind pub - !help pub_help
bind msg - !help msg_help

set githublink "https://github.com/molo1134/qrmbot/"

proc pub_help { nick host hand chan text } {
  global githublink
  putlog "help pub: $nick $host $hand $chan $text"
  putchan $chan "bot commands: ${githublink}blob/master/botcommands.md"
}

proc msg_help {nick uhand handle input} {
  global githublink
  putlog "help msg: $nick $uhand $handle $input"
  putmsg "$nick" "bot commands: ${githublink}blob/master/botcommands.md"
}

