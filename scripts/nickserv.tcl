# register with nickserv
#

# run immediately after connecting to a server
bind evnt - init-server evnt:init_server

source scripts/nickservpassword.tcl

proc evnt:init_server {type} {
  #global botnick
  #putquick "MODE $botnick +iR-ws"
  global nickservpassword
  putquick "PRIVMSG nickserv :identify ${nickservpassword}"
}

# if a notice is received, identify to keep the nick
bind notc "*This nickname is registered and protected.*" identify

proc identify {nick uhost hand text dest} {
  global nickservpassword
  putquick "PRIVMSG nickserv :identify ${nickservpassword}"
}
