# Handoff — Moraen (Phase 0 P0 Docs)

**Assignee:** Moraen  
**Primary machine:** Mac Mini (`arsalans-mac-mini`)  
**Repo:** https://github.com/appopoleisStudios/karjat-farms  
**Branch:** `docs/phase0-p0`  
**Workflow:** [dev-workflow.md](tech/dev-workflow.md) · **Moraen bot:** [ops/moraen-cto-tasks.md](ops/moraen-cto-tasks.md)

---

## How we work (read this first)

**Mac Mini is the primary dev machine.** Three agents share the work:

| Agent | Role |
|---|---|
| **Moraen CTO bot** (Telegram `@moraen_cto_bot`) | **Free overnight labor** — writes docs, research, PRs |
| **Cursor** (interactive on Mac Mini) | Unity MCP, complex debug, architecture with you |
| **You (Arsalan)** | Set overnight goals, review PRs, merge `main`, playtest |

**You do not need to write Phase 0 docs yourself.** Send Moraen bot an overnight Telegram goal; review the PR in the morning.

Full workflow: [docs/tech/dev-workflow.md](tech/dev-workflow.md)

---

## Step 1 — Start Phase 0 (Arsalan sends Telegram goal)

**Arsalan** sends this to `@moraen_cto_bot` (copy from [ops/moraen-cto-tasks.md](ops/moraen-cto-tasks.md)):

```text
GroundWork overnight — karjat-farms

Repo: appopoleisStudios/karjat-farms
Branch: docs/phase0-p0

Goals (all 8 P0 docs — see HANDOFF acceptance table):
1. docs/gdd/GDD.md
2. docs/tech/architecture.md
3. docs/tech/repo-structure.md
4. docs/tech/farming-engine-audit.md
5. docs/gdd/time-system.md
6. docs/geo/karjat-region-bible.md
7. docs/karjat-economy/crops.json + crops.md
8. Update docs/README.md checkboxes

Read: docs/HANDOFF-MORAEN.md
Append docs/dev-log.md each session
Open PR when done; Telegram report with link
Do NOT: merge to main, start Unity
```

**Morning:** Review PR → merge to `main`.

### Mac Mini one-time setup (if not done)

```bash
git clone https://github.com/appopoleisStudios/karjat-farms.git ~/projects/karjat-farms
# Ensure Hermes Moraen gateway running on Mac Mini
```

---

## Step 2 — Read the master plan

| Section | Topic |
|---|---|
| Executive summary | Vision, constraints, timeline |
| §1 | Engine + Farming Engine decision |
| §2 | Architecture |
| §4–4C | MVP phases, GeoEcosystem, land economy |
| §6–8 | Financial model, India PROGA, global offshore |
| §12–13 | Documentation manifest + handoff |

On Mac Mini, copy or open the plan from GitHub/Notion if synced. Linux path:

```
/home/moraen/.cursor/plans/groundwork_game_plan_e9f1bee0.plan.md
```

---

## Step 3 — Write 8 P0 docs

Fill in the placeholder files. **Do not start Unity until these are done.**

| # | Doc | Path | Acceptance criteria |
|---|---|---|---|
| 1 | Documentation index | [docs/README.md](README.md) | P0 links present; checkboxes marked done |
| 2 | GDD | [docs/gdd/GDD.md](gdd/GDD.md) | ≥800 words: vision, pillars, core loop, MVP scope, personas |
| 3 | Architecture | [docs/tech/architecture.md](tech/architecture.md) | System diagram; dual-build IN vs GLOBAL |
| 4 | Repo structure | [docs/tech/repo-structure.md](tech/repo-structure.md) | Folder tree; gitignore rules |
| 5 | Farming Engine audit | [docs/tech/farming-engine-audit.md](tech/farming-engine-audit.md) | Keep/Strip/Replace table per FE system |
| 6 | Time system | [docs/gdd/time-system.md](gdd/time-system.md) | 20 min/day; 90 day/year; IST; Kharif/Rabi |
| 7 | Karjat region bible | [docs/geo/karjat-region-bible.md](geo/karjat-region-bible.md) | 6 MVP crops, water, mandi, chicks starter |
| 8 | Crop data | [docs/karjat-economy/crops.json](karjat-economy/crops.json) + [crops.md](karjat-economy/crops.md) | 6 crops; valid JSON; mandi refs |

### Source material

| File | Use |
|---|---|
| [index.html](../index.html) | `CROPS` object (lines 174–178) |
| [sprites3/](../sprites3/) | Pixel art reference |
| [README.md](../README.md) | Prototype status |

---

## Step 4 — Log progress

Append to [docs/dev-log.md](dev-log.md) after each session.

---

## Step 5 — Ship via PR

```bash
git add docs/
git commit -m "docs: complete Phase 0 P0 documentation"
git push -u origin docs/phase0-p0
gh pr create --title "docs: Phase 0 P0 foundation" --body "Completes 8 P0 docs for Week 1."
```

Merge to `main` after review.

---

## Phase 1 preview (after P0 docs merged)

On Mac Mini:

1. Install Unity 2022.3 LTS + Android module
2. Purchase Farming Engine ($49), create `groundwork-unity/`
3. Install Unity MCP (Funplay or CoplayDev — see [dev-workflow.md](tech/dev-workflow.md))
4. Configure Cursor MCP → Claude can drive Unity Editor locally
5. Feature branches → PRs → `main`

---

## Tailscale reference

| Machine | IP | Role |
|---|---|---|
| Mac Mini | `100.127.150.60` | **Primary dev** |
| moraen-Home | `100.99.243.39` | Secondary / backup SSH |
| umar-asus | `100.79.34.78` | Production web server |
