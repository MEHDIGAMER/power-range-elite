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

Power-Range Elite is a set of **local markdown files** that define Claude Code slash commands and agent behaviors. The security model is:

### What these files CAN do
- Define instructions for Claude Code's AI agents (text prompts)
- Copy files to `~/.claude/commands/` and `~/.claude/agents/`

### What these files CANNOT do
- Execute arbitrary code on install (install scripts only use `cp`/`Copy-Item`)
- Make network calls (no `curl`, `wget`, `fetch` in install scripts)
- Access your filesystem beyond `~/.claude/` (install scripts are scoped)
- Exfiltrate data (no outbound connections in any file)
- Modify system settings (no `sudo`, no registry edits, no PATH changes)

### The one file with network capability
`commands/power-range-escalate.md` contains `curl` commands to 4 AI APIs (OpenAI, Gemini, DeepSeek, xAI). These use **your own API keys** from environment variables and only run when you explicitly invoke `/power-range-escalate`. The URLs are hardcoded to official API endpoints only.

### Protections in place
- **Branch protection** on `main` — no direct pushes, PRs require owner review
- **CODEOWNERS** — every file change requires @MEHDIGAMER approval
- **Force pushes blocked** — history cannot be rewritten
- **Branch deletion blocked** — main cannot be deleted
- **Stale review dismissal** — approved PRs are re-reviewed if changed after approval
- **Admin enforcement** — even repo owner must follow PR rules
- **SHA-256 checksums** — verify file integrity after install (see `checksums.sha256`)

## Verifying Your Installation

After installing, run the verification script to ensure no files were tampered with:

```bash
# From the cloned repo directory
bash verify.sh
```

Or manually verify checksums:
```bash
sha256sum -c checksums.sha256
```

## Known Attack Vectors for Claude Code Skills

These are the attacks we specifically defend against:

| Attack | Defense |
|--------|---------|
| Malicious PR modifying agent behavior | CODEOWNERS + required review |
| Install script running hidden commands | Install scripts are `cp` only — auditable in 30 seconds |
| Prompt injection in agent .md files | All agents write to local `.power-range/session/` only |
| Fork + modify + social engineer merge | Branch protection + admin enforcement |
| Release hijacking | Checksums verify integrity |
| Force push to overwrite history | Force pushes blocked on main |
