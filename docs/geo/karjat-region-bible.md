# GroundWork — Karjat Region Bible (T0 Flagship)

**Status:** complete  
**Phase:** 0 P0  
**Author:** Moraen  
**Region:** Karjat, **Raigad district**, Maharashtra, India — not Ahmednagar Karjat  
**Cross-ref:** [crops.json](../karjat-economy/crops.json) (machine-readable params), [time-system.md](../gdd/time-system.md) (seasonal calendar)

---

## 1. Geography & Climate

| Parameter | Value | Source |
|---|---|---|
| Location | Karjat taluka, Raigad district, Maharashtra | — |
| Coordinates | ~18.9°N, 73.3°E | — |
| Elevation | 100–300 m ASL (Sahyadri foothills) | plan §4 |
| Soil type | Laterite (red-brown, well-drained, low moisture retention) | plan learning roadmap |
| Monsoon | Jun–Oct (Southwest monsoon, Arabian Sea branch) | — |
| Annual rainfall | 2,000–3,000 mm | plan §4 |
| Temperature range | 17°C (Jan) – 35°C (May) | — |
| Major river | Ulhas River (flows through Karjat) | — |
| Nearby landmark | Matheran hill station (N54 km, car-free eco-zone) | — |

**Game implication:** Laterite soil + monsoonal water table → Kharif crops require minimal irrigation input; Rabi crops need manual water cost in-game.

---

## 2. Water & Monsoon

| Season | Real window | Rainfall | Game implication |
|---|---|---|---|
| Kharif (Monsoon) | Jun 15–Oct 31 | Heavy (2,500+ mm) | Monsoon bonus: Kharif crops cost 0 water to plant |
| Rabi (Winter) | Nov 1–Mar 15 | Negligible (<50 mm) | Manual irrigation required; water is a real resource in Rabi |
| Zaid (Summer) | Mar 16–Jun 14 | Very low | Irrigation only; most Rabi crops already harvested |
| Presummer fallow | Mid-Jun | Pre-monsoon | Waiting period; no planting until monsoon onset |

**Game mechanic:** Seasonal planting gates enforced in Phase 1 via `KarjatGameClock` (see farming-engine-audit.md). **Water as a spendable resource** (Rabi irrigation cost, Kharif zero-water bonus) deferred to Phase 2+ — MVP uses season gates only, not water economy.

---

## 3. MVP Crops

All six crops documented. Source priority: `index.html` CROPS object (prototype params), `crops.json` (v1 schema), Agmarknet (mandi prices where available).

| Crop (English UI) | Hindi translit. | Season | growTime* | Seed (Bushels) | Sell (Bushels) | Mandi ref (₹/quintal) | MVP? |
|---|---|---|---|---|---|---|---|
| Methi | methi | Rabi | 20 | 5 | 15 | 1,550–4,020 (MH leaves) | ✅ |
| Red Amaranth | lal saag | Kharif | 25 | 3 | 10 | ~1,000–1,700 | ✅ |
| Radish | mooli | Rabi | 30 | 8 | 20 | ~800–2,500 | ✅ |
| Spinach | palak | Year-round | 22 | 6 | 18 | ~400–3,000 | ✅ |
| Paddy (Karjat Kolam) | dhan | Kharif | 50† | 20 | 70 | 2,369–2,450 (Karjat APMC) | ✅ estimated |
| Finger Millet | nachni | Kharif | 38† | 10 | 42 | 4,900–5,700 (MH hub) | ✅ estimated |

\*See [time-system.md §4](../gdd/time-system.md) for growTime unit schism. †Paddy/nachni game params estimated — playtest in Phase 1.

**Variety note:** Karjat flagship paddy = **Trombay Karjat Kolam (TKR Kolam)**, tested at RARS Karjat Raigad — not “Karadai”.

**Seasonal gates (from time-system.md §3):**
- Kharif plantable: lalsaag, paddy, nachni
- Rabi plantable: methi, mula
- Year-round: palak
- Planting outside season → UI blocks planting; no grow.

---

## 4. Livestock (MVP — Chicks)

| Parameter | Value |
|---|---|
| Starter asset | Chicks (पिल्ले) |
| Starter cost | 500 Bushels |
| Mechanic | Buy chicks → feed daily → eggs → collect + sell |
| Feed cost | TBD (Phase 1 economy tuning) |
| Egg sell price | TBD (Phase 1 economy tuning) |
| Azolla pond | Out of MVP scope (Phase 1.1+) |
| Grow bags | Out of MVP scope |

**Reference:** [plan §4 "chicks starter asset (500 Bushels)"]

---

## 5. Mandi & Economy Flavor

