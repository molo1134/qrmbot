#!/usr/bin/perl -w

# Scrape /r/amateurradio's user flair and user IDs to populate nicks.csv.
# 2-clause BSD license.

# Copyright 2018 /u/molo1134. All rights reserved.

use strict;
use utf8;
use feature 'unicode_strings';
use List::Util 'any';
binmode(STDOUT, ":utf8");

use Cwd 'realpath';
use File::Basename;

my @subreddits = ("amateurradio", "hamradio", "rtlsdr");

#my $useragent = "Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0";
my $useragent = "foo";

my $sleep = 1;

my @baseurls;
foreach my $subreddit (@subreddits) {
  push @baseurls, "https://www.reddit.com/r/${subreddit}/new/.json";
  push @baseurls, "https://www.reddit.com/r/${subreddit}/comments/.json";
#  push @baseurls, "https://www.reddit.com/r/${subreddit}/top/.json";
#  push @baseurls, "https://www.reddit.com/r/${subreddit}/gilded/.json";
#  push @baseurls, "https://www.reddit.com/r/${subreddit}/controversial/.json";
}
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/8i4ayo/your_week_in_amateur_radio_new_licensees_05092018/dyostpt/.json";
#push @baseurls, "https://www.reddit.com/user/molo1134/m/hamradiomulti/new/.json";
#push @baseurls, "https://www.reddit.com/user/molo1134/m/hamradiomulti/comments/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/8fowrk/is_there_a_baofenglike_radio_but_for_hf/dy6fl6s/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/8fd9vb/its_not_much_but_its_mine_shack_edition/dy6mkg7/.json";

our %nicks;
our %results;
our @blacklist = (
  # these look like callsigns, but are not.
  "0X03F", "4N6KID", "6L6GC", "7K60FXD", "9N388GV", "A11EN", "A1AMAN", "A31XX",
  "A5MYTH", "A66AUTO", "AC316SCU", "AJ308WIN", "AM3ON", "AR0B", "AR3N", "AX0N",
  "B0073D", "B0BITH", "B0ZZ", "B3TAL", "B4Q", "B5GEEK", "B95CSF", "BA0TH",
  "BE2VT", "C41N", "CH00F", "CH3X", "CH4QA", "CN89LA", "CP4R", "CQ2QC",
  "CR0CKER", "CR500GUY", "D03BOY", "D333D", "D3JAKE", "DC12V", "DE3L",
  "DH1021X", "DI0DEX", "DI1UTED", "DN3T", "DT2G", "DV82XL", "EF3S", "EM00GUY",
  "EN82JJ", "F15SIM", "F1699BBS", "F3REAL", "FB0M", "FF0000IT", "FO0BAT",
  "FR3QQ", "FX34ME", "G00PIX", "G0JIRA", "GO3TEAM", "GR0TESK", "H3LIX",
  "H6DTR", "HA1156W", "HB3B", "HE3RD", "IG88J", "J1986EG", "JA450N", "JH0N",
  "JK3US", "JN75OT", "K1DOWN", "K240DF", "K24G", "L0RAN", "L10L", "L2NP",
  "L33R", "L33TGOY", "L3STAN", "M00DAWG", "M01E", "M05Y", "M0LE", "M101X",
  "M3US", "MD5SUMO", "MK2JA", "MR2FAN", "MS4SMAN", "N00F", "N00MIN", "N00TZ",
  "N221UA", "N5CORP", "N71FS", "N734LQ", "N7E", "NY3JRON", "OP00TO", "OS2REXX",
  "OZ0SH", "P0RKS", "P1MRX", "P3PPR", "P42O", "P4DDY", "P4NTZ", "P8M", "P9K",
  "PE5ER", "PH00P", "PI4ATE", "PL8ER", "PR0TEAN", "Q00P", "R08SHAW", "R08ZY",
  "R0LFO", "R0WLA", "RJ45JACK", "RJ61X", "RV49ER", "S0LAR", "S1EDOG", "SC04AT",
  "SG92I", "SH0NUFF", "SK00MA", "SK4P", "SL3RM", "SP00NIX", "ST33P", "T0PSKI",
  "T1PHIL", "T3H", "T90FAN", "TH4AB", "TS830S", "TV8TONY", "UP2LATE", "V1CTOR",
  "V3KI", "V3NGI", "V4LSYL", "V8FTW", "VT2NC", "W00TAH", "W0153R", "W33DAR",
  "X4B", "XG33KX", "Y2KAI", "Z33RO", "Z3MATT", "Z3US", "ZE1DA",
  "JH23DF", "K67FDE", "N546RV", "N983CC", "W09U", "CN85PQ", "CN85PL", "BG4LAW",
  "U03BB", "UD83D", "A1LOU", "FN03DR", "A80J", "KZ4I", "KZ4IX", "J0MPZ",
  "WH33T", "KO26BX", "B17X", "HO0BER", "JP82QK", "JO41WX");

