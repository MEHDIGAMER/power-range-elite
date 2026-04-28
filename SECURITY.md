# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| latest (main branch) | Yes |

## Reporting a Vulnerability

If you discover a security vulnerability in Power-Range Elite, **do NOT open a public issue.**

Instead, email: **security@blax.dev** or DM [@daddyblaxing](https://github.com/MEHDIGAMER) directly on GitHub.

You will receive a response within 48 hours.

## Security Design

Power-Range Elite is a set of **local markdown files, one Node.js hook, one Python debate runner, and one Markdown skill** that define Claude Code slash commands and agent behaviors. The security model is:

### What these files CAN do
- Define instructions for Claude Code's AI agents (text prompts in the `.md` files)
- Copy files to `~/.claude/commands/`, `~/.claude/hooks/`, `~/.claude/skills/`, and `~/.power-rangers/` (installer scope only)
- The hook reads `MISTAKES.md` from your project root and appends extracted rules to your project's `CLAUDE.md`
- The Step 19 tester drives a browser via Chrome DevTools Protocol (only when you invoke `/power-range` and reach Step 19)
- The Elite Mode debate runner makes network calls to `openrouter.ai` (only when you invoke `/elite-power-range` and only with your own API key)

### What these files CANNOT do
- Execute arbitrary code on install (install scripts only use `cp`/`Copy-Item`, no `eval`, no `curl | bash`)
- Read files outside your project root or Claude Code's standard scope
- Exfiltrate data to anywhere other than openrouter.ai (only in Elite Mode, only with your key)
- Modify system settings (no `sudo`, no registry edits, no PATH changes)
- Persist credentials anywhere — your OpenRouter key lives only in `~/.power-rangers/config.json` (which is in `.gitignore`) or your `OPENROUTER_API_KEY` environment variable

### Files with network capability (full disclosure)

| File | When it makes network calls | To where |
|---|---|---|
| `commands/power-range-escalate.md` | Only when you invoke `/power-range-escalate` | OpenAI, Gemini, DeepSeek, xAI APIs (uses YOUR keys from env) |
| `debate_runner.py` | Only when Elite Mode triggers a debate (`/elite-power-range` or `/debate`) | `openrouter.ai/api/v1/chat/completions` (uses YOUR key from `~/.power-rangers/config.json` or `$OPENROUTER_API_KEY`) |
| `skills/power-range-tester/SKILL.md` (when activated) | Only at Step 19 when the tester drives your app | Localhost / your dev server only — does not call out |

No other files in this repository make any network requests.

### What the hook does (in detail)

`hooks/power-range-claude-md-updater.js` is pure Node.js file I/O:

1. Finds the project root (looks for `package.json`, `.git`, or `CLAUDE.md`)
2. Reads `MISTAKES.md` if present
3. Extracts lines starting with `Prevention:`, `Rule:`, `Never:`, `Always:`, etc.
4. Appends them to your project's `CLAUDE.md` under an `Auto-Learned Rules (Power-Range)` section
5. Caps the section at 20 rules and the file at 150 lines

It does NOT execute shell commands, make network requests, or read files outside the project root. Audit it in 60 seconds — it's 220 lines of `fs.readFileSync` / `fs.writeFileSync` and string parsing.

### Protections in place
- **Branch protection** on `main` — no direct pushes, PRs require owner review
- **CODEOWNERS** — every file change requires @MEHDIGAMER approval
- **Force pushes blocked** — history cannot be rewritten
- **Branch deletion blocked** — main cannot be deleted
- **Stale review dismissal** — approved PRs are re-reviewed if changed after approval
- **Admin enforcement** — even repo owner must follow PR rules
- **`.gitignore` covers secrets** — `config.json`, `.env*`, `debates/`, `session/`, runtime artifacts excluded by default

### OpenRouter key safety

If you use Elite Mode, your OpenRouter key is sensitive. Recommended order of preference:

1. **Environment variable** (best): `export OPENROUTER_API_KEY=sk-or-v1-...` — never touches disk
2. **Config file** (acceptable): paste into `~/.power-rangers/config.json` — covered by `.gitignore`, but readable by anything with home-dir access
3. **NEVER** commit your real key to a fork or screenshot a session containing it

`debate_runner.py` reads in this order: `$POWER_RANGE_CONFIG` (custom path) → `~/.power-rangers/config.json` → `$OPENROUTER_API_KEY`. The fallback chain lets you pick the storage that fits your threat model.

## Recommended Hardening

If your machine handles production credentials (payment keys, session tokens, infrastructure secrets), add these to `~/.claude/settings.json` before installing power-range:

```json
{
  "permissions": {
    "deny": [
      "Read(~/.ssh/**)",
      "Read(~/.aws/**)",
      "Write(~/.ssh/**)",
      "Write(~/.aws/**)",
      "Bash(curl * | bash)",
      "Bash(curl * | sh)",
      "Bash(wget * | bash)",
      "Bash(ssh *)",
      "Bash(scp *)",
      "Bash(nc *)"
    ],
    "ask": [
      "Read(**/.env)",
      "Read(**/.env.*)",
      "Write(**/.env)",
      "Write(**/.env.*)"
    ]
  }
}
```

These rules apply globally to your Claude Code agent (not just power-range) and protect against malicious repo-controlled `CLAUDE.md` files (CVE-2025-59536, CVE-2026-21852).

## Known Attack Vectors for Claude Code Skills

These are the attacks we specifically defend against:

| Attack | Defense |
|--------|---------|
| Malicious PR modifying agent behavior | CODEOWNERS + required review |
| Install script running hidden commands | Install scripts are `cp`/`Copy-Item` only — auditable in 30 seconds |
| Prompt injection in agent .md files | All agents write to local `.power-range/session/` only |
| Fork + modify + social engineer merge | Branch protection + admin enforcement |
| Release hijacking | Pin to a specific commit SHA when forking — do not use `@latest` blindly |
| Force push to overwrite history | Force pushes blocked on main |
| Hidden Unicode / bidirectional control chars | None present in this repo (audit step in pre-release checklist) |
| Hardcoded credentials | None present in this repo |

## Audit Checklist Before Forking

If you fork this repo, run these checks to confirm no malicious additions:

```bash
# 1. No malicious shell patterns
grep -rE "curl.*\|.*sh|wget.*\|.*sh|eval\(|exec\(|ANTHROPIC_BASE_URL|enableAllProjectMcpServers" .
# Must return nothing.

# 2. No hardcoded credentials
grep -rE "sk-(or|ant|proj)-v1-[a-zA-Z0-9]{20,}|gh[ps]_[a-zA-Z0-9]{30,}|AKIA[0-9A-Z]{16}" .
# Must return nothing.

# 3. No hidden bidi/zero-width Unicode in commands
python -c "import re,sys; p=re.compile(r'[​-‏⁠-⁯﻿‪-‮]'); [print(f) for f in sys.argv[1:] if p.search(open(f,encoding='utf-8').read())]" commands/*.md
# Must print nothing.

# 4. No suspicious post-install behavior
cat install.sh install.ps1
# Must contain only cp/mkdir or Copy-Item/New-Item commands.
```
