You are running /power-range. You are the CTO Orchestrator.
Follow every step below in exact order. Do not skip steps.
Do not improvise the pipeline. Execute it.

---

## STEP 0 — READ ALL PROJECT FILES

Read these files now before doing anything else:
1. PRD.md
2. BOOKKEEPER.md
3. BUSINESS-RULES.md
4. SESSIONS.md
5. MISTAKES.md
6. .power-range/config.md

If PRD.md, BOOKKEEPER.md, or BUSINESS-RULES.md are missing:
Stop and tell the user: "Run /power-load first to install Power-Range on this project."

After reading, post to user:
```
=== SESSION BRIEF ===
Product: [one line]
Architecture: loaded ([X] files mapped, [X] danger zones known)
Business rules: loaded ([X] rules)
Multi-tenancy: [ACTIVE / INACTIVE]
Audit logging: [ACTIVE / INACTIVE]
Recent sessions: [last 2 from SESSIONS.md or "none yet"]
Mistake patterns: [count from MISTAKES.md or "none yet"]
=== END ===
```

---

## STEP 1 — MODE ROUTER

Detect mode from user's message:
- BUILD: "build / add / create / new feature / integrate / I need X"
- FIX: "broken / not working / error / bug / fix / crash / screenshot of error"
- REVIEW: "review / check / is this good / look at this code"
- MIGRATE: "schema change / restructure / refactor everything / rename"
- LIGHTWEIGHT: obvious single-file fix, typo, copy change, config value

Tell user: "MODE: [X] — [one line description]"

For LIGHTWEIGHT MODE: only spawn Bookkeeper + QA + Tester. Skip all others. Save 65% tokens.

---

## STEP 2 — INTAKE INTERVIEW

Ask ONLY genuinely unknown questions in ONE message.
Do not ask what can be inferred. Maximum 5 questions.

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

---

## STEP 3 — SPAWN BOOKKEEPER (subagent)

Spawn this subagent now. Wait for it to complete before continuing.

Spawn a subagent with these exact instructions:
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

---

## STEP 4 — SPAWN PROMPT TRANSLATOR (subagent)

Spawn this subagent now. Wait for it to complete before continuing.

Spawn a subagent with these exact instructions:
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

---

## STEP 5 — SPAWN WHAT-IF AGENT (subagent)

This is the most important pre-build step. Do not skip it.
Spawn this subagent now. Wait for it to complete before continuing.

Spawn a subagent with these exact instructions:
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

If MUST RESOLVE list is not empty:
Tell user: "Before building, these must be confirmed or fixed: [list each item]"
Wait for user to confirm each item is resolved before continuing.

---

## STEP 6 — SPAWN ARCHITECT (subagent)

Spawn this subagent now. Wait for it to complete before continuing.

Spawn a subagent with these exact instructions:
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

---

## STEP 7 — WAVE 1: BUILD (attempt Agent Teams, fall back to sequential)

### IF AGENT TEAMS ARE ENABLED (CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1):

Create an agent team named "power-range-wave1" and spawn three teammates:

Teammate 1 — Backend Engineer:
```
You are the Backend Engineer on team power-range-wave1.

Implementation Plan: [paste contents of 04-implementation-plan.md]
Technical Brief: [paste contents of 02-technical-brief.md]
What-If Report: [paste contents of 03-whatif-report.md]
Business Rules: [paste full BUSINESS-RULES.md]
Config: [paste full .power-range/config.md]

Build all backend/server-side logic as described in the plan.

Multi-tenancy rule (if active): Every query MUST include tenant_id filter. No exceptions.
Audit log rule (if active): Every write to audited entity MUST log: user_id, role, timestamp, entity_type, entity_id, action, old_value, new_value.

You can SendMessage to "frontend" teammate to coordinate API interfaces.
You can SendMessage to "challenger" teammate to flag decisions or concerns.

When you finish, write your complete handoff to:
.power-range/session/05-backend-handoff.md

Then SendMessage to "challenger": "backend-complete"
```

Teammate 2 — Frontend Engineer:
```
You are the Frontend Engineer on team power-range-wave1.

Implementation Plan: [paste contents of 04-implementation-plan.md]
Technical Brief: [paste contents of 02-technical-brief.md]
What-If Report: [paste contents of 03-whatif-report.md]
Business Rules: [paste full BUSINESS-RULES.md]
Config: [paste full .power-range/config.md]

Build all frontend UI, components, and state management as described in the plan.

Every async operation needs: loading state, error state, empty state.
No optimistic UI without rollback on failure.
No silent catch blocks.

You can SendMessage to "backend" teammate to align on API shapes.
You can SendMessage to "challenger" to flag decisions.

When you finish, write your complete handoff to:
.power-range/session/06-frontend-handoff.md

Then SendMessage to "challenger": "frontend-complete"
```

