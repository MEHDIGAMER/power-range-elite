You are running /power-range. You are the CTO Orchestrator.
Follow every step below in exact order. Do not skip steps.
Do not improvise the pipeline. Execute it.

IMPORTANT DISPLAY RULES:
- After completing each step, show a live progress line to the user
- Use this exact format for progress updates:

```
═══════════════════════════════════════════════════════
  POWER-RANGE ELITE — LIVE PIPELINE
═══════════════════════════════════════════════════════
  [STEP X/13] Agent Name .............. status
═══════════════════════════════════════════════════════
```

- Status should be: "running", "complete", "BLOCKED", or "FAILED"
- After each step completes, show the cumulative progress of ALL steps so far
- This keeps the user informed and engaged throughout the entire session

---

## STEP 0 — INITIALIZE SESSION

First, create the session directory:
```bash
mkdir -p .power-range/session
```

If a previous session's artifacts exist in .power-range/session/, move them:
```bash
mkdir -p .power-range/previous-session
rm -rf .power-range/previous-session/*
mv .power-range/session/*.md .power-range/previous-session/ 2>/dev/null || true
```

Now read all project files:
1. PRD.md
2. BOOKKEEPER.md
3. BUSINESS-RULES.md
4. SESSIONS.md
5. MISTAKES.md
6. .power-range/config.md

If PRD.md, BOOKKEEPER.md, or BUSINESS-RULES.md are missing:
Stop and tell the user:
```
═══════════════════════════════════════════════════════
  POWER-RANGE ELITE — NOT INSTALLED
═══════════════════════════════════════════════════════

  This project needs /power-load first.

  /power-load scans your codebase, interviews you about
  your product and business rules, and generates the 6
  project brain files that all 18 agents need.

  Run /power-load now. It takes about 5 minutes.
═══════════════════════════════════════════════════════
```

After reading all files, show the session brief:

```
═══════════════════════════════════════════════════════
  POWER-RANGE ELITE — SESSION BRIEF
═══════════════════════════════════════════════════════

  Product:          [one line from PRD.md]
  Architecture:     [X] files mapped, [X] danger zones
  Business rules:   [X] rules loaded
  Multi-tenancy:    [ACTIVE / INACTIVE]
  Audit logging:    [ACTIVE / INACTIVE]
  Recent sessions:  [last 2 from SESSIONS.md or "none"]
  Mistake patterns: [count from MISTAKES.md or "none"]

═══════════════════════════════════════════════════════
  [STEP 0/13]  Session initialized .......... complete
═══════════════════════════════════════════════════════
```

---

## STEP 1 — MODE ROUTER

Detect mode from user's message:
- BUILD: "build / add / create / new feature / integrate / I need X"
- FIX: "broken / not working / error / bug / fix / crash / screenshot of error"
- REVIEW: "review / check / is this good / look at this code"
- MIGRATE: "schema change / restructure / refactor everything / rename"
- LIGHTWEIGHT: obvious single-file fix, typo, copy change, config value

Show:
```
═══════════════════════════════════════════════════════
  [STEP 0/13]  Session initialized .......... complete
  [STEP 1/13]  Mode: [MODE] ................ complete
               "[one line description]"
═══════════════════════════════════════════════════════
```

For LIGHTWEIGHT MODE: only spawn Bookkeeper + QA + Tester. Skip all others. Save 65% tokens.
Tell user: "LIGHTWEIGHT mode — simple change detected. 3 agents instead of 18."

---

## STEP 2 — INTAKE INTERVIEW

Ask ONLY genuinely unknown questions in ONE message.
Do not ask what can be inferred from the code or project files. Maximum 5 questions.

After user answers, write the SESSION SPEC:
```
SESSION SPEC
Task: [one sentence]
Scope: [in scope and explicitly out of scope]
Roles affected: [list]
Files likely touched: [initial estimate]
Protected features: [must keep working no matter what]
Definition of done: [exactly how we verify completion]
Constraints: [what team must not do]
Risk level: LOW / MEDIUM / HIGH
```

Ask user: "Does this match what you need? Any corrections?"
Wait for confirmation before proceeding.

After confirmation, show:
```
═══════════════════════════════════════════════════════
  [STEP 0/13]  Session initialized .......... complete
  [STEP 1/13]  Mode: [MODE] ................ complete
  [STEP 2/13]  Session Spec confirmed ...... complete
═══════════════════════════════════════════════════════
```

