# IRC bot Commands

## Command summary:

 * `!qrz` `!call` -- lookup callsign on qrz.com
 * `!qth` `!grid` -- lookup grid square or qth
 * `!bands` -- display HF propagation information
 * `!solar` -- display solar ionospheric conditions
 * `!xray` -- display xray flux
 * `!kindex` `!ki` `!kf` -- 3-day k-index forecast
 * `!forecast` -- 27 day solar forecast
 * `!45day` `!usaf` -- USAF 45 day solar forecast
 * `!longterm` -- solar cycle forecast
 * `!activity` -- band activity from pskreporter
 * `!dxcc` -- display information on a dxcc entity
 * `!spots` -- display spots for a callsign
 * `!potaspots` -- find POTA activity
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
 * `!potapark` -- find POTA parks near a given location
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
 * `!cpi` -- US dollar inflation calculator
 * `!setgeo` `!getgeo` -- set your qth for results in some commands †
 * `!github` -- display bot github URL
 * `!quote` `!quotesearch` -- get a quote
 * `!addquote` -- add a quote
 * `!define` -- glossary lookup
 * `!phoneticise` -- random phonetics
 * `!imdb` -- movie info
 * `!steam` -- Steam game info (name, price, rating, description)
 * `!adsb` -- get plane information
 * `!hofh` -- why your radio is broke
 * `!ammo` -- find a price for ammo
 * `!launch` -- search for upcoming rocket launch
 * `!spacex` -- next spacex launch
 * `!translate` -- translate text
 * `!rand` `!dice` `!flip` `!8ball` `!orb` -- random

## Radio-related commands:

### `!qrz` `!call` -- lookup callsign on qrz.com

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

    <molo1134> !qth 1400 pennsylvania avenue washington dc
    <qrm> FM18lv: 38.8960168, -77.0329812: Northwest Washington, Washington, 
             DC, USA

    <molo1134> !qth 1400 pennsylvania avenue washington dc DE 41.714775,-72.727260
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

### `!kindex` `!ki` `!kf` -- 3-day k-index forecast

Example:

```
    <molo1134> !kindex
    <qrm> Kp index prediction as of 2016 Feb 03 0030 UTC:
    <qrm> Feb 03|Feb 04|Feb 05: ▃▄▃▄▃▂▂▃|▃▃▂▂▂▂▂▂|▂▂▂▂▁▁▂▂
```

Data source: NOAA SWPC

### `!forecast` -- 27 day solar forecast

Output also indicates major upcoming HF contests.

Example:

```
    <molo1134> !forecast
    <qrm> Daily forecast as of: 2023 Dec 04 0332 UTC; today to 2023 Dec 30:
    <qrm> Kp : ▆▅▄▃▂▂▂▂▄▃▂▂▂▂▅▅▃▂▅▄▂▂▂▂▂▂▂
    <qrm> Ap : ▄▂▂▁▁▁▁▁▂▁▁▁▁▁▂▃▁▁▃▂▁▁▁▁▁▁▁
    <qrm> SFI: ▄▃▃▃▃▃▃▄▄▄▄▄▄▄▅▅▅▅▅▅▅▅▅▅▄▄▄
    <qrm>           ^^ ARRL 10m
    <qrm>                   ^ ARRL Rookie Roundup, CW
```

Data source: NOAA SWPC

### `!45day` `!usaf` -- USAF 45 day solar forecast

Example:

```
    <molo1134> !usaf
    <qrm> USAF 45-day forecast as of: 2024 Jan 11 2141 UTC; today to 2024 Feb 25:
    <qrm> Ap : ▁▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂▂
    <qrm> SFI: ▆▆▆▆▆▆▆▄▄▄▄▄▄▄▄▃▄▄▄▄▄▅▅▄▅▅▅▅▅▅▅▅▅▅▄▄▄▄▄▄▄▄▃▄▄
```

Data source: USAF via NOAA SWPC

### `!longterm` -- solar cycle forecast

Example:

