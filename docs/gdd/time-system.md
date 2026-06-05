# GroundWork — Time System Spec

**Status:** complete  
**Phase:** 0 P0  
**Author:** Moraen  
**Validated against:** index.html CROPS (lines 174-178), crops.json v1 schema

---

## 1. Core Constants

| Parameter | Value | Derivation |
|---|---|---|
| Real minutes per **game-day** | **20** | Locked by spec (HANDOFF row 6) |
| **Game-days** per game-year | **90** | Locked by spec — **not** 90 real minutes |
| Real minutes per **game-year** | **1,800** | 90 game-days × 20 real-min/game-day |
| Game-minutes per game-day (calendar) | **1,440** | Standard 24h clock compressed into one game-day |
| Game-minutes per real minute (during active day) | **72** | 1440 ÷ 20 |
| Game-minutes per game-year | **129,600** | 1440 × 90 |
| Display timezone | **IST (UTC+5:30)** | Sky/UI clock, not geo-blocking |

> **PM review fix (2026-06-05):** Earlier draft said “90 real minutes per game-year” — wrong.  
> **90 = game-days**, each game-day = 20 real minutes of player time → **~30 hours real time** per in-game year.

## 2. Day/Night Cycle

Reference: index.html IST clock rendering.

| Phase | IST hours | Game-min into day | Visual trigger |
|---|---|---|---|
| Night | 00:00–05:59 | 0–215 | Dark sky, stars |
| Dawn | 06:00–06:59 | 216–287 | Orange gradient, rooster cue |
| Day | 07:00–17:59 | 288–719 | Full brightness |
| Dusk | 18:00–18:59 | 720–791 | Amber/red gradient |
| Night | 19:00–23:59 | 792–959 | Darkening, stars return |

Phase boundaries are **game-time**, displayed in IST for player familiarity.
**MVP note:** Day/night is purely visual. No gameplay gates (e.g. "cannot harvest at night") until Phase 2.

## 3. Seasonal Calendar

| Season | Real-world window | Game-year days | Crop gates |
|---|---|---|---|
| Kharif | Jun 15–Oct 31 | Days 1–48 | lalsaag, paddy, nachni |
| Rabi | Nov 1–Mar 15 | Days 49–78 | methi, mula |
| Zaid | Mar 16–Jun 14 | Days 79–90 | palak (year-round), summer fallow |

**palak** is tagged `"season": "year-round"` in crops.json — always plantable.
Planting a Kharif crop outside Kharif window → crop fails at harvest with "wrong season" message.
Planting a Rabi crop during Kharif → system prevents planting (greyed-out in UI).

### Kharif / Rabi derived from real-world Maharashtra agricultural calendar:
- Kharif sowing: monsoon onset (~Jun 15 Karjat)
- Rabi sowing: post-monsoon rabi cereals (Jun–Sep are too wet for wheat/methi)
- Zaid: short summer window, limited crop selection

## 4. Crop Grow Times — **prototype vs target spec**

### Prototype truth (`index.html`)

```javascript
const elapsed = (Date.now() - plot.plantedAt) / 60000; // REAL minutes
if (elapsed >= growTime) { /* harvest ready */ }
```

| Crop | `growTime` in CROPS | Meaning in prototype | UI label |
|---|---|---|---|
| methi | 20 | **20 real minutes** | seed card “20m” |
| lalsaag | 25 | 25 real minutes | “25m” |
| mula | 30 | 30 real minutes | “30m” |
| palak | 22 | 22 real minutes | “22m” |

`crops.json` field `timeUnit: "game-minutes"` is **aspirational** — not what the HTML prototype implements today.

### Unity / MVP target (TBD — needs product decision)

When we wire Farming Engine, choose one model:

| Model | methi example | Pros | Cons |
|---|---|---|---|
| **A — Keep prototype pacing** | 20 real minutes | Familiar to playtesters | Ignores 20-min game-day calendar |
| **B — Map to game-calendar** | e.g. 480 game-min ≈ 6.7 real min at 72 game-min/real-min | Aligns with seasons/day-night | Requires retuning all crops + UX |
| **C — Hybrid multiplier** | ×N on prototype values | Easy migration knob | Still arbitrary without ag realism |

**Phase 1 decision required (Arsalan + PM):** pick A, B, or C before Unity `PlantData` is authored.

## 5. AI Trader Schedule

- **Day:** Saturday
- **Time:** 10:00 IST
- **Frequency:** Weekly (every 7 game-days)
- **Config:** `economy_config.json` → `aiTrader.dayOfWeek`, `aiTrader.visitHour`
- **Phase:** Phase 2+ (MVP has player-market only)

## 6. IST Display vs Game Calendar

- **IST clock** in sky/UI is cosmetic — shows real current time in IST
- **Game calendar** (Day N, Season name) is authoritative for:
  - Crop planting gates
  - Seasonal events
  - Achievement tracking
- No geo-blocking in India build — game always runs as if in Karjat regardless of player location

## 7. Edge Cases

| Scenario | Resolution |
|---|---|
| Player offline 3+ real days | On return: fast-forward crops to completed state; no retroactive harvest income |
| Season transitions mid-grow | Crop completes normally; no penalty |
| Plant Kharif crop on Rabi day | UI blocks planting (crop greyed out) |
| New game-year rollover | Day counter resets to 1; season restarts Kharif; player inventory persists |
| Device clock mismatch | Use server-authoritative time via Supabase; client clock is display-only |

## 8. Open Questions (for SA / product review)

1. **growTime unit schism** — prototype uses real minutes; `crops.json` says game-minutes. Which is canonical for MVP?
2. **Catch-up tick logic** (3+ real days offline): fast-forward to completed vs partial yield loss vs server sim — economy impact?
3. **Paddy/nachni `growTime: null`** — block MVP or ship 6-crop with 4 playable + 2 locked?
4. **Season day mapping** — Kharif “days 1–48” of 90: does this compress Maharashtra calendar believably for Indian players?
5. **Day/night gameplay gates** (Phase 2): chicken feed, water evaporation — scope now or defer?
6. **IST cosmetic clock vs authoritative game calendar** — can players be confused when real IST ≠ game season UI?