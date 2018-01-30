# qrm IRC bot

## Dependencies

As tested on Debian:

* `curl`
* `gocr`
* `perl`
* `perl-base`
* `perl-modules`
* `libastro-satpass-perl` (`Astro::Coord::ECI` -- see instructions below)
* `libdatetime-format-strptime-perl`
* `libmath-round-perl`
* `libswitch-perl`
* `libtext-csv-perl`
* `liburi-perl`

### Building `libastro-satpass-perl`

```
sudo apt-get install git dh-make-perl
git clone 'https://github.com/trwyant/perl-Astro-Coord-ECI.git'
cd perl-Astro-Coord-ECI
git checkout 'v00.077'
dh-make-perl --vcs none --build
sudo dpkg -i ../libastro-satpass-perl_0.077-1_all.deb
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

## Cache files / state

* `$HOME/.cty.dat` -- cached DXCC data from
  [country-files.com](http://www.country-files.com/)
* `$HOME/.mostwanted.txt` -- cached DXCC "most wanted" data from
  [clublog.org](http://clublog.org/)
* `$HOME/.hamspotcookies` -- HTTP cookies for hamspots.net session
* `$HOME/.qrzcookies` -- HTTP cookies for qrz.com session
* `$HOME/.lotw-dates.txt` -- cached LOTW upload dates
* `$HOME/.spottimestamps` -- used for spots monitor mode

