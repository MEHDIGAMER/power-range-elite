You are running /power-range-escalate.

USE THIS ONLY WHEN:
Power-Range delivered code → claimed PASSED → you tested → it still does not work.

This sends the failed code to four completely different AI models.
Each reviews independently. You get four diagnoses. The loop breaks.

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

## STEP 2 — CALL FOUR EXTERNAL MODELS

Run all four calls. Collect all four responses.
Each model receives the same package cold. No shared context between them.

CALL 1 — GPT-4o (strong at logic errors and wrong calculations):
```bash
curl https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"gpt-4o\",
    \"messages\": [
      {
        \"role\": \"system\",
        \"content\": \"You are a senior software engineer doing an independent code review. You have no prior context. Review only what you are given. Be specific about file, function, and line number when identifying issues.\"
      },
      {
        \"role\": \"user\",
        \"content\": \"TASK THIS CODE WAS SUPPOSED TO DO:\n[paste SESSION SPEC]\n\nCODE THAT WAS DELIVERED:\n[paste actual code content]\n\nBUG REPORTED BY USER:\n[paste user's description]\n\nQUESTION: What is wrong with this code? Why does it not do what the task requires?\"
      }
    ]
  }"
```

CALL 2 — Gemini (strong at integration mismatches and API shape errors):
```bash
curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$GEMINI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"contents\": [{
      \"parts\": [{
        \"text\": \"You are a senior software engineer. Independent code review — no prior context.\n\nTASK THIS CODE WAS SUPPOSED TO DO:\n[paste SESSION SPEC]\n\nCODE DELIVERED:\n[paste actual code]\n\nBUG REPORTED:\n[paste user description]\n\nWhat is wrong and why does it not work?\"
      }]
    }]
  }"
```

CALL 3 — DeepSeek (strong at silent bugs that look correct on the surface):
```bash
curl https://api.deepseek.com/chat/completions \
  -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"deepseek-chat\",
    \"messages\": [
      {\"role\": \"system\", \"content\": \"Senior software engineer. Independent code review. No prior context. Be specific about file and line number.\"},
      {\"role\": \"user\", \"content\": \"TASK:\n[paste SESSION SPEC]\n\nCODE:\n[paste actual code]\n\nBUG:\n[paste user description]\n\nWhat is wrong and why?\"}
    ]
  }"
```

CALL 4 — Grok (strong at edge cases and unusual states):
```bash
curl https://api.x.ai/v1/chat/completions \
  -H "Authorization: Bearer $XAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"grok-3\",
    \"messages\": [
      {\"role\": \"system\", \"content\": \"Senior software engineer. Independent code review. No prior context.\"},
      {\"role\": \"user\", \"content\": \"TASK:\n[paste SESSION SPEC]\n\nCODE:\n[paste actual code]\n\nBUG:\n[paste user description]\n\nWhat is wrong and why?\"}
    ]
  }"
```

---

## STEP 3 — SYNTHESIZE AND REPORT TO USER

Read all four responses. Identify patterns.

Tell user:

```
=== ESCALATION VERDICT ===
Bug: [user's description]

GPT-4o diagnosis:
[their finding — summarized in 2-3 sentences]

Gemini diagnosis:
[their finding]

DeepSeek diagnosis:
[their finding]

Grok diagnosis:
[their finding]

CONSENSUS:
All agree on: [if anything]
Split (2-2 or 3-1): [describe]
No consensus: [surface all four]

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

If consensus is HIGH:
Tell user: "Spawning a targeted FIX session with the diagnosis pre-loaded."
Spawn /power-range in FIX mode with the root cause already identified in the brief.

If consensus is SPLIT:
Tell user the split and ask: "Which diagnosis matches what you're seeing? I'll fix based on your selection."
Wait for user to select. Then spawn targeted FIX.

If no consensus:
Present all four to user. Recommend which to try first and explain why.
Wait for user decision. Spawn targeted FIX.

---

## STEP 5 — MANDATORY MISTAKES.MD UPDATE

After the fix is confirmed working, add to MISTAKES.md:

```
### Mistake: [short descriptive name]
What happened: Power-Range delivered this as working — it was not.
Root cause: [what was actually wrong]
Why Power-Range missed it: [honest assessment — silent failure? wrong assumption? business rule misapplied?]
Caught by: GPT-4o / Gemini / DeepSeek / Grok
Rule that prevents it: [specific actionable rule for future sessions]
First seen: [today's date]
```

This entry is read by every agent at every future session open.
The miss becomes permanent protection.
