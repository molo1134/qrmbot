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