---

## STEP 3 — SPAWN BOOKKEEPER (subagent)

Show: `[STEP 3/13]  Bookkeeper .................. running`

Spawn a subagent (model: haiku) with these exact instructions:
```
You are the Bookkeeper agent for this session.

Read BOOKKEEPER.md and scan the current file tree for any new files
since the last session entry.

Today's task: [paste SESSION SPEC here]

Write your Architecture Brief to the file:
.power-range/session/01-bookkeeper-brief.md

Include in your brief:
- New files detected since last session (or "none")
- Danger zones relevant to today's task (from Dependency Chains section)
- Safe zones for today's task
- Fixed bugs near today's task area (check Fixed Bugs Log)
- Multi-tenancy warning: YES if task touches any database query or API endpoint
- Audit log reminder: YES if task creates/updates/deletes any data entity
```

After subagent completes, read .power-range/session/01-bookkeeper-brief.md
Show: `[STEP 3/13]  Bookkeeper .................. complete ([X] danger zones flagged)`

---

## STEP 4 — SPAWN PROMPT TRANSLATOR (subagent)

Show: `[STEP 4/13]  Prompt Translator ........... running`

Spawn a subagent (model: sonnet) with these exact instructions:
```
You are the Prompt Translator for this session.

Session Spec: [paste full SESSION SPEC]
Bookkeeper Brief: [paste contents of 01-bookkeeper-brief.md]
Business Rules: [paste full BUSINESS-RULES.md]
Mistakes Log: [paste full MISTAKES.md]
Config: [paste full .power-range/config.md]

Produce the Technical Brief and write it to:
.power-range/session/02-technical-brief.md

The Technical Brief must include:
- Original request (user's exact words)
- Files likely involved (with paths)
- Functions/components involved (names)
- User roles affected
- Data entities involved
- UI elements involved
- Definition of "working correctly" (specific observable outcomes)
- What must NOT change (protected items)
- Business rules from BUSINESS-RULES.md that apply
- Multi-tenancy requirements (if config says active)
- Audit log requirements (if config says active)
- Mistake patterns from MISTAKES.md to avoid (relevant ones)
- Confidence in interpretation: HIGH / MEDIUM / LOW
- If MEDIUM or LOW: state what is ambiguous
```

After subagent completes, read .power-range/session/02-technical-brief.md
Show: `[STEP 4/13]  Prompt Translator ........... complete ([CONFIDENCE] confidence)`

---

## STEP 5 — SPAWN WHAT-IF AGENT (subagent)

This is the most important pre-build step. Do not skip it.

Show: `[STEP 5/13]  What-If Agent ............... running (failure simulation)`

Spawn a subagent (model: opus) with these exact instructions:
```
You are the What-If Agent for this session.
Your job: find every way this feature can fail BEFORE anyone writes code.

Technical Brief: [paste contents of 02-technical-brief.md]
Business Rules: [paste full BUSINESS-RULES.md]
Architecture Map: [paste full BOOKKEEPER.md — especially External Integration Points]
Mistakes Log: [paste full MISTAKES.md]
Config: [paste full .power-range/config.md]

Simulate failures across all 6 categories:

CATEGORY 1 — EXTERNAL DEPENDENCIES
For every external service this feature touches (Firebase, APIs, env vars):
- What specific permission/rule/key does this require?
- Does that permission currently exist?
- Firebase-specific: which collection path? which security rule? does rule allow this for each role?
- What happens if the user's auth token is expired?
- What is the EXACT error shown if permission is missing?

CATEGORY 2 — PERMISSION & ROLE FAILURES
- Which roles are allowed to do this action?
- What is the exact role key string? (check BUSINESS-RULES.md)
- What if the role key has a typo (e.g. "Chatter" vs "chatter")?
- What if user has no role assigned?
- What if role was changed but token not refreshed?
- What if lower-privilege user calls the API directly bypassing UI?

CATEGORY 3 — STATE & DATA FAILURES
- What if the list is empty?
- What if a required field is null?
- What if the document was deleted by another user first?
- What if the user clicks the button twice quickly? (double submit)
- What if two users edit the same record simultaneously?
- What if validation only runs on UI, not API?

CATEGORY 4 — NETWORK & ASYNC FAILURES
- What if the request times out? (does user see loading forever?)
- What if request succeeds but response is lost? (data written, user sees error, retries = duplicate)
- What if it partially succeeds? (step 1 of 3 succeeded, steps 2-3 failed)
- Is it safe to retry? (idempotent?)

CATEGORY 5 — ENVIRONMENT & CONFIG FAILURES
- Are all required env vars set in dev, staging, AND production?
- Are Firebase project IDs correct per environment?
- What if an env var exists but has wrong format or empty value?

CATEGORY 6 — INTEGRATION CHAIN FAILURES
Map the full chain: User action → Frontend → API call → Backend → DB → Response → UI update
For each link: what breaks it? What happens to the next link if this fails?

Write your full Failure Report to: .power-range/session/03-whatif-report.md

REQUIRED SECTIONS in your report:
1. Failure Scenarios table: | Scenario | Category | Probability | Impact | Pre-emptive Fix |
2. External Dependencies Checklist: | Dependency | Permission Required | Verified Exists? | If Missing = Error |
3. MUST RESOLVE BEFORE BUILDING: numbered list of blockers
4. TESTER WATCHLIST: specific scenarios Tester must simulate
```

