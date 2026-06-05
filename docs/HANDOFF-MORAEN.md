# Handoff — Moraen (Phase 0 P0 Docs)

**Assignee:** Moraen (Mac Mini — `arsalans-mac-mini`, Tailscale `100.127.150.60`)  
**Repo host:** moraen-Home Linux (`100.99.243.39`) — `/home/moraen/projects/karjat-farms`  
**Branch:** `docs/phase0-p0`  
**Time budget:** ~10–20 hrs/week, Week 1  
**Out of scope:** Unity install, Supabase, geo ingest, legal docs, Agent API OpenAPI

---

## Step 1 — Mac Mini one-time SSH setup

### 1a. Get the private key

The private key **must** live on your Mac Mini. It cannot be committed to git.

Copy `cursor_macmini_moraen_cto` (private key, no `.pub` suffix) from a secure channel:

- Ask Arsalan to AirDrop / 1Password / Signal the file from moraen-Home, **or**
- On moraen-Home (if you have physical access): `cat ~/.ssh/cursor_macmini_moraen_cto`

Place it at:

```
~/.ssh/cursor_macmini_moraen_cto
chmod 600 ~/.ssh/cursor_macmini_moraen_cto
```

### 1b. Run the setup script

Accept the Taildrop file `moraen-mac-setup.sh` from moraen-Home, then:

```bash
chmod +x ~/Downloads/moraen-mac-setup.sh   # adjust path if needed
~/Downloads/moraen-mac-setup.sh
```

Expected output: `Connected` + listing of `/home/moraen/projects/karjat-farms`.

### 1c. Manual fallback (if script fails)

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh

cat >> ~/.ssh/config <<'EOF'
Host groundwork-linux
  HostName 100.99.243.39
  User moraen
  IdentityFile ~/.ssh/cursor_macmini_moraen_cto
EOF
chmod 600 ~/.ssh/config

ssh-keyscan -H 100.99.243.39 >> ~/.ssh/known_hosts
ssh groundwork-linux 'echo Connected && ls /home/moraen/projects/karjat-farms'
```

---

## Step 2 — Open repo in Cursor (Remote SSH)

1. Cursor → **Remote SSH** → connect to `groundwork-linux` (or `moraen@100.99.243.39`)
2. Open folder: `/home/moraen/projects/karjat-farms`
3. Confirm branch: `docs/phase0-p0`

Unity Editor runs natively on Mac Mini later; all doc edits stay on Linux via Remote SSH.

---

## Step 3 — Read the master plan

Read these sections before writing anything:

| Section | Topic |
|---|---|
| Executive summary | Vision, constraints, timeline |
| §1 | Engine + Farming Engine decision |
| §2 | Architecture (Unity ↔ Supabase ↔ Oracle) |
| §4–4C | MVP phases, GeoEcosystem, land economy |
| §6 | Financial model |
| §7–8 | India PROGA + global offshore |
| §12 | Full documentation manifest |
| §13 | Original handoff spec |

**Plan file path on Linux:**

```
/home/moraen/.cursor/plans/groundwork_game_plan_e9f1bee0.plan.md
```

---

## Step 4 — Write 8 P0 docs

Fill in the placeholder files listed in [docs/README.md](README.md). Do **not** start Unity until these are done.

| # | Doc | Path | Acceptance criteria |
|---|---|---|---|
| 1 | Documentation index | [docs/README.md](README.md) | All P0 links present; status checkboxes updated to `done` when complete |
| 2 | GDD | [docs/gdd/GDD.md](gdd/GDD.md) | ≥800 words: vision, 5 GeoEcosystem pillars, core loop, MVP scope, out-of-scope, 2 player personas |
| 3 | Architecture | [docs/tech/architecture.md](tech/architecture.md) | Mermaid or ASCII diagram: Unity client ↔ Supabase ↔ Oracle; dual-build IN vs GLOBAL noted |
| 4 | Repo structure | [docs/tech/repo-structure.md](tech/repo-structure.md) | Folder tree for `groundwork-unity/`, `prototype/`, `docs/`; `.gitignore` rules; what never to commit |
| 5 | Farming Engine audit | [docs/tech/farming-engine-audit.md](tech/farming-engine-audit.md) | Table: Keep / Strip / Replace for each FE system (crops, animals, save, shop, clock, UI) |
| 6 | Time system | [docs/gdd/time-system.md](gdd/time-system.md) | 1 game-day = 20 real min; 1 game-year = 90 real days; IST display rules; Kharif/Rabi calendar gates |
| 7 | Karjat region bible | [docs/geo/karjat-region-bible.md](geo/karjat-region-bible.md) | Raigad context, 6 MVP crops, water/monsoon, mandi flavor, starter asset (chicks) |
| 8 | Crop data | [docs/karjat-economy/crops.json](karjat-economy/crops.json) + [crops.md](karjat-economy/crops.md) | Valid JSON for 6 crops; human-readable table in `.md`; mandi price refs where known |

### Source material

| File | Use |
|---|---|
| [index.html](../index.html) | `CROPS` object (lines 174–178), game loop, IST clock |
| [sprites3/](../sprites3/) | Pixel art reference for crop visuals |
| [README.md](../README.md) | Current prototype status |
| Plan §2 crop table | Paddy + Nachni MVP stubs |

---

## Step 5 — Log progress

After each session, append to [docs/dev-log.md](dev-log.md):

```markdown
## YYYY-MM-DD — Session title
- What I did (1 sentence)
- What blocked me (1 sentence, or "none")
- Next session (1 sentence)
```

---

## Step 6 — Commit (no push unless asked)

```bash
git add docs/
git commit -m "docs: complete Phase 0 P0 documentation"
```

Do **not** push to remote unless explicitly asked.

---

## Tailscale reference

| Machine | Tailscale IP | Role |
|---|---|---|
| moraen-Home | `100.99.243.39` | Repo + docs host |
| arsalans-mac-mini | `100.127.150.60` | Moraen dev machine |
| umar-asus | `100.79.34.78` | Linux PC (production server) |

---

## Questions?

Log blockers in `docs/dev-log.md` and ping Arsalan. Do not guess on legal/compliance sections — mark as `TBD` and move on.
