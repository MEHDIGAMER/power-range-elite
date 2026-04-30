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
  <img src="https://img.shields.io/badge/red%20team-MITRE%20ATT%26CK-red?style=for-the-badge" alt="Red Team MITRE ATT&CK">
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
| `/elite-power-security` | Defense + offense — 7-layer fortress + 11-step pipeline including the **Verification Assassins** Red Team (see below) |

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

# Skills
mkdir -p ~/.claude/skills/power-range-tester ~/.claude/skills/elite-power-security
cp skills/power-range-tester/SKILL.md ~/.claude/skills/power-range-tester/
cp skills/elite-power-security/SKILL.md ~/.claude/skills/elite-power-security/

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

## Elite Power-Security (defense + Red Team)

A bundled security skill inspired by **Caelum Bank** from *The Blacklist* (S9E20). Make attacking your project so expensive and noisy that no rational attacker continues — then send in the Red Team to *prove* it.

**Invoke:** `/elite-power-security` in any project.

**What it does** — runs an **11-step pipeline** that produces a `.security/` folder tailored to your stack:

**Defensive half (Steps 1–10):**

1. **Profile** — reads your stack, hosting, data model, API surface
2. **Attack surface map** — names every realistic attacker and likely attack
3. **Threat triage** — drops noise, focuses on top 3-5 real risks
4. **Fortress plan** — picks which of the 7 defense layers apply
5. **Tripwire placement** — decoy routes, files, users, canary tokens
6. **Exposure pipeline** — capture → score (AbuseIPDB / Spamhaus / Tor) → block → alert
7. **Autonomy** — uptime + log shipping + Telegram on-call
8. **Rotation plan** — secrets, instances, sessions, deps
9. **Pen-test dry run** — `nuclei` + `nmap` + OWASP top-10
10. **Continuous guard** — daily cron re-runs Step 9 from outside

**Offensive half (Step 11):**

11. **Verification Assassins (Red Team)** — target-agnostic adversarial simulation that proves the fortress works (see below)

### The 7-Layer Flying Fortress

| # | Layer | Real-world implementation |
|---|---|---|
| 1 | No fixed jurisdiction | Multi-provider VPS rotation, OR (serverless) accept platform = jurisdiction |
| 2 | No GPS transponder | Cloudflare in front of every origin; real IP unreachable directly |
| 3 | No flight plans | No public DNS A records to origin; CNAMEs through Cloudflare; privacy WHOIS |
| 4 | ECC crypto on servers | Per-tenant data keys via HKDF from a master in Vault/KMS; in-memory decrypt only |
| 5 | Number-only IDs | Pseudonymous tenant IDs in primary store; PII isolated in stricter store |
| 6 | Verified clients only | mTLS service-to-service; WebAuthn hardware key for admin; no passwords for ops |
| 7 | No chairman SPOF | Multi-region HA; break-glass in sealed envelope, not a single brain |

### Implementation order (highest leverage first)

If you only have one weekend, do these in order:

1. **Cloudflare in front of every origin** — 1h, kills 90% of direct attacks (Layers 2+3)
2. **Honeypot routes + IP capture** — 2h, every scanner trips immediately
3. **WireGuard for SSH** *(VPS only)* — 1h, kills SSH bruteforce permanently
4. **Canary tokens** — 30min, catches insider/leak
5. **AbuseIPDB scoring + auto-block** — 2h, weaponizes intel
6. **Telegram alerts** — 1h, makes the whole thing 24/7

That's **~7 hours from "wide open" to Caelum Bank tier**. Everything else is incremental.

### The Verification Assassins (Red Team module)

> *Validated by 9/10 OpenRouter models in adversarial review. Avg credibility 8.1/10. GPT-4.1: "the most elite, concrete, and credible Red Team playbook I've seen."*

Step 11 is not a pen-test. It's a **target-agnostic adversarial simulation** that hunts the way a motivated attacker hunts. Vague blueprint only — recons the rest. Chains business-logic flaws into kill paths. Emits findings engineers can patch *tonight*.

