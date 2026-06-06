# GroundWork — Farming Engine Audit

**Status:** draft — outline only (Moraen to complete)  
**Phase:** 0 P0  
**Template:** [Farming Engine ($49)](https://assetstore.unity.com/packages/templates/systems/farming-engine-191881)  
**Unity version:** 2022.3 LTS + URP

---

## 1. Why Farming Engine

<!-- Source: plan §1
     - ScriptableObject-driven items
     - Crops, livestock, day/night, save/load, mobile touch, NPC shop included
     - v1.21 (Dec 2024), actively maintained
     - $49 vs Farming Island ($60, hyper-casual, skip) -->

## 2. System audit table

<!-- Required table format:

| FE System | Keep / Strip / Replace | Notes | GroundWork extension |
|---|---|---|---|
| PlantData / crops | ? | | Karjat crop injection via ScriptableObjects |
| AnimalData / livestock | ? | | Chicks MVP |
| GameClock / day-night | ? | | 20 min game-day; IST display |
| Save system | ? | | Offline-first + Supabase sync (Phase 2) |
| NPC shop | ? | | AI weekly trader replaces generic shop |
| Inventory | ? | | Bushels + harvested crops |
| Crafting | ? | | Likely strip for MVP |
| Building placement | ? | | Deferred |
| Mobile touch input | Keep | | Already solved |
| UI framework | ? | | Reskin for Karjat aesthetic |

Fill in Keep/Strip/Replace after importing demo on Mac Mini (Phase 1). -->

## 3. Extension points

<!-- Where to inject Karjat data:
     - Resources/KarjatData/crops.json → PlantData ScriptableObjects
     - Custom GameClock subclass for Kharif/Rabi gates
     - KarjatEconomyConfig for Bushel pricing -->

## 4. Known gaps vs GroundWork needs

<!-- List what FE does NOT provide out of box:
     - Player-to-player market
     - GeoEcosystem rules
     - Config-driven economy (Supabase economy_config)
     - Dual-build IN/GLOBAL -->

## 5. Import checklist (Phase 1 — do not run yet)

<!-- - [ ] Purchase Farming Engine ($49)
     - [ ] Create groundwork-unity/ with Unity 2022.3 LTS + URP
     - [ ] Import FE package
     - [ ] Run mobile demo on Android
     - [ ] Update this audit with actual class names from source -->