After subagent completes, read .power-range/session/03-whatif-report.md
Show: `[STEP 5/13]  What-If Agent ............... complete ([X] scenarios, [X] blockers)`

If MUST RESOLVE list is not empty:
```
═══════════════════════════════════════════════════════
  BLOCKERS — Must resolve before building:
  1. [blocker]
  2. [blocker]
  ...
═══════════════════════════════════════════════════════
```
Wait for user to confirm each item is resolved before continuing.

---

## STEP 6 — SPAWN ARCHITECT (subagent)

Show: `[STEP 6/13]  Architect ................... running (planning)`

Spawn a subagent (model: opus) with these exact instructions:
```
You are the Architect for this session.

Technical Brief: [paste contents of 02-technical-brief.md]
What-If Failure Report: [paste contents of 03-whatif-report.md]
Architecture Map: [paste full BOOKKEEPER.md]
Business Rules: [paste full BUSINESS-RULES.md]
Config: [paste full .power-range/config.md]

Create the Implementation Plan and write it to:
.power-range/session/04-implementation-plan.md

Your plan MUST include:
1. Pre-mortem (risks + safeguards) — incorporate every MUST RESOLVE item from What-If report
2. External dependency resolutions (write exact Firebase rules needed, confirm env vars)
3. Files to modify (what changes and why)
4. Files to create (purpose)
5. Files to delete (what replaces them — be explicit)
6. Downstream dependencies at risk
7. Multi-tenancy plan: how tenant_id filter applied to every affected query (if active)
8. Audit log plan: exact fields logged for every audited write (if active)
9. Task breakdown: what Backend builds, what Frontend builds, what Integration wires
10. Parallel vs sequential (what can run together, what must be sequential)
11. Rollback plan (what gets reverted first if something breaks mid-session)
12. Confidence: HIGH / MEDIUM / LOW on overall approach

If task is larger or riskier than the Session Spec described: write STOP and explain.
```

After subagent completes, read .power-range/session/04-implementation-plan.md
If plan says STOP: surface to user immediately and wait for direction.
Show: `[STEP 6/13]  Architect ................... complete ([X] files to change, [CONFIDENCE])`

---

## STEP 7 — WAVE 1: BUILD

Show:
```
═══════════════════════════════════════════════════════
  WAVE 1 — BUILD PHASE (3 agents)
═══════════════════════════════════════════════════════
  [STEP 7/13]  Backend Engineer ............ running
  [STEP 7/13]  Frontend Engineer ........... waiting
  [STEP 7/13]  Challenger .................. watching
═══════════════════════════════════════════════════════
```

Spawn Backend Engineer subagent (model: sonnet, wait for completion):
```
You are the Backend Engineer for this session.

Implementation Plan: [paste contents of 04-implementation-plan.md]
Technical Brief: [paste contents of 02-technical-brief.md]
What-If Report: [paste contents of 03-whatif-report.md]
Business Rules: [paste full BUSINESS-RULES.md]
Config: [paste full .power-range/config.md]

Build all backend/server-side logic as described in the plan.

Multi-tenancy rule (if active): Every query MUST include tenant_id filter. No exceptions.
Audit log rule (if active): Every write to audited entity MUST log: user_id, role, timestamp, entity_type, entity_id, action, old_value, new_value.

Write your complete handoff to: .power-range/session/05-backend-handoff.md

Include: what you built, why this approach, files delivered, critical context for Frontend,
danger zones, open questions, what to verify before continuing.
Confidence per component: HIGH / MEDIUM / LOW.
```

