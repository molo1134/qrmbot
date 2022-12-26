#!/usr/bin/tclsh

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
		set lon [expr $lon + (($pos4 - 65) * (5.0/60.0))];
		set lat [expr $lat + (($pos5 - 65) * (2.5/60.0))];
		# move to center of subsqure
		set lon [expr $lon + 2.5/60]
		set lat [expr $lat + 1.25/60]
		# not too precise
		set formatter "%.5f"
	} else {
		# move to center of square
		set lon [expr $lon + 1]
		set lat [expr $lat + 0.5]
		# even less precise
		set formatter "%.1f"
	}

	return "$lat,$lon"
}

puts -nonewline "FN21 "
puts [grid_to_coords "FN21"]
puts -nonewline "FN21wb "
puts [grid_to_coords "FN21wb"]
