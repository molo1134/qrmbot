# register with nickserv
#

# run immediately after connecting to a server
bind evnt - init-server evnt:init_server

proc evnt:init_server {type} {
  #global botnick
  #putquick "MODE $botnick +iR-ws"
  putquick "PRIVMSG nickserv :identify wtfnone"
}

# if a notice is received, identify to keep the nick
bind notc "*This nickname is registered and protected.*" identify

proc identify {nick uhost hand text dest} {
  putquick "PRIVMSG nickserv :identify wtfnone"
}
