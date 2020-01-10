######
# Copyright Johannes Kuhn <#John @ quakenet>
# This fixes the utf-8 issue on an eggdrop without patch.
# Feel free to distribute and or use.
# No warranty.
#

# Background:
#
# The problem is that eggdrop sometimes treats things as utf-8 strings
# And sometimes as simple byte array.
# Almost each string is passed to the tcl interp
# Witch calls an eggdrop command and this calls again the eggdrop interp.
# When eggdrop passes a string to the interp, it calls Tcl_Eval.
# Tcl_Eval trats the input string as utf-8
# But when a eggdrop command is called, it only uses the lower 8 bit
# This leads to data loss.
#
#
# This script converts all data that should be passed to an eggdrop command
# to utf-8, so only the lowest 8 bit are used. When Tcl_Eval is called again
# it can convert the data back to utf.

package require Tcl 8.5

encoding system utf-8
# Ok, here is a problem:
# We need all eggdrop commands.
# The good thing is that all the eggdrop commands are in the global namespace.
# The difficulty is to disingush between eggdrop commands
# And Tcl commands.
# To find out if it is a tcl command I just create an other interp, look at the commands there
# and skip them
# To make sure that this works, source this script as first script.
# Otherwise there might be extra commands in the global namespace that we don't know.
proc initUtf8 {} {
   rename initUtf8 {}
   set i [interp create]
   set tcmds [interp eval $i {info commands}]
   interp delete $i
   set procs [info procs]
   foreach cmd [info commands] {
      if {   $cmd ni $tcmds && $cmd ni $procs
         && "${cmd}_orig" ni [info commands]
         && ![string match *_orig $cmd]
      } {
         # Eggdrop command.
         rename $cmd ${cmd}_orig
         interp alias {} $cmd {} fixutf8 ${cmd}_orig
      }
   }
}
initUtf8
proc fixutf8 args {
   set cmd {}
   foreach arg $args {
      lappend cmd [encoding convertto utf-8 $arg]
   }
   catch {{*}$cmd} res opt
   dict incr opt -level
   return -opt $opt $res
}
