#!/usr/bin/perl -w
#
# Geocoding utility functions.  Uses Google API.  2-clause BSD license.
#
# Copyright 2018 /u/molo1134. All rights reserved.

package Location;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(argToCoords qthToCoords coordToGrid geolocate gridToCoord distBearing coordToTZ);

use Math::Trig;
use Math::Trig 'great_circle_distance';
use Math::Trig 'great_circle_bearing';
use URI::Escape;

sub gridToCoord {
  my $gridstr = shift;

  if (not $gridstr =~ /^[A-R]{2}[0-9]{2}([A-X]{2})?/i ) {
    print "\ninvalid grid\n";
    return undef;
  }

  my @grid = split (//, uc($gridstr));

  if ($#grid < 3) {
    return undef;
  }

  my $lat;
  my $lon;
  my $formatter;

  $lon = ((ord($grid[0]) - ord('A')) * 20) - 180;
  $lat = ((ord($grid[1]) - ord('A')) * 10) - 90;
  $lon += ((ord($grid[2]) - ord('0')) * 2);
  $lat += ((ord($grid[3]) - ord('0')) * 1);

  if ($#grid >= 5) {
    $lon += ((ord($grid[4])) - ord('A')) * (5/60);
    $lat += ((ord($grid[5])) - ord('A')) * (5/120);
    # move to center of subsquare
    $lon += (5/120);
    $lat += (5/240);
    # not too precise
    $formatter = "%.4f";
  } else {
    # move to center of square
    $lon += 1;
    $lat += 0.5;
    # even less precise
    $formatter = "%.1f";
  }

  # not too precise
  $lat = sprintf($formatter, $lat);
  $lon = sprintf($formatter, $lon);

  return join(',', $lat, $lon);
}

sub coordToGrid {
  my $lat = shift;
  my $lon = shift;
  my $grid = "";

  $lon = $lon + 180;
  $lat = $lat + 90;

  $grid .= chr(ord('A') + int($lon / 20));
  $grid .= chr(ord('A') + int($lat / 10));
  $grid .= chr(ord('0') + int(($lon % 20)/2));
  $grid .= chr(ord('0') + int(($lat % 10)/1));
  $grid .= chr(ord('a') + int(($lon - (int($lon/2)*2)) / (5/60)));
  $grid .= chr(ord('a') + int(($lat - (int($lat/1)*1)) / (2.5/60)));

  return $grid;
}

sub qthToCoords {
  my $place = uri_escape_utf8(shift);
  my $lat = undef;
  my $lon = undef;
  my $url = "http://maps.googleapis.com/maps/api/geocode/xml?address=$place&sensor=false";

  my $tries = 0;

  RESTART:
  $tries++;

  open (HTTP, '-|', "curl -k -s '$url'");
  binmode(HTTP, ":utf8");
  GET: while (<HTTP>) {
    #print;
    chomp;
    if (/OVER_QUERY_LIMIT/) {
      #print "warning: over query limit\n";
      close(HTTP);
      print "error: over query limit. please try again.\n" if $tries > 3;
      exit $::exitnonzeroonerror if $tries > 3;
      goto RESTART;
    }
    if (/<lat>([+-]?\d+.\d+)<\/lat>/) {
      $lat = $1;
    }
    if (/<lng>([+-]?\d+.\d+)<\/lng>/) {
      $lon = $1;
    }
    if (defined($lat) and defined($lon)) {
      last GET;
    }
  }
  close HTTP;

  if (defined($lat) and defined($lon)) {
    return "$lat,$lon";
  } else {
    return undef;
  }
}

sub geolocate {
  my $lat = shift;
  my $lon = shift;

  my $url = "http://maps.googleapis.com/maps/api/geocode/xml?latlng=$lat,$lon&sensor=false";

  my $newResult = 0;
  my $getnextaddr = 0;
  my $addr = undef;
  my $type = undef;

  my %results;
  my $tries = 0;

  RESTART:

  open (HTTP, '-|', "curl -k -s '$url'");
  binmode(HTTP, ":utf8");
  while (<HTTP>) {
    #print;
    chomp;

    if (/OVER_QUERY_LIMIT/) {
      #print "warning: over query limit\n" unless defined($raw) and $raw == 1;
      close(HTTP);
      exit $::exitnonzeroonerror if $tries > 3;
      goto RESTART;
    }

    last if /ZERO_RESULTS/;

    if (/<result>/) {
      $newResult = 1;
      next;
    }

    if ($newResult == 1 and /<type>([^<]+)</) {
      $type = $1;
      $getnextaddr = 1;
      $newResult = 0;
      next;
    }

    if ($getnextaddr == 1 and /<formatted_address>([^<]+)</) {
      #print "$type => $1\n";
      $results{$type} = $1;
      $getnextaddr = 0;
      next;
    }
  }
  close HTTP;

  if (defined($results{"neighborhood"})) {
    $addr = $results{"neighborhood"};
  } elsif (defined($results{"locality"})) {
    $addr = $results{"locality"};
  } elsif (defined($results{"administrative_area_level_3"})) {
    $addr = $results{"administrative_area_level_3"};
  } elsif (defined($results{"postal_town"})) {
    $addr = $results{"postal_town"};
  } elsif (defined($results{"political"})) {
    $addr = $results{"political"};
  } elsif (defined($results{"postal_code"})) {
    $addr = $results{"postal_code"};
  } elsif (defined($results{"administrative_area_level_2"})) {
    $addr = $results{"administrative_area_level_2"};
  } elsif (defined($results{"administrative_area_level_1"})) {
    $addr = $results{"administrative_area_level_1"};
  } elsif (defined($results{"country"})) {
    $addr = $results{"country"};
  } elsif (defined($results{"sublocality"})) {
    $addr = $results{"sublocality"};
  } elsif (defined($results{"sublocality_level_3"})) {
    $addr = $results{"sublocality_level_3"};
  } elsif (defined($results{"sublocality_level_4"})) {
    $addr = $results{"sublocality_level_4"};
  }

  return $addr;
}

sub argToCoords {
  my $arg = shift;
  my $type;

  if ($arg =~ /^(grid:)? ?([A-R]{2}[0-9]{2}([a-x]{2})?)/i) {
    $arg = $2;
    $type = "grid";
  } elsif ($arg =~ /^(geo:)? ?([-+]?\d+(.\d+)?,\s?[-+]?\d+(.\d+)?)/i) {
    $arg = $2;
    $type = "geo";
  } else {
    $type = "qth";
  }

  my $lat = undef;
  my $lon = undef;
  my $grid = undef;

  if ($type eq "grid") {
    $grid = $arg;
  } elsif ($type eq "geo") {
    ($lat, $lon) = split(',', $arg);
  } elsif ($type eq "qth") {
    my $ret = qthToCoords($arg);
    if (!defined($ret)) {
      #print "'$arg' not found.\n";
      #exit $::exitnonzeroonerror;
      return undef;
    }
    ($lat, $lon) = split(',', $ret);
  }

  if (defined($grid)) {
    ($lat, $lon) = split(',', gridToCoord(uc($grid)));
  }

  return join(',', $lat, $lon);
}

sub distBearing {
  my $lat1 = shift;
  my $lon1 = shift;
  my $lat2 = shift;
  my $lon2 = shift;

  my @origin = NESW($lon1, $lat1);
  my @foreign = NESW($lon2, $lat2);

  my ($dist, $bearing);

  # disable "experimental" warning on smart match operator use
  no if $] >= 5.018, warnings => "experimental::smartmatch";

  if (@origin ~~ @foreign) {	  # smart match operator - equality comparison
    $dist = 0;
    $bearing = 0;
  } else {
    $dist = great_circle_distance(@origin, @foreign, 6378.1);
    $bearing = rad2deg(great_circle_bearing(@origin, @foreign));
  }

  return ($dist, $bearing);
}

