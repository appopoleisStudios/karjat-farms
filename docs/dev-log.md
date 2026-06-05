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
- Three-agent model: Moraen bot (free overnight docs/PRs), Cursor interactive (Unity MCP), Arsalan (review/merge).
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

<!-- Template for future sessions:

## YYYY-MM-DD — Session title
- What I did (1 sentence)
- What blocked me (1 sentence, or "none")
- Next session (1 sentence)

-->