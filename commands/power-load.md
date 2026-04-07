You are running /power-load. This is a one-time project installation.
You are the Power-Load Installer. Do not skip any phase.
Read everything before touching anything.

---

## PHASE 1 — DISCOVERY

Scan the entire project without modifying any files.

Collect:
- Read package.json → stack, scripts, all dependencies
- Read all config files (.env.example, firebase.json, vite.config, tsconfig, etc.)
- Map every folder and file in the project
- Identify: pages, components, hooks, stores, utils, services, API routes
- Note which files are imported the most (danger zones)
- Note naming conventions already in use
- Check for existing tests — where, what do they cover
- Check for FIXME/TODO/HACK/DEPRECATED comments
- Run the start command — does it launch cleanly?

---

## PHASE 2 — INTERVIEW THE USER

Send this exact message to the user (one message, wait for response):

---
I need to understand your project before installing Power-Range.
Answer in plain language — no technical knowledge needed.

**Product:**
1. What is this product in one sentence?
2. Who are the users? List every role and what each one does.
3. What are the 5 most critical features that must always work?
4. What does this product NEVER do? (hard limits)
5. Non-negotiable rules? (design, data, access rules)
6. How do you know when something is done and working?

**Business Rules:**
7. What can each user role do? What are they NOT allowed to do?
8. Any workflow rules? (sequences, approvals, timing, shifts)
9. Who sees whose data? What data does each role own vs. view?
10. Any calculations that must be exact? (revenue, commission, scoring — write the formula)
11. Rules not obvious from the UI that a developer would get wrong?
12. What would break your business if coded wrong?

**Multi-Tenancy:**
13. Does each client/agency get completely isolated data?
14. Can users from one tenant EVER see another tenant's data?
15. How are new tenants created? Is there a super-admin role?

**Deployment:**
16. Do you use GitHub? (yes → repo name)
17. How do you deploy? (Vercel / Firebase / Netlify / manual / other)
18. Automation level:
    A) Manual — you handle git and deploy yourself
    B) Git-aware — Power-Range commits to a branch and opens a PR
    C) Full CI/CD — automated pipeline triggers on every commit
---

Wait for user response before continuing.

---

## PHASE 3 — GENERATE ALL PROJECT FILES

After user responds, create these files:

### PRD.md
```
# [PROJECT NAME] — Product Requirements
Last updated: [today's date]

## What This Product Is
[one paragraph from user's answer]

## User Roles
| Role | Can Do | Cannot Do |
|------|--------|-----------|
[from user's answers]

## Critical Features (Must Always Work)
1. [from user]
2.
3.
4.
5.

## Hard Limits
[from user]

## Non-Negotiable Rules
[from user]

## Definition of Done
[from user]

## Tech Stack
- Frontend: [detected]
- Backend/DB: [detected]
- Auth: [detected]
- Hosting: [from user]
- Key integrations: [detected]
```

### BOOKKEEPER.md
```
# [PROJECT NAME] — Architecture Map
Last updated: [today's date]

## Layer Architecture
| Layer | Name | Purpose |
|-------|------|---------|
| 0 | External Services | APIs, databases, third-party |
| 1 | Foundation | Auth, core config, global state, routing |
| 2 | Shared Logic | Hooks, utilities, stores, helpers |
| 3 | Pages/Routes | Page-level components |
| 4 | UI Components | Presentational, independent |

## Component & File Registry
| File | Layer | Depends On | Used By | Safe Alone? |
|------|-------|------------|---------|-------------|
[fill from Phase 1 scan]

## Dependency Chains — DANGER ZONES
[files that cascade to many others when changed]

## Safe Zones
[files with no shared dependencies]

## External Integration Points
[every connection to outside services]

## Naming Conventions In Use
[detected patterns — agents must follow these]

## Detected Patterns
[state management, API call patterns, error handling]

## Fixed Bugs Log
| Date | Bug | Fix | Files | DO NOT REVERT |
|------|-----|-----|-------|---------------|

## Session History
| Date | Task | Files Changed |
|------|------|---------------|
```

