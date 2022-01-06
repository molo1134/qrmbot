# qrm IRC bot and command line tools

A collection of command line tools and wrapper scripts for the eggdrop IRC bot.

Eggdrop is an IRC bot written in C with a built-in TCL scripting environment.
These IRC bot scripts are based around command-line tools written in perl with
a TCL wrapper layer.  The command line tools are designed to be standalone with
VT220/ANSI terminal output, and have been adapted for IRC color output.

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
* `perl`
* `perl-base`
* `perl-modules`
* `libastro-satpass-perl` (`Astro::Coord::ECI` -- see instructions below)
* `libclone-perl`
* `libdate-manip-perl`
* `libdatetime-format-strptime-perl`
* `libdatetime-perl`
* `libjson-perl`
* `libmath-bigint-perl`
* `libmath-round-perl`
* `libswitch-perl`
* `libtext-csv-perl`
* `liburi-perl`

### Building `libastro-satpass-perl`

```
$ sudo apt-get install git dh-make-perl apt-file
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

* `$HOME/.adsbx` -- API key for adsbexchange.com
* `$HOME/.aerisweather` -- API key for aerisweather.com
* `$HOME/.aprs.fi` -- required [aprs.fi](http://aprs.fi/) API key for `aprs` tool
* `$HOME/.bitlyapikey` -- key for bit.ly API
* `$HOME/.clublogapikey` -- API key for clublog.org
* `$HOME/.coinmarketcapkey` -- API key for coinmarketcap.com
* `$HOME/.darksky` -- API key for darksky.com
* `$HOME/.googleapikeys` -- key for Google APIs
* `$HOME/.hamspotlogin` -- required login credentials for [hamspots.net](http://hamspots.net) use
* `$HOME/.imgurkey` -- API key for imgur.com
* `$HOME/.nicks.csv` -- irc and reddit nicknames -- optional, will override repository data
* `$HOME/.qrzlogin` -- required login credentials for [qrz.com](http://qrz.com/) lookup
* `$HOME/.wunderground` -- required API key for [WUnderground](http://wundergound.com/) weather lookup

## Cache files / state

* `$HOME/.clublogusers.gz` -- cache of clublog.org user data
* `$HOME/.cty.dat` -- cached DXCC data from [country-files.com](http://www.country-files.com/)
* `$HOME/.dmr-id-repeaters.csv` -- cache of DMR repeater IDs
* `$HOME/.dmr-id-users.csv` -- cache of DMR user IDs
* `$HOME/.hamspotcookies` -- HTTP cookies for hamspots.net session
* `$HOME/.icao-types` -- cache of ICAO aircraft type data
* `$HOME/.lotw-dates.txt` -- cached LOTW upload dates
* `$HOME/.mostwanted.txt` -- cached DXCC "most wanted" data from [clublog.org](http://clublog.org/)
* `$HOME/.qrzcookies` -- HTTP cookies for qrz.com session
* `$HOME/.spottimestamps` -- used for spots monitor mode; safe to remove


## Security

Reasonable precautions have been made to filter out or escape shell special
characters and so forth, but this is not foolproof.  I suggest running the bot
inside a minimal chroot without any setuid binaries, or a suitable VM, as
needed.

## TODO

1. Clean up and modularize TCL scripts
2. Document how to use and configure TCL scripts
3. ~~Accept other formats for `!setgeo`~~
4. Use geo grid for `!activity`
5. Cleanup needed in `qrz` script
6. Add a preferred wx station in addition to `!setgeo` geo coords
7. If no callsign is specified with `!spots` use irc nick.
8. Requested by K1NZ: `!untappd` for beer info -- they are not giving out API keys. :(
9. ~~Add [clublog log check](https://clublog.freshdesk.com/support/solutions/articles/96841-checking-logs-for-the-existence-of-a-qso) or [clublog log search](https://clublog.freshdesk.com/support/solutions/articles/3000071078-performing-a-log-search-using-json)~~
10. Add [clublog DXCC activity data](https://clublog.freshdesk.com/support/solutions/articles/55364-activity-data-json-api)
11. ~~Add POTA~~
12. Move dotfiles to a dot dir
13. ~~Add [clublog league status](https://bbs.km8v.com/bot/league?call=)~~
14. ~~Add free space path loss calculation using gnu units.~~
15. Add wavelength and frequency calculation (free space and in-wire w/ velocity factor).
16. ~~Add coax loss calculation by length, frequency/band and type.~~
17. ~~Add nearest fires command from aeris wx api.~~


## Contributors

* Chris K2CR
* AA4JQ
* Dan VK3DAN
* Josh W9VFR
* Oliver M6WRF
* Andrew KC2G
* Asara WX0R
* KN6RAP