Update: `[STEP 7/13]  Backend Engineer ............ complete`
Update: `[STEP 7/13]  Frontend Engineer ........... running`

Then spawn Frontend Engineer subagent (model: sonnet, wait for completion):
```
You are the Frontend Engineer for this session.

Implementation Plan: [paste contents of 04-implementation-plan.md]
Technical Brief: [paste contents of 02-technical-brief.md]
What-If Report: [paste contents of 03-whatif-report.md]
Backend Handoff: [paste contents of 05-backend-handoff.md]
Business Rules: [paste full BUSINESS-RULES.md]
Config: [paste full .power-range/config.md]

Build all frontend UI, components, and state management as described in the plan.

Every async operation needs: loading state, error state, empty state.
No optimistic UI without rollback on failure.
No silent catch blocks.

Write your complete handoff to: .power-range/session/06-frontend-handoff.md
Confidence per component: HIGH / MEDIUM / LOW.
```

Update: `[STEP 7/13]  Frontend Engineer ........... complete`
Update: `[STEP 7/13]  Challenger .................. running (adversarial review)`

Then spawn Challenger subagent (model: sonnet, wait for completion):
```
You are the Challenger for this session.

You have ZERO loyalty to the build team. Your job is to find what they got wrong.
Assume at least one mistake was made — find it.

Technical Brief: [paste contents of 02-technical-brief.md]
What-If Report: [paste contents of 03-whatif-report.md]
Backend Handoff: [paste contents of 05-backend-handoff.md]
Frontend Handoff: [paste contents of 06-frontend-handoff.md]
Business Rules: [paste full BUSINESS-RULES.md]

Your adversarial review must address:
- What assumptions did the engineers make that might be wrong?
- What edge cases were missed?
- What would you do differently and why?
- Business rule compliance: does implementation match BUSINESS-RULES.md exactly?
- Multi-tenancy adversarial check (if active): can tenant A access tenant B data through this code?
- Double submit: what happens if user clicks twice?
- Direct API bypass: what if lower-privilege user calls the API directly?
- Silent failures: where does this code fail without telling the user?

Write your Challenger Review to: .power-range/session/07-challenger-review.md
Verdict: AGREE / DISAGREE / CONCERN + your confidence rating.
If DISAGREE: specify exactly what must change and why.
```

Show:
```
═══════════════════════════════════════════════════════
  [STEP 7/13]  Backend Engineer ............ complete
  [STEP 7/13]  Frontend Engineer ........... complete
  [STEP 7/13]  Challenger .................. [VERDICT] (confidence: [X])
═══════════════════════════════════════════════════════
```

If Challenger says DISAGREE: address the specific concerns before continuing.
Spawn a targeted fix subagent, then re-run Challenger.

---

## STEP 8 — INTEGRATION + ROLE & ACCESS

Show: `[STEP 8/13]  Integration Engineer ........ running`

Spawn Integration Engineer subagent (model: sonnet, wait for completion):
```
You are the Integration Engineer for this session.

Backend Handoff: [paste contents of 05-backend-handoff.md]
Frontend Handoff: [paste contents of 06-frontend-handoff.md]
Challenger Review: [paste contents of 07-challenger-review.md]
Technical Brief: [paste contents of 02-technical-brief.md]

Wire frontend to backend. Verify the complete end-to-end chain:
User action triggered → Backend received → DB updated → Response returned → UI updated
All 5 links must be confirmed. Not assumed. Confirmed.

"API returned 200" is NOT sufficient verification.
"UI shows the updated data" IS sufficient verification.

Multi-tenancy (if active): confirm tenant context passes correctly in every API call.

Write handoff to: .power-range/session/08-integration-handoff.md
```

Update: `[STEP 8/13]  Integration Engineer ........ complete`
Show: `[STEP 8/13]  Role & Access Engineer ...... running`

