<p align="center">
  <img src="assets/power-range-banner.svg" alt="Power-Range Elite" width="700">
</p>

<h1 align="center">Power-Range Elite</h1>

<p align="center">
  <strong>Turn Claude Code into a full engineering team.</strong><br>
  One command. 20-step quality pipeline. Optional 10-model parallel debate. Zero shortcuts.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/pipeline-20_steps-blue?style=for-the-badge" alt="20 Steps">
  <img src="https://img.shields.io/badge/elite-10_AI_consultants-purple?style=for-the-badge" alt="10 AI Consultants">
  <img src="https://img.shields.io/badge/tester-autonomous-orange?style=for-the-badge" alt="Autonomous Tester">
  <img src="https://img.shields.io/badge/price-FREE-green?style=for-the-badge" alt="Free">
  <img src="https://img.shields.io/badge/paywall-NONE-red?style=for-the-badge" alt="No Paywall">
</p>

---

## What Is This?

Power-Range is a set of slash commands for [Claude Code](https://claude.ai/code) that transforms a single AI into a **full engineering team** running a **20-step quality pipeline**.

Instead of one AI doing everything, Power-Range orchestrates specialized agents — each with a specific role, specific instructions, and specific output files. The result is code that's been planned, built, challenged, reviewed, tested, and verified before you ever see it.

**No required API keys. No subscriptions. No paywall.** Run the installer and go.

**Want more?** Add an OpenRouter key to unlock **Elite Mode** — every architectural decision gets debated by 10 external AI models (Claude Sonnet, Claude Opus, GPT-4.1, DeepSeek R1, Gemini 2.5 Pro, Qwen3-235B, Llama-4-Maverick, and others) in parallel before your team executes.

---

## The 20-Step Pipeline

```
Step 0:    Mode detection (BUILD / FIX / REVIEW / PRUNE)
Step 0.5:  Goal extraction (what does success LOOK like?)
Step 0.75: Spec generation (plain-English → structured product spec)
Step 1:    Read project context (PRD, architecture, rules)
Step 2:    Codebase intelligence scan (GitNexus optional, grep fallback)
Step 3:    Prompt translation (vague → sharp tool-tuned instructions)
Step 4:    What-If failure simulation (every way it can break)
Step 4.5:  Multi-model plan competition (Elite mode only)
Step 5:    Architecture plan (DELETE > MODIFY > REUSE > ADD)
Step 5.5:  TDD — failing tests written FIRST
Step 6-9:  Build wave (backend, frontend, integration, role-access)
Step 10:   Challenger review (adversarial: assume engineers missed something)
Step 11-13:Parallel review wave (QA, Load Architect, Code Review, Security)
Step 14:   Simplifier (compress diff size 20-30%)
Step 14.5: Code Surgeon (delete redundant complexity)
Step 15:   Test Coverage Engineer (70% threshold enforced)
Step 16:   Business KPI Analyst (math correctness)
Step 17:   Documentation
Step 17.5: Final-validation debate (Elite mode only — 10 models attack the solution)
Step 18:   Tech Lead final gate
Step 19:   Autonomous tester (drives the app via Chrome DevTools Protocol)
Step 20:   Session close (scorecard, MISTAKES.md, auto-CLAUDE.md update)
```

---

## Commands

| Command | Purpose |
|---------|---------|
| `/power-range` | Main pipeline — 20 steps, full agent team |
| `/elite-power-range` | Same pipeline + 10-model OpenRouter debate at every critical decision |
| `/power-range-escalate` | Tier escalation when basic mode hits a wall |
| `/power-load` | One-time project setup (PRD, rules, config) |
| `/power-mapout` | Codebase intelligence mapper (dependency graph + blast radius) |

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

The installer copies all slash commands, the autonomous tester skill, the auto-CLAUDE.md hook, and the elite-mode debate runner.

### Option 2: Manual copy

```bash
# Slash commands
mkdir -p ~/.claude/commands
cp commands/*.md ~/.claude/commands/

# Tester skill
mkdir -p ~/.claude/skills/power-range-tester
cp skills/power-range-tester/SKILL.md ~/.claude/skills/power-range-tester/

# Auto-CLAUDE.md hook (optional — see SECURITY.md before installing)
mkdir -p ~/.claude/hooks
cp hooks/power-range-claude-md-updater.js ~/.claude/hooks/

# Elite-mode runtime (optional)
mkdir -p ~/.power-rangers
cp debate_runner.py config.example.json ~/.power-rangers/
mv ~/.power-rangers/config.example.json ~/.power-rangers/config.json
# then edit ~/.power-rangers/config.json with your OpenRouter key
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

### Build with 10 AI consultants debating every decision:
```
/elite-power-range build the user dashboard with real data from the API
```

### Force a debate at any moment during a session:
```
/debate
```

---

## Elite Mode (optional)

Elite Mode adds a multi-model debate layer. At every critical decision point — architecture choices, blocked agents, final validation — the same problem is sent to multiple OpenRouter models **in parallel**, and consensus is synthesized back to your team.

**Setup:**
1. Get an OpenRouter key at [openrouter.ai/keys](https://openrouter.ai/keys)
2. `pip install aiohttp`
3. Edit `~/.power-rangers/config.json` (or `export OPENROUTER_API_KEY=...`)
4. Use `/elite-power-range` instead of `/power-range`

**Default model lineup** (configurable in `config.json`):
- `anthropic/claude-sonnet-4`, `anthropic/claude-opus-4`
- `openai/gpt-4.1`
- `deepseek/deepseek-r1`, `deepseek/deepseek-chat`
- `google/gemini-2.5-pro-preview-05-06`
- `qwen/qwen3-235b-a22b`
- `x-ai/grok-3-mini-beta`
- `meta-llama/llama-4-maverick`

Minimum 3 models for consensus. Cost: typically $0.05–$0.30 per debate round depending on model selection.

---

## Autonomous Tester (Step 19)

The tester drives your app end-to-end via Chrome DevTools Protocol — clicks every button, fills every form, watches console + network + DOM for regressions, and writes a 4-state verdict:

- `READY-FOR-PUBLIC` — ship it
- `READY-WITH-CAVEATS` — works, with documented limitations
- `BLOCKED` — bugs found; auto-fix loop kicks in (max 3 iterations)
- `NEEDS-USER` — destructive gates / charge flows / async jobs require human approval

No more "okay you go test it now" handoffs. The pipeline tests itself.

---

## Auto-CLAUDE.md Hook

After every session, the hook reads `MISTAKES.md` from your project root, extracts prevention rules (`Prevention:`, `Rule:`, `Never:`, `Always:` markers), and appends them to your project's `CLAUDE.md` under an `Auto-Learned Rules` section. Capped at 20 rules / 150 lines so CLAUDE.md doesn't bloat.

This is opt-in — the hook only runs if you copied it to `~/.claude/hooks/`. The installer does this by default; remove the file to opt out. See [SECURITY.md](SECURITY.md) for the threat model.

---

## Requirements

- [Claude Code](https://claude.ai/code) ≥ 2.1.64 (older versions are vulnerable to CVE-2026-39861 sandbox escape)
- For Elite Mode: Python 3.11+ with `aiohttp`, OpenRouter API key
- For Step 19 tester: a browser installed (Chrome by default; tester uses CDP)

---

## License

MIT — see [LICENSE](LICENSE). Free forever. No paywall. No catch.

---

<p align="center">
  <strong>Built by <a href="https://github.com/MEHDIGAMER">@MEHDIGAMER</a></strong><br>
  <em>Stop building alone. Start building with a team.</em>
</p>