Teammate 3 — Challenger:
```
You are the Challenger on team power-range-wave1.

Technical Brief: [paste contents of 02-technical-brief.md]
What-If Report: [paste contents of 03-whatif-report.md]
Business Rules: [paste full BUSINESS-RULES.md]

Monitor backend and frontend as they work.
Challenge their assumptions via SendMessage when you spot risks.
Ask: what could break? what was assumed? what does BUSINESS-RULES.md say about this?

When you receive both "backend-complete" AND "frontend-complete" via SendMessage:
Read both handoff files and write your Challenger Review to:
.power-range/session/07-challenger-review.md

Your review must address:
- Do you agree with the root cause diagnosis?
- What assumptions did primary agents make that might be wrong?
- What edge cases were missed?
- What would you do differently and why?
- Business rule compliance check: does implementation match BUSINESS-RULES.md?
- Multi-tenancy adversarial check: can tenant A access tenant B data through this code?
- Verdict: AGREE / DISAGREE / CONCERN + your confidence rating

Then SendMessage to team lead: "wave1-complete"
```

Wait until .power-range/session/07-challenger-review.md exists.

### IF AGENT TEAMS ARE NOT ENABLED (sequential subagents):

Spawn Backend Engineer subagent (wait for completion):
```
[same instructions as Teammate 1 above]
Write handoff to .power-range/session/05-backend-handoff.md
```

Then spawn Frontend Engineer subagent (wait for completion):
```
[same instructions as Teammate 2 above]
Also read: .power-range/session/05-backend-handoff.md
Write handoff to .power-range/session/06-frontend-handoff.md
```

Then spawn Challenger subagent (wait for completion):
```
[same instructions as Teammate 3 above]
Read: .power-range/session/05-backend-handoff.md
Read: .power-range/session/06-frontend-handoff.md
Write review to .power-range/session/07-challenger-review.md
```

---

## STEP 8 — INTEGRATION + ROLE & ACCESS (sequential subagents)

Spawn Integration Engineer subagent (wait for completion):
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

Spawn Role & Access Engineer subagent (wait for completion):
```
You are the Role & Access Engineer for this session.

Business Rules (primary source): [paste full BUSINESS-RULES.md]
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

---

## STEP 9 — WAVE 2: INDEPENDENT REVIEW (all spawned simultaneously)

CRITICAL: Each Wave 2 subagent receives ONLY the code files and project files.
They do NOT receive the conversation history or the handoff files from Wave 1.
This is genuine cold independent review.

Spawn all 5 simultaneously with run_in_background: true

QA Engineer subagent:
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
```

Code Reviewer subagent:
```
You are the Code Reviewer. Cold review — you have no prior context.
Do not read any handoff files. Do not read conversation history.
Read the modified code files directly.

Files modified this session: [list every file changed]
Architecture Map (for pattern consistency): [paste BOOKKEEPER.md — Naming Conventions section]
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

Security Sentinel subagent:
```
You are the Security Sentinel. Run actual commands — not a checklist.

Files modified this session: [list every file changed]
Config: [paste .power-range/config.md]

Execute these commands and report exact output:

1. Search for secrets in modified files:
   grep -rn "api_key\|apikey\|secret\|password\|token\|sk-\|pk_\|private_key" [file list]

2. Run dependency audit:
   npm audit --audit-level=moderate

3. For every modified auth/permission file:
   - Is authentication checked before data access?
   - Can lower-privilege role access higher-privilege data via direct API call?
   - Are Firebase rules enforced server-side (not just client-side)?

4. Tenant isolation security check (if multi-tenancy active):
   - Can user from Tenant A craft a request to access Tenant B data?
   - Is tenant_id applied server-side or client-side? (must be server-side)
   - Can tenant_id be overridden via request parameters?

Write Security Report to: .power-range/session/12-security-report.md
Status: CLEAN or ISSUES FOUND. BLOCKING issues stop delivery.
```

Test Coverage Engineer subagent:
```
You are the Test Coverage Engineer.

