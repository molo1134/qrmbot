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
@EXPORT = qw(decodeEntities stripIrcColors getFullWeekendInMonth getIterDayInMonth getYearForDate monthNameToNum commify humanNum moveFile shortenUrl isNumeric getEggdropUID getDxccDataRef updateCty checkCtyDat checkMW scrapeMW);

use URI::Escape;
use Date::Manip;
use Math::Round;
use File::Temp qw(tempfile);
use File::Copy;

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

# Strip IRC formatting and color codes from a string.
# Removes:
#  - mIRC-style color codes: \x03NN or \x03NN,MM
#  - formatting control characters used by Colors.pm: \x02 (bold), \x0F (reset),
#    \x1F (underline), \x16 (inverse), \x1D (italic), \x06 (blink),
#    \x11 (monospace), \x1E (terminal strikethrough)
sub stripIrcColors {
  my $s = shift;
  return undef unless defined $s;

  # Remove mIRC color codes like \x03<fg>[,<bg>] (where <fg>/<bg> are 1-2 digits)
  $s =~ s/\x03\d{1,2}(?:,\d{1,2})?//g;

  # Remove common IRC formatting control characters
  $s =~ s/[\x02\x0F\x1F\x16\x1D\x06\x11\x1E]//g;

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

our %__monthNames = (
  "Jan" => 1,
  "Feb" => 2,
  "Mar" => 3,
  "Apr" => 4,
  "May" => 5,
  "Jun" => 6,
  "Jul" => 7,
  "Aug" => 8,
  "Sep" => 9,
  "Oct" => 10,
  "Nov" => 11,
  "Dec" => 12,
);

sub monthNameToNum {
  my $monthabbr = shift;
  our %__monthNames;
  return $__monthNames{$monthabbr};
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

# move if the file exists and is a regular file, not a symlink
sub moveFile {
  my $src = shift;
  my $dst = shift;

  return if not -e $src;
  return if not -f $src;
  return if -e $dst;

  # File::Copy
  move($src, $dst);
}

sub shortenUrl {
  my $url = shift;
  return undef if length($url) < 30;
  my $timeout = 4;	# max 4 seconds

  our $bitly_apikey=undef;
  my $bitlykeyfile = $ENV{'HOME'} . "/.bitlyapikey";
  if (-e ($bitlykeyfile)) {
    do $bitlykeyfile;
  }
  return undef if not defined($bitly_apikey);

  my $shortUrl = undef;
  my $errmsg = undef;
  my $requestdoc = "{\n\"domain\":\"bit.ly\",\n\"long_url\":\"$url\"\n}\n";
  my $rest = "https://api-ssl.bitly.com/v4/shorten";

  open(HTTP, '-|',
	  "curl --max-time $timeout -L -k -s " .
	  "-H 'Content-Type: application/json' " .
	  "-H 'Authorization: Bearer $bitly_apikey' " .
	  "-X POST --data '$requestdoc' ".
	  "'$rest'");
  binmode(HTTP, ":utf8");
  while(<HTTP>) {
    $shortUrl = $1 if /"link":\s*"(.*?)"/;
    $errmsg = $1 if /"message":\s*"(.*?)"/;
    $errmsg .= ": " . $1 if /"description":\s*"(.*?)"/;
  }
  close(HTTP);

  # success
  return $shortUrl if $shortUrl =~ /^http/;

  # failure case
  print "error shortening url: $errmsg\n";
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

sub getEggdropUID {
  return "eggdrop";  # edit this to customize the UID of the eggdrop bot
}


# Retrieve from here: http://www.country-files.com/big-cty/
our $_ctydat=$ENV{'HOME'} . "/.cty.dat";
our $_cty_maxage=604800; # 1 week
our $_cty_handle = undef;

# load mostwanted summary from $HOME/.mostwanted.txt, which will be populated
# by the scrapeMW() subroutine.
our $_mostwantedfile=$ENV{'HOME'} . "/.mostwanted.txt";
our $_mw_maxage=604800; # 1 week

sub getDxccDataRef {
  our $_cty_handle;

  return $_cty_handle if defined $_cty_handle;

  my @lastentity = undef;
  my @records;
  my %dxccmap;
  our $_ctydat;
  our $_mostwantedfile;

  open(CTYDAT, "<", $_ctydat) or die "unable to find cty.dat file: $_ctydat ";
  while (<CTYDAT>) {
    chomp;
    s/\x0D$//; #CRLF terminators

    if (/^[a-z]/i) {
      # entity
      my @entity = split(/:\s*/);

      if ($entity[7] =~ /^\*/) {
	$entity[7] =~ s/^\*//;
	$entity[0] .= " (not DXCC)";
      }

      #print "$entity[7]: $entity[0]\n";
      @lastentity = @entity;

    } elsif (/^\s/) {
      # prefixes/calls
      die "cty.dat formatting error" unless @lastentity;

      s/^\s+//;
      s/;\s*$//;
      my @prefixes = split(/,/);

      for (@prefixes) {
	my $length;
	my $prefix;
	my $pattern;
	my ($itu, $cq, $dxcc, $name, $cont, $lat, $lon, $tz);

	if (/\[(\d+)\]/) {
	  $itu = $1;
	} else {
	  $itu = $lastentity[2];
	  $itu =~ s/^0*//;
	}
	if (/\((\d+)\)/) {
	  $cq = $1;
	} else {
	  $cq = $lastentity[1];
	  $cq =~ s/^0*//;
	}

	$prefix = $_;
	$prefix =~ s/=?([^\(\[]*)(\(\d+\))?(\[\d+\])?/$1/;
	$length = length $prefix;

	if (/^=/) {
	  $pattern = "^$prefix\$";
	} else {
	  $pattern = "^$prefix";
	}

	# hack to deal with Gitmo; KG4xx = gitmo; KG4xxx = W4
	$pattern = '^KG4[A-Z][A-Z]$' if $pattern eq "^KG4";

	$dxcc = $lastentity[7];
	$name = $lastentity[0];
	$cont = $lastentity[3];
	$lat = $lastentity[4];
	$lon = -$lastentity[5]; # sign is reversed
	$tz = -$lastentity[6];  # sign is reversed

	$dxccmap{uc $dxcc} = join('|', $length, $pattern, $prefix, $dxcc, $cq, $itu, $name, $cont, $lat, $lon, $tz);
	push @records, join('|', $length, $pattern, $prefix, $dxcc, $cq, $itu, $name, $cont, $lat, $lon, $tz);
	#print "$prefix: $dxcc $cq $itu $pattern $length\n";
      }

    } else {
      print "unexpected input: $_\n";
    }
  }
  close(CTYDAT);

  # Sort descending by length of matching prefix/callsign.
  # So we try by the most specific match first.
  @records = sort { (split /\|/,$b)[0] <=> (split /\|/,$a)[0] } @records;

  # ----------------

  # load mostwanted summary from $HOME/.mostwanted.txt, if present
  my %mostwantedByPrefix;
  my %mostwantedByName;
  open(MW, "<", $_mostwantedfile) or goto SKIPMW;
  while (<MW>) {
    chomp;
    if (/^\d/) {
      my ($rank, $prefix, $name) = split /,/;
      #print "$prefix => $rank\n";
      $mostwantedByPrefix{$prefix} = $rank;
      $mostwantedByName{$name} = $rank;

      # hack. this place is called 'San Andres & Providencia' in cty.dat, but
      # 'SAN ANDRES ISLAND' by clublog and LoTW.
      if ($name eq "SAN ANDRES ISLAND") {
	$mostwantedByName{"SAN ANDRES & PROVIDENCIA"} = $rank;
      }
      # hack. this place is 3B6 in cty.dat but 3B7 in clublog.
      if ($name eq "AGALEGA & ST BRANDON ISLANDS") {
	$mostwantedByPrefix{"3B6"} = $rank;
	$mostwantedByName{"AGALEGA & ST. BRANDON"} = $rank;
      }
      if ($name eq "VIET NAM") {
	$mostwantedByName{"VIETNAM"} = $rank;
      }
    }
  }
  close(MW);
  SKIPMW:

  my %handle;
  $handle{map} = \%dxccmap;
  $handle{rec} = \@records;
  $handle{mwPfx} = \%mostwantedByPrefix;
  $handle{mwNm} = \%mostwantedByName;

  $_cty_handle = \%handle;

  return $_cty_handle;
}

sub checkCtyDat {
  my $now = time;
  my $needCTY = 0;
  our $_ctydat;
  if ( ! -e $_ctydat ) {
    $needCTY = 1;
  } else {
    my (undef, undef, undef, undef, undef, undef, undef, $size, undef, $mtime, undef, undef, undef) = stat $_ctydat;
    if (defined $mtime) {
      my $age = $now - $mtime;
      if ($age > $_cty_maxage or $size == 0) {
	$needCTY = 1;
      }
    } else {
      $needCTY = 1;
    }
  }
  return $needCTY;
}

sub updateCty {
  my $rssURL = "http://www.country-files.com/category/big-cty/feed/";
  my $done = 0;
  my $inItem = 0;
  my $updateUrl = undef;

  #print "$rssURL\n";
  open (RSS, '-|', "curl -s -k -L --max-time 4 --retry 1 '$rssURL'");
  binmode(RSS, ":utf8");
  while(<RSS>) {
    chomp;
    next if $done == 1;
    $inItem = 1 if /<item>/;
    if ($inItem == 1 and /<link>(.*)<\/link>/) {
      $updateUrl = $1;
      $done = 1;
    }
  }
  close(RSS);
  print "warning: unable to retrieve cty.dat feed" if !defined $updateUrl;

  my $zipurl = undef;
  $done = 0;
  if (defined $updateUrl) {
    #print "$updateUrl\n";
    open (UPD, '-|', "curl -s -k -L --max-time 4 --retry 1 '$updateUrl'");
    binmode (UPD, ":utf8");
    while (<UPD>) {
      chomp;
      if ($done == 0 and /(https?:\/\/www\.country-files\.com\/bigcty\/download\/.*\.zip)/) {
	$zipurl = $1;
	$done = 1;
      }
    }
    close(UPD);
    #http://www.country-files.com/bigcty/download/bigcty-20180123.zip
  }

  if (defined $zipurl) {
    #print "$zipurl\n";
    my (undef, $tmpfile) = tempfile();
    #print "$tmpfile\n";
    system "curl --max-time 20 -s -f -k -L -o $tmpfile '$zipurl'";
    my (undef, undef, undef, undef, undef, undef, undef, $size, undef, undef, undef, undef, undef) = stat $tmpfile;
    if ($size == 0) {
      print "warning: unable to retrieve $zipurl\n"
    } else {
      system "unzip -p $tmpfile cty.dat > $_ctydat";
    }
    unlink $tmpfile
  } else {
    print "warning: unable to retrieve cty.dat zip";
  }
}

sub checkMW {
  my $needMW = 0;
  if ( ! -e $_mostwantedfile ) {
    $needMW = 1;
  } else {
    my $now = time;
    my (undef, undef, undef, undef, undef, undef, undef, $size, undef, $mtime, undef, undef, undef) = stat $_mostwantedfile;
    if (defined $mtime) {
      my $age = $now - $mtime;
      if ($age > $_mw_maxage or $size == 0) {
	$needMW = 1;
      }
    } else {
      $needMW = 1;
    }
  }
  return $needMW;
}

sub scrapeMW {
  my $mwurl = "https://clublog.org/mostwanted.php";

  open(MWFILE, ">", $_mostwantedfile) or die "Can't open for writing: $!";

  #print "$mwurl\n";
  open (HTTP, '-|', "curl -s -k -L --max-time 4 --retry 1 '$mwurl'");
  binmode(HTTP, ":utf8");
  while(<HTTP>) {
    chomp;
    if ( /<p><table>/ ) {
      my @rows = split /<tr>/i;
      foreach my $row (@rows) {
	#print "$row\n";
	if ($row =~ /<td>([0-9]+)\.<\/td><td>([^<]+)<\/td><td><a href='mostwanted2.php\?dxcc=[0-9]+'>([^<]+)<\/a>.*?<\/tr>/i) {
	  my ($rank, $prefix, $name) = ($1, $2, $3);
	  print MWFILE "$rank,$prefix,$name\n";
	}
      }

    }
  }
  close(HTTP);
  close(MWFILE);
}

# always return true
return 1;
