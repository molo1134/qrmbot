#!/usr/bin/perl -w
#
# Utility functions.
#
# 2-clause BSD license.
# Copyright (c) 2020, 2021 molo1134@github. All rights reserved.

package Util;

use utf8;
use feature 'unicode_strings';

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(decodeEntities getFullWeekendInMonth getIterDayInMonth getYearForDate monthNameToNum commify humanNum shortenUrl isNumeric);

use URI::Escape;
use Date::Manip;
use Switch;
use Math::Round;

sub decodeEntities {
  my $s = shift;
  $s =~ s/&#(\d+);/chr($1)/eg;
  $s =~ s/&#x([0-9a-f]+);/chr(hex($1))/egi;

  $s =~ s/&reg;/®/g;
  $s =~ s/&copy;/©/g;
  $s =~ s/&trade;/™/g;
  $s =~ s/&cent;/¢/g;
  $s =~ s/&pound;/£/g;
  $s =~ s/&yen;/¥/g;
  $s =~ s/&euro;/€/g;
  $s =~ s/&laquo;/«/g;
  $s =~ s/&raquo;/»/g;
  $s =~ s/&bull;/•/g;
  $s =~ s/&dagger;/†/g;
  $s =~ s/&deg;/°/g;
  $s =~ s/&permil;/‰/g;
  $s =~ s/&micro;/µ/g;
  $s =~ s/&middot;/·/g;
  $s =~ s/&rsquo;/’/g;
  $s =~ s/&lsquo;/‘/g;
  $s =~ s/&ldquo;/“/g;
  $s =~ s/&rdquo;/”/g;
  $s =~ s/&ndash;/–/g;
  $s =~ s/&mdash;/—/g;

  $s =~ s/&aacute;/á/g;
  $s =~ s/&Aacute;/Á/g;
  $s =~ s/&acirc;/â/g;
  $s =~ s/&Acirc;/Â/g;
  $s =~ s/&aelig;/æ/g;
  $s =~ s/&AElig;/Æ/g;
  $s =~ s/&agrave;/à/g;
  $s =~ s/&Agrave;/À/g;
  $s =~ s/&aring;/å/g;
  $s =~ s/&Aring;/Å/g;
  $s =~ s/&atilde;/ã/g;
  $s =~ s/&Atilde;/Ã/g;
  $s =~ s/&auml;/ä/g;
  $s =~ s/&Auml;/Ä/g;
  $s =~ s/&ccedil;/ç/g;
  $s =~ s/&Ccedil;/Ç/g;
  $s =~ s/&eacute;/é/g;
  $s =~ s/&Eacute;/É/g;
  $s =~ s/&ecirc;/ê/g;
  $s =~ s/&Ecirc;/Ê/g;
  $s =~ s/&egrave;/è/g;
  $s =~ s/&Egrave;/È/g;
  $s =~ s/&eth;/ð/g;
  $s =~ s/&ETH;/Ð/g;
  $s =~ s/&euml;/ë/g;
  $s =~ s/&Euml;/Ë/g;
  $s =~ s/&iacute;/í/g;
  $s =~ s/&Iacute;/Í/g;
  $s =~ s/&icirc;/î/g;
  $s =~ s/&Icirc;/Î/g;
  $s =~ s/&iexcl;/¡/g;
  $s =~ s/&igrave;/ì/g;
  $s =~ s/&Igrave;/Ì/g;
  $s =~ s/&iquest;/¿/g;
  $s =~ s/&iuml;/ï/g;
  $s =~ s/&Iuml;/Ï/g;
  $s =~ s/&ntilde;/ñ/g;
  $s =~ s/&Ntilde;/Ñ/g;
  $s =~ s/&oacute;/ó/g;
  $s =~ s/&Oacute;/Ó/g;
  $s =~ s/&ocirc;/ô/g;
  $s =~ s/&Ocirc;/Ô/g;
  $s =~ s/&oelig;/œ/g;
  $s =~ s/&OElig;/Œ/g;
  $s =~ s/&ograve;/ò/g;
  $s =~ s/&Ograve;/Ò/g;
  $s =~ s/&ordf;/ª/g;
  $s =~ s/&ordm;/º/g;
  $s =~ s/&oslash;/ø/g;
  $s =~ s/&Oslash;/Ø/g;
  $s =~ s/&otilde;/õ/g;
  $s =~ s/&Otilde;/Õ/g;
  $s =~ s/&ouml;/ö/g;
  $s =~ s/&Ouml;/Ö/g;
  $s =~ s/&szlig;/ß/g;
  $s =~ s/&thorn;/þ/g;
  $s =~ s/&THORN;/Þ/g;
  $s =~ s/&uacute;/ú/g;
  $s =~ s/&Uacute;/Ú/g;
  $s =~ s/&ucirc;/û/g;
  $s =~ s/&Ucirc;/Û/g;
  $s =~ s/&ugrave;/ù/g;
  $s =~ s/&Ugrave;/Ù/g;
  $s =~ s/&uml;/ö/g;
  $s =~ s/&uuml;/ü/g;
  $s =~ s/&Uuml;/Ü/g;
  $s =~ s/&yacute;/ý/g;
  $s =~ s/&Yacute;/Ý/g;
  $s =~ s/&yuml;/ÿ/g;
  $s =~ s/&divide;/÷/g;

  $s =~ s/&lt;/</g;
  $s =~ s/&gt;/>/g;
  $s =~ s/&quot;/"/g;
  $s =~ s/&apos;/'/g;
  $s =~ s/&nbsp;/ /g;
  $s =~ s/&amp;/\&/g;

  $s =~ s/&lsaquo;/‹/g;
  $s =~ s/&rsaquo;/›/g;
  $s =~ s/&laquo;/«/g;
  $s =~ s/&raquo;/»/g;

  return $s;
}

