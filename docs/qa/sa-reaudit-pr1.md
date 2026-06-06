# SA Re-Audit Request — PR #1 (`docs/phase0-p0`)

**Requested by:** Cursor PM  
**Date:** 2026-06-06  
**Branch HEAD:** (see latest commit on PR)  
**Prior audit:** [sa-audit-night1.md](sa-audit-night1.md) — night 1 only; **request changes** resolved in `3b31fbe`

---

## Scope (full P0 packet — re-audit all)

| Doc | Status since night 1 |
|---|---|
| [time-system.md](../gdd/time-system.md) | PM reviewed; §8 decisions table |
| [repo-structure.md](../tech/repo-structure.md) | PM reviewed; SA blockers fixed |
| [farming-engine-audit.md](../tech/farming-engine-audit.md) | Moraen night 2 + PM review `d4e62e3` |
| [karjat-region-bible.md](../geo/karjat-region-bible.md) | Moraen night 2 + PM review |
| [crops.json](../karjat-economy/crops.json) + [crops.md](../karjat-economy/crops.md) | PM crop research `c5d8a15` |
| [GDD.md](../gdd/GDD.md) | PM draft `2026-06-06` (~1238 words) |
| [architecture.md](../tech/architecture.md) | PM draft `2026-06-06` (~1222 words) |
| [README.md](../README.md) | 7/8 P0 checkboxes done; index self-row pending |
| SDLC docs | coordination, dev-workflow, moraen-cto-tasks aligned |

---

## SA checklist — please verify

### Blockers (merge gate)

- [ ] No contradictions: Phase 1 MVP = **direct harvest-sell** (not P2P market)
- [ ] Season gates = Phase 1 (`KarjatGameClock`); water economy = Phase 2+
- [ ] growTime schism documented; GDD §9 G1 defers Model B to playtest
- [ ] India build: no withdrawal, no Bushel purchase with INR (PROGA)
- [ ] Dual-build §4 matches plan §8 (INDIA_BUILD / GLOBAL_BUILD)
- [ ] English primary UI + Hindi Latin transliteration (crops.json namingPolicy)
- [ ] Paddy variety = Trombay Karjat Kolam — not “Karadai”
- [ ] 4+2 crop teaser policy consistent across GDD, region bible, crops.json

### Advisories

- [ ] GDD persona B (market optimizer) clearly Phase 2 — not oversold in MVP
- [ ] paddy/nachni game params marked `estimated` — playtest before ship
- [ ] Phase 1 exit gate: no Supabase until offline playtest — stated in architecture §8
- [ ] `groundwork-unity/` skeleton same PR as FE import — farming-engine-audit §5
- [ ] Git LFS still unset for sprites — defer or flag for Phase 1?

### Process

- [ ] Post formal GitHub **Approve** or **Request changes** review on PR #1
- [ ] If approve → **merge to `main`** (Claude SA owns merge per SDLC)

---

## Devil's advocate — new questions for SA

1. **GDD §4 “Coming Soon” for paddy/nachni** — does Play Store listing need all 6 playable, or 4+2 acceptable with store copy?
2. **Architecture Phase 2 dashed lines** — is Supabase auth in Phase 2 or Phase 3 per plan MVP table (GDD says cloud save Phase 2; plan MVP lists auth)?
3. **500 Bushel chicks** — GDD flags G3; SA: block Phase 1 or accept tuning risk?
4. **README index row** — still `[ ] pending` for README itself; cosmetic or blocker?

---

## PM disposition (pre-SA)

| Item | PM view |
|---|---|
| Merge readiness | **Ready for SA review** — not self-merging |
| Remaining P0 | README self-checkbox + optional index polish (Moraen evening) |
| Unity start | Blocked until SA merges PR #1 to `main` |

---

## How to respond

Comment on PR #1 or append to this file. SA merge command: approve PR #1 → merge `docs/phase0-p0` → `main`.
