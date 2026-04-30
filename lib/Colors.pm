#!/usr/bin/perl -w
#
# Terminal color/bold and IRC color/bold output.
#
# 2-clause BSD license.
# Copyright (c) 2018, 2019, 2020, 2021 molo1134@github. All rights reserved.

package Colors;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(darkRed red redOnWhite blackOnWhite yellow green lightgreen lightblue blue darkYellow lightGrey grey cyan lightcyan magenta bold underline inverse italic strikethrough blink monospace optimizeIrcColor
lightBlueOnLightRed
lightBlueOnLightYellow
lightBlueOnRed
lightBlueOnWhite
lightBlueOnYellow
lightCyanOnBlack
lightCyanOnBlue
lightGreenOnYellow
lightRedOnBlack
lightRedOnBlue
lightRedOnLightBlue
lightYellowOnBlack
lightYellowOnBlue
cyanOnBlue
magentaOnBlack
redOnLightBlack
whiteOnBlack
whiteOnBlue
yellowOnBlack
yellowOnBlue
yellowOnLightBlack
);

BEGIN {
  our $username = $ENV{'USER'} || $ENV{'USERNAME'} || getpwuid($<);
  our $highlight="vt220";
  $highlight = "none" if ! -t STDOUT;
  $highlight = "irc" if $username eq "eggdrop";  # edit this to customize the username of the eggdrop bot
}

sub ircColor {
  my $code = shift;
  my $s = shift;
  return undef if not defined $code;
  return undef if not defined $s;
  return "\x03$code\x02\x02$s\x0F";
}

sub vt220Color {
  my $code = shift;
  my $s = shift;
  return undef if not defined $code;
  return undef if not defined $s;
  return "\e[${code}m$s\e[0m";
}

sub colorIrcVt220 {
  my $irccode = shift;
  my $vtcode = shift;
  my $s = shift;
  return undef if not defined $s;
  if ($highlight eq "irc") {
    return ircColor($irccode, $s);
  } elsif ($highlight eq "vt220") {
    return vt220Color($vtcode, $s);
  } else {
    return $s;
  }
}

sub darkRed {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("5", "31", $s);
}
sub red {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("4", "1;31", $s);
}
sub redOnWhite {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("4,0", "1;31;48;5;15", $s);
}
sub blackOnWhite {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("1,0", "0;30;48;5;15", $s);
}

sub lightBlueOnLightRed {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("12,4", "1;34;48;5;9", $s);
}
sub lightBlueOnLightYellow {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("12,8", "1;34;48;5;11", $s);
}
sub lightBlueOnRed {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("12,5", "1;34;48;5;1", $s);
}
sub lightBlueOnWhite {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("12,0", "1;34;48;5;15", $s);
}
sub lightBlueOnYellow {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("12,7", "1;34;48;5;11", $s);
}
sub lightCyanOnBlack {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("11,1", "1;36;48;5;0", $s);
}
sub lightCyanOnBlue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("11,2", "1;36;48;5;4", $s);
}
sub lightGreenOnYellow {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("9,5", "1;32;48;5;3", $s);
}
sub lightRedOnBlack {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("4,1", "1;31;48;5;0", $s);
}
sub lightRedOnBlue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("4,2", "1;31;48;5;4", $s);
}
sub lightRedOnLightBlue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("4,12", "1;31;48;5;12", $s);
}
sub lightYellowOnBlack {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("8,1", "1;33;48;5;0", $s);
}
sub lightYellowOnBlue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("8,2", "1;33;48;5;4", $s);
}
sub cyanOnBlue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("10,2", "0;36;48;5;4", $s);
}
sub magentaOnBlack {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("6,1", "0;35;48;5;0", $s);
}
sub redOnLightBlack {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("5,14", "0;31;48;5;8", $s);
}
sub whiteOnBlack {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("0,1", "0;37;48;5;0", $s);
}
sub whiteOnBlue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("0,2", "0;37;48;5;4", $s);
}
sub yellowOnBlack {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("8,1", "0;33;48;5;0", $s);
}
sub yellowOnBlue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("8,2", "0;33;48;5;4", $s);
}
sub yellowOnLightBlack {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("8,14", "0;33;48;5;8", $s);
}

sub yellow {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("8", "1;33", $s);
}
sub green {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("3", "32", $s);
}
sub lightgreen {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("9", "1;32", $s);
}
sub lightblue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("12", "1;34", $s);
}
sub blue {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("2", "34", $s);
}
sub darkYellow {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("7", "33", $s);
}
sub lightGrey {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("15", "37", $s);
}
sub grey {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("14", "1;30", $s);
}
sub cyan {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("10", "36", $s);
}
sub lightcyan {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("11", "1;36", $s);
}
sub magenta {
  my $s = shift;
  return undef if not defined($s);
  return colorIrcVt220("6", "35", $s);
}

# ctrl-b in irc client
sub bold {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x02$s\x0F";
  } elsif ($highlight eq "vt220") {
    return "\e[1m$s\e[0m";
  } else {
    return $s;
  }
}
# ctrl-_ in irc client
sub underline {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x1F$s\x0F";
  } elsif ($highlight eq "vt220") {
    return "\e[4m$s\e[0m";
  } else {
    return $s;
  }
}
# ctrl-v in irc client
sub inverse {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x16$s\x0F";
  } elsif ($highlight eq "vt220") {
    return "\e[7m$s\e[0m";
  } else {
    return $s;
  }
}
# ctrl-] in irc client
sub italic {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x1D$s\x0F";
  } elsif ($highlight eq "vt220") {
    return "\e[3m$s\e[0m";
  } else {
    return $s;
  }
}

sub strikethrough {
  return unicodeStrike2(shift);
}

# ctrl-^ in irc client ?
# only supported by textual irc now
sub terminalStrikethrough {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x1E$s\x0F";
  } elsif ($highlight eq "vt220") {
    return "\e[9m$s\e[0m";
  } else {
    return $s;
  }
}

sub unicodeStrike1 {
  return unicodeStrike(shift, "\x{0335}");
}
sub unicodeStrike2 {
  return unicodeStrike(shift, "\x{0336}");
}
require Encode;
sub unicodeStrike{
  my $text = shift;
  my $strikechar = shift;
  my $result = "";

  foreach my $c (split //, $text) {
    $result .= "$c$strikechar";
  }
  return $result;
}

# ctrl-f in irc client
sub blink {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x06$s\x0F";
  } elsif ($highlight eq "vt220") {
    return "\e[5m$s\e[0m";
  } else {
    return $s;
  }
}
# only supported in IRCCloud client now
# ctrl-q ?
sub monospace {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x11$s\x0F";
  } else {
    return $s;
  }
}

# join consecutive color blocks
sub optimizeIrcColor {
  my $s = shift;

  return $s if $highlight ne "irc";

  for (my $i = 0; $i < 64; $i++) {
    my $lastlen = length($s);
    my $newlen = 0;
    #my $n = 0;
    while ($newlen < $lastlen) {
      $lastlen = length($s);
      #print "doing $i before: $s\n";
      $s =~ s/\x03$i\x02\x02([^\x0F]+)\x0F\x03$i\x02\x02([^\x0F]+)\x0F/\x03$i\x02\x02$1$2\x0F/g;
      #print "doing $i after : $s\n";
      #print "---$n---\n";
      #$n++;
      $newlen = length($s);
    }
  }

  return $s;
}

return 1;
