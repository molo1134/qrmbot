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
* `libtext-csv-perl`
* `liburi-perl`
* `libdbd-sqlite3-perl`
* `libdbi-perl`
* `libsqlite3-0`

If using the `stock` command, the `curl-impersonate` fork/patch is needed to
emulate the TLS handshake of an actual browser to work around TLS
fingerprinting:

* [curl-impersonate](https://github.com/lwthiker/curl-impersonate)

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

* `$HOME/.qrmbot/conf/qth` -- set your default geographic coordinates, for command line use
* `$HOME/.qrmbot/creds/hamspots` -- required login credentials for [hamspots.net](http://hamspots.net) use
* `$HOME/.qrmbot/creds/qrz` -- required login credentials for [qrz.com](http://qrz.com/) lookup
* `$HOME/.qrmbot/db/nicks.csv` -- irc and reddit nicknames -- optional, will override repository data
* `$HOME/.qrmbot/keys/adsb.fi` -- key for [adsb.fi](https://adsb.fi/) aircraft tracking (optional)
* `$HOME/.qrmbot/keys/aerisweather` -- API key for aerisweather.com
* `$HOME/.qrmbot/keys/aprs.fi` -- required [aprs.fi](http://aprs.fi/) API key for `aprs` tool
* `$HOME/.qrmbot/keys/bitly` -- key for [bit.ly](https://bit.ly/) API
* `$HOME/.qrmbot/keys/clublog` -- API key for [clublog.org](https://clublog.org/)
* `$HOME/.qrmbot/keys/coinmarketcap` -- API key for [coinmarketcap.com](https://coinmarketcap.com/)
* `$HOME/.qrmbot/keys/deepl` -- API key for [deepl.com](https://deepl.com/) translation
* `$HOME/.qrmbot/keys/google` -- keys for Google APIs (geocoding, translation)
* `$HOME/.qrmbot/keys/imgur` -- API key for [imgur.com](https://imgur.com/)
* `$HOME/.qrmbot/keys/omdbapi` -- API key for [omdbapi.com](https://www.omdbapi.com/)

## Cache files / state

* `$HOME/.qrmbot/cache/clublogusers.gz` -- cache of clublog.org user data
* `$HOME/.qrmbot/cache/cty.dat` -- cached DXCC data from [country-files.com](http://www.country-files.com/)
* `$HOME/.qrmbot/cache/dmr-id-repeaters.csv` -- cache of DMR repeater IDs
* `$HOME/.qrmbot/cache/dmr-id-users.csv` -- cache of DMR user IDs
* `$HOME/.qrmbot/cache/hamspots.cookies` -- HTTP cookies for hamspots.net session
* `$HOME/.qrmbot/cache/icao-types` -- cache of ICAO aircraft type data
* `$HOME/.qrmbot/cache/lotw-dates.txt` -- cached LOTW upload dates
* `$HOME/.qrmbot/cache/mostwanted.txt` -- cached DXCC "most wanted" data from [clublog.org](http://clublog.org/)
* `$HOME/.qrmbot/cache/qrz.cookies` -- HTTP cookies for qrz.com session
* `$HOME/.qrmbot/cache/radmon.txt` -- cached rad monitor data; safe to remove
* `$HOME/.qrmbot/cache/spot_timestamps` -- used for spots monitor mode; safe to remove
* `$HOME/.qrmbot/db/spots.sqlite` -- database of user-added radio spots


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
12. ~~Move dotfiles to a dot dir~~
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
* Jack WA6CR
