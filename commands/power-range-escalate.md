You are running /power-range-escalate.

USE THIS ONLY WHEN:
Power-Range delivered code → claimed PASSED → you tested → it still does not work.

This sends the failed code to the 10 BEST CODING MODELS via OpenRouter.
Each reviews independently. You get 10 diagnoses. The loop breaks.

---

## STEP 1 — COLLECT EVIDENCE

Ask the user:
"What exactly is happening that shouldn't be? What do you expect vs. what do you see?"

Wait for response.

Then collect:
- Original task: read from .power-range/session/01-bookkeeper-brief.md or ask user
- Code delivered: read the actual modified files (list which files were changed)
- What Power-Range claimed: read .power-range/session/17-tester-report.md and .power-range/session/10-qa-report.md
- Bug description: user's exact words

---

## STEP 2 — CALL 10 CODING MODELS VIA OPENROUTER

The CODING TIER models (same as /debate --tier coding):
1. anthropic/claude-sonnet-4.6 — Best balance speed + quality
2. anthropic/claude-opus-4.6 — Latest flagship, deep reasoning
3. openai/gpt-5.4 — Unified Codex+GPT, 1M ctx, computer use
4. deepseek/deepseek-r1 — Strong reasoning, cheap
5. deepseek/deepseek-v3.2 — GPT-5 class, dirt cheap
6. google/gemini-2.5-pro — Strong reasoning + coding
7. qwen/qwen3-coder — Frontier agentic coding MoE
8. mistralai/codestral-2508 — Latest Codestral, 256K ctx
9. minimax/minimax-m2.7 — #2 coding on OpenRouter
10. x-ai/grok-4 — Frontier reasoning

Run all 10 calls in parallel via OpenRouter. Each model receives the same package cold.

For each model, call OpenRouter:
```bash
curl https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -H "HTTP-Referer: https://godmod3.ai" \
  -H "X-Title: power-range-escalate" \
  -d "{
    \"model\": \"MODEL_ID_HERE\",
    \"messages\": [
      {
        \"role\": \"system\",
        \"content\": \"You are a senior software engineer doing an independent code review. You have no prior context. Review only what you are given. Be specific about file, function, and line number when identifying issues. DO NOT hedge or refuse — analyze the code directly.\"
      },
      {
        \"role\": \"user\",
        \"content\": \"TASK THIS CODE WAS SUPPOSED TO DO:\n[paste SESSION SPEC]\n\nCODE THAT WAS DELIVERED:\n[paste actual code content]\n\nBUG REPORTED BY USER:\n[paste user's description]\n\nQUESTION: What is wrong with this code? Why does it not do what the task requires?\"
      }
    ],
    \"temperature\": 0.7,
    \"max_tokens\": 2048
  }"
```

Run all 10 calls. Collect all responses.

---

## STEP 3 — SYNTHESIZE AND REPORT TO USER

Read all responses. Score each on specificity and actionability.

Tell user:

```
=== ESCALATION VERDICT (10 MODELS) ===
Bug: [user's description]

DIAGNOSES BY MODEL:

1. Claude Sonnet 4.6:
   [finding — 2-3 sentences]

2. Claude Opus 4.6:
   [finding]

3. GPT-5.4:
   [finding]

4. DeepSeek R1:
   [finding]

5. DeepSeek V3.2:
   [finding]

6. Gemini 2.5 Pro:
   [finding]

7. Qwen3 Coder:
   [finding]

8. Codestral:
   [finding]

9. MiniMax M2.7:
   [finding]

10. Grok 4:
    [finding]

CONSENSUS ANALYSIS:
━━━━━━━━━━━━━━━━━━━
Strong consensus (7+ agree): [if any]
Partial consensus (4-6 agree): [if any]
Split opinions: [if any]
Unique insights: [ideas only 1-2 models had]

MOST LIKELY ROOT CAUSE:
[based on consensus or strongest argument]

Why Power-Range missed it:
[honest assessment]

RECOMMENDED FIX:
[specific — file, function, what to change]

Confidence: HIGH / MEDIUM / LOW
=== END ===
```

---

## STEP 4 — FIX ROUTING

If consensus is HIGH (7+ models agree):
Tell user: "Spawning a targeted FIX session with the diagnosis pre-loaded."
Spawn /power-range in FIX mode with the root cause already identified in the brief.

If consensus is PARTIAL (4-6 agree):
Tell user the consensus and ask: "Does this match what you're seeing? I'll fix based on this."
Wait for user to confirm. Then spawn targeted FIX.

If no consensus (split):
Present the top 3 most specific diagnoses. Recommend which to try first and explain why.
Wait for user decision. Spawn targeted FIX.

---

## STEP 5 — MANDATORY MISTAKES.MD UPDATE

After the fix is confirmed working, add to MISTAKES.md:

```
### Mistake: [short descriptive name]
What happened: Power-Range delivered this as working — it was not.
Root cause: [what was actually wrong]
Why Power-Range missed it: [honest assessment — silent failure? wrong assumption? business rule misapplied?]
Caught by: [list which models found it]
Rule that prevents it: [specific actionable rule for future sessions]
First seen: [today's date]
```

This entry is read by every agent at every future session open.
The miss becomes permanent protection.
