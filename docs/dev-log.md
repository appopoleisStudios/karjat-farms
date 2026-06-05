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

## 2026-06-05 — Model routing constraint

- No CrofAI. Moraen bot uses OpenRouter free, NVIDIA NIM free endpoints, and Ollama on Linux PC GPU (100.79.34.78) only.
- Primary: OR gemma-4-31b-it:free; coding delegate: qwen3-next-80b:free + Ollama qwen2.5-coder:14b.

## 2026-06-05 — Moraen CTO bot integrated

- Added docs/ops/moraen-cto-tasks.md and docs/coordination.md.
- Three-agent model: Moraen bot (free overnight docs/PRs), Cursor interactive (Unity MCP), Arsalan (review/merge).
- Phase 0 docs assigned to Moraen bot via Telegram overnight goals — not manual writing by default.

---

<!-- Template for future sessions:

## YYYY-MM-DD — Session title
- What I did (1 sentence)
- What blocked me (1 sentence, or "none")
- Next session (1 sentence)

-->
