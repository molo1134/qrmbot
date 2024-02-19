# IRC bot Commands

## Command summary:

 * `!qrz` `!call` -- lookup callsign on qrz.com
 * `!qth` `!grid` -- lookup grid square or qth
 * `!bands` -- display HF propagation information
 * `!solar` -- display solar ionospheric conditions
 * `!xray` -- display xray flux
 * `!kindex` `!ki` -- 3-day k-index forecast
 * `!forecast` -- 27 day solar forecast
 * `!45day` -- 45 day solar forecast
 * `!longterm` -- solar cycle forecast
 * `!activity` -- band activity from pskreporter
 * `!dxcc` -- display information on a dxcc entity
 * `!spots` -- display spots for a callsign
 * `!morse` `!cw` -- convert to morse code
 * `!unmorse` `!demorse` -- decode from morse
 * `!repeater` -- search for repeater
 * `!iono` -- report from nearest ionosonde
 * `!muf` -- GIRO MUF reports from ionosondes
 * `!blitz` `!zap` -- lightning report
 * `!aprs` -- APRS station information
 * `!eme` -- EME prediction
 * `!graves` -- French 143 MHz radar as EME beacon
 * `!sat` -- satellite info and pass predictor
 * `!satpass` -- satellite pass predictor
 * `!satinfo` -- satellite info
 * `!qcode` `!q` -- qcode lookup
 * `!rig` -- describe a radio or other gear
 * `!lotw` -- last upload date to LoTW for a callsign
 * `!eqsl` -- last login to eqsl.cc for a callsign
 * `!clublog` `!oqrs` -- log and OQRS info on clublog.org
 * `!qsl` -- check all of the above qsl methods
 * `!league` -- report clublog league standings
 * `!pota` -- search POTA parks and users
 * `!sota` -- search SOTA summits
 * `!iota` -- search IOTA islands
 * `!1x1` -- search 1x1 special event stations
 * `!contests` -- list current and upcoming contests
 * `!wrtc` -- show WRTC standings for a callsign
 * `!fspl` -- free space path loss calculator
 * `!coax` `!atten` -- coax attenuation calculator
 * `!ae7q` -- get US callsign availability info
 * `!vanity` -- get US vanity callsign application info
 * `!dxped` -- get current dxpedition info
 * `!wx` `!wxfull` -- show current weather conditions
 * `!wxf` `!wxflong` -- weather forecast
 * `!metar` -- show METAR weather data
 * `!taf` -- show TAF weather data
 * `!utc` -- display current UTC time
 * `!time` `!tz` -- localtime in the qth or grid specified
 * `!wwv` -- emulate WWV station (in channel only)
 * `!moon` -- Lunar position and phase
 * `!sun` -- Solar position
 * `!elev` -- get elevation data for a place
 * `!drive` -- compute drive time and distance using google maps
 * `!transit` -- compute transit time and route using google transit
 * `!fire` -- show nearest wildfire
 * `!rad` -- report nearest radiation monitor
 * `!quake` `!quakef` -- earthquake info
 * `!calc` -- calculator
 * `!units` -- convert values between units
 * `!ctof` `!ftoc` -- convert temperatures
 * `!stock` -- financial quotes
 * `!gold` `!silver` `!platinum` -- precious metal prices
 * `!crypto` -- cryptocurrency price check
 * `!bitcoin` `!btc` `!litecoin` `!ltc` `!etherium` `!eth` `!doge`
 * `!debt` -- US government debt
 * `!setgeo` `!getgeo` -- set your qth for results in some commands †
 * `!github` -- display bot github URL
 * `!quote` `!quotesearch` -- get a quote
 * `!addquote` -- add a quote
 * `!define` -- glossary lookup
 * `!phoneticise` -- random phonetics
 * `!imdb` -- movie info
 * `!adsb` -- get plane information
 * `!hofh` -- why your radio is broke
 * `!ammo` -- find a price for ammo
 * `!launch` -- search for upcoming rocket launch
 * `!spacex` -- next spacex launch
 * `!translate` -- translate text
 * `!rand` `!dice` `!flip` `!8ball` -- random

## Radio-related commands:

### `!qrz` !call -- lookup callsign on qrz.com

Usage:

```
    !qrz [call:]<callsign>|<name>|[grid:]<grid>|<qth>|dmr:<dmrID>
```

Examples:

```
    <molo1134> !call W1AW 
    <@qrn> W1AW: USA:  ARRL HQ OPERATORS CLUB -- W1AW@ARRL.ORG -- Club class
            -- DMR IDs: 3109478, 310938 -- trustee: NJ1Q -- QSL: US STATIONS
            PLEASE QSL VIA LOTW OR DIRECT WITH SASE. [LM] -- Attn: JOSEPH P
            CARCIA III; 225 MAIN ST; NEWINGTON, CT 06111; USA --
            FN31pr [src: user]

    <molo1134> !call dmr:3109478
    <@qrn> W1AW: USA:  ARRL HQ OPERATORS CLUB -- W1AW@ARRL.ORG -- Club class
            -- DMR IDs: 3109478, 310938 -- trustee: NJ1Q -- QSL: US STATIONS
            PLEASE QSL VIA LOTW OR DIRECT WITH SASE. [LM] -- Attn: JOSEPH P
            CARCIA III; 225 MAIN ST; NEWINGTON, CT 06111; USA --
            FN31pr [src: user]

    <molo1134> !qrz grid:FN31pr
    <qrm> FN31pr matches:
    <qrm> AA1EZ: Jon [..redacted..] Newington CT FN31pr
    <qrm> AA1FC: Frederick [..redacted..] Newington CT FN31pr
    <qrm> AA1OX: ANDREW [..redacted..] HARTFORD CT FN31pr
    <qrm> AB1FM: Maria [..redacted..] Newington CT FN31pr
    <qrm> truncated. 145 matches found. see https://www.qrz.com/lookup/?query=FN31pr&mode=grid

    <molo1134> !qrz newington ct
    <qrm> newington ct: possible matches:
    <qrm> 8P9IU: Michael [..redacted..] Newington CT
    <qrm> AA1EZ: Jon [..redacted..] Newington CT
    <qrm> AA1FC: Frederick [..redacted..] Newington CT
    <qrm> AB1AL: Mary [..redacted..] Newington CT
    <qrm> truncated. 197 matches found. see https://www.qrz.com/lookup/?query=newington+ct&mode=name

    <molo1134> !qrz united nations
    <qrm> united nations: possible matches:
    <qrm> 4U0R: UNITED NATIONS ARCDXC - Contest DX Club Vienna. Austria.
    <qrm> 4U0WFP: United Nations World Food Programme Rome
    <qrm> 4U1A: United Nations Amateur Radio Contest DX Club  Wagramer St. 5.
    <qrm> 4U1AIDS: c/o Andrey [..redacted..] JOINT UNITED NATIONS PROGRAMME ON HIV/AIDS Geneva
    <qrm> truncated. 24 matches found. see https://www.qrz.com/lookup/?query=united+nations&mode=name
```

Data source: https://www.qrz.com/

### `!qth` `!grid` -- lookup grid square or qth

Usage:

```
    !grid <grid>|<lat>,<lon>|<qth> [de <grid>|<lat>,<lon>|<qth>]
```

Examples:

```
    <molo1134> !grid FN31pr
    <qrm> FN31pr: 41.7292, -72.7083: South West, Hartford, CT, USA

    <molo1134> !grid 41.714775,-72.727260
    <qrm> FN31pr: 41.714775, -72.727260: Newington, CT, USA

    <molo1134> !grid 1400 pennsylvania avenue washington dc
    <qrm> FM18lv: 38.8960168, -77.0329812: Northwest Washington, Washington, 
             DC, USA

    <molo1134> !grid 1400 pennsylvania avenue washington dc DE 41.714775,-72.727260
    <qrm> FM18lv: 38.8960168, -77.0329812: Northwest Washington, Washington, 
             DC, USA -- 481.6 km, 231° from FN31pr
```

Data source: Google Geocoding API

### `!bands` -- display HF propagation information

Example:

```
    <molo1134> !bands
    <qrm> Bands as of 19 Feb 2024 2259 GMT: SFI=152 SN=64 A=4 K=0 eSFI=143.8
           eSSN=108.5
    <qrm> | 12m-10m | day: Good | night: Poor |
    <qrm> | 17m-15m | day: Good | night: Good |
    <qrm> | 30m-20m | day: Fair | night: Good |
    <qrm> | 80m-40m | day: Poor | night: Good |

```

Data sources: https://hamqsl.com/ ; eSSN and eSFI via https://prop.kc2g.com/

### `!solar` -- display solar ionospheric conditions

Example:

```
    <molo1134> !solar
    <qrm> Conditions: SFI=152 SN=73 A=0 K=0 eSFI=143.8 eSSN=108.5
```

