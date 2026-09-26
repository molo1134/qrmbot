# Blitzortung Lightning Monitor — JSON-RPC HTTP API

Documentation of the HTTP requests the **Blitzortung Lightning Monitor** Android app
makes to the blitzortung.org JSON-RPC data service, derived from the Kotlin source
(`app/src/main/java/org/blitzortung/android/jsonrpc/` and
`app/src/main/java/org/blitzortung/android/data/provider/standard/`).

The app uses two interchangeable data providers (see `data/provider/DataProviderFactory.kt`):

* **RPC** (default) — the JSON-RPC service documented here.
* **HTTP** — the legacy blitzortung.org file-based service (`data.blitzortung.org`), out of scope for this document.

---

## 1. Transport layer

| Property | Value |
|---|---|
| HTTP method | `POST` |
| Endpoint | `http://bo-service.tryb.de/` (configurable via the `service_url` setting; default in `JsonRpcDataProvider`) |
| Request `Content-Type` | `text/json` |
| Request `Content-Length` | byte length of the UTF-8 request body |
| `User-Agent` | `bo-android-<versionCode>` (e.g. `bo-android-337`) |
| `Accept-Encoding` | `gzip` (response is transparently gunzipped when `Content-Encoding: gzip`) |
| Connection timeout | 40 000 ms |
| Socket/read timeout | 40 000 ms |
| Authentication | none for the JSON-RPC endpoint (the `username`/`password` settings belong to the legacy HTTP provider) |

The request body is the raw JSON-RPC text (no URL encoding, no query parameters).
Connections are kept open across calls by the client (`HttpURLConnection`).

---

## 2. JSON-RPC 2.0 envelope

All requests are JSON-RPC 2.0 objects with **positional parameters** (always a JSON array):

```json
{
  "jsonrpc": "2.0",
  "id": 7,
  "method": "get_strikes",
  "params": [60, 0]
}
```

* `id` — an integer, starting at `1` and **incremented per call** (`AtomicInteger` in `JsonRpcClient`).
  It is a client-side counter, not a per-method token.
* `params` — a flat array of numbers, order matters. See §5 per method.
* There are no named parameters, no notifications, no batching in requests.

### Response

```json
{
  "jsonrpc": "2.0",
  "id": 7,
  "result": { "t": "20260325T12:00:00", "s": [ ... ] }
}
```

Client-side parsing rules (`JsonRpcClient.parseResponse`):

* The body must be a JSON-RPC 2.0 object (`"jsonrpc": "2.0"` is enforced).
* The `result` member **must be a JSON object**. The app throws
  `invalid JSON-RPC response result` if it is missing or is any other type
  (e.g. a raw array or scalar).
* A **batch response** (top-level JSON array) is tolerated: the client picks the
  element whose `id` matches the request's `id`, falling back to element 0.
* If `error` is present it is non-null, the client throws a `JsonRpcException`
  with the message `remote Exception '<message>' #<code>` (standard JSON-RPC error fields).

### Error format (as produced by the server)

```json
{ "jsonrpc": "2.0", "id": 7, "error": { "code": -32601, "message": "method not found", "data": "" } }
```

---

## 3. Core concepts

### 3.1 Time

* **Reference timestamp `t`** — a string in `yyyyMMdd'T'HH:mm:ss`, **UTC**,
  parsed with `TimeFormat.parseTime` (e.g. `"20260325T12:00:00"`).
* **Interval duration** — the data window length in **seconds**. Default is `60`
  (latest minute). The app's `interval_duration` setting is an integer **in seconds**.
  Example values: 60, 300, 600, 900.
* **Interval offset** — signed offset **in seconds** from "now":
  * `0` = realtime (the current window, ending now);
  * negative = a window that far in the past (history playback / animation),
    e.g. `-900` = the window ending 15 minutes ago.
  Offsets are aligned to the history time increment (30 s by default) and limited
  to the configured history range (24 h by default).
* **Strike timestamps** are computed from `t` plus signed per-strike offsets — see §6.
  The app stores everything as Unix epoch milliseconds (`System.currentTimeMillis()` style).

### 3.2 Coordinates and the grid

