# GroundWork Dev Log

Three sentences per session. Feeds GTM authenticity story.

---

## 2026-06-05 — Handoff created

- Agent on moraen-Home created Phase 0 handoff skeleton, verified SSH key auth, and sent Mac setup script via Taildrop.
- Moraen has not yet connected from Mac Mini — pending private key transfer and first Remote SSH session.
- Next: Moraen reads HANDOFF-MORAEN.md, connects via Cursor Remote SSH, and writes the 8 P0 docs.

## 2026-06-05 — Workflow redesigned

- Mac Mini confirmed as primary dev machine; GitHub is source of truth (not Linux laptop).
- Added docs/tech/dev-workflow.md: git PR SDLC, Unity MCP on Mac Mini, machine roles.
- Phase 0: clone repo on Mac Mini, Cursor locally, PR to main. Phase 1: Unity 2022.3 + Funplay/Coplay MCP.
- Retired SSH-to-Linux-laptop as primary workflow; kept as optional backup.

## 2026-06-05 — Model routing corrected (Hermes-aware)

- Previous OR gemma-4-31b primary was wrong — not smoke-tested with Hermes tool loop.
- Keep NIM minimaxai/minimax-m2.7 as primary (Hermes provider:nvidia); decode works; timeout/429 fixed by /reset + split sessions + retry.
- Fallbacks: OR minimax-m2.5:free, llama-3.3-70b:free, Ollama Linux PC only after 64k ctx + smoke test (H-032).
- No CrofAI, no Groq.

## 2026-06-05 — Moraen CTO bot integrated

- Added docs/ops/moraen-cto-tasks.md and docs/coordination.md.
- Three-agent model: Moraen bot (free overnight docs), Cursor PM (review + `gh pr create`), Claude SA (audit + merge), Arsalan (playtest + product answers).
- Phase 0 docs assigned to Moraen bot via Telegram overnight goals — not manual writing by default.

## 2026-06-05 — H-032 smoke test + Mac Mini rails applied

- Smoke-tested NIM M2.7 and Llama 3.3 via Hermes tool loop; OR `:free` fallbacks failed (404/429).
- Live CTO config: primary `provider: nvidia` / `minimaxai/minimax-m2.7`; fallback NIM Llama 3.3; CrofAI removed from chain.
- Added `NVIDIA_API_KEY` to `~/.hermes/profiles/cto/.env`; cloned `docs/phase0-p0` to Mac Mini (old Unity `Assets/` backed up locally).
- Next: Telegram `/reset` + short test message; send overnight Phase 0 goal to Moraen bot.

## 2026-06-05 — GroundWork night 1: time-system + repo-structure docs

- Completed docs/gdd/time-system.md: verified 3 game-min/real-min math, documented day/night phases (IST 5-cycle), Kharif/Rabi/Zaid seasonal gates from crops.json, crop growTime conversion table, and 4 open questions (growTime multiplier, catch-up logic, paddy/nachni nulls, day/night gates).
- Completed docs/tech/repo-structure.md: full top-level + Unity + docs folder trees, FarmingEngine import conventions, gitignore rules, branch strategy, IDE setup, and 3 open questions (Supabase schema structure, Git LFS, scripts/ vs tools/).
- Blocked on: growTime multiplier decision (needs Arsalan), paddy/nachni mandi research (Phase 1 prep), Git LFS not yet configured on repo.
- Next: night 2 — farming-engine-audit.md + karjat-region-bible.md; night 3 — GDD.md + architecture.md; night 4 — crops.json completeness + README.md.

## 2026-06-05 — PM role + GTM intel brief

- Cursor took senior dev/PM hat; Arsalan onboarded as product trainee under PM for GroundWork.
- Queried Supabase twitter intel (1k+ bookmarks); wrote GTM brief reusing Chronicler/HyperFrames/tntMan stack.
- SDLC locked: PM reviews docs + opens PR from moraen-Home; Claude SA audits (devil's advocate) and merges.

## 2026-06-05 — PM doc review (night 1)

- Fixed time-system.md: game-year = 1800 real-min (not 90); prototype growTime = real minutes vs crops.json schism.
- Fixed repo-structure VPS reference; added qa/pm-doc-review.md with SA devil's-advocate questions.
- Opened PR #1 from moraen-Home for Claude SA audit.

## 2026-06-05 — SA audit response (PR #1)

- Claude SA: request changes — 3 blockers, 4 advisories; recorded in docs/qa/sa-audit-night1.md.
- PM fixed blockers: time-system §8 decisions table, repo-structure merge + machine roles, season calendar rebalanced.
- Adopted SA guidance: offline catch-up cap, 4+2 crop teaser, ban yolo Hermes goals in model-routing §6b.

## 2026-06-06 — PM crop research + naming policy

- Researched all 6 MVP crops: mandi refs from Karjat(Raigad) APMC + Maharashtra hub data; filled paddy/nachni estimated game params in crops.json.
- Locked UI naming: **English primary**, Hindi names as Latin transliteration only (`palak`, `mooli`, `dhan`) — no Devanagari in default UI.
- Corrected paddy variety to Trombay Karjat Kolam (RARS Karjat Raigad trials); removed wrong “Karadai” label.

## 2026-06-05 — GroundWork night 2: farming-engine-audit + karjat-region-bible docs

- Completed docs/tech/farming-engine-audit.md: 16-system Keep/Strip/Replace table with TBD markers, Karjat crop injection via Resources/KarjatData/, Phase 1 import checklist, 5 open engineering questions.
- Completed docs/geo/karjat-region-bible.md: 6-crop table with Raigad/Karjat geography + monsoon water model, mandi flavor (APMC + AI trader), chicks livestock spec, T0 vs T2 fidelity distinction, 5 TBD items with PM/SA decision labels.
- Blocked on: FE class names unverified (need Phase 1 import), Agmarknet mandi prices incomplete (paddy ₹2,350–4,700 confirmed; leafy veg + nachni TBD).
- Next: night 3 — GDD.md (≥800 words) + architecture.md (system diagram + dual-build); night 4 — README checkboxes + crops.json completeness check.

## 2026-06-06 — PM integrated Moraen night 2 (Mac Mini → GitHub)

- Moraen commit `d73c59c` was local-only on Mac Mini (push blocked — no `gh auth`); PM cherry-picked content to moraen-Home.
- Night 2 docs land on PR #1 pending PM review pass + README checkbox update.

---

<!-- Template for future sessions:

## YYYY-MM-DD — Session title
- What I did (1 sentence)
- What blocked me (1 sentence, or "none")
- Next session (1 sentence)

-->
