#!/usr/bin/perl -w
#
# Terminal color/bold and IRC color/bold output.  2-clause BSD license.
#
# Copyright 2018 /u/molo1134. All rights reserved.

package Colors;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(darkRed red redOnWhite blackOnWhite yellow green lightblue darkYellow lightGrey grey cyan lightcyan bold underline inverse italic strikethrough blink monospace);

BEGIN {
  our $username = $ENV{'USER'} || $ENV{'USERNAME'} || getpwuid($<);
  our $highlight="vt220";
  $highlight = "none" if ! -t STDOUT;
  $highlight = "irc" if $username eq "eggdrop";
}

sub darkRed {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x035\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[31m$s\e[0m"
  } else {
    return $s;
  }
}
sub red {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x034\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[1;31m$s\e[0m"
  } else {
    return $s;
  }
}
sub redOnWhite {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x034,0\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[1;31;48;5;15m$s\e[0m"
  } else {
    return $s;
  }
}
sub blackOnWhite {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x031,0\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[0;30;48;5;15m$s\e[0m"
  } else {
    return $s;
  }
}
sub yellow {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x038\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[1;33m$s\e[0m"
  } else {
    return $s;
  }
}
sub green {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x033\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[32m$s\e[0m"
  } else {
    return $s;
  }
}
sub lightblue {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x0312\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[1;34m$s\e[0m"
  } else {
    return $s;
  }
}
sub darkYellow {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x037\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[33m$s\e[0m"
  } else {
    return $s;
  }
}
sub lightGrey {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x0315\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[37m$s\e[0m"
  } else {
    return $s;
  }
}
sub grey {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x0314\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[1;30m$s\e[0m"
  } else {
    return $s;
  }
}
sub cyan {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x0310\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[36m$s\e[0m"
  } else {
    return $s;
  }
}
sub lightcyan {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x0311\x02\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[1;36m$s\e[0m"
  } else {
    return $s;
  }
}

# ctrl-b in irc client
sub bold {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x02$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[1m$s\e[0m"
  } else {
    return $s;
  }
}
# ctrl-_ in irc client
sub underline {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x1F$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[4m$s\e[0m"
  } else {
    return $s;
  }
}
# ctrl-v in irc client
sub inverse {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x16$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[7m$s\e[0m"
  } else {
    return $s;
  }
}
# ctrl-] in irc client
sub italic {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x1D$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[3m$s\e[0m"
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
    return "\x1E$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[9m$s\e[0m"
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
    return "\x06$s\x0F"
  } elsif ($highlight eq "vt220") {
    return "\e[5m$s\e[0m"
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
    return "\x11$s\x0F"
  } else {
    return $s;
  }
}



return 1;
