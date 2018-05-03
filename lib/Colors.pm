#!/usr/bin/perl -w
#
# Terminal color/bold and IRC color/bold output.  2-clause BSD license.
#
# Copyright 2018 /u/molo1134. All rights reserved.

package Colors;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(darkRed red yellow green lightblue bold darkYellow lightGrey grey);

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
sub darkYellow {
  my $s = shift;
  return undef if not defined($s);
  if ($highlight eq "irc") {
    return "\x035\x02\x02$s\x0F"
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

return 1;
