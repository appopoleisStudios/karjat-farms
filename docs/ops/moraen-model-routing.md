# Moraen CTO Bot — Model Routing for GroundWork

**Bot:** Telegram `@moraen_cto_bot` · Hermes `~/.hermes/profiles/cto/`  
**Harness:** [NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent) v0.6 profiles  
**Constraint:** **No CrofAI, no Groq.** Only:
1. **NVIDIA NIM** free hosted endpoints (`provider: nvidia`, `NVIDIA_API_KEY`)
2. **OpenRouter** `:free` models (`provider: openrouter`)
3. **Ollama on Linux PC GPU** (`provider: custom`, Tailscale `100.79.34.78:11434`)

---

## Read this first — Hermes is not “any OpenAI API”

Hermes is an **agent harness** with ~40 tool turns, streaming, compression, and Telegram gateway. A model can be “free on OpenRouter” and still **fail in production** if:

| Failure mode | Symptom | Example |
|---|---|---|
| **Empty decode** | Telegram: “no response generated” (H-014) | Reasoning models put text in `reasoning_content`, not `content` |
| **No tool_calls** | Raw JSON in chat, tools never run | Server lacks tool-calling; llama.cpp without `--jinja` |
| **Context too small** | Silent truncation, broken tool schemas | Ollama default 32k — Hermes requires **≥64k** with tools |
| **Timeout / 429** | “model provider failed after retries” | Long sessions (~84k+ tokens) on M2.7 — **not a decode bug** |

**Operational rule:** Only promote a model after a **Hermes smoke test** on Mac Mini (see §7). Do not copy generic “best free model” lists from blogs.

---

## Evidence table (honest)

| Model | Provider in Hermes | GroundWork fit | Evidence |
|---|---|---|---|
| **`minimaxai/minimax-m2.7`** | `nvidia` | **Primary orchestrator** | **PROVEN** — you run it today; Hermes decodes; fails on **long context timeout / 429**, not empty replies |
| `minimax/minimax-m2.5:free` | `openrouter` | Fallback orchestrator | **LIKELY** — same vendor family; smoke test before relying on it |
| `meta-llama/llama-3.3-70b-instruct:free` | `openrouter` | Fallback docs | **LIKELY** — Llama 3.x native tool calling per Hermes docs |
| `meta/llama-3.3-70b-instruct` | `nvidia` | Fallback docs | **LIKELY** — NIM free endpoint; smoke test |
| `nvidia/nemotron-3-super-120b-a12b` | `nvidia` | Optional primary test | **HERMES-DOCUMENTED** — official NIM example in Hermes provider docs |
| `qwen/qwen3-next-80b-a3b-instruct:free` | `openrouter` | **junior-dev delegate only** | **LIKELY for code/JSON** — do not use as Moraen orchestrator until smoke tested |
| `qwen2.5-coder:14b-instruct-q4_K_M` | `custom` → Ollama Linux PC | Code delegate fallback | **CONDITIONAL** — only if `num_ctx ≥ 65536` on Linux PC |
| `google/gemma-4-31b-it:free` | `openrouter` | ❌ not recommended yet | **UNVERIFIED** — may need thinking/`extra_body`; not proven in your Hermes CTO logs |
| `deepseek/deepseek-r1:free` | `openrouter` | ❌ orchestrator | **RISKY** — reasoning output may not surface in Telegram (`reasoning_content`) |
| `qwen3.6-27b` | any | ❌ | **FAILED** — HTTP 500 in 2026-06-04 incident |
| CrofAI / Groq | — | ❌ banned | Out of scope |

---

## Recommendation — keep M2.7, fix operations not decode

You were right: **MiniMax M2.7 on NIM works with Hermes.** The 2026-06-04 incident was **session bloat + timeout at ~84k tokens**, not “Hermes can’t decode M2.7.”

**Do not replace M2.7** with unverified OpenRouter models. Instead:

1. **`/reset`** before every overnight GroundWork goal  
2. **Split large goals** (e.g. 4 docs per night, not 8 in one thread)  
3. **Retry on 429** in the Telegram goal text (Moraen already does this well)  
4. Add **verified fallbacks only** (below)

---

## Recommended Hermes config (Mac Mini `~/.hermes/profiles/cto/config.yaml`)

Use Hermes **native providers** — not `provider: custom` for NIM.

```yaml
model:
  provider: nvidia
  default: minimaxai/minimax-m2.7
  max_tokens: 8192
  # Do NOT set context_length unless auto-detect is wrong

fallback_model:
  # Tier 1 — same family, free OR overflow
  - provider: openrouter
    model: minimax/minimax-m2.5:free

  # Tier 2 — Llama 3.x tool-native (smoke test first)
  - provider: openrouter
    model: meta-llama/llama-3.3-70b-instruct:free

  # Tier 3 — NIM alternate
  - provider: nvidia
    model: meta/llama-3.3-70b-instruct

  # Tier 4 — Linux PC GPU (after num_ctx fix — see §6)
  - provider: custom
    base_url: http://100.79.34.78:11434/v1
    model: qwen2.5-coder:14b-instruct-q4_K_M

agent:
  max_turns: 40
  reasoning_effort: medium

display:
  streaming: true
  show_reasoning: false
  tool_progress: all

compression:
  summary_model:
    provider: nvidia
    model: google/gemma-3-27b-it

smart_model_routing:
  enabled: true
  max_simple_chars: 400
  cheap_model:
    provider: nvidia
    model: google/gemma-3-27b-it
    max_tokens: 1024
```