```
    <molo1134> !longterm
    <qrm> NOAA:      | 2026       | 2027       | 2028
    <qrm> SFI: ▅▄▄▄▄▄|▄▄▄▄▄▄▄▄▄▄▄▃|▃▃▃▃▃▃▂▂▂▂▂▂|▂▂▂▂▁▁▁▁▁▁▁▁ : 84.5-155.3
    <qrm> SN:  ▇▇▇▇▇▇|▇▇▇▇▇▇▇▇▇▇▆▆|▆▆▅▅▅▅▄▄▄▄▃▃|▃▃▂▂▂▂▁▁▁▁▁▁ : 37.2-123.9
    <qrm> NASA:      | 2026       | 2027       | 2028
    <qrm> SFI: ▄▄▄▄▄▄|▄▄▄▃▃▃▃▃▃▃▃▃|▃▂▂▂▂▂▂▂▂▂▂▂|▂▁▁▁▁▁▁▁▁▁▁▁ : 82.8-154.3
    <qrm> AP:  ▅▅▆▆▇▇|▇▇▇▇▇▇▇▇▇▇▇▇|▇▇▇▆▆▅▄▄▄▄▃▃|▂▂▂▂▃▃▃▂▂▁▁▁ : 13.7-16.5
    <qrm> ITU :| 2026
    <qrm> SN:  |▇▇▇▇▆▆▅▄▃▃▂▁ : 90-113
```

Data sources: NOAA SWPC, NASA MSAFE, ITU HFBC

### `!activity` -- band activity from pskreporter

Usage:

```
    !activity [mode] <grid>
```

Examples:

```
    <molo1134> !activity FN
    <qrm> ALL from grid FN (last 15 min): 0.23m⇒5, 2m⇒30, 6m⇒4, 10m⇒59903,
             12m⇒13053, 15m⇒35153, 17m⇒9882, 20m⇒64162, 30m⇒16118, 40m⇒32383,
             60m⇒964, 80m⇒5054, 160m⇒1037, 630m⇒10

    <molo1134> !activity FN21
    <qrm> ALL from grid FN21 (last 15 min): 10m⇒884, 12m⇒857, 15m⇒1483,
             17m⇒26, 20m⇒140, 30m⇒75, 40m⇒52, 160m⇒1

    <molo1134> !activity FN FT4
    <qrm> FT4 from grid FN (last 15 min): 10m⇒2246, 12m⇒6, 15m⇒470, 17m⇒50,
             20m⇒2630, 30m⇒281, 40m⇒1266, 60m⇒3, 80m⇒112, 160m⇒22
```

Data source: https://pskreporter.info/

### `!dxcc` -- display information on a dxcc entity

Usage:

```
    !dxcc <callsign>|<prefix>|<name> [de <grid>|<lat>,<lon>|<qth>]
```

Examples:

```
    <molo1134> !dxcc W1AW
    <qrm> W1AW: United States (K): NA CQ:5 ITU:8 MW:340

    <molo1134> !dxcc kiribati
    <qrm> T30: Western Kiribati: OC CQ:31 ITU:65 MW:86

    <molo1134> !dxcc kiribati de hawaii
    <qrm> T30: Western Kiribati: OC CQ:31 ITU:65 MW:86 -- 3982.2 km, 243°
             from BK29ev
```

Data sources:

* DXCC Country File "Big-CTY": http://www.country-files.com/big-cty/
* Clublog most-wanted entities: https://clublog.org/mostwanted.php

### `!spots` -- display spots for a callsign

Usage:

```
    !spots [--qrm] [--dxw] [--rbn] [--psk] [--ham] [--pota] <callsign> [limit]
    !spots <freq_khz>
```

Examples:

```
    <molo1134> !spots W1AW
    <qrm> G4UFK   W1AW     1802 579 with qsb                 0333z 08 Oct d
    <qrm> N8MSA   W1AW     7047 cw 21 dB, 18 wpm             0301z 08 Oct r
    <qrm> KP3Z    W1AW     7047 cw 18 dB, 15 wpm             0155z 08 Oct r

    <molo1134> !spots --dxw W1AW
    <qrm> KO6BQV  W1AW    28467                              1805z 16 Feb d
    <qrm> PD7V    W1AW    28476 Thnx visit my qrz page pleas 1626z 16 Feb d
    <qrm> M7GTP   W1AW    28476 CQ                           1618z 16 Feb d

    <molo1134> !spots 7005
    <qrm> WF5K    OX7AM    7003                              0159z 20 Feb d
    <qrm> WP4O    VU2GSM   7004                              0135z 20 Feb d
```

