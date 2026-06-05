# Karjat Crop Data

**Status:** partial — 4 prototype crops complete, 2 MVP stubs pending  
**Machine-readable:** [crops.json](crops.json)  
**Owner:** Moraen

---

## Prototype crops (from index.html)

Extracted from `CROPS` object in [index.html](../../index.html) (lines 174–178).

| ID | Name | Season | Seed (🪙) | Grow (min) | Sell (🪙) | Prototype |
|---|---|---|---|---|---|---|
| methi | Methi | Rabi | 5 | 20 | 15 | Yes |
| lalsaag | Lal Saag | Kharif | 3 | 25 | 10 | Yes |
| mula | Mula | Rabi | 8 | 30 | 20 | Yes |
| palak | Palak | Year-round | 6 | 22 | 18 | Yes |

**Time unit:** game-minutes (see [time-system.md](../gdd/time-system.md) for conversion to game-days).

---

## MVP stubs (Moraen to complete)

| ID | Name | Season | Mandi ref (₹/quintal) | Game role | Status |
|---|---|---|---|---|---|
| paddy | Paddy (Karjat Kolam) | Kharif | ~₹2,350–4,700 | Flagship seasonal | **stub** |
| nachni | Nachni (Ragi) | Kharif upland | TBD | Drought-resilient | **stub** |

Moraen: research Agmarknet Raigad mandi prices, then fill `seedCost`, `growTime`, `sellPrice` in crops.json and update this table.

---

## Bushel conversion notes

<!-- Document how real mandi ₹/quintal maps to in-game Bushel prices.
     Source: plan §6 economy — to be defined in price-formula.md (Phase 1) -->

---

## JSON schema

See `$schema` field in crops.json. Future fields: `waterRequirement`, `soilType`, `kharifBonus`, `rabiPenalty`.