# load nicks
our $nickfile = "$ENV{'HOME'}/.nicks.csv";
$nickfile = dirname(realpath(__FILE__)) . "/nicks.csv" if (! -e $nickfile);
our @headers; 	# keep headers for when we rewrite the nicks.csv file.
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
  my $limit = 1000;

  for ( my $count = 0; $count < $limit; $count++) {

    my ($u, $f, $c);
    last if defined $after and $after eq "null";
    $url = "$baseurl?after=$after" if defined $after;
    print STDERR "$count: $url\n";

    open (HTTP, '-|', "curl -s -k -L -A \"$useragent\" \"$url\"");
    binmode(HTTP, ":utf8");
    while(<HTTP>) {
    #  print STDERR "$_\n";
      $_ =~ s/{/{\n/g;
      $_ =~ s/["\]],\s+"/"\n"/g;
      $_ =~ s/(\d|true|false|null), /$1\n/g;
      @_ = split "\n";
      foreach my $e (@_) {
    #    print STDERR "$e\n";
	if ($e =~ /"(\w+)": (-?[\d.]+|null|true|false|".+"$)/) {
	  my ($k, $v) = ($1, $2);
	  $v =~ s/^"(.*)"$/$1/;
    #      print STDERR "$k => $v\n";

	  if ($k eq "after") {
	    $after = $v;
	  } elsif ($k eq "author") {
	    $u = $v;
	    if ($u =~ /^\d?[a-z]{1,2}[0-9Øø∅]{1,4}[a-z]{1,4}$/i) {
	      # username is callsign
	      $c = uc $u;
	      $c =~ s/[Øø∅]/0/g;
	    }
	  } elsif ($k eq "author_flair_text") {
	    $f = $v;
	    next if $f eq "null";
	    ($c, undef) = grep {$_ ne ''} split(/[\s\W]/, $f);
	    next if not defined $c;
	    #print "$c\n";
	    if ($c =~ /^[A-R]{2}[0-9]{2}([a-x]{2})?$/) { # grid
	      $c = undef;
	      next;
	    }
	    if ($c =~ /^\d?[a-z]{1,2}[0-9Øø∅]{1,4}[a-z]{1,4}$/i) {
	      $c = uc $c;
	      $c =~ s/[Øø∅]/0/g;
	    } else {
	      $c = undef;
	    }
	  } elsif ($k eq "kind") {
	    # moving on to new entry
	    if (defined $c and defined $u) {
	      if (not any { /^$c$/i } @blacklist) {
		print STDERR "found: $c /u/$u\n";
		$results{$c} = $u;
	      }
	    }
	    $u = undef;
	    $c = undef;
	  }
	}
      }
      if (defined($u) and defined($c)) {
	if (not any { /^$c$/i } @blacklist) {
	  print STDERR "found: $c /u/$u\n";
	  $results{$c} = $u;
	}
      }
      $u = undef;
      $c = undef;

    }
    close(HTTP);

    updatenicks();

    sleep $sleep;
  }
}

sub updatenicks {
  our %results;
  our %nicks;
  our $nickfile;
  our @headers;
  our @blacklist;

  foreach my $k (keys %results) {
    next if $k eq "";
    if (any { /^$k$/i } @blacklist) {
      delete $nicks{$k};
      next;
    }

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
}
