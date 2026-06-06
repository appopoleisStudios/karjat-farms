# Karjat Crop Data

**Status:** 4 prototype-complete + 2 estimated (paddy, nachni)  
**Machine-readable:** [crops.json](crops.json)  
**Naming:** English primary UI · Hindi names as **Latin transliteration** in `localName` (no Devanagari in default UI)

---

## Naming policy (PM decision 2026-06-06)

| Field | Use |
|---|---|
| `name` | English label shown first in UI (e.g. **Spinach**, **Finger Millet**) |
| `nameEnglish` | Longer English descriptor for tooltips / GDD |
| `localName` | Hindi transliteration in Latin script only (`palak`, `mooli`, `dhan`) |
| `displayAlias` | Optional legacy/prototype short name (`Mula`, `Nachni`) |

**UI pattern:** `Spinach (palak)` · `Finger Millet (nachni)` · `Paddy (Karjat Kolam) (dhan)`

Devanagari script is **out of scope for Phase 1 default UI** — optional accessibility setting later.

---

## All six MVP crops (researched)

| ID | English (`name`) | Hindi translit. | Season | Seed 🪙 | Grow* | Sell 🪙 | Mandi ref ₹/q | Status |
|---|---|---|---|---|---|---|---|---|
| methi | Methi | methi | Rabi | 5 | 20 | 15 | 1,550–4,020 | prototype |
| lalsaag | Red Amaranth | lal saag | Kharif | 3 | 25 | 10 | ~1,000–1,700 | prototype |
| mula | Radish | mooli | Rabi | 8 | 30 | 20 | ~800–2,500 | prototype |
| palak | Spinach | palak | Year-round | 6 | 22 | 18 | ~400–3,000 | prototype |
| paddy | Paddy (Karjat Kolam) | dhan | Kharif | 20 | 50 | 70 | 2,369–2,450 | estimated |
| nachni | Finger Millet | nachni | Kharif | 10 | 38 | 42 | 4,900–5,700 | estimated |

\*Grow column uses `crops.json` units (`timeUnit: game-minutes`). Prototype HTML still uses **real minutes** — see [time-system.md §4](../gdd/time-system.md).

---

## Research notes by crop

### Methi (fenugreek leaves) · `methi`

- **Hindi:** methi · **Marathi:** methi (same transliteration)
- **MVP role:** Fast Rabi starter; prototype ROI ~3× (5 → 15 Bushels)
- **Mandi:** Maharashtra methi leaves wholesale **₹1,550–4,020/quintal** (NaPanta state aggregate, Apr 2026). Leafy — volatile, not a stable quintal commodity at village level.
- **Game:** Keep prototype params; mandi is directional only.

### Red amaranth (lal saag) · `lal saag`

- **Hindi:** lal saag / chaulai · **Marathi:** lal math (leaves)
- **MVP role:** Low-cost Kharif entry crop
- **Mandi:** Amaranth leaves retail **₹10–16/kg** in Maharashtra mandi/retail trackers → **~₹1,000–1,600/q** directional wholesale.
- **Game:** Keep prototype params.

### Radish · `mooli` (prototype alias **Mula**)

- **Hindi:** mooli · **Marathi:** mula — prototype used Marathi short form **Mula** as crop id/display alias
- **MVP role:** Mid-cycle Rabi; higher margin (8 → 20 Bushels)
- **Mandi:** Root vegetables sold by weight/bundle; wide spread **~₹800–2,500/q** depending on market and grade.
- **Game:** Keep prototype params; `displayAlias: "Mula"` preserves HTML prototype continuity.

### Spinach · `palak`

- **Hindi / Marathi:** palak
- **MVP role:** Year-round safety crop
- **Mandi:** Spinach wholesale Maharashtra **~₹400–3,000/q** (highly seasonal).
- **Game:** Keep prototype params.

### Paddy — Trombay Karjat Kolam · `dhan`

- **Correct variety name:** **Trombay Karjat Kolam (TKR Kolam)** — BARC/Konkan rice line, evaluated at **Regional Agricultural Research Station, Karjat, Raigad** (not a generic “Karadai” name).
- **English UI:** `Paddy (Karjat Kolam)` · Hindi translit: **dhan** (unhusked paddy grain)
- **Mandi (Karjat Raigad APMC):**
  - Paddy (dhan common): **₹2,369–2,450/q** (2024–25 snapshots, commodity aggregators)
  - Milled rice: **₹4,100–5,800/q** (processed — not what the farmer sells at harvest)
- **Game params (estimated):** seed 20 · grow 50 · sell 70 — flagship Kharif, longest cycle, highest Bushel payout. **Playtest before locking.**

### Finger millet (ragi) · `nachni`

- **Hindi:** nachni / mandua · **Marathi:** nachni · **English trade name:** ragi
- **English UI:** `Finger Millet` · Hindi translit: **nachni**
- **Mandi:** Maharashtra ragi/nachni **₹4,900–5,700/q** modal at Pune APMC (~₹5,200/q Mar 2026). Karjat APMC lists coarse grains (bajra ~₹2,500/q) but nachni often clears at state hubs at premium.
- **Game params (estimated):** seed 10 · grow 38 · sell 42 — upland Kharif, between veggies and paddy on effort/reward.

---

## Bushel vs mandi (important)

**Do not auto-convert ₹/quintal → Bushels.** Leafy crops are sold in bundles at village level; mandi quintal rates are wholesale directional references only. In-game prices are **hand-tuned for fun pacing** (see [karjat-region-bible §5](../geo/karjat-region-bible.md)).

Formal formula deferred to `docs/economy/price-formula.md` (Phase 1).

---

## Sources

| Source | Used for |
|---|---|
| [Karjat(Raigad) APMC](https://www.commoditymarketlive.com/mandi-price-market/karjat) | Paddy, rice, bajra snapshots |
| [NaPanta — methi leaves MH](https://www.napanta.com/agri-commodity-prices/maharashtra/methi-leaves/) | Methi wholesale range |
| [NaPanta / market trackers — amaranth, spinach](https://www.napanta.com/agri-commodity-prices/maharashtra/amaranthus/) | Leafy directional prices |
| [Pune APMC ragi/nachni](https://www.commoditymarketlive.com/mandi-price-state/maharashtra/ragi-finger-millet) | Nachni state hub modal |
| [RARS Karjat — Trombay Karjat Kolam trials](https://www.biochemjournal.com/archives/2025/vol9issue10S/PartC/S-9-10-15-893.pdf) | Paddy variety naming |
| [index.html](../../index.html) lines 174–178 | Prototype growTime + Bushel prices |

---

## JSON schema

See `$schema` in crops.json. Future fields: `waterRequirement`, `soilType`, `kharifBonus`, `rabiPenalty`.