### BUSINESS-RULES.md
```
# [PROJECT NAME] — Business Rules
Last updated: [today's date]
READ BEFORE TOUCHING ANY ROLE, PERMISSION, DATA, OR QUERY LOGIC.

## User Roles & Permissions
[from user answers — one section per role]

## Workflow Rules
[from user]

## Data Rules
[from user]

## Exact Calculations
[formulas written precisely]

## Rules Not Obvious From UI
[from user]

## Hard Business Constraints
[from user]

## Multi-Tenancy
Tenant isolation: [YES/NO — from user answer]
Cross-tenant access: NEVER PERMITTED (except super-admin if applicable)
Every query must include tenant scope: [YES/NO/exceptions]
New tenant provisioning: [from user]

## Audit Requirements
Required: [YES/NO — from user answer]
Entities requiring audit trail: [list]
Who can view: [roles]
```

### SESSIONS.md
```
# [PROJECT NAME] — Session Log
| Date | Task | Files Changed | Outcome | Watch Out For |
|------|------|---------------|---------|---------------|
```

### MISTAKES.md
```
# [PROJECT NAME] — Mistake Patterns
READ THIS BEFORE EVERY SESSION.

[Empty on first install. Updated automatically after each session.]
```

### .power-range/config.md
```
# Power-Range Config — [PROJECT NAME]
Generated: [today's date]

## Commands
Start:      [from package.json scripts]
Build:      [from package.json scripts]
Type check: npx tsc --noEmit
Lint:       [from package.json scripts]
Test:       [from package.json scripts]

## Agent Model Assignments
Opus:   CTO, Architect, Tech Lead, What-If Agent
Sonnet: Backend, Frontend, Challenger, Integration, Role & Access,
        QA, Code Reviewer, Business KPI, Prompt Translator
Haiku:  Security Sentinel, Test Coverage, Bookkeeper, Documentation, Tester

## Multi-Tenancy Active
[YES / NO — from user answer]
[If YES: Every query MUST include tenant_id filter. No exceptions.]

## Audit Logging Active
[YES / NO — from user answer]
[If YES: Every write to audited entity MUST log: who, when, what, old, new]

## Project-Specific Rules
[naming conventions and patterns from Phase 1]

## Never Introduce
[patterns that would break consistency]

## High-Risk Files (Read Before Touching)
[top 5 most-imported files from Phase 1 scan]

## Known Fragile Areas
[files or systems needing extra care]
```

---

## PHASE 4 — CI/CD SETUP

If user chose B or C, create:

### .github/workflows/power-range-ci.yml
```yaml
name: Power-Range Quality Gate
on:
  push:
    branches: ['power-range/*', 'fix/*', 'feature/*']
  pull_request:
    branches: [main, develop]
jobs:
  quality-gate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci
      - run: npx tsc --noEmit
      - run: npm run lint
      - run: npm test -- --coverage --coverageThreshold='{"global":{"lines":70}}'
      - run: npm run build
      - run: npm audit --audit-level=moderate
        continue-on-error: true
```

### .github/pull_request_template.md
```markdown
## Power-Range Session Delivery
**Task:**
**Mode:** BUILD / FIX / REVIEW / MIGRATE

## Delivered
## Files Changed
## Verification
- [ ] QA: PASS
- [ ] Security: CLEAN
- [ ] Tests: PASS (coverage maintained)
- [ ] Tester: PASSED
- [ ] Business KPI: ALIGNED
- [ ] Multi-tenancy verified: YES / N/A
- [ ] Audit log verified: YES / N/A
## Protected Features Intact
## Advisory Items
```

---

## PHASE 5 — CONFIRM TO USER

Tell the user:

```
=== POWER-LOAD COMPLETE ===
Product: [one line summary]
Stack: [summary]
Roles: [list]
Multi-tenancy: [YES/NO]
Audit logging: [YES/NO]
CI/CD: [configured/manual]

Files created:
PRD.md
BOOKKEEPER.md
BUSINESS-RULES.md
SESSIONS.md
MISTAKES.md
.power-range/config.md
[CI/CD files if configured]

Power-Range Elite is now installed on this project.
Type /power-range to begin your first session.
=== END ===
```
