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

> **Caveat (SA advisory):** The 90-day game-year **compresses** Maharashtra seasons for pacing. It is not a literal ag almanac. Marketing must not claim day-perfect Konkan calendar accuracy — say “inspired by Karjat Kharif/Rabi/Zaid rhythms.”

| Season | Real-world reference (Raigad) | Game-year days | Share | Crop gates |
|---|---|---|---|---|
| Kharif | Monsoon sowing ~Jun–Sep (Konkan retreat ~Oct) | Days **1–40** | 44% | lalsaag, paddy, nachni |
| Rabi | Post-monsoon Oct–Mar | Days **41–75** | 39% | methi, mula |
| Zaid | Short summer gap | Days **76–90** | 17% | palak (year-round), summer fallow |

**Revision note (SA audit):** Prior draft (Kharif 48 / Rabi 30 days) overweighted Kharif vs Konkan monsoon end and underweighted Rabi — rebalanced above.

**palak** is tagged `"season": "year-round"` in crops.json — always plantable.
Planting a Kharif crop outside Kharif window → crop fails at harvest with "wrong season" message.
Planting a Rabi crop during Kharif → system prevents planting (greyed-out in UI).

### Real-world anchors (design reference only)

- Kharif sowing: monsoon onset (~mid-Jun Karjat)
- Rabi: primary cereal/veg window post-monsoon through winter
- Zaid: limited summer crops between Rabi harvest and next Kharif

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
| Player offline 3+ real days | **Phase 1:** fast-forward crops but **cap at 1 game-day of progress per real-day absent** (SA Q2 — limits exploit). **Phase 2:** server-authoritative sim replaces client cap |
| Season transitions mid-grow | Crop completes normally; no penalty |
| Plant Kharif crop on Rabi day | UI blocks planting (crop greyed out) |
| New game-year rollover | Day counter resets to 1; season restarts Kharif; player inventory persists |
| Device clock mismatch | Use server-authoritative time via Supabase; client clock is display-only |

## 8. Open questions — resolved / deferred (SA audit 2026-06-05)

| # | Topic | Owner | Status | Decision |
|---|---|---|---|---|
| Q1 | growTime unit schism | PM + trainee | **Deferred → Phase 1** | SA recommends **Model B** (game-calendar mapping). Prototype stays on real minutes until post-playtest confirms pacing; lock before `PlantData` authoring. |
| Q2 | Offline catch-up exploit | PM | **Phase 1 mitigation** | Cap offline fast-forward at **1 game-day progress per real-day absent** (see §7). Full server sim deferred Phase 2 — not a merge blocker. |
| Q3 | Paddy/nachni stubs | PM | **Accepted MVP scope** | Ship **4 playable + 2 teaser** for soft launch; paddy/nachni show **Coming Soon** in UI. Paid store listing requires all 6 playable — Phase 1 gate. |
| Q4 | Season day mapping | PM | **Resolved in §3** | Rebalanced Kharif/Rabi/Zaid split + marketing caveat — gameplay compression, not literal almanac. |
| Q5 | Day/night gameplay gates | PM | **Deferred Phase 2** | Visual only in MVP; chicken feed / evaporation out of scope. |
| Q6 | IST clock vs game calendar | PM + UX | **Deferred Phase 1 UX** | Season banner + day counter are authoritative; IST sky is cosmetic — add onboarding tooltip in Unity UI pass. |