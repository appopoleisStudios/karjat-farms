# GroundWork — Time System Spec

**Status:** complete  
**Phase:** 0 P0  
**Author:** Moraen  
**Validated against:** index.html CROPS (lines 174-178), crops.json v1 schema

---

## 1. Core Constants

| Parameter | Value | Derivation |
|---|---|---|
| Real minutes per game-day | **20** | Locked by spec |
| Real minutes per game-year | **90** | Locked by spec |
| Game-minutes per real minute | **3** | 1440 real-min/day ÷ 20 real-min/game-day = 72 game-min/real-min ÷ 24 |
| Game-minutes per game-day | **4,320** | 1440 × 3 |
| Game-minutes per game-year | **388,800** | 4320 × 90 |
| Game-hours per game-day | **72** | 4320 ÷ 60 |
| 1 game-minute in real seconds | **≈0.833 s** | 20 real-min × 60 s ÷ 4320 game-min |
| Display timezone | **IST (UTC+5:30)** | Sky/UI clock, not geo-blocking |

> Math check: 90 real-days × 1440 real-min/day = 129,600 real-min ÷ 3 game-min/real-min = **43,200 game-min/year**
> Wait — recheck: 1 game-day = 20 real-min, so 1 real-min = 4320/1440 game-min = **3 game-min per real-min**
> 90 real-days × (1440 real-min/day ÷ 20 real-min/game-day) = **6,480 game-days per game-year** ✓

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

## 4. Crop Grow Times (game-minute → real-minute conversion)

Formula: `real-min = growTime-game-min × (20 real-min/game-day ÷ 4320 game-min/day)`

| Crop | growTime (game-min) | = real minutes | = real seconds |
|---|---|---|---|
| methi | 20 | ~0.09 min | ~5.5 s |
| lalsaag | 25 | ~0.12 min | ~6.9 s |
| mula | 30 | ~0.14 min | ~8.3 s |
| palak | 22 | ~0.10 min | ~6.1 s |

> Prototype has 1:1 growTime:game-minutes (e.g. growTime:20 means 20 game-minutes).  
> At the 20-min/day scale, crops complete in **under 1 real minute** — intentionally fast for prototype pacing.  
> **Phase 1 decision required:** Scale grow times up for realism (×10 or ×30 multiplier) or keep fast-paced for retention?

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

## 8. Open Questions (Moraen)

1. **growTime multiplier for Phase 1?** Fast prototype pacing vs. realistic agriculture — need Arsalan decision before Unity integration.
2. **Catch-up tick logic** (3+ days offline): current spec says "fast-forward to completed." Should player lose partial yield? Need Economy lead decision.
3. **Paddy/nachni grow times** in crops.json are `null` — stub status. Require mandi research to set realistic values.
4. **Day/night gameplay gates** (Phase 2): worth scoping? Could tie chicken feed consumption, water evaporation rates.