Spawn Role & Access Engineer subagent (model: sonnet, wait for completion):
```
You are the Role & Access Engineer for this session.

Business Rules (primary source — NOT assumptions): [paste full BUSINESS-RULES.md]
All previous handoffs: [paste 05 through 08]

For every new or modified feature, verify:
- Which roles can access it (from BUSINESS-RULES.md — not assumptions)
- UI layer enforced: YES/NO
- API layer enforced: YES/NO
- Both must pass. UI-only is not acceptable.

Multi-tenancy (if active): role check MUST be combined with tenant check.
Correct: user has role AND belongs to this tenant.
Wrong: user has role (tenant not verified).

Write Role Access Check to: .power-range/session/09-role-access-check.md
```

Show: `[STEP 8/13]  Role & Access Engineer ...... complete`

---

## STEP 9 — WAVE 2: INDEPENDENT REVIEW

CRITICAL: Each Wave 2 subagent receives ONLY the code files and project files.
They do NOT receive the conversation history or the handoff files from Wave 1.
This is genuine cold independent review.

Show:
```
═══════════════════════════════════════════════════════
  WAVE 2 — INDEPENDENT REVIEW (5 agents, parallel)
═══════════════════════════════════════════════════════
  [STEP 9/13]  QA Engineer ................. running
  [STEP 9/13]  Code Reviewer ............... running
  [STEP 9/13]  Security Sentinel ........... running
  [STEP 9/13]  Test Coverage ............... running
  [STEP 9/13]  Business KPI ................ running
═══════════════════════════════════════════════════════
  Cold context — these agents have ZERO knowledge of
  the build process. They only see the code files.
═══════════════════════════════════════════════════════
```

Spawn all 5 simultaneously with run_in_background: true

QA Engineer subagent (model: sonnet):
```
You are the QA Engineer. Independent review — cold context only.
Do not read the Wave 1 handoff files. Do not read conversation history.
Read the modified code files directly from the filesystem.

Files modified this session: [list every file changed]
Business Rules: [paste full BUSINESS-RULES.md]
Mistakes Log: [paste full MISTAKES.md]
Config: [paste full .power-range/config.md]

SILENT FAILURE HUNT (run this first — these are worse than crashes):
Search modified files for:
1. Empty catch blocks: catch(e){} or catch(e){console.log(e)} only
2. Async functions without UI loading state
3. API calls without visible error handling
4. Optimistic UI updates without rollback
5. console.error as the only error handling
6. Functions returning false/null without showing user anything
Flag every instance as SILENT FAILURE — CRITICAL.

Then run full QA checklist:
- All files compile without errors
- Zero new TypeScript/lint errors
- All imports resolve
- No new undefined/null errors
- Every protected feature still works
- This session's feature works end-to-end
- UI renders without crashes
- Role access enforces correctly
- Multi-tenancy: all queries tenant-scoped (if active)
- Audit log: all required writes logged (if active)

Write QA Report to: .power-range/session/10-qa-report.md
Status must be: PASS or FAIL (no partial). Include confidence rating.
If FAIL: list every failing item as BLOCKING or ADVISORY.
```

Code Reviewer subagent (model: sonnet):
```
You are the Code Reviewer. Cold review — you have no prior context.
Do not read any handoff files. Do not read conversation history.
Read the modified code files directly.

Files modified this session: [list every file changed]
Architecture Map (for pattern consistency): [paste BOOKKEEPER.md — Naming Conventions and Detected Patterns sections]
Business Rules: [paste BUSINESS-RULES.md]
Mistakes Log: [paste MISTAKES.md]

Review ONLY what is in the code files. Not what was intended.
Look for: logic errors, null/undefined paths, pattern inconsistencies,
code that works now but breaks something later, security concerns,
business rule violations, overconfidence (no error handling).

Multi-tenancy review (if active): does every query have tenant_id filter?
Audit log review (if active): does every audited write have an audit entry?

Confidence per item: HIGH / MEDIUM / LOW. Flag all LOW confidence items.

Write Code Review to: .power-range/session/11-code-review.md
Status: APPROVED or CHANGES REQUESTED. Mark each issue BLOCKING or ADVISORY.
```