Last column indicates the source of the spot as follows:

* `d` -- DX cluster
* `h` -- HamSpots.net
* `p` -- PSK Reporter
* `P` -- POTA
* `q` -- qrmbot spot added with !spot
* `r` -- Reverse beacon network

Data sources: dxwatch.com (DX Cluster), ReverseBeacon.net, pskreporter.info, hamspots.net, pota.app

### `!potaspots` -- find POTA activity

Usage:

```
    !potaspots [--phone|--cw|--digi] [--<band>] [number]
```

Examples:

```
    <molo1134> !potaspots
    <qrm> W2NNN   WK4DS   14043 US-5524 US-FL CW 9 dB 21 WPM 1530z 30 Jan P
    <qrm> NF5R    K4NYM   24897 US-3627 US-FL CW 5NN TX TU   1530z 30 Jan P
    <qrm> KM3T-3  NO4D    14074 US-9203 US-SC FT8 -12 dB via 1529z 30 Jan P

    <molo1134> !potaspots 8
    <qrm> W6YX    WK4DS   14043 US-5524 US-FL CW 8 dB 21 WPM 1530z 30 Jan P
    <qrm> N4IN    N4IN    14064 US-1267 US-KY CW QRV         1530z 30 Jan P
    <qrm> NF5R    K4NYM   24897 US-3627 US-FL CW 5NN TX TU   1530z 30 Jan P
    <qrm> KM3T-3  NO4D    14074 US-9203 US-SC FT8 -12 dB via 1529z 30 Jan P
    <qrm> K1RA    N8BB     7074 US-4239 US-MI,US-MN,US-ND,US 1529z 30 Jan P
    <qrm> K3AV    KG1A    14044 US-6305 US-FL CW 559 MD      1529z 30 Jan P
    <qrm> W8ATE   W9DXP   14080 US-3805 US-KY FT4            1529z 30 Jan P
    <qrm> N1ECT   KF8FGA  14292 US-1946 US-OH SSB 6/9+ in RI 1529z 30 Jan P

    <molo1134> !potaspots --phone --20m 5
    <qrm> KC5LL   K4ACJ   14304 US-12107 US-SC SSB 59 Texas  1530z 30 Jan P
    <qrm> N1ECT   KF8DYB  14292 US-1946 US-OH SSB 5/9+ in RI 1530z 30 Jan P
    <qrm> N1ECT   KF8FGA  14292 US-1946 US-OH SSB 6/9+ in RI 1529z 30 Jan P
    <qrm> F4JXY/P F4JXY/P 14330 FR-11340 FR-OCC SSB 5 ref po 1529z 30 Jan P
    <qrm> K8WAG   K1DLA   14254 US-3014 US-TX SSB [55 OH]    1528z 30 Jan P
```

Data source: pota.app

### `!morse` `!cw` -- convert to morse code

Usage:

```
   !morse [--weight] <text>
```

Examples:

```
    <molo1134> !morse CQ CQ DE W1AW
    <qrm> -.-. --.-   -.-. --.-   -.. .   .-- .---- .- .--   

    <molo1134> !morse --weight W1AA K1AA N1AA
    <qrm> W1AA: 48; K1AA: 48; N1AA: 44
```

### `!unmorse` `!demorse` -- decode from morse

Usage:
```
    !unmorse [--cyrillic] [--greek] [--hebrew] [--arabic] [--japanese] <morse code text>
```

Examples:

```
    <molo1134> !unmorse -.-. --.-   -.-. --.-   -.. .   .-- .---- .- .--
    <qrm> CQ CQ DE W1AW

    <molo1134> !unmorse --greek -.-. --.-   -.-. --.-   -.. .   .-- .---- .- .--
    <qrm> ΘΨ ΘΨ ΔΕ Ω1ΑΩ
```

