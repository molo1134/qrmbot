#!/usr/bin/perl -w
#
# Color

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
  if ($highlight eq "irc") {
    return "\x035\x02\x02$s\x03"
  } elsif ($highlight eq "vt220") {
    return "\e[31m$s\e[0m"
  } else {
    return $s;
  }
}
sub red {
  my $s = shift;
  if ($highlight eq "irc") {
    return "\x034\x02\x02$s\x03"
  } elsif ($highlight eq "vt220") {
    return "\e[1;31m$s\e[0m"
  } else {
    return $s;
  }
}
sub yellow {
  my $s = shift;
  if ($highlight eq "irc") {
    return "\x038\x02\x02$s\x03"
  } elsif ($highlight eq "vt220") {
    return "\e[1;33m$s\e[0m"
  } else {
    return $s;
  }
}
sub green {
  my $s = shift;
  if ($highlight eq "irc") {
    return "\x033\x02\x02$s\x03"
  } elsif ($highlight eq "vt220") {
    return "\e[32m$s\e[0m"
  } else {
    return $s;
  }
}
sub lightblue {
  my $s = shift;
  if ($highlight eq "irc") {
    return "\x0312\x02\x02$s\x03"
  } elsif ($highlight eq "vt220") {
    return "\e[1;34m$s\e[0m"
  } else {
    return $s;
  }
}
sub bold {
  my $s = shift;
  if ($highlight eq "irc") {
    return "\002$s\002"
  } elsif ($highlight eq "vt220") {
    return "\e[1m$s\e[0m"
  } else {
    return $s;
  }
}
sub darkYellow {
  my $s = shift;
  if ($highlight eq "irc") {
    return "\x035\x02\x02$s\x03"
  } elsif ($highlight eq "vt220") {
    return "\e[33m$s\e[0m"
  } else {
    return $s;
  }
}
sub lightGrey {
  my $s = shift;
  if ($highlight eq "irc") {
    return "\x0315\x02\x02$s\x03"
  } elsif ($highlight eq "vt220") {
    return "\e[37m$s\e[0m"
  } else {
    return $s;
  }
}
sub grey {
  my $s = shift;
  if ($highlight eq "irc") {
    return "\x0314\x02\x02$s\x03"
  } elsif ($highlight eq "vt220") {
    return "\e[1;30m$s\e[0m"
  } else {
    return $s;
  }
}

return 1;
