# PM Doc Review — Phase 0 (`docs/phase0-p0`)

**Reviewer:** Cursor (senior dev / PM)  
**Next reviewer:** Claude (SA audit via `claude_bridge` or PR comments)  
**Trainee:** Arsalan — product decisions on flagged questions  
**Rule:** PM reviews and fixes before every push; Claude devil's-advocates; no merge until SA sign-off.

---

## SDLC loop (docs)

```mermaid
sequenceDiagram
  participant M as Moraen bot
  participant PM as Cursor PM
  participant GH as GitHub PR
  participant SA as Claude SA
  participant T as Arsalan trainee

  M->>M: overnight doc commits on branch
  PM->>PM: read diff vs HANDOFF acceptance table
  PM->>GH: push + open PR (always from moraen-Home)
  SA->>GH: audit — devil's advocate, gaps, risks
  PM->>GH: address SA comments; revise docs
  SA->>GH: approve or request changes
  T->>GH: merge to main (after SA pass)
```

**Hard rules:**
- Moraen **never** runs `gh pr create` — push commits only; PM opens PR from Linux laptop.
- Moraen **never** merges to `main`.
- Claude SA owns merge after audit (per Arsalan 2026-06-05).

---

## Night 1 review summary

| Doc | Verdict | PM actions taken |
|---|---|---|
| [time-system.md](../gdd/time-system.md) | **Revise** | Fixed game-year math (1800 real-min, not 90); documented prototype `growTime` = real minutes; escalated unit schism |
| [repo-structure.md](../tech/repo-structure.md) | **Accept with fixes** | Fixed VPS2 → umar-asus; branch merge rule → SA audit |
| [gtm-twitter-intel-research.md](../ops/gtm-twitter-intel-research.md) | **Accept** | New — no blockers |
| [moraen-model-routing.md](../ops/moraen-model-routing.md) | **Accept** | Updated fallback stack (OR paid → Groq → Ollama); removed broken NIM Llama fallback |

---

## Devil's advocate — questions for Claude SA

### Time system

1. **Unit schism:** `index.html` grows crops in **real minutes**; `crops.json` declares `timeUnit: "game-minutes"`. If we ship Unity without resolving this, Farming Engine tuning will be wrong on day one. Force a written decision: A/B/C from [time-system.md §4](../gdd/time-system.md)?

2. **90-day year vs Maharashtra seasons:** Kharif mapped to game-days 1–48 of 90 — is that enough Rabi/Zaid resolution for a game marketed as “authentic Karjat”? Or do we need real-week mapping?

3. **Offline catch-up:** “Fast-forward to completed, no retroactive income” — does this invite exploit (plant, offline 3 days, harvest wall)? Should server authority be Phase 2 blocker?

4. **IST cosmetic clock:** Players in Dubai or London see IST sky colors — intentional cultural anchor or confusing?

### Repo structure

5. **`groundwork-unity/` not in repo yet** — Phase 1 handoff assumes it exists. Add explicit “create on Phase 1 day 1” checklist?

6. **Git LFS unset** — committing `sprites3/` PNGs without LFS may bloat repo before Unity imports. SA: require LFS before Phase 1 merge?

### Product / scope

7. **Paddy + nachni stubs** — MVP says 6 crops; 2 are null params. Is “4 playable + 2 teaser” acceptable for India social launch narrative?

8. **Moraen standing goals** — yolo Stardew goals caused Telegram spam + wrong work. SA: ban open-ended goals in Hermes config?

---

## Acceptance gaps (still open P0)

| # | Doc | Blocker |
|---|---|---|
| 1 | GDD | ≥800 words — outline only |
| 2 | architecture | diagram + dual-build — outline only |
| 3 | farming-engine-audit | Keep/Strip/Replace table empty |
| 4 | karjat-region-bible | stub |
| 5 | crops.json / crops.md | 4 complete, 2 stubs |
| 6 | README checkboxes | 2/8 done after PM pass |

---

## Claude SA checklist (copy into PR review)

- [x] Every **Open Question** in time-system has owner + decision or explicit defer (§8 table)
- [x] growTime unit schism resolved as **defer Phase 1** with Model B target
- [x] Season calendar rebalanced + caveat in time-system §3
- [ ] repo-structure machine roles match dev-workflow.md — **PM fixed 2026-06-05**
- [ ] No contradictions between HANDOFF acceptance table and doc status flags
- [x] ops/ model routing matches live Mac Mini config (no NIM Llama fallback)

**SA audit:** [sa-audit-night1.md](sa-audit-night1.md) — re-audit for merge.

---

## Changelog

| Date | Who | Note |
|---|---|---|
| 2026-06-05 | Cursor PM | Night 1 review; math fixes; SA questions drafted |