Data sources: Kp and Ap via gfz-potsdam.de; SFI via NOAA; SSN via sidc.be; eSSN
and eSFI via https://prop.kc2g.com/

### `!xray` -- display xray flux

Example:

```
    <molo1134> !xray
    <qrm> Xray status: C2.1 at 2024-02-19T22:58:00Z; recent flare: C2.7 at
             2024-02-19T22:46:00Z
```

Data source: GOES via NOAA SWPC

### `!kindex` `!ki` -- 3-day k-index forecast
### `!forecast` -- 27 day solar forecast
### `!45day` -- 45 day solar forecast
### `!longterm` -- solar cycle forecast
### `!activity` -- band activity from pskreporter
### `!dxcc` -- display information on a dxcc entity
### `!spots` -- display spots for a callsign
### `!morse` `!cw` -- convert to morse code
### `!unmorse` `!demorse` -- decode from morse
### `!repeater` -- search for repeater
### `!iono` -- report from nearest ionosonde
### `!muf` -- GIRO MUF reports from ionosondes
### `!blitz` `!zap` -- lightning report
### `!aprs` -- APRS station information
### `!eme` -- EME prediction
### `!graves` -- French 143 MHz radar as EME beacon
### `!sat` -- satellite info and pass predictor
### `!satpass` -- satellite pass predictor
### `!satinfo` -- satellite info
### `!qcode` `!q` -- qcode lookup
### `!rig` -- describe a radio or other gear
### `!lotw` -- last upload date to LoTW for a callsign
### `!eqsl` -- last login to eqsl.cc for a callsign
### `!clublog` `!oqrs` -- log and OQRS info on clublog.org
### `!qsl` -- check all of the above qsl methods
### `!league` -- report clublog league standings
### `!pota` -- search POTA parks and users
### `!sota` -- search SOTA summits
### `!iota` -- search IOTA islands
### `!1x1` -- search 1x1 special event stations
### `!contests` -- list current and upcoming contests
### `!wrtc` -- show WRTC standings for a callsign
### `!fspl` -- free space path loss calculator
### `!coax` `!atten` -- coax attenuation calculator
### `!ae7q` -- get US callsign availability info
### `!vanity` -- get US vanity callsign application info
### `!dxped` -- get current dxpedition info

## Geophysical-related commands:

### `!wx` `!wxfull` -- show current weather conditions
### `!wxf` `!wxflong` -- weather forecast
### `!metar` -- show METAR weather data
### `!taf` -- show TAF weather data
### `!utc` -- display current UTC time
### `!time` `!tz` -- localtime in the qth or grid specified
### `!wwv` -- emulate WWV station (in channel only)
### `!moon` -- Lunar position and phase
### `!sun` -- Solar position
### `!elev` -- get elevation data for a place
### `!drive` -- compute drive time and distance using google maps
### `!transit` -- compute transit time and route using google transit
### `!fire` -- show nearest wildfire
### `!rad` -- report nearest radiation monitor
### `!quake` `!quakef` -- earthquake info

## Numerical and finance

### `!calc` -- calculator
### `!units` -- convert values between units
### `!ctof` `!ftoc` -- convert temperatures
### `!stock` -- financial quotes
### `!gold` `!silver` `!platinum` -- precious metal prices
### `!crypto` -- cryptocurrency price check
### `!bitcoin` `!btc` `!litecoin` `!ltc` `!etherium` `!eth` `!doge`
### `!debt` -- US government debt

## Metadata and bot control

### `!setgeo` `!getgeo` -- set your qth for results in some commands †
### `!github` -- display bot github URL

## Fun stuff / web scraping

### `!quote` `!quotesearch` -- get a quote
### `!addquote` -- add a quote
### `!define` -- glossary lookup
### `!phoneticise` -- random phonetics
### `!imdb` -- movie info
### `!adsb` -- get plane information
### `!hofh` -- why your radio is broke
### `!ammo` -- find a price for ammo
### `!launch` -- search for upcoming rocket launch
### `!spacex` -- next spacex launch
### `!translate` -- translate text
### `!rand` `!dice` `!flip` `!8ball` -- random

<!-- !amcon - - some dumb prepper shit -->
<!-- !c19 !corona - - coronavirus stats -->


