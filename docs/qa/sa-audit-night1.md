# SA Audit — Night 1 (`docs/phase0-p0` PR #1)

**Auditor:** Claude SA  
**Date:** 2026-06-05  
**Scope:** `time-system.md`, `repo-structure.md`, PM review packet, model routing  
**Initial verdict:** Request changes — 3 blockers, 4 advisories  
**PM response:** Same date — blockers addressed in follow-up commit

---

## Blockers (resolved by PM)

| # | Finding | Fix |
|---|---|---|
| B1 | `time-system.md` §8 — 6 open questions without owners | → §8 decisions table with owner + defer/resolve per row |
| B2 | `repo-structure.md` §6 — merge rule said "SA + trainee review" | → Claude SA owns merge; PM opens PR from moraen-Home |
| B3 | `repo-structure.md` §7 — moraen-Home "docs-only" vs dev-workflow PR seat | → Aligned: moraen-Home = Cursor PM + `gh pr create` |

---

## Advisories (addressed)

| # | Finding | PM action |
|---|---|---|
| A1 | Kharif 48/90 days overshoots Konkan monsoon; Rabi undersold | Rebalanced §3: Kharif 1–40, Rabi 41–75, Zaid 76–90 + marketing caveat |
| A2 | repo-structure vs dev-workflow machine role friction | §7 rewritten; dev-workflow moraen-Home row updated |
| A3 | Offline catch-up exploit | §7 edge case: cap 1 game-day progress per real-day absent (Phase 1) |
| A4 | Open-ended Hermes goals | Banned in moraen-model-routing §6b + moraen-cto-tasks |

---

## Passes (unchanged)

- growTime schism properly deferred to Phase 1 with SA recommendation (Model B)
- Model routing matches H-032 Mac Mini config (no NIM Llama fallback)

---

## Devil's advocate — SA recommendations adopted

| Q | SA recommendation | PM disposition |
|---|---|---|
| Q1 growTime | Model B (game-calendar) | **Deferred Phase 1** — validate pacing in playtest first |
| Q2 offline | Exploit risk; cap fast-forward | **Accepted** — Phase 1 client cap; server sim Phase 2 |
| Q3 paddy/nachni | 4+2 teaser OK soft launch | **Accepted** — Coming Soon UI; paid listing needs 6 playable |
| Q8 Hermes goals | Ban open-ended / yolo | **Accepted** — §6b overnight goal template |

---

## Re-audit checklist (Claude SA)

- [x] §8 decisions table complete — no orphan questions
- [x] §3 season split + caveat satisfies authenticity concern
- [x] repo-structure §6–§7 matches coordination.md + dev-workflow.md (PM cross-doc pass 2026-06-05)
- [x] moraen-model-routing §6b present
- [ ] Claude SA formal GitHub review posted
- [ ] Ready to merge PR #1 to `main`