### `!repeater` -- search for repeater

Usage:

```
    !repeater [--world] <search terms> [band]
```

Examples:

```
    <molo1134> !repeater KQ2H
    <qrm> KQ2H: 29.6200 (-) 146.2 / CSQ PL @ Wurtsburo, Catskill Mountains,
          Sullivan County, NY -- truncated, see: https://repeaterbook.com/repeaters/keyword.php?func=result&keyword=kq2h&state_id=0

    <molo1134> !repeater KQ2H 2m
    <qrm> N2ACF: 146.4600 (s) 77.0  PL @ Pomona, Rockland County, NY --
          truncated, see: https://repeaterbook.com/repeaters/keyword.php?func=result&keyword=kq2h&state_id=0

    <molo1134> !repeater fort lee
    <qrm> KB2RQE: 145.3100 (-) 100.0  PL @ Fort Lee, Bergen County, NJ --
             truncated, see: https://repeaterbook.com/repeaters/keyword.php?func=result&keyword=fort%20lee&state_id=0
```

Data source: repeaterbook.com

### `!iono` -- report from nearest ionosonde

Usage:

```
    !iono <grid>|<lat>,<lon>|<qth>
```

Examples:

```
    <molo1134> !iono tokyo
    <qrm> I-Cheon, South Korea (PM37 1096 km WNW) @ 2026-01-18 0307z
          [confidence: 75]: MUF 37.759 MHz, FoF2 11.1 MHz with M(D) 3.402x
    <qrm>  prop.kc2g.com model prediction for PM95tq: MUF 35.025 MHz; FoF2
          10.624 MHz

    <molo1134> !iono FN21
    <qrm> Millstone Hill, MA, USA (FN42 314 km ENE) @ 2026-01-18 0315z
          [confidence: 60]: MUF 7.634 MHz, FoF2 2.875 MHz with M(D) 2.655x
    <qrm>  prop.kc2g.com model prediction for FN21mm: MUF 8.973 MHz; FoF2
          2.965 MHz
```

Data source: https://prop.kc2g.com/

### `!muf` -- GIRO MUF reports from ionosondes

Usage:

```
    !muf <station>
    !muf list
```

List of stations is sent via private message.

Examples:

```
    <molo1134> !muf millstone
    <qrm> MILLSTONE HILL (FN42): MUF @ 2024-02-20 0237z: 13.291 MHz; recent
          high: 36.006 at 2107z; low 10.141 at 1015z

    <molo1134> !muf icheon
    <qrm> I-CHEON (PM37): MUF @ 2024-02-20 0230z: 38.497 MHz; recent high:
          38.853 at 0215z; low 11.958 at 1852z
```

Data source: GIRO DIDBase https://lgdc.uml.edu/common/DIDBFastStationList

### `!blitz` `!zap` -- lightning report

Usage:

```
    !blitz <grid>|<lat>,<lon>|<qth>
```

Examples:

```
    <molo1134> !blitz bundeena
    <qrm> Nearest lightning strike to Bundeena NSW 2230, Australia (QF55nv)
          in last 15 minutes: ⚡48.5 km (30.2 mi) S at 02:47z

    <molo1134> !blitz colfax, california
    <qrm> Nearest lightning strike to Colfax, CA 95713, USA (CM99mc) in last
          15 minutes: ⚡⚡16.6 km (10.3 mi) SSE at 02:51z
```

Data source: blitzortung.org

### `!aprs` -- APRS station information

Usage:

```
    !aprs <callsign or object>
```

Examples:

```
    <molo1134> !aprs W1AW
    <qrm> W1AW: Newington, CT, USA at 2026-01-18 03:25z (W1AW in Newin) via
          (KB1AEV-15,W1QI-4,WIDE2*,qAR,KB1FYZ-3)

    <molo1134> !aprs K4DXB
    <qrm> K4DXB (WX): Old Bridge, NJ 08857, USA  Temp: -2°C/29°F  Humidity:
          99%  Wind: N calm  Pressure: 1020.6mb/30.14inHg  Precipitation:
          last 24h: 0.5mm/0.02in today: 0.5mm/0.02in  at 2026-01-18 03:30z
          (Old Bridge NJ iGate-Digi-Wx) via (WIDE1-1,qAO,K2GE-14)

    <molo1134> !aprs BI4UMB-5G
    <qrm> BI4UMB-5G: Yangzhou, Jiangsu, China @ 0kph/0mph alt 22m/72ft at
          2026-01-18 03:48z (E1[★中国业余无线电爱好者★
          芯片识别码Imei:〔*570〕 信号强度Rssi:〔-52〕 卫星数量Sat:〔19/29
          〕设备温度Temp:〔35°C〕 设备电压Vol:〔3.8V
          〕行驶总里程mileage:〔1475.4km〕]) via (TCPIP*,qAC,T2HAKATA)

```

Data source: https://aprs.fi/

### `!eme` -- EME prediction

Usage:

```
    !eme <grid>|<lat>,<lon>|<qth>
```

Examples:

```
    <molo1134> !eme
    <qrm> Moon is set; phase: new moon 🌑, 0% illum.; Moon will rise at
          2026-01-18 12:33z (in 8h41m); EME degrd(2m): 3.2 dB (Fair);

    <molo1134> !eme tokyo
    <qrm> Moon az/el 202.5°/24.1°; dist 394853 km; phase: new moon 🌑, 0%
          illum.; Moon will set at 2026-01-18 07:05z (in 3h12m); EME
          degrd(2m): 3.6 dB (Fair); EME path loss(2m): 252.5 dB (+2.1 dB,
          89%);
```

### `!graves` -- French 143 MHz radar as EME beacon

Usage:

```
    !graves
```

Examples:

```
    <molo1134> !graves
    <qrm> GRAVES Radar: Moon Illuminated, 143.050 MHz: az/el 223.5°/22.2°;
           path loss 252.7 dB

    <molo1134> !graves
    <qrm> GRAVES Radar: Moon outside of beam; az/el 117°/12.5°

	<molo1134> !graves
	<qrm> GRAVES Radar: Moon is set
```

### `!sat` -- satellite info and pass predictor

Usage:

```
    !sat <sat>[,sat2,..,satN] [--pass|--info] <qth>|<grid> [--commonpass <qth2>|<grid2>]
```

Examples:

```
    <molo1134> !sat AO-73
    <qrm> AO-73 (#39444) @FN21wb: AO-73: AOS 2026-01-18 08:16z az  17°; max
          el 52° az  99°; LOS 08:28z az 182° ‖ AO-73: AOS 2026-01-18 09:51z
          az 350°; max el 12° az 295°; LOS 10:01z az 240° ‖ AO-73: AOS
          2026-01-18 19:00z az 141°; max el 28° az  69°; LOS 19:12z az 359°
    <qrm> AO-73 (#39444): linear: "Mode U/V Linear"
          435.13-435.15/145.95-145.97 [inverting] mode USB ‖ transmitting:
          "CW Beacon" 145.815 mode CW ‖ transmitting: "BPSK Telemetry"
          145.935 mode BPSK 1200 baud

	<molo1134> !sat AO-73 chicago --commonpass denver
	<qrm> EN61ev 2026-01-18 09:52z:   N ▁▂▂▄▅▅▄▃▂▁▁ SSW :10:03z; max el ~47°
	<qrm> DM79mr 2026-01-18 09:52z: NNE ▁▁▁▂▂▃▃▃▂▂▁ SSE :10:03z; max el ~26°
	<qrm> EN61ev 2026-01-18 20:37z: SSE ▁▂▃▅█▆▄▂▂▁ NNW :20:47z; max el ~76°
	<qrm> DM79mr 2026-01-18 20:37z: ESE ▁▁▁▂▂▂▂▁▁▁ NNE :20:47z; max el ~13°
```

Sources: amsat.org, satnogs.org


### `!satpass` -- satellite pass predictor

See `!sat` above.

### `!satinfo` -- satellite info

See `!sat` above.

### `!qcode` `!q` -- qcode lookup

Usage:

```
    !qcode <code>
```

Examples:

```
	<molo1134> !q QLF
	<qrm> QLF: Are you sending with your left foot? Try sending with your
		  left foot!
```

### `!rig` -- describe a radio or other gear

Usage:

```
    !rig <model>
```

Examples:

```
    <molo1134> !rig ic-9700
    <qrm> Icom IC-9700: 2m/70cm/1.2 GHz; SSB/CW/FM/Dstar; dual RX; SDR;
          100W/75W/10W; direct sampling for 2 bands, IF sampling for 1.2 GHz;
          digital modulation; Dstar DD on 1.2 GHz; 2019

    <molo1134> !rig ts-430
    <qrm> Kenwood TS-430S: 160-10m w/ WARC, gen. coverage RX; CW/SSB/AM, FM
          (option); no CAT; 1984
```

### `!lotw` -- last upload date to LoTW for a callsign

Usage:

```
    !lotw [--loose] <callsign>
```

Examples:

```
	<molo1134> !lotw 4U1UN
	<qrm> 4U1UN: LoTW 2025-12-31 16:45:58

	<molo1134> !lotw 4U1
	<qrm> ^4U1$: LoTW not found

	<molo1134> !lotw --loose 4U1
	<qrm> 4U100QO: LoTW 2023-08-05 15:24:13
	<qrm> 4U13FEB: LoTW 2024-11-27 22:25:38
	<qrm> 4U150ITU: LoTW 2015-05-19 21:22:25
	<qrm> 4U1A: LoTW 2025-12-21 09:00:45
	<qrm> (truncated. see https://lotw.arrl.org/lotw-user-activity.csv )
```

### `!eqsl` -- last login to eqsl.cc for a callsign

Usage:

```
    !eqsl <callsign>
```

Example:

```
    <molo1134> !eqsl kj3n
    <qrm> KJ3N: eQSL (AG) ✪ FM29ft; last login: 08-Nov-2025; last activity:
          30 Nov 2025 00:07Z
```

### `!clublog` `!oqrs` -- log and OQRS info on clublog.org

Usage:

```
    !clublog <callsign> [logged call]
```

Examples:

```
    <molo1134> !oqrs K1NZ
    <qrm> K1NZ: clublog from 2011-11-19 to 2026-01-16; last upload
          2026-01-16?; OQRS; grid FN32UC

    <molo1134> !clublog K1NZ K2CR
    <qrm> K2CR in K1NZ clublog:  Phone: 80; Digital: 80,20
```

### `!qsl` -- check all of the above qsl methods

TODO FIXME

### `!league` -- report clublog league standings

Usage:

```
    !league [club#] [--cw|--ssb|--data] [--slots] [--lastyear|--12mo|--alltime] [--qsl]
```

Examples:

```
    <molo1134> !league
    <qrm> Clublog standings for 2026 1: K4JKB 126/217; 2: KM8V 112/120; 3:
          KC3ZYT 106/350; 4: K8ROX 95/172; 5: W9MR 92/189; 6: N8GMZ 64/89; 7:
          PD3AN 61/83; 8: K2CAT 56/128; 9: WM3O 53/90; 10: TA7OYG 49/130 --
          https://clublog.org/league.php?club=187

    <molo1134> !league --ssb
    <qrm> Clublog standings for 2026 1: K8ROX 30/47; 2: TA7OYG 27/49; 3:
          K4JKB 11/16; 4: VK3KTT 10/13; 5: KC3ZYT 8/10; 6: WM3O 7/7; 7:
          IU5CIJ 5/5; 8: K4PZZ 3/3; 9: N5YHF 2/5; 10: K1TPK 2/5 --
          https://clublog.org/league.php?club=187

    <molo1134> !league --cw --lastyear --qsl
    <qrm> Clublog standings for 2025 1: NN3W 118/365; 2: WM3O 93/264; 3:
          PE4KH 90/194; 4: W9MR 88/164; 5: N8RGA 84/121; 6: IU5HES 69/141; 7:
          LB1TI 65/115; 8: KU5B 62/112; 9: K4JKB 57/120; 10: VE2HEW 50/93 --
          https://clublog.org/league.php?club=187

```

### `!pota` -- search POTA parks and users