* `!activity` -- band activity from pskreporter
* `!bands` -- display propagation information
* `!contests` -- list current and upcoming contests
* `!dxcc` -- display information on a DXCC entity
* `!eqsl` -- last login to eqsl.cc for a callsign
* `!kf` -- display KP index predictions
* `!lotw` -- last upload date to LoTW for a callsign
* `!qrz` or `!call` -- lookup a callsign or known associated reddit username on qrz.com
* `!qth` or `!grid` -- lookup a grid square or qth
* `!setgeo` or `!getgeo` -- set/get your QTH for results in the above †
* `!solar` -- display solar ionospheric conditions
* `!spots` -- display spots for a callsign
* `!units` -- convert values between units, general purpose calculations
* `!utc` or `!z` -- display current time in UTC
* `!wx` or `!wxfull` -- display current weather conditions
* `!morse` or `!cw` -- convert to morse code
* `!unmorse` or `!demorse` -- decode from morse
* `!kindex` or `!ki` -- 3-day k-index forecast
* `!forecast` -- 27-day solar forecast
* `!phoneticise` -- random phonetics
* `!repeater` -- lookup repeater by callsign
* `!muf` -- Maximum Usable Frequency reports from ionosondes -- see [KML map](http://pastebin.com/Ni9tRV7N)
* `!muf2` -- Alternate data sources for MUF
* `!aprs` -- APRS station information
* `!sun` -- Sun position
* `!moon` -- Moon position
* `!eme` -- EME 2m propagation information
* `!graves` -- [GRAVES Radar](https://en.wikipedia.org/wiki/Graves_%28system%29) EME beacon status
* `!sat` -- satellite pass predictor
* `!qcode` or `!q` -- qcode lookup
* `!crypto` -- cryptocurrency price check, with the following shortcuts: `!bitcoin` `!btc` `!litecoin` `!ltc` `!etherium` `!eth` `!doge`
* `!rig` -- Look up amateur radio equipment by name

Notes:

† -- requires a bot account.  `/msg <botname> hello` to create a bot account (may require a registered nick on some irc networks)

## Examples

    < molo1134> !call W1AW 
    < qrm> W1AW: USA:  ARRL HQ OPERATORS CLUB -- W1AW@ARRL.ORG -- Club class
           -- trustee: K1ZZ -- QSL: US STATIONS PLEASE QSL VIA LOTW OR DIRECT
           WITH SASE. [LEM] -- 225 MAIN ST; NEWINGTON, CT 06111; USA --
           FN31pr [src: user]

    < molo1134> !call TX3X
    < qrm> TX3X: Chesterfield Islands: Chesterfield Islands 2015 DX-pedition
           -- k5gs@pdxg.net -- IOTA: OC-176 -- QSL: See QSL info at TX3X.com
           [LM] -- PO Box 189; Divide, CO 80814; USA -- QH90dl [src: user]

    < molo1134> !dxcc W1AW
    < qrm> W1AW: United States (K): NA CQ:5 ITU:8 MW:340

    < molo1134> !dxcc kiribati
    < qrm> T30: Western Kiribati: OC CQ:31 ITU:65 MW:97

    < molo1134> !solar
    < qrm> Conditions as of 08 Oct 2015 1547 GMT: SFI=80 SN=24 A=77 K=5

    < molo1134> !bands
    < qrm> Bands as of 08 Oct 2015 1547 GMT: SFI=80 SN=24 A=77 K=5
    < qrm> | 12m-10m | day: Shit | night: Shit |
    < qrm> | 17m-15m | day: Shit | night: Shit |
    < qrm> | 30m-20m | day: Shit | night: Shit |
    < qrm> | 80m-40m | day: Shit | night: Shit |
    < qrm> vhf-aurora: northern_hemi MID LAT AUR

    < molo1134> !lotw W1AW
    < qrm> W1AW: 2015-09-28

    < molo1134> !eqsl W1AW
    < qrm> W1AW: (AG) FN31pr; last login: 07-Feb-2014

    < molo1134> !spots W1AW
    < qrm> G4UFK   W1AW     1802 579 with qsb                 0333z 08 Oct d
    < qrm> N8MSA   W1AW     7047 cw 21 dB, 18 wpm             0301z 08 Oct r
    < qrm> KP3Z    W1AW     7047 cw 18 dB, 15 wpm             0155z 08 Oct r

    < molo1134> !activity CW FN  
    < qrm> CW from grid FN: 10m⇒4, 15m⇒17, 17m⇒7, 20m⇒53, 30m⇒95, 40m⇒171,  
           80m⇒53, 160m⇒3  

    < molo1134> !activity IO  
    < qrm> ALL from grid IO: 15m⇒16, 20m⇒8, 30m⇒55, 40m⇒880, 60m⇒1, 80m⇒663,  
           160m⇒218, 630m⇒23  

    < molo1134> !qth london, uk from san jose, california
    < qrm> IO91wm: 51.5073509, -0.1277583: London, UK -- 8641.5 km, 33° from
           CM97bi

    < molo1134> !units 15W in dBm
    < qrm> 15W = 41.760913 dBm

    < molo1134> !units (dBuV(140.5)/m)/(9.73 /((c/98MHz)*sqrt(dB(2.14)))) in V
    < qrm> (dBuV(140.5)/m)/(9.73 /((c/98MHz)*sqrt(dB(2.14)))) = 4.2607082 V

    < molo1134> !contests  
    < qrm> now: AWA Bruce Kelley 1929 QSO Party  
    < qrm> this weekend: ARRL 10-Meter Contest; SKCC Weekend Sprintathon;  
                 International Naval Contest

    < KM4JOJ> !wx 20111
    < qrm> Weather for Manassas, VA conditions: Clear  Temp: 7°C/45°F
        Humidity: 75%  Wind: North at 1kph/1mph (gust 1.6kph/1.0mph)

    < NS7I> !wxfull laramie
    < qrm> Weather for Laramie, WY (-105.6,41.3)  Elev: 2190m/7185ft
    < qrm>  observed at KLAR, Laramie, Last Updated on November 20, 11:22 AM MST
    < qrm>  conditions: Snow  Temp: -6°C/21°F  Humidity: 88%
    < qrm>  Feels like: -14°C/8°F  Visibility: 1.6km/1.0mi  
    < qrm>  Wind: North at 24kph/15mph  Pressure: 29.96inHg/1014mb (↓)  
    < qrm>  Precipitation: today: 0.5mm/0.02in  

    < molo1134> !morse CQ CQ DE W1AW
    < qrm> -.-. --.-   -.-. --.-   -.. .   .-- .---- .- .--   
    < molo1134> !demorse -.-. --.-   -.-. --.-   -.. .   .-- .---- .- .--
    < qrm> CQ CQ DE W1AW

    < molo1134> !kindex
    < qrm> Kp index prediction as of 2016 Feb 03 0030 UTC:
    < qrm> Feb 03|Feb 04|Feb 05: ▃▄▃▄▃▂▂▃|▃▃▂▂▂▂▂▂|▂▂▂▂▁▁▂▂


    < molo1134> !forecast
    <+qrm> Daily forecast as of: 2017 Nov 20 0559 UTC; today to 2017 Dec 16:
    <+qrm> Kp : ▄▄▃▂▂▂▂▂▃▃▂▂▂▆▆▅▅▃▂▂▄▄▄▃▂▂
    <+qrm> Ap : ▂▂▁▁▁▁▁▁▁▂▁▁▁▄▅▃▃▂▁▁▂▂▂▁▁▁
    <+qrm> SFI: ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁

    < VA7EEX_> !phonetics w8tam
    < qrm> welcomed 8 tabulate aural matchmakers

    < JR2TTS> !repeater W3VPR
    <+qrm> W3VPR: 147.0750 (+) 107.2 PL @ Glen Burnie, Anne Arundel County, MD
    <+qrm> truncated, see: http://repeaterbook.com/repeaters/keyResult.php?keyword=W3VPR

    <molo1134> !muf list
    <qrm> Ascension Beijing Boulder Brisbane Camden Canberra Casey Chongqing 
            Cocos_Is Darwin Dixon Dourbes Eglin ElArensillo Fairford Gibilmanna 
            Grahamstown Guangzhou Hainan Hermanus Hobart Jeju Jicamarca 
            Juliusruh Learmonth Louisvale Madimbo Magadan Manzhouli Mawson 
            Moscow Murmansk Niue Norfolk_Is Perth Pruhonice Rome Salekhard 
            San_Vito Scott_Base Tomsk Townsville Tromso Warsaw 

    < Hamsterdave> !muf wallops
    <+qrm> Wallops (37,-76) MUF @ 2016-06-14 1940 UTC: 15.064 MHz; recent high:
        21.46 at 1140 UTC; low: 8.658 at 0925 UTC

    <+NS7I> !aprs n3bbq-9
    <+qrm> N3BBQ-9: Grand Junction, CO, USA @ 27kph/17mph 89° alt 1765m/5790ft
        at 2016-06-18 22:00z (14340 mn20 npota) via (WIDE1-1,WIDE2-1,qAR,KB0YNA-5)

    < KO6RM> !sun DN70
    <+qrm> Sun is set; Sun will rise at 2017-03-20 13:05z (in 11h54m)

    < molo1134> !sun tokyo
    <+qrm> Sun az/el 143.1°/47.9°; Sun will set at 2017-03-20 08:49z (in
             7h35m)

    < molo1134> !moon
    <+qrm> Moon is set; phase: 3rd qrtr., 56% illum.; Moon will rise at
             2017-03-20 05:54z (in 4h40m);

    < molo1134> !moon paris
    <+qrm> Moon az/el 121.7°/1.4°; dist 403318 km; phase: 3rd qrtr., 56%
             illum.; Moon will set at 2017-03-20 10:11z (in 8h56m);

    < molo1134> !eme paris
    <+qrm> Moon az/el 121.8°/1.5°; dist 403311 km; phase: 3rd qrtr., 56%
             illum.; Moon will set at 2017-03-20 10:11z (in 8h55m); EME
             degrd(2m): 10.5 dB (Very Poor); EME path loss(2m): 252.9 dB (+2.1 
             dB, 93%);

    < molo1134> !graves
    <+qrm> GRAVES Radar: Moon outside of beam; az/el 123.4°/3.6°

    < molo1134> !sat AO-85 seattle
    <+qrm> AO-85 @CN87uo: AOS 2017-11-21 11:42z az 178°; max el 20° az 113°;
             LOS 11:53z az 49° ‖ AOS 2017-11-21 13:21z az 231°; max el 47° az
             314°; LOS 13:34z az 35° ‖ AOS 2017-11-21 15:03z az 279°; max el
             12° az 337°; LOS 15:14z az 33°

    < molo1134> !sat iss
    <+qrm> ISS @FN20xw: AOS 2017-11-21 03:09z az 260°; max el 27° az 334°;
             LOS 03:19z az 49° ‖ AOS 2017-11-21 04:47z az 294°; max el 13° az
             354°; LOS 04:56z az 54° ‖ AOS 2017-11-21 06:24z az 310°; max el
             16° az 15°; LOS 06:34z az 80°

    < molo1134> !crypto ETH USD
    <+qrm> ETHUSD ↑365.565 +0.58% qty 2900852 ETH/24h (1,060,450,000 USD/24h)

    < molo1134> !btc
    <+qrm> BTCUSD ↑8,274.25 +0.52% qty 536638 BTC/24h (4,440,280,000 USD/24h)



For callsign lookup with distance and bearing (last field), first create a bot
account and set your origin.  Note: **only decimal degrees are accepted for !setgeo**, and **no space after the comma**.  You can look up decimal degrees with the !qth command.

    /msg qrm hello
    /msg qrm pass <yourpassword>
    < Crossbar> !setgeo 40.361852,-76.328412
    < Crossbar> !call hb9frv
    < qrm> HB9FRV: Switzerland: Matt (Mathias) Weyland -- hb9frv@uska.ch --
           QSL: direct or via USKA bureau [LE] -- Allmendweg 20; Aarau 5000;
           Switzerland -- JN47aj [src: user] -- 4279.8 km, 33° from FN11ht

## Data sources

* callsign lookup: http://qrz.com
* DXCC entities: http://www.country-files.com/big-cty/
* most-wanted entities: http://www.clublog.org/mostwanted.php
* activity: http://pskreporter.info/
* band conditions: http://www.hamqsl.com/solarxml.php
* contest calendar: http://www.hornucopia.com/contestcal/weeklycont.php
* eqsl status: http://www.eqsl.cc/Member.cfm?CALLSIGN
* lotw status: https://lotw.arrl.org/lotw-user-activity.csv
* kindex prediction: http://services.swpc.noaa.gov/text/3-day-forecast.txt
* solar forecast: http://services.swpc.noaa.gov/text/27-day-outlook.txt
* units: [GNU Units](https://www.gnu.org/software/units/)
* weather: https://www.wunderground.com/weather/api/
* spots: http://pskreporter.info/, http://dxwatch.com/, http://reversebeacon.net/, http://hamspots.net/
* qth geocoding: [Google maps geocoding API](https://developers.google.com/maps/documentation/geocoding/intro)
* repeaters: https://www.repeaterbook.com/
* aprs: http://aprs.fi/
* MUF: ftp://ftp.swpc.noaa.gov/pub/lists/iono_day/
* MUF2: https://lgdc.uml.edu/common/DIDBFastStationList
* Sats: http://www.amsat.org/amsat/ftp/keps/current/nasabare.txt
* Cryptocurrency prices: https://coinmarketcap.com/api/

