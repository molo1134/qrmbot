#!/usr/bin/perl -w

# Scrape /r/amateurradio's user flair and user IDs to populate nicks.csv.
# 2-clause BSD license.

# Copyright 2018 /u/molo1134. All rights reserved.

use strict;
use utf8;
use feature 'unicode_strings';
binmode(STDOUT, ":utf8");

use Cwd 'realpath';
use File::Basename;

my @subreddits = ("hamradio", "amateurradio");

#my $useragent = "Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0";
my $useragent = "foo";

my $sleep = 5;

my @baseurls;
foreach my $subreddit (@subreddits) {
  push @baseurls, "https://www.reddit.com/r/${subreddit}/new/.json";
  push @baseurls, "https://www.reddit.com/r/${subreddit}/comments/.json";
}
push @baseurls, "https://www.reddit.com/user/molo1134/m/hamradiomulti/new/.json";
push @baseurls, "https://www.reddit.com/user/molo1134/m/hamradiomulti/comments/.json";

my %nicks;
my %results;

# load nicks
my $nickfile = "$ENV{'HOME'}/.nicks.csv";
$nickfile = dirname(realpath(__FILE__)) . "/nicks.csv" if (! -e $nickfile);
my @headers; 	# keep headers for when we rewrite the nicks.csv file.
if (-e $nickfile) {
  open (NICKFILE, "<", $nickfile);
  while (<NICKFILE>) {
    chomp;
    if (/^\s*#/) {
      push @headers, $_;
      next;
    }

    my ($call, undef, undef) = split /,/;
    $nicks{$call} = $_;
  }
  close(NICKFILE);
}


foreach my $baseurl (@baseurls) {
  my $url = $baseurl;
  my $after = undef;

  # number of pages to traverse
  my $count = 5;
  $count = 10 if $url =~ /comments/;

  for ( ; $count > 0; $count--) {

    my ($u, $f, $c);
    $url = "$baseurl?after=$after" if defined $after;
    print STDERR "$count: $url\n";

    open (HTTP, '-|', "curl -s -k -L -A \"$useragent\" \"$url\"");
    binmode(HTTP, ":utf8");
    while(<HTTP>) {
    #  print STDERR "$_\n";
      @_ = split ", ";
      foreach my $e (@_) {
    #    print STDERR "$e\n";
	if ($e =~ /"(\w+)": (null|"[^"]+")/) {
	  my ($k, $v) = ($1, $2);
	  $v =~ s/^"(.*)"$/$1/;
    #      print STDERR "$k => $v\n";

	  if ($k eq "after") {
	    $after = $v;
	  } elsif ($k eq "author") {
	    $u = $v;
	    if ($u =~ /^\d?[a-z]{1,2}[0-9Øø]{1,4}[a-z]{1,4}$/i) {
	      # username is callsign
	      $c = uc $u;
	      #print "inserting: $c $u\n";
	      $results{$c} = $u;
	    }
	  } elsif ($k eq "author_flair_text") {
	    $f = $v;
	    ($c, undef) = split(" ", $f);
	    next if $c =~ /^[A-R]{2}[0-9]{2}([a-x]{2})?$/; # grid
	    if ($c =~ /^\d?[a-z]{1,2}[0-9Øø]{1,4}[a-z]{1,4}$/i) {
	      #print "inserting: $c $u\n";
	      $c = uc $c;
	      $results{$c} = $u;
	    }
	  }
	}
      }
    }
    close(HTTP);

    if (!defined $after and $count > 0) {
      sleep($sleep);	# throttle
      goto get;
    }
    sleep $sleep;
  }
}

foreach my $k (keys %results) {
  next if $k eq "4N6KID";	# these look like callsigns, but are not.
  next if $k eq "A1AMAN";
  next if $k eq "AC316SCU";
  next if $k eq "AM3ON";
  next if $k eq "AR3N";
  next if $k eq "B0073D";
  next if $k eq "B0ZZ";
  next if $k eq "B3TAL";
  next if $k eq "B4Q";
  next if $k eq "B95CSF";
  next if $k eq "CH00F";
  next if $k eq "CH4QA";
  next if $k eq "CR0CKER";
  next if $k eq "CR500GUY";
  next if $k eq "D3JAKE";
  next if $k eq "DN3T";
  next if $k eq "DV82XL";
  next if $k eq "EM00GUY";
  next if $k eq "F3REAL";
  next if $k eq "FO0BAT";
  next if $k eq "FX34ME";
  next if $k eq "G0JIRA";
  next if $k eq "H6DTR";
  next if $k eq "HA1156W";
  next if $k eq "J1986EG";
  next if $k eq "JK3US";
  next if $k eq "JN75OT";  # is grid, not a callsign
  next if $k eq "K24G";
  next if $k eq "L2NP";
  next if $k eq "L33TGOY";
  next if $k eq "M0LE";
  next if $k eq "MR2FAN";
  next if $k eq "OS2REXX";
  next if $k eq "P42O";
  next if $k eq "P4NTZ";
  next if $k eq "P9K";
  next if $k eq "PE5ER";
  next if $k eq "PH00P";
  next if $k eq "Q00P";
  next if $k eq "R08SHAW";
  next if $k eq "R0LFO";
  next if $k eq "R0WLA";
  next if $k eq "RJ45JACK";
  next if $k eq "RV49ER";
  next if $k eq "S0LAR";
  next if $k eq "S1EDOG";
  next if $k eq "SG92I";
  next if $k eq "SK4P";
  next if $k eq "ST33P";
  next if $k eq "T1PHIL";
  next if $k eq "T3H";
  next if $k eq "T90FAN";
  next if $k eq "TV8TONY";
  next if $k eq "V1CTOR";
  next if $k eq "V8FTW";
  next if $k eq "W00TAH";
  next if $k eq "W0153R";
  next if $k eq "W33DAR";
  next if $k eq "XG33KX";
  next if $k eq "Z3US";

  next if $k eq "";

  if (defined $nicks{$k}) {
    my ($call, $ircnick, undef) = split (/,/, $nicks{$k});
    $nicks{$k} = "$call,$ircnick,/u/$results{$k}";
  } else {
    $nicks{$k} = "$k,,/u/$results{$k}";
  }
}

# output, rewrite nick file
open (NICKFILE, ">", $nickfile);
foreach my $h (@headers) {
  print NICKFILE "$h\n";
}
foreach my $k (sort keys %nicks) {
  print NICKFILE "$nicks{$k}\n";
}
close(NICKFILE);

