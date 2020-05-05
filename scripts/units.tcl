# Use GNU units to convert between values and perform mathematical calculations

# 2-clause BSD license.
# Copyright (c) 2018 /u/molo1134. All rights reserved.

bind msg - !units msg_convert_units
bind pub - !units pub_convert_units

# because no one can remember GNU units syntax
bind msg - !ftoc msg_ftoc
bind pub - !ftoc pub_ftoc

bind msg - !ctof msg_ctof
bind pub - !ctof pub_ctof

# also metals
bind pub - !gold pub_gold
bind pub - !silver pub_silver
bind pub - !platinum pub_plat
bind msg - !gold msg_gold
bind msg - !silver msg_silver
bind msg - !platinum msg_plat

set unitsbin "/usr/bin/units"

# load utility methods
source scripts/util.tcl

proc msg_convert_units {nick uhand handle arg} {
  global unitsbin
  regexp {^(.*) +in +(.*)$} $arg matched sub1 sub2
  regexp {^([A-Za-z0-9_]+(\([0-9.]+\))?)$} $arg matched2 subA

  if {[info exists matched]} {
    #putmsg $nick "matched: $matched"
    set term1 [sanitize_string $sub1]
    set term2 [sanitize_string $sub2]
  }
  if {[info exists matched2]} {
    #putmsg $nick "matched2: $matched2"
    #putmsg $nick "subA: $subA"
    set term1 $subA
    #unset term2
  }

  if {![info exists matched] && ![info exists matched2]} {
    putmsg $nick "syntax: !units <foo> in <bar>"
    return
  }

  #putmsg $nick "$matched"
  #catch {exec ${unitsbin} -t -- ${sub1} ${sub2} | head -1} data
  #catch {exec ${unitsbin} -- ${sub1} ${sub2} } data
  #catch {exec ${unitsbin} -- ${sub1} ${sub2} \| grep -v "reciprocal conversion" \| head -1 \| sed -e "s/^.*\\*\\s\\(.*\\)/\\1/"} data
  #catch {exec ${unitsbin} -- ${sub1} ${sub2} \| grep -v "reciprocal conversion" \| head -1 \| sed -e "s/^\\s*\\*\\?\\s//"} data

  putlog "units msg: $nick $uhand $handle $term1 $term2"

  if ([info exists term2]) {
    catch {exec ${unitsbin} -- ${term1} ${term2} \| grep -v "reciprocal conversion" \| head -1 \| sed -e "s/^\\s*\\*\\?\\s//"} data
  } else {
    catch {exec ${unitsbin} -- ${term1} \| sed -e "s/^\\s*\\*\\?\\s//"} data
  }

  set output [split $data "\n"]

  #foreach line $output {
  #  putmsg $nick "$line"
  #}

  if (![info exists term2]) {
    foreach line $output {
      putmsg $nick "$line"
    }
    return
  }

  if {[string match -nocase {*error*} $data] ||
      [string match -nocase {*unknown*} $data]} {
    putmsg $nick [lindex $output 0]
    return
  }

  if {[string match -nocase {* + *} $data]} {
    putmsg $nick [concat "$term1 = " [lindex $output 0]]
  } else {
    putmsg $nick [concat "$term1 = " [lindex $output 0] " $term2"]
  }
}

proc pub_convert_units {nick host hand chan arg} {
  global unitsbin
  regexp {^(.*) +in +(.*)$} $arg matched sub1 sub2
  regexp {^([A-Za-z0-9_]+(\([0-9.]+\))?)$} $arg matched2 subA

  if {[info exists matched]} {
    #putmsg $nick "matched: $matched"
    set term1 [sanitize_string $sub1]
    set term2 [sanitize_string $sub2]
  }
  if {[info exists matched2]} {
    #putmsg $nick "matched2: $matched2"
    #putmsg $nick "subA: $subA"
    set term1 [sanitize_string $subA]
    #unset term2
  }


  if {![info exists matched] && ![info exists matched2]} {
    putnotc $nick "syntax: !units <foo> in <bar>"
    return
  }

  #putnotc $nick "$matched"
  #catch {exec ${unitsbin} -t -- ${sub1} ${sub2} | head -1} data
  #catch {exec ${unitsbin} -- ${sub1} ${sub2} \| grep -v "reciprocal conversion" \| head -1 \| sed -e "s/^.*\\*\\s\\(.*\\)/\\1/"} data
  #catch {exec ${unitsbin} -- ${sub1} ${sub2} \| grep -v "reciprocal conversion" \| head -1 \| sed -e "s/^\\s*\\*\\?\\s//"} data

  putlog "units pub: $nick $host $hand $chan $term1 $term2"

  if ([info exists term2]) {
    catch {exec ${unitsbin} -- ${term1} ${term2} \| grep -v "reciprocal conversion" \| head -1 \| sed -e "s/^\\s*\\*\\?\\s//"} data
  } else {
    catch {exec ${unitsbin} -- ${term1} \| sed -e "s/^\\s*\\*\\?\\s//"} data
  }

  set output [split $data "\n"]

  if (![info exists term2]) {
    foreach line $output {
      putchan $chan "$line"
    }
    return
  }


  if {[string match -nocase {*error*} $data] ||
      [string match -nocase {*unknown*} $data]} {
    putchan $chan [lindex $output 0]
    return
  }

  if {[string match -nocase {* + *} $data]} {
    putchan $chan [concat "$term1 = " [lindex $output 0]]
  } else {
    putchan $chan [concat "$term1 = " [lindex $output 0] " $term2"]
  }
}


proc msg_ftoc {nick uhand handle arg} {
  set arg [sanitize_string $arg]
  msg_convert_units $nick $uhand $handle "tempF($arg) in tempC"
}
proc pub_ftoc {nick host hand chan arg} {
  set arg [sanitize_string $arg]
  pub_convert_units $nick $host $hand $chan "tempF($arg) in tempC"
}

proc msg_ctof {nick uhand handle arg} {
  set arg [sanitize_string $arg]
  msg_convert_units $nick $uhand $handle "tempC($arg) in tempF"
}
proc pub_ctof {nick host hand chan arg} {
  set arg [sanitize_string $arg]
  pub_convert_units $nick $host $hand $chan "tempC($arg) in tempF"
}

proc pub_gold {nick host hand chan arg} {
  pub_convert_units $nick $host $hand $chan "goldprice * 1 troyounce in USD"
}
proc pub_silver {nick host hand chan arg} {
  pub_convert_units $nick $host $hand $chan "silverprice * 1 troyounce in USD"
}
proc pub_plat {nick host hand chan arg} {
  pub_convert_units $nick $host $hand $chan "platinumprice * 1 troyounce in USD"
}
proc msg_gold {nick uhand handle arg} {
  msg_convert_units $nick $uhand $handle "goldprice * 1 troyounce in USD"
}
proc msg_silver {nick uhand handle arg} {
  msg_convert_units $nick $uhand $handle "silverprice * 1 troyounce in USD"
}
proc msg_platinum {nick uhand handle arg} {
  msg_convert_units $nick $uhand $handle "platinumprice * 1 troyounce in USD"
}
