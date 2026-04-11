<p align="center">
  <img src="assets/power-range-banner.svg" alt="Power-Range Elite" width="700">
</p>

<h1 align="center">Power-Range Elite</h1>

<p align="center">
  <strong>Turn Claude Code into a full 18-agent engineering team.</strong><br>
  One command. 13-step quality pipeline. Zero shortcuts.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/agents-18-gold?style=for-the-badge" alt="18 Agents">
  <img src="https://img.shields.io/badge/pipeline-13_steps-blue?style=for-the-badge" alt="13 Steps">
  <img src="https://img.shields.io/badge/price-FREE-green?style=for-the-badge" alt="Free">
  <img src="https://img.shields.io/badge/paywall-NONE-red?style=for-the-badge" alt="No Paywall">
</p>

---

## What Is This?

Power-Range is a set of slash commands for [Claude Code](https://claude.ai/code) that transforms a single AI into an **18-agent engineering team** with a **13-step quality pipeline**.

Instead of one AI doing everything, Power-Range orchestrates specialized agents — each with a specific role, specific instructions, and specific output files. The result is code that's been planned, built, challenged, reviewed, tested, and verified before you ever see it.

**No API keys. No subscriptions. No paywall. Just copy 4 files and go.**

---

## The 18 Agents

| Agent | Role | What They Do |
|-------|------|-------------|
| **CTO** | Orchestrator | Reads project files, detects mode, manages the full pipeline |
| **Bookkeeper** | Architecture memory | Scans codebase, tracks danger zones, knows every file |
| **Project Manager** | User advocate | Translates your wishes into a blueprint, tracks progress to 100% |
| **What-If Agent** | Failure simulator | Finds every way the feature can fail BEFORE anyone writes code |
| **Architect** | Technical planner | Creates implementation plan with rollback strategy |
| **Backend Engineer** | Server-side builder | Writes all backend/API/database code |
| **Frontend Engineer** | UI builder | Writes all frontend/component/state code |
| **Challenger** | Adversarial reviewer | Assumes the builders made mistakes, finds what they missed |
| **Integration Engineer** | Wiring specialist | Verifies the full end-to-end chain actually works |
| **Role & Access Engineer** | Permission auditor | Verifies every role/permission from business rules |
| **QA Engineer** | Independent tester | Cold review — hunts for silent failures |
| **Code Reviewer** | Code quality | Logic errors, pattern violations, security concerns |
| **Security Sentinel** | Security scanner | Runs actual grep/audit commands, not checklists |
| **Test Coverage Engineer** | Test writer | Writes tests, enforces coverage thresholds |
| **Business KPI Analyst** | Math verifier | Verifies calculations match business rules exactly |
| **Documentation Engineer** | Doc writer | Inline comments (WHY not WHAT), updates docs |
| **Tech Lead** | Final gate | Signs off only when ALL reports pass |
| **Tester** | Live tester | Launches the app, clicks through it, takes screenshots |

---

## The 13-Step Pipeline

```
Step 0:  Read project files (PRD, architecture, rules, history)
Step 1:  Detect mode (BUILD / FIX / REVIEW / MIGRATE / LIGHTWEIGHT)
Step 2:  Intake interview (understand end result, not just code task)
Step 3:  Bookkeeper scans architecture, flags danger zones
Step 4:  Project Manager creates blueprint of user's wishes
Step 5:  What-If Agent simulates every failure mode
Step 6:  Architect creates implementation plan
Step 7:  Wave 1 BUILD: Backend + Frontend + Challenger (parallel)
Step 8:  Integration Engineer + Role & Access Engineer
Step 9:  Wave 2 REVIEW: 5 independent cold-context reviewers (parallel)
Step 10: Documentation Engineer
Step 11: Tech Lead sign-off
Step 12: Tester launches and verifies
Step 13: Session close (update project files, log mistakes)
```

---

## Installation

### Option 1: Run the installer

**Mac/Linux:**
```bash
git clone https://github.com/MEHDIGAMER/power-range-elite.git
cd power-range-elite
bash install.sh
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/MEHDIGAMER/power-range-elite.git
cd power-range-elite
.\install.ps1
```

### Option 2: Manual copy

Copy the 4 files from `commands/` to your Claude commands directory:

```bash
# Mac/Linux
mkdir -p ~/.claude/commands
cp commands/*.md ~/.claude/commands/

# Windows
mkdir %USERPROFILE%\.claude\commands
copy commands\*.md %USERPROFILE%\.claude\commands\
```

---

## Usage

### First time on a project:
```
/power-load
```
Creates project context files (PRD, architecture map, business rules, config).

### Optional — map your codebase:
```
/power-mapout
```
Creates a dependency graph with blast radius scores for every function.

### Build something:
```
/power-range build the user dashboard with real data from the API
```

### Fix something:
```
/power-range the login page is broken, users see a white screen
```

### Review code:
```
/power-range review the auth middleware for security issues
```

---

## Commands

| Command | Purpose |
|---------|---------|
| `/power-range` | Main pipeline — 18 agents, 13 steps |
| `/power-load` | One-time project setup |
| `/power-mapout` | Codebase intelligence mapper |
| `/power-range-escalate` | Escalate when pipeline is stuck |

---

## Requirements

- [Claude Code](https://claude.ai/code) — that's it. No other dependencies.

---

## License

MIT — free forever. No paywall. No catch.

---

<p align="center">
  <strong>Built by <a href="https://github.com/MEHDIGAMER">@MEHDIGAMER</a></strong><br>
  <em>Stop building alone. Start building with a team.</em>
</p>