### Karjat APMC
- **Full name:** Karjat Agricultural Produce Market Committee, Karjat, Raigad
- **Regulation:** Maharashtra Agricultural Produce Marketing (Regulation) Act, 1963
- **Crops traded:** Rice (paddy), vegetables, jowar, Nachni (ragi), fruits
- **Source:** Karjat taluka agricultural records; Agmarknet (agmarknet.gov.in)

### mandi price notes for game params
- **Leafy vegetables (methi, palak, lal saag):** Sold in **bundles** at mandi, not quintals. Agmarknet tracks these as per-quintal for wholesale analysis, but village-level sales are bundle-based. Game sell price in Bushels is hand-tuned (see crops.json prototype values); real-world mandi prices are directional reference only.
- **Root vegetables (mula/radish):** Similarly sold by weight in mandi but purchased by farmers per packet of seed. Bushels sell price in-game is a game-balance decision, not a direct mandi conversion.
- **Paddy (dhan):** Karjat(Raigad) APMC **₹2,369–2,450/quintal** for common paddy (2024–25). Milled rice trades higher (₹4,100–5,800/q) — game uses farm-gate paddy ref, not retail rice.
- **Nachni (ragi/millet):** Maharashtra hub modal **₹4,900–5,700/quintal** (Pune APMC 2026). Game params in crops.json are estimated.

### AI weekly trader (Phase 2+)
- Flavor: "village buyer" who visits Karjat village on Saturday mornings
- Not a generic FE NPC shop — custom `AIMarketTrader` with configurable markup/discount on mandi prices
- References `economy_config.json` for pricing schedule
- **Phase 1 MVP:** Direct harvest-sell only (player drops crop at market UI, receives Bushels immediately)

### Currency
- **Bushels** — soft in-game currency, no real-money cash-out in India build (PROGA social game compliance)
- Bushels ↔ INR not part of India build; cosmetic only (premium cosmetics IAP, Farmer's Pass)

---

## 6. Social & Cultural Flavor

- **UI language (PM decision):** **English primary.** Hindi crop names appear as **Latin transliteration** in subtitles — e.g. `Spinach (palak)`, `Finger Millet (nachni)`. No Devanagari in default Phase 1 UI.
- **Crop labels:** English common name first; `(localName)` from [crops.json](../karjat-economy/crops.json) when it adds Karjat flavor.
- **Local calendar events (Phase 2+):** Diwali bonus market prices, monsoon festival narrative events
- **Village aesthetic:** Laterite soil tiles, Ulhas River visual, Matheran-inspired hill backdrop
- **Voice/locale (Phase 2+):** Optional Hindi audio; English UI remains default

---

## 7. T0 vs T2 Fidelity

| Override | T0 (Karjat flagship) | T2 (FAO GAEZ global) |
|---|---|---|
| Crop list | 6 crops (4 complete + 2 stubs) | Geo-referenced crop database |
| Mandi prices | Agmarknet Raigad (directional) | Live API scrape |
| Season calendar | Maharashtra agricultural calendar | Real-week mapping per lat/lon |
| Water rules | Karjat rainfall model | GAEZ water balance model |
| Market prices | Direct harvest-sell (Phase 1); AI trader (Phase 2+) | Dynamic market simulation |

**T0 is the MVP.** T2 (FAO GAEZ v5 global lookup) deferred to Phase 2.5+. T0 overrides live in `Resources/KarjatData/GeoConfig.asset`.

---

## 8. Sources & Research

| Source | Status | Notes |
|---|---|---|
| [Agmarknet](https://agmarknet.gov.in) | Partial | paddy Karjat APMC ₹2,369–2,450; nachni via Pune hub ₹4,900–5,700 |
| Maharashtra Agricultural Calendar | Not reviewed | Needed for Rabi/Kharif window confirmation |
| Karjat taluka agricultural officer | Not contacted | Phase 1 field validation target |
| crops.json v1 schema | ✅ Complete | Source of truth for game params (prototype 4 crops) |
| index.html CROPS object | ✅ Complete | growTime + prices verified (lines 174–178) |

---

## 9. TBD Items (require PM/SA decision — do not implement without sign-off)

1. **Leafy crop mandi → Bushels** — **Resolved:** game prices hand-tuned; mandi directional only (see crops.md). No auto-conversion.
2. **Nachni game params** — **Estimated** in crops.json (seed 10 / grow 38 / sell 42). Validate in Phase 1 playtest.
3. **Water cost values** — TBD Phase 1 economy tuning. Not a blocker for Phase 0 doc acceptance.
4. **Egg income values** — TBD Phase 1 economy tuning. Chick economy balance not yet scoped.
5. **Seasonal events** — Phase 2+. TBD scope and festival calendar.