# Notice the 90 - latitude: phi zero is at the North Pole.
# Example: my @London = NESW( -0.5, 51.3); # (51.3N 0.5W)
# Example: my @Tokyo  = NESW(139.8, 35.7); # (35.7N 139.8E)
sub NESW {
  deg2rad($_[0]), deg2rad(90 - $_[1])
}

sub coordToTZ {
  my $lat = shift;
  my $lon = shift;

  my $now = time();
  my $url = "https://maps.googleapis.com/maps/api/timezone/json?location=$lat,$lon&timestamp=$now";

  my ($dstoffset, $rawoffset, $zoneid, $zonename);

  open (HTTP, '-|', "curl -k -s '$url'");
  binmode(HTTP, ":utf8");
  while (<HTTP>) {

    # {
    #    "dstOffset" : 3600,
    #    "rawOffset" : -18000,
    #    "status" : "OK",
    #    "timeZoneId" : "America/New_York",
    #    "timeZoneName" : "Eastern Daylight Time"
    # }

    if (/"(\w+)" : (-?\d+|"[^"]*")/) {
      my ($k, $v) = ($1, $2);
      $v =~ s/^"(.*)"$/$1/;
      #print "$k ==> $v\n";
      if ($k eq "status" and $v ne "OK") {
	return undef;
      }
      $dstOffset = $v if $k eq "dstOffset";
      $rawOffset = $v if $k eq "rawOffset";
      $zoneid = $v if $k eq "timeZoneId";
      $zonename = $v if $k eq "timeZoneName";
    }
  }
  close(HTTP);

  return $zoneid;
}