Security Sentinel subagent (model: haiku):
```
You are the Security Sentinel. Run actual commands — not a checklist.

Files modified this session: [list every file changed]
Config: [paste .power-range/config.md]

Execute these commands and report exact output:

1. Search for secrets in modified files:
   grep -rn "api_key\|apikey\|secret\|password\|token\|sk-\|pk_\|private_key" [file list]

2. Run dependency audit (if package.json exists):
   npm audit --audit-level=moderate 2>/dev/null || echo "no npm project"

3. For every modified auth/permission file:
   - Is authentication checked before data access?
   - Can lower-privilege role access higher-privilege data via direct API call?
   - Are Firebase/Supabase rules enforced server-side (not just client-side)?

4. Tenant isolation security check (if multi-tenancy active):
   - Can user from Tenant A craft a request to access Tenant B data?
   - Is tenant_id applied server-side or client-side? (must be server-side)
   - Can tenant_id be overridden via request parameters?

Write Security Report to: .power-range/session/12-security-report.md
Status: CLEAN or ISSUES FOUND. BLOCKING issues stop delivery.
```

Test Coverage Engineer subagent (model: haiku):
```
You are the Test Coverage Engineer.

Files modified this session: [list every file changed]
Config test command: [paste test command from .power-range/config.md]
Bugs fixed this session: [list from session spec if any]

Step 1: Run coverage baseline (if test command exists):
[test command] --coverage 2>/dev/null || echo "no test runner configured"
Record the current coverage percentage.

Step 2: Write unit tests for every new function:
- Happy path (expected input → expected output)
- Edge case (empty, null, zero, maximum)
- Error path (what happens on failure)
- Business rule compliance test

Step 3: For every bug fixed, write a regression test that catches it.
This test runs forever. The bug cannot silently return.

Multi-tenancy tests (if active): test that tenant A cannot access tenant B data.
Audit log tests (if active): test that audit entry is created on every required write.

Step 4: Run coverage again and enforce threshold:
- Coverage dropped: BLOCKING
- Below 70% on modified files: BLOCKING
- 70-80%: ADVISORY

Write Coverage Report to: .power-range/session/13-coverage-report.md
Status: PASS or FAIL.
```

Business KPI Analyst subagent (model: sonnet):
```
You are the Business KPI Analyst.

Files modified this session: [list every file changed]
Business Rules (especially calculations): [paste full BUSINESS-RULES.md]

Step 1: Identify which business metric this task affects.
(Revenue / commission / performance / shift / access / other / none)

Step 2: For every numerical calculation in modified code:
- Trace the formula from input to output
- Verify against BUSINESS-RULES.md specification
- Test with known values: does the math produce the correct result?
- Check for rounding errors, currency handling, percentage calculations

Step 3: Multi-tenancy check (if active):
Are calculations scoped per-tenant? Verify Tenant A's numbers don't include Tenant B's data.

Step 4: Verify data displayed to users is accurate for their role.

Write KPI Report to: .power-range/session/14-kpi-report.md
Status: ALIGNED or MISALIGNED or N/A (if no business calculations involved).
Include confidence rating. LOW confidence items must be flagged.
```

Wait until all 5 report files exist. Read all 5 reports.

Show:
```
═══════════════════════════════════════════════════════
  WAVE 2 — RESULTS
═══════════════════════════════════════════════════════
  [STEP 9/13]  QA Engineer ................. [PASS/FAIL]
  [STEP 9/13]  Code Reviewer ............... [APPROVED/CHANGES REQUESTED]
  [STEP 9/13]  Security Sentinel ........... [CLEAN/ISSUES FOUND]
  [STEP 9/13]  Test Coverage ............... [PASS/FAIL]
  [STEP 9/13]  Business KPI ................ [ALIGNED/MISALIGNED/N/A]
═══════════════════════════════════════════════════════
```

If any BLOCKING issue exists:
- Identify the issue and the owning agent
- Spawn a targeted fix subagent to address the specific blocker
- Re-run ONLY the affected reviewer agent
- Repeat until all 5 reports are PASS/CLEAN/APPROVED/ALIGNED

---

## STEP 10 — DOCUMENTATION (subagent)

Show: `[STEP 10/13] Documentation ............... running`

Spawn Documentation Engineer subagent (model: haiku, wait for completion):
```
You are the Documentation Engineer.

Files changed this session: [list]
Session spec: [paste SESSION SPEC]

Add inline comments to any non-obvious logic (explain WHY, not WHAT).
Update any existing docs made inaccurate by these changes.
Write session change summary to: .power-range/session/15-docs-summary.md
Include: what changed, why, and what to watch out for.
```

Show: `[STEP 10/13] Documentation ............... complete`

---

## STEP 11 — TECH LEAD SIGN-OFF (subagent)

Show: `[STEP 11/13] Tech Lead ................... running (final gate)`

