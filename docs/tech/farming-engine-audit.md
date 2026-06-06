# GroundWork — Farming Engine Audit

**Status:** complete  
**Phase:** 0 P0  
**Author:** Moraen  
**Asset:** [Farming Engine v1.21 ($49)](https://assetstore.unity.com/packages/templates/systems/farming-engine-191881)  
**Unity:** 2022.3 LTS + URP  
**Cross-ref:** [time-system.md](../gdd/time-system.md) §4 — growTime unit schism; SA recommends **Option B (game-calendar mapping), pending playtest**

---

## 1. Why Farming Engine

- **ScriptableObject-driven items**: crop configs, animal data, item definitions as assets — clean separation from code
- **Included systems**: crops, livestock, day/night cycle, save/load, mobile touch input, NPC shop
- **v1.21 (Dec 2024)**, actively maintained by vendor
- **$49** vs alternatives: Farming Island ($60, hyper-casual, skipped)
- **Import location**: `Assets/FarmingEngine/` — never modify vendor code directly; all Karjat overrides in `Assets/Scripts/`

---

## 2. System Audit Table

> **TBD** = requires Phase 1 import + Mac Mini demo run to verify against actual FE source.  
> **K** = Keep (use as-is) | **S** = Strip (delete from build) | **R** = Replace with GroundWork custom

| FE System | Decision | GroundWork Extension | Status |
|---|---|---|---|
| `PlantData` / crop configs | **K → R** | Karjat crop injection via `Resources/KarjatData/PlantData` ScriptableObjects authored from `crops.json` | TBD (verify class name after import) |
| `AnimalData` / livestock | **K → R** | Chicks MVP only; replace FE cow/sheep/pig defaults with `ChickData` ScriptableObject | TBD |
| `GameClock` / day-night cycle | **K → R** | Subclass for Kharif/Rabi season gates; IST cosmetic clock (see time-system.md §6) | TBD |
| Save system (`SaveSystem`) | **K → R** | Keep FE local save; add Supabase cloud sync in Phase 2. See §4 Phase 2 item #3 | TBD |
| NPC Shop (`NpcShop`) | **S → R** | Strip FE shop for MVP. Phase 1: direct harvest-sell UI. Phase 2: AI weekly trader replaces shop | TBD |
| `Inventory` | **K** | Bushels + harvested crop items only; no additional item types in MVP | TBD |
| Crafting | **S** | Strip for MVP — no crafting in v1 scope | TBD |
| Building placement | **S → defer** | Deferred beyond Phase 1; no farm building placement in MVP | TBD |
| Mobile touch input | **K** | FE mobile input already handles touch planting/harvesting; verify on Android device in Phase 1 | TBD |
| UI framework | **K → R** | Reskin all FE UI prefabs for Karjat aesthetic (earth tones, Marathi crop names, IST clock) | TBD |
| Player-to-player market | **R** | Not in FE; requires custom `MarketSystem` (Phase 2). MVP has direct-harvest-sell only | TBD |
| GeoEcosystem rules | **R** | Not in FE; `GeoConfig` + `KarjatGameClock` enforce Kharif/Rabi planting gates in Phase 1 (see time-system.md §3). Water cost model Phase 2+ | TBD |
| Config-driven economy | **R** | Not in FE; `economy_config.json` via Supabase RLS (Phase 2+) | TBD |
| Dual-build IN/GLOBAL | **R** | Not in FE; branching via Unity Build Defines (Phase 3+) | TBD |
| Audio / SFX | **K** | Keep FE audio stubs; replace with Karjat farm ambience + Marathi voice lines | TBD |

---

## 3. Extension Points (Phase 1 Integration)

### `Resources/KarjatData/` — crop data injection

```
Resources/KarjatData/
├── Crops/
│   ├── MethiData.asset
│   ├── LalSaagData.asset
│   ├── MulaData.asset
│   ├── PalakData.asset
│   ├── PaddyData.asset    # stub until mandi research completes
│   └── NachniData.asset   # stub until mandi research completes
├── ChickData.asset
└── GeoConfig.asset          # Season gates (Phase 1); economy tuning (Phase 2+)
```

**Workflow**: `crops.json` (source of truth) → Python generator script (`scripts/generate_plantdata.py`) → Unity ScriptableObject assets. Never hand-author `.asset` files.

### Custom GameClock subclass — seasonal gates

```csharp
// Assets/Scripts/Time/KarjatGameClock.cs
// Subclass FE GameClock to enforce Kharif/Rabi planting restrictions
// Reference: time-system.md §3 seasonal calendar
// growTime unit schism: use Option B (game-calendar mapping) per SA recommendation
```

### `KarjatEconomyConfig` — pricing

Prices sourced from `crops.json`. AI trader markup/discount configured via `economy_config.json`.

---

## 4. Known Gaps vs GroundWork Needs

| Gap | Phase | GroundWork Solution |
|---|---|---|
| Player-to-player market | Phase 2 | Custom `MarketSystem` + Supabase realtime |
| GeoEcosystem rules | Phase 2 | `GeoConfig` ScriptableObject + Kharif/Rabi gate checks |
| Config-driven economy | Phase 2 | Supabase `economy_config` table with RLS |
| Dual-build IN/GLOBAL | Phase 3 | Unity `#if INDIA_BUILD` / `#if GLOBAL_BUILD` defines |
| Cloud save / cross-device | Phase 2 | Supabase auth + `PlayerSave` table |
| Social (friends, gifting) | Phase 2+ | TBD after player-market stability |

---

## 5. Phase 1 Import Checklist (do not run yet)

- [ ] Purchase Farming Engine on Unity Asset Store
- [ ] Create `groundwork-unity/` with Unity 2022.3 LTS + URP
- [ ] Import FE package → `Assets/FarmingEngine/`
- [ ] Run mobile demo on Android device
- [ ] Verify FE class names against this audit table; update TBD rows
- [ ] Author `Resources/KarjatData/` from `crops.json` via `scripts/generate_plantdata.py`
- [ ] Subclass `GameClock` → `KarjatGameClock` with seasonal gates
- [ ] Reskin FE UI for Karjat aesthetic
- [ ] Commit `ProjectSettings/` + `Packages/manifest.json` + `Assets/FarmingEngine/` to `feature/phase1-unity-setup`

> **SA advisory:** Create `groundwork-unity/` and commit its skeleton **in the same PR** as the Farming Engine import. Without the skeleton committed, future PRs waste time re-creating the Unity project structure.

---

## 6. Open Questions (TBD — require Phase 1 import to answer)

1. **FE class names**: PlantData, AnimalData, GameClock, SaveSystem, Inventory — verify actual class/API names after import
2. **Livestock scope**: FE includes cows, sheep, pigs. MVP is chicks only. Cost of stripping other animal types vs leaving them disabled?
3. **Save format**: FE local save (JSON/binary). Supabase cloud sync in Phase 2 — what's the FE save upgrade path when we introduce cloud saves?
4. **NPC shop removal**: Does stripping `NpcShop` require deleting FE scenes or just disabling the prefab reference?
5. **UI framework version**: Does FE use uGUI or UI Toolkit? Determines reskin approach.