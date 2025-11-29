# utility methods
#
# 2-clause BSD license.
# Copyright (c) 2018, 2019 molo1134@github. All rights reserved.

proc sanitize_string {text} {
  regsub -all ">" $text "" text
  regsub -all "<" $text "" text
  regsub -all "&" $text "" text
  regsub -all "\\|" $text "" text
  regsub -all "\n" $text " " text
  regsub -all "\r" $text " " text
  regsub -all "\"" $text "\\\"" text

  return $text
}

proc sanitize_url {text} {
  regsub -all ">" $text "%3E" text
  regsub -all "<" $text "%3C" text
  #regsub -all "&" $text "" text
  regsub -all "\\|" $text "%7C" text
  regsub -all "\n" $text "%0A" text
  regsub -all "\r" $text "%0D" text
  regsub -all "\"" $text "\\\"" text

  return $text
}

set geofile geolist

proc qrz_getgeo { handle } {
	global geofile
	set found 0

	if {$handle == "*"} {
		return ""
	}

	set gf [open $geofile r]
	set line [gets $gf]
	while {![eof $gf]} {
		if { [string tolower [lindex $line 0]] == [string tolower $handle] } {
			close $gf
			return [lindex $line 2]
		}
		set line [gets $gf]
	}
	close $gf
	return ""
}

