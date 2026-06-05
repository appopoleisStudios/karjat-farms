# Handoff — Moraen (Phase 0 P0 Docs)

**Assignee:** Moraen  
**Primary machine:** Mac Mini (`arsalans-mac-mini`)  
**Repo:** https://github.com/appopoleisStudios/karjat-farms  
**Branch:** `docs/phase0-p0`  
**Workflow:** [dev-workflow.md](tech/dev-workflow.md)  
**Time budget:** ~10–20 hrs/week, Week 1  
**Out of scope:** Unity install, Supabase, geo ingest, legal docs

---

## How we work (read this first)

**Mac Mini is the primary dev machine.** Docs and code both live in git on GitHub — not on the Linux laptop.

| Phase | Where you work | Tooling |
|---|---|---|
| **Phase 0 (now)** | Mac Mini | Cursor locally, git PRs — no Unity yet |
| **Phase 1+** | Mac Mini | Cursor + Unity 2022.3 + Unity MCP (Claude drives Editor) |

You do **not** need SSH into the Linux laptop for normal work. Clone the repo on Mac Mini and open it in Cursor.

Full workflow design: [docs/tech/dev-workflow.md](tech/dev-workflow.md)

---

## Step 1 — Mac Mini one-time setup

```bash
# 1. Clone repo
brew install git gh        # if missing
gh auth login
git clone https://github.com/appopoleisStudios/karjat-farms.git ~/projects/karjat-farms
cd ~/projects/karjat-farms
git checkout docs/phase0-p0

# 2. Open in Cursor
cursor ~/projects/karjat-farms
```

If `docs/phase0-p0` is not on GitHub yet, ask Arsalan to run on the Linux laptop:

```bash
git push -u origin docs/phase0-p0
```

### Optional: SSH backup path to Linux laptop

Only if you need files that aren't in git yet:

```bash
# After placing ~/.ssh/cursor_macmini_moraen_cto (chmod 600)
bash scripts/moraen-mac-setup.sh
ssh groundwork-linux
```

This is **not** the primary workflow. See [dev-workflow.md](tech/dev-workflow.md).

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
