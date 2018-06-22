# qrm IRC bot and command line tools

A collection of command line tools and wrapper scripts for the eggdrop IRC bot.

## License

All original code is 2-clause BSD licensed.  See [LICENSE](LICENSE) file.

The [`astro`](lib/astro) program has portions derived from K1JT Joe Taylor's
wsjt program and is GPLv3 licensed.  See [COPYING](COPYING) file.

## Usage

See [the /r/amateurradio wiki page for qrm
bot](https://www.reddit.com/r/amateurradio/wiki/qrmbot).

## Dependencies

As tested on Debian:

* `curl`
* `gocr`
* `netpbm`
* `perl`
* `perl-base`
* `perl-modules`
* `libastro-satpass-perl` (`Astro::Coord::ECI` -- see instructions below)
* `libdatetime-format-strptime-perl`
* `libdatetime-perl`
* `libmath-round-perl`
* `libswitch-perl`
* `libtext-csv-perl`
* `liburi-perl`

### Building `libastro-satpass-perl`

```
$ sudo apt-get install git dh-make-perl
$ sudo apt-file update
$ git clone 'https://github.com/trwyant/perl-Astro-Coord-ECI.git'
$ cd perl-Astro-Coord-ECI
$ git checkout 'v00.077'
$ dh-make-perl --vcs none --build

Would you like to configure as much as possible automatically? yes

What approach do you want? manual

$ sudo dpkg -i ../libastro-satpass-perl_0.077-1_all.deb
```

## Configuration files

* `$HOME/.aprs.fi` -- required [aprs.fi](http://aprs.fi/) API key for `aprs`
  tool
* `$HOME/.hamspotlogin` -- required login credentials for
  [hamspots.net](http://hamspots.net) use
* `$HOME/.qrzlogin` -- required login credentials for
  [qrz.com](http://qrz.com/) lookup
* `$HOME/.wunderground` -- required API key for
  [WUnderground](http://wundergound.com/) weather lookup
* `$HOME/.nicks.csv` -- irc and reddit nicknames -- optional, will override repository data

## Cache files / state

* `$HOME/.cty.dat` -- cached DXCC data from
  [country-files.com](http://www.country-files.com/)
* `$HOME/.mostwanted.txt` -- cached DXCC "most wanted" data from
  [clublog.org](http://clublog.org/)
* `$HOME/.hamspotcookies` -- HTTP cookies for hamspots.net session
* `$HOME/.qrzcookies` -- HTTP cookies for qrz.com session
* `$HOME/.lotw-dates.txt` -- cached LOTW upload dates
* `$HOME/.spottimestamps` -- used for spots monitor mode; safe to remove

## Security

Reasonable precautions have been made to filter out or escape shell special
characters and so forth, but this is not foolproof.  I suggest running the bot
inside a minimal chroot without any setuid binaries, or a suitable VM, as
needed.

## TODO

1. Clean up and modularize TCL scripts
2. ~~Add TCL scripts~~
3. Document how to use and configure TCL scripts
4. Clarify this week/next week for `contests`
5. Accept other formats for `!setgeo`
6. Use geo grid for `!activity`
7. Cleanup needed in `qrz` script
8. Add a preferred wx station in addition to `!setgeo` geo coords

