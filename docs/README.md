# GroundWork Documentation Index

**Project:** Karjat Farms / GroundWork  
**Phase:** 0 — Foundation docs (Week 1)  
**PM / senior dev:** Cursor · **Trainee:** Arsalan  
**Handoff:** [HANDOFF-MORAEN.md](HANDOFF-MORAEN.md)  
**Workflow:** [tech/dev-workflow.md](tech/dev-workflow.md) — Mac Mini primary, GitHub SDLC, Unity MCP  
**Overnight labor:** [ops/moraen-cto-tasks.md](ops/moraen-cto-tasks.md) — Moraen CTO Telegram bot (free)  
**GTM research:** [ops/gtm-twitter-intel-research.md](ops/gtm-twitter-intel-research.md) — Twitter intel → build + market automation  
**Queue:** [coordination.md](coordination.md)

## Phase 0 P0 docs (Week 1 — blocking Unity start)

| Status | Doc | Path | Owner |
|---|---|---|---|
| [ ] pending | Documentation index | [docs/README.md](README.md) | Moraen |
| [ ] pending | Game Design Document | [docs/gdd/GDD.md](gdd/GDD.md) | Moraen |
| [ ] pending | Architecture overview | [docs/tech/architecture.md](tech/architecture.md) | Moraen |
| [x] done | Repository structure | [docs/tech/repo-structure.md](tech/repo-structure.md) | Moraen · PM reviewed |
| [x] done | Farming Engine audit | [docs/tech/farming-engine-audit.md](tech/farming-engine-audit.md) | Moraen · PM reviewed 2026-06-06 |
| [x] done | Time system spec | [docs/gdd/time-system.md](gdd/time-system.md) | Moraen · PM reviewed (math + growTime fixes) |
| [x] done | Karjat region bible | [docs/geo/karjat-region-bible.md](geo/karjat-region-bible.md) | Moraen · PM reviewed 2026-06-06 |
| [ ] pending | Crop data (JSON + MD) | [docs/karjat-economy/crops.json](karjat-economy/crops.json) · [crops.md](karjat-economy/crops.md) | Moraen |

Update checkboxes to `[x] done` as each doc is completed.

---

## Session log

[docs/dev-log.md](dev-log.md) — append after every work session.

---

## Master plan

Full roadmap (52 docs, phases, legal, economy):

```
/home/moraen/.cursor/plans/groundwork_game_plan_e9f1bee0.plan.md
```

---

## Folder structure (target)

```
docs/
├── README.md              ← you are here
├── HANDOFF-MORAEN.md      ← start here if new
├── dev-log.md
├── gdd/                   ← game design
├── tech/                  ← architecture & systems
├── economy/               ← numbers, formulas (Phase 1+)
├── geo/                   ← Earth map & GeoEcosystem
├── backend/               ← Supabase, Edge Functions (Phase 2+)
├── api/                   ← Partner Agent API (Phase 3.5+)
├── legal/                 ← compliance (Phase 3+)
├── ops/                   ← runbooks (Phase 3+)
├── art/                   ← asset pipeline (Phase 1+)
├── qa/                    ← test plans (Phase 1+)
├── karjat-economy/        ← crop/livestock data sheets
└── business/              ← financial model, GTM (Phase 3+)
```

---

## Prototype reference

| Asset | Path |
|---|---|
| HTML5 prototype | [index.html](../index.html) |
| Pixel sprites | [sprites3/](../sprites3/) |
| Legacy sprites | [sprites/](../sprites/) |