Usage:

```
    !pota <search term>
```

Examples:

```
<molo1134> !pota adirondack
<qrm> US-2001 - Adirondack (FN23sx): State Park; New York, United States
      of America -- 1199 activations (44,532 QSOs) -- last activation:
      2026-01-17 by KD2YLZ (39 QSOs) -- top activators: #1 🥇: KD2YLZ:
      14,645 QSOs; #2 🥈: WV1W: 2,563 QSOs; #3 🥉: AK2G: 2,551 QSOs --
      324.4 km, 356° from FN21wb

<molo1134> !pota US-8319
<qrm> US-8319 - Palisades Interstate (FN30aw): State Park; New Jersey,New
      York, United States of America -- 645 activations (25,286 QSOs) --
      last activation: 2026-01-14 by KM3STU (12 QSOs) -- top activators:
      #1 🥇: KE2NJ: 4,155 QSOs; #2 🥈: KM3STU: 3,842 QSOs; #3 🥉: K2MFR:
      3,546 QSOs -- 21.1 km, 125° from FN21wb
```

### `!potapark` -- find POTA parks near a given location

Usage:

```
    !potapark <grid>|<lat>,<lon>|<qth> [count]
```

Examples:

```
    <molo1134> !potapark
    <qrm> US-4998: Ramapo Mountain State Forest -- Wanaque, NJ, USA -- 11.5 km W
    <qrm> US-1630: Ringwood State Park -- Ringwood, NJ, USA -- 12.2 km NW
    <qrm> US-2069: Harriman State Park -- Ramapo, NY, USA -- 13.3 km NNW

    <molo1134> !potapark san francisco
    <qrm> US-0757: San Francisco Maritime National Historical Park -- Fort
        Mason, San Francisco, CA 94109, USA -- 3.6 km N
    <qrm> US-7889: Presidio of SF National Historic Site -- Presidio of San
        Francisco, San Francisco, CA, USA -- 4.5 km NW
    <qrm> US-7888: Alcatraz Island National Historic Site -- San Francisco,
        CA, USA -- 5.8 km N
```

### `!sota` -- search SOTA summits

Usage:

```
    !sota <search term>
```

Examples:

```
	<molo1134> !sota marcy
	<qrm> found: W2/GA-001: Marcy; Mount; W5O/WI-005: Mount Marcy;

	<molo1134> !sota W2/GA-001
	<qrm> W2/GA-001 - Marcy; Mount (1629 m / 5344 ft; FN34ac): Greater
		  Adirondacks region, 10 pts.; last activation: 2025-09-13 AC1NM (6
		  QSOs)
```

### `!iota` -- search IOTA islands

TODO FIXME -- broken

### `!1x1` -- search 1x1 special event stations

Usage:

```
    !1x1 <callsign>|<search term>
```

Examples:

```
    <molo1134> !1x1 new jersey
    <qrm> N2J: past: Commission of USS NEW JERSEY from 2024-09-12 to
          2024-09-19 by WA2VUY (ANGEL M GARCIA)

    <molo1134> !1x1 W2J
    <qrm> W2J: past: NJ QSO Party from 2025-09-19 to 2025-09-22 by NV2D (West
          Bergen WPX Contest Club Trustee:K2CR)
```

### `!contests` -- list current and upcoming contests

Example:

```
    <molo1134> !contests
    <qrm> now: AWA Linc Cundall Memorial CW Contest; Hungarian DX Contest;
          PRO Digi Contest; North American QSO Party, SSB; NA Collegiate
          Championship, SSB; ARRL January VHF Contest; Feld Hell Sprint
    <qrm> this weekend: CQ 160-Meter Contest, CW
    <qrm> next weekend: Kawanua DX Contest; REF Contest, CW; BARTG RTTY
          Sprint; Winter Field Day
```

### `!wrtc` -- show WRTC standings for a callsign

Usage:

```
    !wrtc [--2022] [--2026] <callsign> [callsign 2] ... [callsign N]
```

Example:

```
    <molo1134> !wrtc NN3W
    <qrm> 2026: NN3W: United States #6; NA-2 #1; Points: 7453
```

