#!/bin/sh

SPOTFILE="$HOME/.qrmbot/db/spots.sqlite"
QUERY="
    ATTACH DATABASE '$SPOTFILE' AS spots;
    SELECT DATETIME(timestamp, 'unixepoch') AS time, de, channel, callsign, freq_hz, notes
    FROM spots.t_spots
    ORDER BY timestamp DESC
    LIMIT 30;
"

if [ ! -e "$SPOTFILE" ]; then
  echo "missing $SPOTFILE"
  exit 1
fi

#sqlite3 -readonly -header -column "$SPOTFILE" "$QUERY";
sqlite3 -header -column "$SPOTFILE" "$QUERY";


# most spots reported by user:
# select de, count(*) from spots.t_spots group by de order by 2 desc;

# most commonly spotted callsign
# select callsign, count(*) from spots.t_spots group by callsign order by 2 desc limit 10;

# number of spots by origin channel
# select channel, count(*) from spots.t_spots group by channel order by 2 desc;

# spots by band
# select freq_hz / 1000000 as MHz, count(*) from spots.t_spots group by freq_hz / 1000000;