sub getFullWeekendInMonth {
  my $ary = shift;
  my $month = shift;

  my $iter = aryToIter($ary);

  my $today = ParseDate("today");
  my $today_ts = UnixDate($today, "%s");
  my $thisyear = UnixDate($today, "%Y");
  my $nextyear = $thisyear + 1;
  my $year = $thisyear;

  my $satquery = "$iter Saturday in $month $year";
  my $sunquery = "$iter Sunday in $month $year";

  my $sat = ParseDate($satquery);
  my $sun = ParseDate($sunquery);

  my $sat_ts = UnixDate($sat, "%s");
  my $sun_ts = UnixDate($sun, "%s");

  if ($sat_ts < $today_ts and $sun_ts < $today_ts) {
    $year = $nextyear;

    $satquery = "$iter Saturday in $month $year";
    $sunquery = "$iter Sunday in $month $year";

    $sat = ParseDate($satquery);
    $sun = ParseDate($sunquery);

    $sat_ts = UnixDate($sat, "%s");
    $sun_ts = UnixDate($sun, "%s");
  }

  if (not isSequential($sat, $sun) and $ary == 5) {
    # not a full weekend
    return getFullWeekendInMonth(--$ary, $month);
  }

  # Result will always a full weekend since we look for the Nth Saturday, which
  # will be followed by a Sunday. -- except February? #TODO

  return UnixDate($sat, "%Y %m %d");
}


sub getIterDayInMonth {
  my $ary = shift;
  my $day = shift;
  my $month = shift;
  my $maxlength = shift;

  # can look back up to this many days
  $maxlength = 7 if not defined $maxlength;

  my $iter = aryToIter($ary);

  my $today = ParseDate("today");
  my $today_ts = UnixDate($today, "%s");
  $today_ts -= ($maxlength * 24 * 60 * 60);
  my $thisyear = UnixDate($today, "%Y");
  my $nextyear = $thisyear + 1;
  my $year = $thisyear;

  my $dayquery = "$iter $day in $month $year";
  my $date = ParseDate($dayquery);
  my $date_ts = UnixDate($date, "%s");

  if ($date_ts < $today_ts) {
    $year = $nextyear;

    $dayquery = "$iter $day in $month $year";
    $date = ParseDate($dayquery);
    $date_ts = UnixDate($date, "%s");
  }

  return UnixDate($date, "%Y %m %d");
}