* Positions are WGS84 decimal degrees: **latitude** in `[-90, 90]`, **longitude** in `[-180, 180]`.
* **Regions** (integer `region` parameter):
  * `0` = **global** (`GLOBAL_REGION`),
  * `-1` = **local** — a rectangular tile computed from a geographic position (`LOCAL_REGION`),
  * any positive integer = a **predefined named region** the server understands
    (passed through unchanged; used by the legacy HTTP provider's region files).

  **Named regions** (the positive integer codes, defined in the app's `strings.xml` paired arrays):

  | Code | Name |
  |------|------|
  | 1 | Europe |
  | 2 | Oceania |
  | 3 | N. America |
  | 4 | Asia |
  | 5 | S. America |
  | 6 | Africa |
  | 7 | C. America |

  The codes were added incrementally: originally 1 (Europe) and 3 (N. America),
  then 2 (Oceania), then 4 (Asia) / 5 (S. America) / 6 (Africa),
  then 7 (C. America). The display ordering in the app does not follow the
  numeric sequence.
* **`gridSize`** — the requested cell size **in meters** (e.g. `5000` = 5 km, `10000` = 10 km).
  The server is free to honor it approximately; the response carries the *actual* grid
  geometry (see `xd`/`yd`, §6.2). The client never converts gridSize to degrees itself.
  Auto-scaling by zoom level: `5000` (zoom ≥ 7.5), `10000` (5–7.5), `25000` (3.5–5),
  `50000` (2.5–3.5), `100000` (below).
* **`countThreshold`** — minimum strike count per grid cell for the cell to be
  included in the result (a density filter). Default `0` (all cells).
* **Local tiles (`DataArea`)** — a local region is identified by tile coordinates
  `(x, y, scale)`:
  * `scale` — tile side length **in degrees**; a whole number that is a multiple of 5, in `[5, 20]` (`LocalData`).
  * tile `x` covers longitude `[x·scale, (x+1)·scale)`;
  * tile `y` covers latitude `[y·scale, (y+1)·scale)`.
  * For the **device-location path** the scale is always **5** (`LOCAL_DATA_SCALE`).

---

## 4. Flow overview (how a request comes about)

```
Timer / location change / map pan-zoom
        │  (MainDataHandler.updateData → FetchDataTask, coroutine on Dispatchers.IO)
        ▼
Parameters (region, gridSize, interval duration+offset, countThreshold, dataArea?)
        │  activeParameters: localData.updateParameters(parameters, location)
        ▼
JsonRpcData.requestData(parameters)        ← picks method by region
        │  JsonRpcClient.call(url, method, ...params)
        ▼
POST http://bo-service.tryb.de/  (JSON-RPC 2.0)
        ▼
JsonRpcResponse → DataBuilder parses strikes/grid → DataReceived
        ▼
DataCache (5 min TTL) / event bus to map overlay, overlay, alerts
```

The RPC provider always works in **grid mode** (`DataMode(grid = true, region = false)`),
so the interactive app uses `get_*_strikes_grid`; the plain `get_strikes` method is a
secondary data channel the provider also implements and uses when grid mode is off.

---

## 5. API methods

All parameters are positional integers unless noted. Parameter order is exactly as listed.

### 5.1 `get_strikes(intervalDuration, idOrOffset)`

Fetch **individual strikes** (not grid cells). Two modes, selected by the second parameter:

| Condition | Second param | Server behavior the client expects |
|---|---|---|
| Realtime/historical with offset `< 0` | the **offset** itself (negative seconds) | full fetch of the window |
| Realtime (**offset = 0**, after the first call) | the **cursor id** from the response's `next` field | **incremental** — only strikes newer than the cursor |

* On the very first realtime call the cursor is `0`.
* When the client resets (offset < 0 or provider reset), the internal cursor returns to `0`.

**Response result fields**

| Field | Type | Meaning |
|---|---|---|
| `t` | string | reference timestamp `yyyyMMdd'T'HH:mm:ss` UTC |
| `s` | array of arrays | strikes, each a 5-tuple — see §6.1 |
| `next` | int, optional | cursor to pass back as the second parameter of the next call |
| `h` | array of ints, optional | histogram of strikes per time bucket — see §6.4 |

### 5.2 `get_strikes_grid(intervalDuration, gridSize, intervalOffset, region, countThreshold)`

Returns a strike-count **grid for a predefined named region** (positive `region` code).
Note the parameter order: duration comes first, `gridSize` second, then offset,
then region, then threshold.

### 5.3 `get_global_strikes_grid(intervalDuration, gridSize, intervalOffset, countThreshold)`

Whole-world grid. The client
**clamps `gridSize` to a minimum of 25000 m** (`coerceAtLeast`),
and **overwrites the response's `x0` and `y1` with `0.0`** — i.e. the global grid is
always interpreted as anchored at latitude 0°N, longitude 0°E. All other grid fields
(`xd`, `yd`, `xc`, `yc`, `r`, `t`, `h`) come from the server.

### 5.4 `get_local_strikes_grid(x, y, gridSize, intervalDuration, intervalOffset, countThreshold, scale)`

Grid for a single local tile. `x`, `y` are the tile indices (may be negative west/south
of the prime meridian/equator), `scale` the tile side in degrees. This is the method
used for **device-location-based** queries (§7).

---

## 6. Output formats and their meaning

### 6.1 Strikes (`s` entries in `get_strikes`)

Each element is a **JSON array of 5 numbers**:

```
[timeOffset, longitude, latitude, lateralError, amplitude]
```

| Index | Field | Type | Meaning |
|---|---|---|---|
| 0 | `timeOffset` | int | **seconds before** `t`. Strike time = `parse(t) − 1000·timeOffset` (ms). `0` ≈ now |
| 1 | `longitude` | double | WGS84 longitude, decimal degrees |
| 2 | `latitude` | double | WGS84 latitude, decimal degrees |
| 3 | `lateralError` | double | estimated horizontal location error (km; supplied by the server, stored unmodified) |
| 4 | `amplitude` | double | signal amplitude, stored by the app as a float (kA per blitzortung conventions) |

A strike is mapped to the app's `DefaultStrike` bean:

```kotlin
DefaultStrike(
    timestamp   = referenceTimestamp - 1000 * timeOffset,
    longitude   = longitude,
    latitude    = latitude,
    lateralError= lateralError,
    amplitude   = amplitude,
    altitude = 0, stationCount = 0, multiplicity = 1   // not carried by this API
)
```

### 6.2 Grids (`r` entries in `get_*_strikes_grid`)

The **result object** carries the grid geometry:

| Field | Type | Meaning |
|---|---|---|
| `t` | string | reference timestamp (UTC) |
| `x0` | double | longitude of the grid's **western** border (degrees) |
| `y1` | double | latitude of the grid's **northern** border (degrees) — note this is the **top** edge |
| `xd` | double | cell width in longitude degrees (eastward step) |
| `yd` | double | cell height in latitude degrees (southward step) |
| `xc` | int | number of columns (cells along the longitude axis) |
| `yc` | int | number of rows (cells along the latitude axis) |
| `r` | array of arrays | non-empty cells, each a 4-tuple (§6.3) |
| `h` | array of ints, optional | histogram (§6.4) |

The grid spans:
```
longitude from x0            to x0 + xd·xc   (east)
latitude  from y1 - yd·yc    to y1           (south…north)
```

> Grids use a **north-west anchor**: `(x0, y1)` is the top-left corner; rows are
> counted **southward**. This is reflected in the cell math below. For the global
> request the client forces `x0 = 0`, `y1 = 0`.

### 6.3 Grid cells (`r` entries)

Each element is a **JSON array of 4 numbers**:

```
[lonOffset, latOffset, multiplicity, timeOffset]
```

| Index | Field | Type | Meaning |
|---|---|---|---|
| 0 | `lonOffset` | int | 0-based column index |
| 1 | `latOffset` | int | 0-based row index (from the north edge, southward) |
| 2 | `multiplicity` | int | number of individual strikes aggregated into this cell |
| 3 | `timeOffset` | int | **seconds after** `t`. Cell time = `parse(t) + 1000·timeOffset` (ms) |

Cell **center** coordinates (how the app places the marker on the map):

```kotlin
centerLongitude = x0 + xd · (lonOffset + 0.5)
centerLatitude  = y1 − yd · (latOffset + 0.5)
```

> Sign note: strike offsets (§6.1) are **subtracted** from `t`; grid-cell offsets are
> **added** to `t`. This asymmetry is exactly what `DataBuilder` implements — a `[2,0,5,10]`
> cell at `t = 20230326T18:49:34` yields `timestamp = 1679856584000` ms (reference + 10 s).

### 6.4 Histogram (`h`)

An array of integers, one count per equal time bucket covering the requested interval.
The client provisions buckets at **5 minutes each** when it builds the histogram itself
(`binCount = intervalDuration / 5`), with **index 0 = oldest bucket, last index = newest**.
When the server supplies `h`, the client trusts the array as-is (same orientation assumed).
Histogram data drives the small strip chart at the bottom of the app's map.

### 6.5 Incremental updates (`next` cursor)

The `next` field returned in a `get_strikes` response is an **opaque numeric cursor**
that the client stores in `nextId` and hands back in the following call:

```
call 1: get_strikes(60, 0)        → { ..., "next": 4711, "s": [ ... ] }   // full minute
call 2: get_strikes(60, 4711)     → { ..., "next": 5312, "s": [ ... ] }   // only new strikes
```

The client treats the first (full) answer as a reset (`updated = -1`) and every
incremental answer as an addition (`updated = number of strikes returned`).
If a response has no `next` field, the cursor is left unchanged.

---

## 7. From a user location (lat, lng) to an HTTP request

This is the core local-region path. Given a geographic position
(<code>latitude, longitude</code> in decimal degrees):

### Step 1 — compute the tile indices

Tile side `scale` for the location path is fixed at **5 degrees** (`LOCAL_DATA_SCALE`).
The tile coordinate is the position **floored to the scale**, with the negative-coordinate
correction done explicitly:

```kotlin
x = floor(longitude / scale)     // implement as: (lng / scale).toInt() - if (lng < 0) 1 else 0
y = floor(latitude  / scale)     // implement as: (lat / scale).toInt() - if (lat < 0) 1 else 0
```

Examples (scale = 5):

| Position | x / y |
|---|---|
| Berlin `52.52, 13.405` | x = floor(13.405/5) = 2, y = floor(52.52/5) = 10 |
| San Francisco `37.77, −122.42` | x = floor(−122.42/5) = −25, y = floor(37.77/5) = 7 |
| Sydney `−33.87, 151.21` | x = floor(151.21/5) = 30, y = floor(−33.87/5) = −7 |

### Step 2 — assemble the request

With `region = −1` and `dataArea = (x, y, scale)`:

```
POST http://bo-service.tryb.de/       Content-Type: text/json
{ "jsonrpc": "2.0", "id": <n>,
  "method": "get_local_strikes_grid",
  "params": [ x, y, gridSize, intervalDuration, intervalOffset, countThreshold, scale ] }
```

Worked example — Berlin, 5 km cells, last 60 s, no threshold:

```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "method": "get_local_strikes_grid",
  "params": [2, 10, 5000, 60, 0, 0, 5]
}
```

### Step 3 — interpret the response geometrically

The server returns the raster for the tile (illustrative values):

```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "result": {
    "t": "20260325T12:00:00",
    "x0": 10.0, "y1": 25.0,
    "xd": 0.25, "yd": 0.25,
    "xc": 20,   "yc": 20,
    "r": [ [3, 7, 12, 2], [4, 8, 5, 9] ],
    "h": [2, 5, 9, 4]
  }
}
```

Cell `[3, 7, 12, 2]` becomes:

* centerLongitude = `10.0 + 0.25·(3+0.5)` = `10.875`
* centerLatitude  = `25.0 − 0.25·(7+0.5)` = `23.125`
* multiplicity = 12 strikes in that cell
* timestamp = `t + 2 s`

### Alternatives to the fixed 5° tile

* **Map bounding box** — when the user pans/zooms (`MainDataHandler.updateGrid` →
  `LocalData.update(boundingBox)`), the tile scale is derived from the visible extent:

  ```
  scale = ceil(0.5 · max(longitudeSpan, latitudeSpan) / 5) · 5      (degrees, multiple of 5)
  x, y  = tile index of the bounding-box center at that scale
  ```

  If `scale` would exceed `20°`, the view is considered global and the request falls
  back to `get_global_strikes_grid`.

* **Global** — `region = 0`: `get_global_strikes_grid(intervalDuration, max(gridSize, 25000), intervalOffset, countThreshold)`, grid anchored at (0°N, 0°E).

* **Named region** — positive `region`: `get_strikes_grid(intervalDuration, gridSize, intervalOffset, region, countThreshold)`.

* **Background service** (`AppService`, `ServiceDataHandler`) — always uses the local
  tile path with fixed `gridSize = 5000`, a 10-minute interval (`TimeInterval.BACKGROUND`),
  `countThreshold = 0`, and the device's last known location; it never falls back to global.

#### ⚠️ Tile boundary blind spot

The local tile is a **hard boundary** — `get_local_strikes_grid` returns only strikes
whose coordinates fall within the requested tile. Strikes in **adjacent tiles** are simply
not included in the response, even if they are only metres away geographically.

This creates a blind spot for users near a tile boundary:

```
Tile (-16, 7)  covers  [-80°W, -75°W) × [35°N, 40°N)
A location at  39.95°N, 75.15°W  (Philadelphia)
  →  ~3.5 miles from the northern boundary (40°N)
  →  ~7  miles from the eastern  boundary (75°W)
A strike 10 miles north  (40.1°N) → tile (-16, 8), not fetched
A strike 10 miles east   (74.8°W) → tile (-15, 7), not fetched
```

For the **background service** this is a real gap: `AlertHandler` subscribes to the
service's `DataEvent` and only inspects strikes that were fetched. A strike crossing a
tile boundary within alert range (e.g. 50 km) will **never trigger a proximity alert**,
even though the user is close enough to be warned. The app trades this comprehensive
coverage for bandwidth and battery efficiency (a 5°×5° tile is ~500 000 km² at mid-latitudes).

The map bounding-box path (above) partly mitigates this for interactive use because it
computes a potentially larger scale from the visible extent. But the background alert
path always uses the fixed 5° tile.

---

## 8. How the app maps API output to geography (map rendering)

* **Strikes** (`get_strikes` → `DefaultStrike`) are plotted as points at
  `(latitude, longitude)` using their exact coordinates.
* **Grid cells** (`GridElement`) are plotted at the **cell center** (§6.3), with visual
  size/emphasis proportional to `multiplicity` (strike count) and fading with age.
* **Age** drives color: strikes are colored red (most recent) → yellow → blue (oldest)
  by `StrikeColorHandler`, based on `now − timestamp`. Cells older than one animation
  step (or outside the active window) are expired from the overlay.
* **Own location** is drawn from the device `Location` — it is *not* derived from the API.
* The app's `referenceTime` is taken from the response `t` for grid requests but stays at
  client request time for `get_strikes`; timestamps are always Unix ms.

---

## 9. Errors and robustness

* Any non-`2.0` response, missing `result`, or non-object `result` → `JsonRpcException`
  (`unsupported JSON-RPC response version`, `invalid JSON-RPC response: missing result`,
  `invalid JSON-RPC response result`).
* Server `error` member → `JsonRpcException("remote Exception '<message>' #<code>")`.
* Network/HTTP failures inside `FetchDataTask` are caught and converted into a
  `DataReceived(failed = true)` event; the UI shows the previous data.
* 5-minute client-side cache (`DataCache`) keyed by `Parameters` avoids redundant calls.
* `SequenceValidator` drops out-of-order (stale) results using monotonically increasing
  sequence numbers.
* Errors in the local tile math never occur because negative coordinates are handled by
  the floor-correction in `calculateLocalCoordinate`.

---

## 10. Reference source files

| Concern | File |
|---|---|
| Transport (POST, headers, gzip) | `app/src/main/java/org/blitzortung/android/jsonrpc/HttpServiceClientDefault.kt` |
| JSON-RPC envelope, ids, batch, errors | `app/src/main/java/org/blitzortung/android/jsonrpc/JsonRpcClient.kt` |
| Provider: method calls, cursor, grid parse | `app/src/main/java/org/blitzortung/android/data/provider/standard/JsonRpcDataProvider.kt` |
| Method/region routing | `app/src/main/java/org/blitzortung/android/data/provider/standard/JsonRpcData.kt` |
| Tuple → bean parsing | `app/src/main/java/org/blitzortung/android/data/provider/standard/DataBuilder.kt` |
| Tile math, regions, local/global switch | `app/src/main/java/org/blitzortung/android/data/provider/LocalData.kt` |
| Parameter model (region, gridSize, interval, dataArea) | `app/src/main/java/org/blitzortung/android/data/Parameters.kt` |
| Orchestration/caching | `app/src/main/java/org/blitzortung/android/data/MainDataHandler.kt`, `data/cache/DataCache.kt` |
| Background service query | `app/src/main/java/org/blitzortung/android/data/ServiceDataHandler.kt` |

Tests with concrete request shapes:
`app/src/test/java/org/blitzortung/android/data/provider/standard/JsonRpcDataProviderTest.kt`,
`app/src/test/java/org/blitzortung/android/jsonrpc/JsonRpcClientTest.kt`.