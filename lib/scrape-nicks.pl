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

my @subreddits = ("antennasporn", "hamfest", "hamdevs", "morse", "MMDVM",
	"hampota", "hamspots", "PDXhamradio", "CHIhamradio", "baofeng",
	"EmComm", "diytubes", "electricalengineering", "hamcasters", "lidnet",
	"amateursatellites", "hamradio", "rtlsdr", "amateurradio");

#my $useragent = "Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0";
my $useragent = "foo";

my $sleep = 1;

my @baseurls;
foreach my $subreddit (@subreddits) {
  push @baseurls, "https://www.reddit.com/r/${subreddit}/new/.json";
  push @baseurls, "https://www.reddit.com/r/${subreddit}/comments/.json";
#  push @baseurls, "https://www.reddit.com/r/${subreddit}/gilded/.json";
#  push @baseurls, "https://www.reddit.com/r/${subreddit}/top/.json?sort=top&t=all"; # doesn't work
#  push @baseurls, "https://www.reddit.com/r/${subreddit}/controversial/.json"; # doesn't work
}
#push @baseurls, ".json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/asxn9e/what_was_your_first_ham_mistake/.json";
#push @baseurls, "https://www.reddit.com/r/TropicalWeather/comments/6zcr3y/this_is_a_message_from_st_john_us_virgin_islands/.json?limit=500";
#push @baseurls, "https://www.reddit.com/r/trees/comments/iwr3u/i_think_one_of_your_users_got_high_and_wandered/.json";
#push @baseurls, "https://www.reddit.com/r/trees/comments/iwzpn/hey_guys_i_made_my_first_dx_contact_on_my_qrp_rig/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/iw0ro/hey_rtrees_today_i_woke_upate_breakfasttook_a/.json";
#push @baseurls, "https://www.reddit.com/r/AskReddit/comments/87v3pv/serious_amatuer_ham_radio_operators_of_reddit/.json";
#push @baseurls, "https://www.reddit.com/r/AskReddit/comments/8ykbu5/what_hobby_would_you_get_into_if_you_had_a_spare/.json";
#push @baseurls, "https://www.reddit.com/r/AskReddit/comments/9xhg9/does_anyone_still_use_ham_radios_what_are_your/.json";
#push @baseurls, "https://www.reddit.com/r/AskReddit/comments/80xk8w/when_in_comes_to_your_hobby_what_is_a_sure_sign/.json";
#push @baseurls, "https://www.reddit.com/r/AskReddit/comments/1zhf0e/what_is_cheap_yet_fun_hobby_that_anyone_can_get/.json";
#push @baseurls, "https://www.reddit.com/r/AskReddit/comments/3pcw9o/what_hobby_do_you_simply_not_get/.json";
#push @baseurls, "https://www.reddit.com/r/AskReddit/comments/9z3jz7/whats_a_very_niche_but_interesting_hobby_many/.json";
#push @baseurls, "https://www.reddit.com/r/AskReddit/comments/27g2oa/amateur_radio_operators_of_reddit_what_tips_do/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/8i4ayo/your_week_in_amateur_radio_new_licensees_05092018/dyostpt/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/8fowrk/is_there_a_baofenglike_radio_but_for_hf/dy6fl6s/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/8fd9vb/its_not_much_but_its_mine_shack_edition/dy6mkg7/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/8ydhs6/2way_radio_recommendations/e2a6fcq/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/ayyp9l/calibration_instructions_for_a_daiwa_cn501h/.json";
#push @baseurls, "https://www.reddit.com/r/amateurradio/comments/bewqre/morsecodeme_online_morse_code_radio/.json";