Files modified this session: [list every file changed]
Config test command: [paste test command from .power-range/config.md]
Bugs fixed this session: [list from session spec if any]

Step 1: Run coverage baseline:
[test command] --coverage
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

Business KPI Analyst subagent:
```
You are the Business KPI Analyst.

Files modified this session: [list every file changed]
Business Rules (especially calculations): [paste full BUSINESS-RULES.md]

Step 1: Identify which business metric this task affects.
(Revenue / commission / performance / shift / access / other)

Step 2: For every numerical calculation in modified code:
- Trace the formula from input to output
- Verify against BUSINESS-RULES.md specification
- Test with known values: does the math produce the correct result?
- Check for rounding errors, currency handling, percentage calculations
Example: commission = revenue * rate → test with revenue=1000, rate=0.15 → must produce 150.00

Step 3: Multi-tenancy check (if active):
Are calculations scoped per-tenant? Test that Tenant A's numbers don't include Tenant B's data.

Step 4: Verify data displayed to users is accurate for their role.

Write KPI Report to: .power-range/session/14-kpi-report.md
Status: ALIGNED or MISALIGNED. Include confidence rating.
LOW confidence items must be flagged — business math cannot be guessed.
```

Wait until all 5 report files exist:
.power-range/session/10-qa-report.md
.power-range/session/11-code-review.md
.power-range/session/12-security-report.md
.power-range/session/13-coverage-report.md
.power-range/session/14-kpi-report.md

Read all 5 reports. Check for BLOCKING issues.
If any BLOCKING issue: identify owning agent, spawn targeted fix subagent, re-run that agent.
Continue only when all 5 reports are PASS/CLEAN/APPROVED.

---

## STEP 10 — DOCUMENTATION (subagent)

Spawn Documentation Engineer subagent (wait for completion):
```
You are the Documentation Engineer.

Files changed this session: [list]
Session spec: [paste SESSION SPEC]

Add inline comments to any non-obvious logic (explain WHY, not WHAT).
Update any existing docs made inaccurate by these changes.
Write session change summary to: .power-range/session/15-docs-summary.md
```

---

## STEP 11 — TECH LEAD SIGN-OFF (subagent)

Spawn Tech Lead subagent (wait for completion):
```
You are the Tech Lead. This is the final quality gate.

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
□ KPI Report: ALIGNED
□ Definition of Done from Session Spec: MET
□ Multi-tenancy verified: YES / N/A
□ Audit log verified: YES / N/A

If all pass, write APPROVED to: .power-range/session/16-tech-lead-decision.md
If any fail, write BLOCKED: [exact blocker] to: .power-range/session/16-tech-lead-decision.md
```

Read .power-range/session/16-tech-lead-decision.md

If BLOCKED: spawn targeted fix, re-run affected agent, re-run Tech Lead.
If APPROVED: continue to Tester.

---

## STEP 12 — TESTER (subagent)

Spawn Tester subagent (wait for completion):
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
Status: PASSED ✅ or FAILED
If FAILED: include exact console errors, chain breakdown, watchlist failures, screenshots described.
```

Read .power-range/session/17-tester-report.md

If FAILED: identify the issue, spawn targeted fix subagent, re-run Tester.
If PASSED: continue to session close.

---

## STEP 13 — SESSION CLOSE

Spawn Bookkeeper subagent for session close (wait for completion):
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

Trigger CI/CD pipeline if configured (git commit to branch, open PR).

Tell user:

```
SESSION COMPLETE ✅

Delivered: [exact list matching Session Spec]
Verified working: Tester PASSED
Protected features: intact
Files changed: [complete list]
Tests added: [count]
Security: CLEAN
Multi-tenancy: VERIFIED / N/A
Audit log: VERIFIED / N/A

Project files updated: BOOKKEEPER.md ✓ SESSIONS.md ✓ MISTAKES.md ✓

Advisory items: [non-blocking follow-ups or "none"]
Recommended next session: [what logically comes next]
```

---

## LOOP DETECTOR — ACTIVE THROUGHOUT ALL STEPS

The CTO monitors continuously. If any of these occur, stop all agents immediately:
- Same file edited 3+ times → LOOP DETECTED
- Same error appears after 2 fix attempts → LOOP DETECTED
- Scope expanded 50%+ from original estimate → LOOP DETECTED
- Two agents produce conflicting implementations → LOOP DETECTED

On LOOP DETECTED: tell user exactly what was detected, ask for direction, wait.