### `!fspl` -- free space path loss calculator


Usage:

```
    !fspl <dist> <dist units> <freq> <freq units>
```

Example:

```
    <molo1134> !fspl 25 km 146 MHz
    <qrm> (4 * pi * 25 km * 146 MHz / c)^2 = 103.69364 dB
```

### `!coax` `!atten` -- coax attenuation calculator

Usage:

```
    !atten <coax type> [<freq> <freq units> [<length> <length units>]]
```

Examples:

```
    <molo1134> !atten 9913 446.0 MHz
    <qrm> 9913 (50Ω O.D. 0.405"/10.3mm https://bit.ly/3ZA8am7 ) attenuation
          estimated at 446.0 MHz: 2.98 dB/100 ft (9.78 dB/100 m); loss
          @length 100 ft: 2.98 dB

    <molo1134> !atten LMR-400 446.0 MHz 12.5 m
    <qrm> LMR-400 (50Ω O.D. 0.405"/10.3mm https://bit.ly/3xHdPtX )
          attenuation estimated at 446.0 MHz: 2.7 dB/100 ft (8.86 dB/100 m);
          loss @length 12.5 m: 1.11 dB
```


### `!ae7q` -- get US callsign availability info

Usage:

```
    !ae7q <call>|<region>
```

Examples:

```
TODO FIXME
```

### `!vanity` -- get US vanity callsign application info

Usage:

```
    !vanity <call>|<region/AK/HI/territory>
```

Examples:

```
TODO FIXME
```

### `!dxped` -- get current dxpedition info

Example:

```
    <molo1134> !dxped
    <qrm> Cambodia: XU7O to Jan 18; Curacao: PJ2ND to Jan 30; Grenada: J38WG
          to Feb 16; British Virgin: VP2V/W5GI to Jan 20; Honduras:
          VE3VSM/HR9 to Jan 31; Benin: TY5GG to Feb 06; Senegal: 6W/DB1RUL to
          Jan 20; Lakshadweep: VU7RS to Jan 22; Aruba: P40AA to Jan 29;
          Desecheo: KP5/NP3VI to Feb 10; Sint Maarten: PJ7/IZ2DPX to Jan 21;
          French Polynesia: FO/F6HCM to Jan 20; Indonesia: YB5 to Feb 01;
```

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
### `!cpi` -- US dollar inflation calculator

## Metadata and bot control

### `!setgeo` `!getgeo` -- set your qth for results in some commands †
### `!github` -- display bot github URL

## Fun stuff / web scraping

### `!quote` `!quotesearch` -- get a quote
### `!addquote` -- add a quote
### `!define` -- glossary lookup
### `!phoneticise` -- random phonetics
### `!imdb` -- movie info
### `!steam` -- Steam game info
### `!adsb` -- get plane information
### `!hofh` -- why your radio is broke
### `!ammo` -- find a price for ammo
### `!launch` -- search for upcoming rocket launch
### `!spacex` -- next spacex launch
### `!translate` -- translate text
### `!rand` `!dice` `!flip` `!8ball` `!orb` -- random

`!orb` is a yes/no oracle like `!8ball`, with a 2% chance of a multi-line legendary response (across blue/cosmic, red/cursed, electric/chaotic, and fire tiers).

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


    < molo1134> !lotw W1AW
    < qrm> W1AW: 2015-09-28

    < molo1134> !eqsl W1AW
    < qrm> W1AW: (AG) FN31pr; last login: 07-Feb-2014

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

    < VA7EEX_> !phonetics w8tam
    < qrm> welcomed 8 tabulate aural matchmakers

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

* contest calendar: http://www.hornucopia.com/contestcal/weeklycont.php
* eqsl status: http://www.eqsl.cc/Member.cfm?CALLSIGN
* lotw status: https://lotw.arrl.org/lotw-user-activity.csv
* units: [GNU Units](https://www.gnu.org/software/units/)
* aprs: http://aprs.fi/
* Sats: http://www.amsat.org/amsat/ftp/keps/current/nasabare.txt
* Cryptocurrency prices: https://coinmarketcap.com/api/