our %nicks;
our %results;
our @blacklist = (
  # these look like callsigns, but are not.
  "0X03F", "4N6KID", "6L6GC", "7K60FXD", "9N388GV", "A11EN", "A1AMAN", "A31XX",
  "A5MYTH", "A66AUTO", "AC316SCU", "AJ308WIN", "AM3ON", "AR0B", "AR3N", "AX0N",
  "B0073D", "B0BITH", "B0ZZ", "B3TAL", "B4Q", "B5GEEK", "B95CSF", "BA0TH",
  "BE2VT", "C41N", "CH00F", "CH3X", "CH4QA", "CP4R", "CQ2QC",
  "CR0CKER", "CR500GUY", "D03BOY", "D333D", "D3JAKE", "DC12V", "DE3L",
  "DH1021X", "DI0DEX", "DI1UTED", "DN3T", "DT2G", "DV82XL", "EF3S", "EM00GUY",
  "F15SIM", "F1699BBS", "F3REAL", "FB0M", "FF0000IT", "FO0BAT",
  "FR3QQ", "FX34ME", "G00PIX", "G0JIRA", "GO3TEAM", "GR0TESK", "H3LIX",
  "H6DTR", "HA1156W", "HB3B", "HE3RD", "IG88J", "J1986EG", "JA450N", "JH0N",
  "JK3US", "K1DOWN", "K240DF", "K24G", "L0RAN", "L10L", "L2NP",
  "L33R", "L33TGOY", "L3STAN", "M00DAWG", "M01E", "M05Y", "M0LE", "M101X",
  "M3US", "MD5SUMO", "MK2JA", "MR2FAN", "MS4SMAN", "N00F", "N00MIN", "N00TZ",
  "N221UA", "N5CORP", "N71FS", "N734LQ", "N7E", "NY3JRON", "OS2REXX",
  "OZ0SH", "P0RKS", "P1MRX", "P3PPR", "P42O", "P4DDY", "P4NTZ", "P8M", "P9K",
  "PE5ER", "PH00P", "PI4ATE", "PL8ER", "PR0TEAN", "Q00P", "R08SHAW", "R08ZY",
  "R0LFO", "R0WLA", "RJ45JACK", "RJ61X", "RV49ER", "S0LAR", "S1EDOG", "SC04AT",
  "SG92I", "SH0NUFF", "SK00MA", "SK4P", "SL3RM", "SP00NIX", "ST33P", "T0PSKI",
  "T1PHIL", "T3H", "T90FAN", "TH4AB", "TS830S", "TV8TONY", "UP2LATE", "V1CTOR",
  "V3KI", "V3NGI", "V4LSYL", "V8FTW", "VT2NC", "W00TAH", "W0153R", "W33DAR",
  "X4B", "XG33KX", "Y2KAI", "Z33RO", "Z3MATT", "Z3US", "ZE1DA",
  "K67FDE", "N546RV", "N983CC", "W09U", "BG4LAW", "U03BB", "UD83D", "A1LOU",
  "A80J", "KZ4I", "KZ4IX", "J0MPZ", "WH33T", "B17X", "HO0BER", "H8TE",
  "FC3SBOB", "OP00TO", "P0NS", "H2LOL", "AD936X", "E30JAWN", "ML20S",
  "J300BLK", "R820T", "B3RIA", "1OF3S", "TW010F", "A2BTLC", "XP2FAN", "KT315I",
  "B2311E", "L00PEE", "TH3BFG", "NO99SUM", "NO3FCC", "R4808N", "0D1USA",
  "W4NEWS", "F8HP", "K20A", "5R7W", "6AQ7GT", "C0LBW", "D073N", "QU1EN",
  "RY4NY", "S1OED", "G8BBC", "D74A", "D72A", "MR3MPTY", "4X4PLAY", "PN2222A",
  "D868UV", "T430S", "T351A", "D878UV", "MD25X", "GL0WL", "0X64ON", "E85WRX",
  "E440QF", "TS771AS", "A01TYAD", "AJ111AJ", "SH4DOWC", "D2BIG", "R1KKH",
  "V71A", "M4TTPS", "8R1LL", "DO2TUBE", "K3S", "M08Y", "HG765VBC", "JR149S",
  "4Y3NI", "A2MAIL", "E3BU", "HG766VBC", "S1IDER", "SC0TOMA", "SH0T", "T4W",
  "WH1SPER", "N17MAN", "OS2MAC", "N1ETSI", "BF17C", "T70A", "WA4415SWL",
  "UV5R", "2V4ZHNO", "G7T", "EN55PD", "KR00GA", "D710GA", "D7AG", "AB2ETFL",
  "T400FAN", "X333X", "A62OKAY", "M1200AK", "T1S", "NU773R", "T0S", "N4LQ",
  "C3MER", "ST0PX", "XO28XO", "B0XCH", "J34BIT", "Z3TH", "SW7600GR", "A77ASAD",
  "GH0DAM", "S9OONS", "SP00GEY", "AW3RDE", "5X9QRM", "SW4L", "CT4677GUT",
  "TA0321TA", "CC0AYXY", "TX69ER", "P8A", "AS171ABD", "T3NCHI", "L33TOR",
  "2X4SR", "FT450D", "D360JR", "0X15E", "3E8M", "7W4773R", "AV83R", "B20BOB",
  "B3333N", "BR14NVG", "CV26TH", "H14C", "L4MB", "MH00H", "MN1H", "N00B",
  "N1A", "NC45L", "QE37QULU", "SR65K", "T0NITO", "T109J", "T1TWAN", "UP10AD",
  "V3NGE", "G1LV", "XS400CAFE", "O3GEN", "T60R", "DJ027X", "4TR5V", "J3DUDE",
  "LB7GUY", "RC5K", "W33T", "J42J", "D4RKS",
  # opt-out
  "N4ADK");

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

    my ($u, $f, $c, $ts);
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
#	print "$e\n";
#	if (/"crosspost_parent_list":/) {
#	  if (defined $u and defined $c) {
#	    print "$c :: $u :: $ts\n";
#	    updateResult($c, $ts, $u);
#	  }
#	  $u = $c = $ts = undef;
#	}
	if ($e =~ /"(\w+)": (-?[\d.]+|null|true|false|".+"$)/) {
	  my ($k, $v) = ($1, $2);
	  $v =~ s/^"(.*)"$/$1/;
	  $v =~ s/\\u([0-9a-f]{4})/chr(hex($1))/egi;
	  #print "$k => $v\n";

	  if ($k eq "after") {
	    if (defined $after and $after eq $v) {
	      #print "duplicate AFTER - infinite loop\n"
	      $after = "null";
	    } else {
	      $after = $v;
	    }
	  } elsif ($k eq "author") {
	    #print "author: $v\n";
	    $u = $v;
	    if ($u =~ /^\d?[a-z]{1,2}[0-9Øø∅]{1,4}[a-z]{1,4}$/i) {
	      # username is callsign
	      $c = uc $u;
	      $c =~ s/[Øø∅]/0/g;
	    }
	  } elsif ($k eq "author_flair_text") {
	    #print "author_flair_text: $v\n";
	    $f = $v;
	    next if $f eq "null";
	    my ($tmp, undef) = grep {$_ ne ''} split(/[\s\W]/, $f);
	    next if not defined $tmp;
	    #print "$tmp\n";
	    if ($tmp =~ /^[A-R]{2}[0-9]{2}([a-x]{2})?$/i) { # grid
	      next;
	    }
	    if ($tmp =~ /^\d?[a-z]{1,2}[0-9Øø∅]{1,4}[a-z]{1,4}$/i) {
	      $c = uc $tmp;
	      $c =~ s/[Øø∅]/0/g;
	    }
	  } elsif ($k eq "created_utc" or $k eq "created") {
	    $ts = $v;
	    $ts =~ s/\.0*$//g;
	  } elsif ($k eq "body" or $k eq "selftext") {
	    if ($v =~ /(\\n|73.*?|DE|-)(\s|\\n)*([A-Z0-9Øø∅]+)(\.|\s|\\n)*$/i) {
	      my $tmp = $3;
	      if ($tmp =~ /^\d?[a-z]{1,2}[0-9Øø∅]{1,4}[a-z]{1,4}$/i) {
		$c = uc $tmp;
		$c =~ s/[Øø∅]/0/g;
		printf STDERR "%s :: %s => %s\n", $c, $k, substr($v,-25);
	      }
	    }
	  } elsif ($k eq "kind" or $k eq "banned_by") {
	    # moving on to new entry
	    #print "NEXT: $k\n";
	    if (defined $c and defined $u) {
	      if (not any { /^$c$/i } @blacklist and $u ne "[deleted]") {
		updateResult($c, $ts, $u);
		#$ts = time() if not defined $ts;
		#$results{$c} = "$ts,$u";
	      }
	    }
	    $u = undef;
	    $c = undef;
	    $ts = undef;
	  }
	}
      }
      if (defined($u) and defined($c)) {
	if (not any { /^$c$/i } @blacklist and $u ne "[deleted]") {
	  updateResult($c, $ts, $u);
	  #$ts = time() if not defined $ts;
	  #$results{$c} = "$ts,$u";
	}
      }
      $u = undef;
      $c = undef;
      $ts = undef;

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
    my (undef, $uid) = split(/,/, $results{$k});

    if (defined $nicks{$k}) {
      my ($call, $ircnick, undef) = split (/,/, $nicks{$k});
      $nicks{$k} = "$call,$ircnick,/u/$uid";
    } else {
      print STDERR "NEW: ===> $k $uid\n";
      $nicks{$k} = "$k,,/u/$uid";
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

sub updateResult {
  our %results;
  my $c = shift;
  my $ts = shift;
  my $u = shift;
  return if $u =~ /\[deleted\]/;
  return if $u eq "pongo000";
  $ts = time if not defined $ts;
  #print "found: $c /u/$u \@$ts\n";
  if (defined($results{$c})) {
    my ($oldts,$oldval) = split(/,/, $results{$c});
    if ($ts > $oldts) {
      $results{$c} = "$ts,$u";
#    } else {
      #print STDERR "discarding older\n";
    }
  } else {
    $results{$c} = "$ts,$u";
  }
}