sub isSequential {
	my $d1 = shift;
	my $d2 = shift;
	my $d1_ts = UnixDate($d1, "%s");
	my $d2_ts = UnixDate($d2, "%s");
	if (($d2_ts - $d1_ts) <= 90000 and ($d2_ts - $d1_ts) > 0) {
		# 25 hours to allow for DST
		return 1;
	}
	return 0;
}

sub aryToIter {
  my $ary = shift;
  my $iter;

  if ($ary == 1) {
    $iter = "1st";
  } elsif ($ary == 2) {
    $iter = "2nd";
  } elsif ($ary == 3) {
    $iter = "3rd";
  } elsif ($ary == 4) {
    $iter = "4th";
  } elsif ($ary == 5) {
    $iter = "last";
  } else {
    $iter = "";
  }
  return $iter;
}

sub getYearForDate {
  $m = shift;
  $d = shift;

  my $today = ParseDate("today");
  my $today_ts = UnixDate($today, "%s");
  my $thisyear = UnixDate($today, "%Y");
  my $nextyear = $thisyear + 1;
  my $year = $thisyear;

  my $query = "$m $d $year";
  my $date = ParseDate($query);
  my $query_ts = UnixDate($date, "%s");
  if ($query_ts < ($today_ts - (7 * 24 * 60 * 60))) {
    $year = $nextyear;
    $query = "$m $d $year";
    $date = ParseDate($query);
    $query_ts = UnixDate($date, "%s");
  }
  return UnixDate($date, "%Y %m %d");
}

sub monthNameToNum {
  my $monthabbr = shift;
  switch ($monthabbr) {
    case "Jan" { return 1; }
    case "Feb" { return 2; }
    case "Mar" { return 3; }
    case "Apr" { return 4; }
    case "May" { return 5; }
    case "Jun" { return 6; }
    case "Jul" { return 7; }
    case "Aug" { return 8; }
    case "Sep" { return 9; }
    case "Oct" { return 10; }
    case "Nov" { return 11; }
    case "Dec" { return 12; }
    else       { die "unknown month: $monthabbr"; }
  }
}

sub commify {
  my $num = shift;
  my ($whole, $frac);
  if ($num =~ /\./) {
    ($whole, $frac) = split(/\./, $num, 2);
    $num = $whole;
  }
  $num =~ s/(\d)(?=(\d{3})+(\D|$|\.\d*))/$1\,/g;
  $num = "$num.$frac" if defined($frac);
  return $num;
}
sub humanNum {
  my $num = shift;
  if ($num > 1000000000) {
    return nearest(0.01, $num / 1000000000.0) . "B";
  } elsif ($num > 1000000) {
    return nearest(0.01, $num / 1000000.0) . "M";
  } elsif ($num > 1000) {
    return nearest(0.01, $num / 1000.0) . "k";
  }
  return $num;
}

sub shortenUrl {
  my $url = shift;
  return undef if length($url) < 50;
  my $timeout = 4;	# max 4 seconds

  our $bitly_apikey=undef;
  my $bitlykeyfile = $ENV{'HOME'} . "/.bitlyapikey";
  if (-e ($bitlykeyfile)) {
    do $bitlykeyfile;
  }
  return undef if not defined($bitly_apikey);

  my $shortUrl = undef;
  my $requestdoc = "{\n\"domain\":\"j.mp\",\n\"long_url\":\"$url\"\n}\n";
  my $rest = "https://api-ssl.bitly.com/v4/shorten";

  open(HTTP, '-|',
	  "curl --max-time $timeout -L -k -s " .
	  "-H 'Content-Type: application/json' " .
	  "-H 'Authorization: Bearer $bitly_apikey' " .
	  "--data '$requestdoc' ".
	  "'$rest'");
  binmode(HTTP, ":utf8");
  while(<HTTP>) {
    $shortUrl = $1 if /"link":\s*"(.*?)"/;
  }
  close(HTTP);

  # success
  return $shortUrl if $shortUrl =~ /^http/;

  # failure case
  print "error: $shortUrl\n";
  return undef;
}

sub isNumeric {
  my $val = shift;
  if ( defined $val ) {
    return $val =~ /^-?[0-9]+\.?[0-9]*$/ ? 1 : 0;
  } else {
    warn "isNumeric requires an argument!";
  }
}
