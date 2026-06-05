# Moraen CTO Bot — Model Routing for GroundWork

**Bot:** Telegram `@moraen_cto_bot` · Mac Mini Hermes `~/.hermes/profiles/cto/`  
**Platform reference:** `ai-router/docs/moraen-model-optimisation-plan.md`  
**Failure runbook:** `ai-router/docs/moraen-cto-provider-failure-runbook.md`

---

## TL;DR — what to use (not MiniMax M2.7 as primary)

| GroundWork task | Best model | Provider | Why |
|---|---|---|---|
| **Overnight doc sprints** (read plan + 8 files) | `deepseek-v4-flash` | CrofAI primary | **1M context**, cheap long outputs ($0.21/1M completion vs M2.7 $0.95) |
| **JSON / crops / structured data** | `qwen/qwen3-next-80b-a3b-instruct:free` | OpenRouter (delegate) | Best free 80B coding/structure model |
| **Simple Telegram acks** ("got it", status) | `glm-4.7-flash` or `qwen3.5-9b` | CrofAI free | Fast, $0, smart-routing tier |
| **Hard docs** (GDD, architecture) | `z-ai/glm-5.1` | **NVIDIA NIM** | Best quality when prose must be right |
| **PR review before you merge** | `deepseek/deepseek-r1:free` | OpenRouter | Reasoning chain for gaps/errors |
| **Emergency / CrofAI 401** | `llama-3.3-70b-versatile` | Groq | Reliable fallback (see runbook) |

**Demote `minimaxai/minimax-m2.7`:** keep as **short-task fallback only** (quick replies &lt;20 tool turns). It **times out at ~84k tokens** on long SDLC threads — bad for overnight GroundWork goals.

---

## Recommended Moraen CTO stack for GroundWork

```yaml
# ~/.hermes/profiles/cto/config.yaml — GroundWork-optimised (conceptual)

model:
  default: deepseek-v4-flash          # CrofAI — 1M ctx, doc sprints
  provider: crofai
  base_url: https://crof.ai/v1
  max_tokens: 8192

fallback_model:
  # Tier 1 — cheap premium overflow
  - provider: crofai
    model: gemma-4-31b-it

  # Tier 2 — NVIDIA NIM quality (your NVAPI key)
  - provider: nvidia
    base_url: https://integrate.api.nvidia.com/v1
    model: z-ai/glm-5.1

  # Tier 3 — free overflow
  - provider: openrouter
    model: google/gemma-4-31b-it:free

  # Tier 4 — permanent free
  - provider: crofai
    model: glm-4.7-flash

  # Tier 5 — Groq emergency (not M2.7 first)
  - provider: groq
    model: llama-3.3-70b-versatile

  # Short replies only — last resort
  - provider: nvidia
    model: minimaxai/minimax-m2.7

smart_model_routing:
  enabled: true
  max_simple_chars: 400
  cheap_model:
    model: glm-4.7-flash              # CrofAI free — "ok", "starting task"
    provider: crofai

compression:
  summary_model: gemma-4-31b-it       # NOT minimax — cheaper summaries

delegation:
  # Sub-agent for C#, JSON, boilerplate code in groundwork-unity/
  model: qwen/qwen3-next-80b-a3b-instruct:free
  provider: openrouter
  max_iterations: 25
```

Apply changes on Mac Mini only with your approval. Script reference: `ai-router/hermes_config/tools/patch_cto_model_rails.py` (opt-in).

---

## Task → model map (GroundWork)

### Phase 0 — docs (now)

| Doc / task | Model | Notes |
|---|---|---|
| `time-system.md`, `repo-structure.md` | `deepseek-v4-flash` | Spec-following, tables |
| `karjat-region-bible.md` + mandi research | `deepseek-v4-flash` | Long context for web research notes |
| `GDD.md`, `architecture.md` | **NIM `glm-5.1`** | Highest prose quality; worth NIM cost |
| `crops.json` fill | Delegate → `qwen3-next-80b:free` | Structured JSON |
| `farming-engine-audit.md` | `gemma-4-31b-it` | Table-heavy, medium complexity |
| Telegram "starting overnight" | `glm-4.7-flash` | Smart routing |

### Phase 1+ — Unity / game code

| Task | Model | Notes |
|---|---|---|
| C# ScriptableObject stubs from `crops.json` | Delegate → `qwen3-next-80b:free` | Moraen orchestrates, junior-dev writes code |
| `docs/economy/*.md` | `deepseek-v4-flash` | Long specs |
| Supabase SQL draft | Delegate → `qwen3-next-80b:free` | |
| Security-sensitive RLS review | `deepseek-r1:free` or NIM `glm-5.1` | Reasoning |
| Unity scene work | **Not Moraen chat model** — Cursor + Unity MCP (you) | |

---

## Session hygiene (avoid M2.7-style timeouts)

Before every **overnight GroundWork goal**:

1. Send `/reset` to `@moraen_cto_bot` (fresh session — no 80k-token poison)
2. One goal per session — all 8 P0 docs OK if using **deepseek-v4-flash** (1M ctx)
3. Cap `max_turns: 40` — if hit, bot reports partial PR; you continue next night
4. Bot appends `docs/dev-log.md` even on partial completion

---

## Cost for GroundWork overnight work

| Provider | GroundWork usage | Est. cost |
|---|---|---|
| CrofAI Hobby ($5/mo) | ~5–15 req/night for docs | Included in 500/day budget |
| OpenRouter free | Delegated coding/JSON | $0 |
| NVIDIA NIM | 1–2 glm-5.1 calls/night for GDD/architecture only | ~$0.50–2/mo |
| MiniMax M2.7 | Avoid as primary | Saves timeout + completion cost |

**Total GroundWork AI labor:** ~$5–7/mo on top of existing CrofAI hobby — mostly free if you use deepseek-v4-flash + OR free delegation.

---

## What NOT to do

| Bad choice | Why |
|---|---|
| MiniMax M2.7 as primary | Timeouts on long SDLC; expensive completions |
| Same session for ComfyUI + GroundWork docs | Context pollution (see runbook 2026-06-04) |
| qwen3.6-27b as fallback | HTTP 500 seen in production |
| glm-4.7-flash when credits empty without fallback chain | 401 loops — keep Groq fallback |

---

## Verify after config change

```bash
# Mac Mini
tail -30 ~/.hermes/profiles/cto/logs/gateway.error.log

# Telegram — after /reset
"GroundWork test: reply with model name and OK"
# Expect reply in <30s, not "model provider failed"
```

---

## References

- Full stack plan: `ai-router/ai-router/docs/moraen-model-optimisation-plan.md`
- GroundWork tasks: [moraen-cto-tasks.md](moraen-cto-tasks.md)
- Dev workflow: [../tech/dev-workflow.md](../tech/dev-workflow.md)
