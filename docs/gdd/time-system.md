# GroundWork — Time System Spec

**Status:** draft — outline only (Moraen to complete)  
**Phase:** 0 P0

---

## 1. Core constants

| Parameter | Value | Notes |
|---|---|---|
| Real minutes per game-day | **20** | Locked |
| Real days per game-year | **90** | Locked |
| Game-days per game-year | 90 × (24×60/20) = **6,480** | Derive and verify |
| Display timezone | **IST (UTC+5:30)** | Sky/UI only; not geo-blocking |

<!-- Moraen: verify math and document tick rate (e.g. 1 game-minute = 20/1440 real seconds) -->

## 2. Day/night cycle

<!-- Source: index.html IST clock
     - Dawn / Day / Dusk / Night phases
     - Visual only for MVP or gameplay gates?
     - Document phase boundaries (e.g. 06:00–18:00 = Day in IST) -->

## 3. Seasonal calendar (Kharif / Rabi)

<!-- Kharif: ~Jun–Oct (monsoon sowing)
     Rabi: ~Nov–Mar (winter crops)
     Which crops are plantable per season? Reference crops.json -->

| Season | Real-world window (IST) | Game-year mapping | Crop gates |
|---|---|---|---|
| Kharif | Jun–Oct | TBD | lalsaag, paddy, nachni |
| Rabi | Nov–Mar | TBD | methi, mula, palak |

## 4. Crop grow times

<!-- Prototype uses real minutes = game minutes (1:1 at 20 min/day scale?)
     Document conversion: prototype growTime:20 → ? game-hours
     Source: index.html CROPS.growTime -->

## 5. AI trader schedule

<!-- Weekly visit: Saturday 10:00 IST (configurable via economy_config)
     Source: plan §2 -->

## 6. IST display vs game calendar

<!-- Clarify: IST clock is cosmetic for sky/UI
     Game calendar (Day N, Season) is authoritative for crop gates
     No real-world geo-blocking in India build -->

## 7. Edge cases

<!-- Player offline for 3 real days — catch-up tick or pause?
     Season transition mid-grow — crop fails or completes? -->