**`.env` (no CrofAI):**

```bash
NVIDIA_API_KEY=nvapi-...
OPENROUTER_API_KEY=sk-or-...
# Do NOT set CROFAI_API_KEY or GROQ_API_KEY for GroundWork rails
```

Restart: `launchctl kickstart -k gui/$(id -u)/ai.hermes.gateway-cto`

**YAML key note:** Live profile may use `fallback_providers` (repo template) or `fallback_model` (patch script). Check live file — gateway reads `config.yaml` on Mac Mini. Align with whatever your Hermes version expects (gateway supports both per provider-runtime docs).

---

## Task → model map (GroundWork)

### Moraen orchestrator (Telegram overnight)

| Task | Model | Session rule |
|---|---|---|
| Doc writing (markdown) | **NIM M2.7** | `/reset`; ≤4 docs per session |
| Mandi research + region bible | **NIM M2.7** | Same session OK if under ~60k tokens |
| Git commit + PR open | **NIM M2.7** | Tools must execute — smoke test after config change |
| Telegram “starting…” | NIM `gemma-3-27b-it` | smart routing only |

On **429:** retry with backoff (your workflow). On **timeout:** `/reset`, continue next slice — do not switch model unless fallbacks also fail.

### junior-dev subagent (`hermes -p junior-dev chat`)

Spawn for **bounded code/JSON** — keeps M2.7 context clean:

| Task | Model | Provider |
|---|---|---|
| `crops.json`, C# stubs, SQL drafts | `qwen/qwen3-next-80b-a3b-instruct:free` | openrouter |
| Fallback if OR rate-limits | `qwen2.5-coder:14b-instruct-q4_K_M` | Ollama Linux PC (64k ctx) |

Configure in `~/.hermes/profiles/junior-dev/config.yaml` — **separate profile**, separate smoke test.

### Cursor + Unity MCP (you)

Not Moraen chat models — interactive only.

---

## Linux PC Ollama — required before use

Hermes requires **≥64,000 token context** for tool use ([Hermes provider docs](https://hermes-agent.nousresearch.com/docs/integrations/providers)).

Default `qwen2.5-coder:14b` pulls often ship with **32k** — will break or be rejected.

**On umar-asus (`100.79.34.78`):**

```bash
# Modelfile or serve with expanded context
OLLAMA_HOST=0.0.0.0:11434 ollama serve

# Example: recreate with 64k context (adjust per model)
# num_ctx 65536 in Modelfile
```

**Verify from Mac Mini:**

```bash
curl -s http://100.79.34.78:11434/api/tags
hermes -p cto chat -Q -q "Use one file tool, reply OK"  # with Ollama as forced fallback only after test
```

Use `provider: custom` + full `/v1` base URL — Hermes maps `ollama` alias to `custom`.

---

## Overnight Telegram template (M2.7-safe)

```text
/reset

GroundWork overnight — karjat-farms
Repo: appopoleisStudios/karjat-farms
Branch: docs/phase0-p0

Goals (max 4 docs this session):
1. docs/gdd/time-system.md
2. docs/tech/repo-structure.md
3. docs/geo/karjat-region-bible.md (partial OK)
4. Update docs/dev-log.md

On HTTP 429: wait 60s, retry up to 5x per step.
On timeout: commit partial work, push, report what remains.

Read: docs/HANDOFF-MORAEN.md
Do NOT: merge main, Unity, secrets
```

Night 2: remaining docs in a **fresh `/reset` session**.

---

## §7 — Mandatory smoke test before any rail change

Tracker item **H-032**. Run on Mac Mini:

```bash
# 1. Gateway healthy
tail -30 ~/.hermes/profiles/cto/logs/gateway.error.log

# 2. Tool loop + visible reply
hermes -p cto chat -Q --accept-hooks -q \
  "List files in /home/moraen/projects/karjat-farms/docs and reply with OK plus model name."

# 3. Telegram
# Send short test after /reset — must reply <30s, not empty
```

**Pass criteria:**
- [ ] Tool call executes (not raw JSON in message)
- [ ] User-visible Telegram text (not H-014 empty turn)
- [ ] `gateway.error.log` shows 200, not 401/500 loop
- [ ] Same test on each new fallback model before adding to chain

---

## What we deliberately avoid

| Model / pattern | Why |
|---|---|
| CrofAI | Banned by you; 401 when credits empty |
| Groq | Banned by you |
| OR `deepseek-r1:free` as Moraen primary | Reasoning decode risk in Hermes |
| OR `gemma-4-31b:free` as primary | Unverified tool loop; previous recommendation was premature |
| Long sessions without `/reset` | M2.7 timeout ~84k tokens — operational, not model decode |
| `provider: custom` for build.nvidia.com | Use `provider: nvidia` — Hermes attaches NIM billing headers |

---

## Cost

| Source | Cost |
|---|---|
| NIM free tier (rate-limited) | $0 |
| OpenRouter `:free` | $0 |
| Ollama Linux PC GPU | $0 (+ electricity) |

---

## References

- Hermes providers: https://hermes-agent.nousresearch.com/docs/integrations/providers  
- Hermes provider runtime: https://github.com/NousResearch/hermes-agent/blob/main/website/docs/developer-guide/provider-runtime.md  
- Incident runbook: `ai-router/docs/moraen-cto-provider-failure-runbook.md`  
- Evolution tracker H-014, H-016, H-032: `ai-router/docs/hermes-evolution-tracker.md`  
- GroundWork tasks: [moraen-cto-tasks.md](moraen-cto-tasks.md)