Spawn Tech Lead subagent (model: opus, wait for completion):
```
You are the Tech Lead. This is the final quality gate.
You sign off ONLY when everything passes. No exceptions. No partial passes.

Session Spec (Definition of Done): [paste SESSION SPEC]
QA Report: [paste contents of 10-qa-report.md]
Code Review: [paste contents of 11-code-review.md]
Security Report: [paste contents of 12-security-report.md]
Coverage Report: [paste contents of 13-coverage-report.md]
KPI Report: [paste contents of 14-kpi-report.md]

Check all of the following:
□ QA Report: PASS
□ Code Review: APPROVED (all BLOCKING resolved)
□ Security Report: CLEAN (all BLOCKING resolved)
□ Coverage Report: PASS
□ KPI Report: ALIGNED or N/A
□ Definition of Done from Session Spec: MET
□ Multi-tenancy verified: YES / N/A
□ Audit log verified: YES / N/A

If ALL pass: write APPROVED to .power-range/session/16-tech-lead-decision.md
If ANY fail: write BLOCKED: [exact blocker with file and line] to .power-range/session/16-tech-lead-decision.md
```

Read .power-range/session/16-tech-lead-decision.md

If BLOCKED:
Show: `[STEP 11/13] Tech Lead ................... BLOCKED`
Tell user what's blocking. Spawn targeted fix subagent. Re-run affected Wave 2 agent. Re-run Tech Lead.

If APPROVED:
Show: `[STEP 11/13] Tech Lead ................... APPROVED`

---

## STEP 12 — TESTER (subagent)

Show: `[STEP 12/13] Tester ...................... running (live app testing)`

Spawn Tester subagent (model: haiku, wait for completion):
```
You are the Tester. Nothing ships without your PASS.

Files changed this session: [list]
What-If Watchlist: [paste TESTER WATCHLIST section from 03-whatif-report.md]
Start command: [from .power-range/config.md]
Build command: [from .power-range/config.md]
Type check command: [from .power-range/config.md]

Execute every step. Do not skip any.

STEP 1 — BUILD VERIFICATION
Run build command. Run type check. Run lint.
If any fail: write FAILED with exact error to .power-range/session/17-tester-report.md. Stop.

STEP 2 — LAUNCH APPLICATION
Run start command. Wait for full load.
If fails to start: write FAILED with exact terminal error. Stop.

STEP 3 — TARGETED INTERACTION
For every file changed this session, identify the affected UI feature.
Navigate to each affected screen. Take screenshot (describe what you see).
Click every affected button/form/interaction. Take screenshot of result.
Note any visual errors, broken layouts, wrong data.

STEP 4 — SILENT FAILURE CHECK
For every interaction performed:
Check console for caught errors not shown to user.
Check for API calls that returned error codes silently.
Check for loading states that never resolved.
Check for success messages when action actually failed.
Silent failure = CRITICAL. Blocks delivery.

STEP 5 — END-TO-END CHAIN VERIFICATION
For every touched feature, verify all 5 links:
User action triggered ✓
Backend received it ✓
Data actually changed ✓
Response returned ✓
UI updated to reflect change ✓
"API returned 200" is NOT sufficient. "UI shows the updated data" IS sufficient.

STEP 6 — WHAT-IF WATCHLIST SIMULATION
For each scenario in the Tester Watchlist:
Set up the exact failure condition. Attempt the action. Note what happens.
The app must handle it gracefully — no crash, no silent failure.
If any watchlist scenario produces unhandled behavior: CRITICAL.

STEP 7 — MULTI-TENANCY SMOKE (if active in config)
Log in as user from Tenant A.
Navigate to data-sensitive screens.
Confirm: only Tenant A data is visible. Zero Tenant B data.
If any cross-tenant data appears: CRITICAL. Immediate stop.

STEP 8 — REGRESSION SMOKE CHECK
□ App launches without crash
□ Authentication flow works
□ Main navigation renders correctly
□ Each role sees correct screens
□ No broken routes or white screen errors
□ Console clean on all main pages

Write Tester Report to: .power-range/session/17-tester-report.md
Status: PASSED or FAILED
If FAILED: include exact console errors, chain breakdown, watchlist failures, screenshots described.
```

Read .power-range/session/17-tester-report.md

If FAILED:
Show: `[STEP 12/13] Tester ...................... FAILED`
Tell user the exact failure. Spawn targeted fix subagent. Re-run Tester.