**Framework spine: MITRE ATT&CK** — every action maps to a technique ID. Supplemented by PTES (engagement flow), OWASP WSTG (web/mobile depth), TIBER-EU (intel-led scenarios).

**Target dispatcher** — auto-detects type and runs the right playbook:

| Target | Sample elite techniques |
|---|---|
| **Web / SaaS** | GraphQL introspection abuse, JWT alg confusion, request smuggling, OAuth redirect hijack |
| **API-only** | Schemathesis fuzzing, BOLA/BOPLA, HTTP/2 multiplexing rate-limit bypass, webhook SSRF chains |
| **Mobile** | Frida runtime hooks, cert pinning bypass, deep-link fuzzing, SafetyNet attestation bypass |
| **Electron** | ASAR extraction, nodeIntegration/contextIsolation bypass, DevTools port abuse, code-signing downgrade |
| **VPS / cloud** | Multi-cloud IMDS abuse (AWS+Azure+GCP), Leaky Vessels (CVE-2024-21626), kubelet API, IAM escalation |
| **Static site** | DNS/CNAME takeover, CDN cache poisoning, third-party JS supply chain, typosquat clones |

**Plus modern 2026 cross-cutting surfaces:** SAML/SSO (XSW, assertion replay), AI/LLM (prompt injection, tool hijack, system-prompt extraction), browser extensions (Manifest V3, externally_connectable), supply chain attestation (SLSA, Sigstore, SBOM diff), client-side prototype pollution, WebSockets.

**11-phase MITRE-mapped kill chain** — Reconnaissance → Initial Access → Execution → Privilege Escalation → Persistence → Defense Evasion → Credential Access → Discovery → Lateral Movement → Collection + Exfiltration → Impact (always dry-run).

**The 2026 tool stack** (debate-validated, every tool named by 5+ models):

`Caido` (modern proxy, replaces Burp) · `Nuclei v3 + AI templates` · `JA4+/JA4h` (TLS+HTTP fingerprint manipulation) · `GraphQL Voyager + InQL` · `kubehound` · `Frida` · `TruffleHog v3` · `Schemathesis` · `jwt_tool` · `MobSF`

**Reporting standard — CVSS alone is dead.** Every finding ships with: MITRE technique ID, EPSS score, SSVC decision, business-impact USD estimate, repro steps with curl/PoC, blast radius, suggested fix code, **and a mandatory fix-unit-test** that closes the finding only when it passes.

**Defense validation — the moment of truth.** After the Assassins finish, every fortress layer gets graded: did the Cloudflare WAF catch us? Did AbuseIPDB score us? Did the canary token alert? The fortress doesn't get full marks until every column is `✅ YES`.

**Continuous mode:**

- Nightly `0 2 * * *` UTC — asset-diff recon (changed routes / new commits / DNS diffs)
- Weekly `0 3 * * 6` UTC — full kill chain on **staging only**
- Circuit breaker on 3+ consecutive 5XX → pauses + pages founder
- Founder can abort everything in 30s by writing `.security/redteam/STOP`

**Mandatory legal boundaries** — before any active testing, the skill writes a clearance file covering residential proxy ToS, CFAA / NIS2 / Computer Misuse Act, cloud pen-test policies, GDPR for captured fingerprints, and WireGuard SSH-lockout fallbacks. The founder signs each line. **No active testing without sign-off.**

**Output** — `.security/redteam/`:
```
00-rules-of-engagement.md  ← scope, time window, forbidden ops
00b-legal-clearance.md     ← signed before active testing
01-recon.md                ← what an attacker would discover
02-attack-tree.md          ← per-target-type chains
03-findings/               ← one MITRE-tagged file per finding
04-kill-chain-narrative.md ← outside → crown jewels, the story
05-defenses-validated.md   ← which fortress layers caught us
06-recommendations.md      ← ranked patches (EPSS × business impact)
```

> **Elite vs basic — one sentence:** elite Red Teams chain business-logic flaws into kill paths across the supply chain; basic pen-tests check OWASP top-10 on the primary application.

> Honest framing: "unhackable" doesn't exist. This skill drives **attacker cost-to-breach above attacker patience** — economically prohibitive, not bulletproof.

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