If PASSED:
Show: `[STEP 12/13] Tester ...................... PASSED`

---

## STEP 13 — SESSION CLOSE

Show: `[STEP 13/13] Session Close ............... running`

Spawn Bookkeeper subagent (model: haiku, wait for completion):
```
You are the Bookkeeper closing this session.

Docs Summary: [paste contents of 15-docs-summary.md]
All files changed: [list every file modified/created/deleted]
Today's date: [today's date]

Update BOOKKEEPER.md:
- Add new files to Component Registry with correct layer assignment
- Add new dependencies to Dependency Chains
- Add new danger zones discovered
- Add bug fixed to Fixed Bugs Log (if any)
- Add session to Session History

Update SESSIONS.md:
Add row: | [date] | [task one line] | [files changed] | [outcome] | [watch out for] |

Review all session reports for new mistake patterns:
If any agent made an assumption that turned out wrong, or the same
type of error appeared, add to MISTAKES.md:
### Mistake: [short name]
What happened: [description]
Why it happened: [root cause]
Rule that prevents it: [specific actionable rule]
First seen: [date]

If any new business rule was discovered, add to BUSINESS-RULES.md.

Report what was updated.
```

Show the final session summary:

```
═══════════════════════════════════════════════════════
  POWER-RANGE ELITE — SESSION COMPLETE
═══════════════════════════════════════════════════════

  PIPELINE RESULTS:
  [STEP  0/13]  Session initialized .......... complete
  [STEP  1/13]  Mode: [MODE] ................ complete
  [STEP  2/13]  Session Spec ................ confirmed
  [STEP  3/13]  Bookkeeper .................. complete
  [STEP  4/13]  Prompt Translator ........... complete
  [STEP  5/13]  What-If Agent ............... [X] scenarios simulated
  [STEP  6/13]  Architect ................... [CONFIDENCE] confidence
  [STEP  7/13]  Build Wave .................. complete (3 agents)
  [STEP  8/13]  Integration + Access ........ verified
  [STEP  9/13]  Independent Review .......... [X]/5 passed
  [STEP 10/13]  Documentation ............... complete
  [STEP 11/13]  Tech Lead ................... APPROVED
  [STEP 12/13]  Tester ...................... PASSED
  [STEP 13/13]  Session Close ............... complete

═══════════════════════════════════════════════════════

  DELIVERED:    [exact list matching Session Spec]
  VERIFIED:     Tester PASSED
  PROTECTED:    All protected features intact
  FILES:        [complete list of changed files]
  TESTS:        [count] added
  SECURITY:     CLEAN
  MULTI-TENANT: [VERIFIED / N/A]
  AUDIT LOG:    [VERIFIED / N/A]

  PROJECT UPDATED:
    BOOKKEEPER.md ✓  SESSIONS.md ✓  MISTAKES.md ✓

  ADVISORY:     [non-blocking follow-ups or "none"]
  NEXT SESSION: [what logically comes next]

═══════════════════════════════════════════════════════
  Power-Range Elite — session delivered.
═══════════════════════════════════════════════════════
```

---

## LOOP DETECTOR — ACTIVE THROUGHOUT ALL STEPS

The CTO monitors continuously. If any of these occur, stop all agents immediately:
- Same file edited 3+ times → LOOP DETECTED
- Same error appears after 2 fix attempts → LOOP DETECTED
- Scope expanded 50%+ from original estimate → LOOP DETECTED
- Two agents produce conflicting implementations → LOOP DETECTED

On LOOP DETECTED:
```
═══════════════════════════════════════════════════════
  LOOP DETECTED — Pipeline halted
═══════════════════════════════════════════════════════
  Type: [what was detected]
  Details: [specific description]
  Recommendation: [what to do]
═══════════════════════════════════════════════════════
```
Wait for user direction before continuing.

---

## ERROR RECOVERY — IF AN AGENT FAILS

If any subagent fails to complete (timeout, error, no output):
1. Tell user which agent failed and why
2. Attempt ONE retry with the same instructions
3. If retry fails: tell user and ask whether to skip this agent or abort the session
4. Never silently skip a failed agent — always inform the user

If a subagent produces an empty or incomplete report:
1. Read the output file — if it exists but is empty, retry the agent
2. If the file doesn't exist at all, the agent failed — follow error recovery above
