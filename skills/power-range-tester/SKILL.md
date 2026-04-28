---
name: power-range-tester
description: Run the autonomous tester on an Electron app or website. Drives the app end-to-end via Chrome DevTools Protocol, clicks through every feature from the session spec with destructive-gate + invariant + visual-audit checks, issues a 4-state verdict (READY-FOR-PUBLIC / READY-WITH-CAVEATS / BLOCKED / NEEDS-USER), and on BLOCKED triggers an auto-fix loop that routes bugs to the right engineers and re-tests (max 3 iterations). Use when the user says "test the app", "run tester", "verify ready to ship", or when /power-range / /elite-power-range reaches Step 19.
---

# Power-Range Tester

Active, autonomous UI testing. No manual clicking. Replaces pair-testing.

## When to invoke

- End of a `/power-range` or `/elite-power-range` session (Step 19)
- User says "test it", "is it ready?", "tester", "verify the app"
- After any engineer claims a UI feature is done

## Prerequisites (check first)

```bash
agent-browser --version         # >= 0.26 required
which agent-browser             # must resolve
```

If missing:
```bash
npm install -g agent-browser && agent-browser install
```

## Inputs

Required from the user (ask if missing):
- **Target**: Electron app path OR URL (e.g. `http://localhost:3000`)
- **Session spec location** (default: `.power-rangers/session/00.5-spec.md`)

Optional:
- **Scope**: specific features to prioritize (comma-separated). Default: everything in the spec.
- **Credentials**: if auth is required. Do NOT hardcode — read from existing `.env.*` files.

## Execution

Delegate to the `tester` sub-agent:

```
Use the Agent tool with subagent_type=tester and prompt:
"Run the full Step 0-10 tester protocol against <TARGET>.
Session spec: <SPEC PATH>.
Scope: <SCOPE or 'all features in spec'>.
Write the report to .power-rangers/session/19-tester-report.md and
the verdict to .power-rangers/session/19-verdict.txt."
```

The tester agent handles preflight, launch, CDP connect, feature drive, visual audit, and report.

## Post-run

Read `.power-rangers/session/19-verdict.txt`. One of:

| Verdict | CTO next action |
|---------|-----------------|
| `READY-FOR-PUBLIC` | Show the report summary. Proceed to session close. |
| `BLOCKED` | Show the bug list. Route each critical bug back to the right engineer (frontend, backend, integration). Re-run tester when fixes claim done. |
| `NEEDS-USER` | Show the NEEDS-USER items. Ask the user to complete those specific flows manually, then merge results into the report. |

## Leverage agent-browser's built-in skills

The tester internally uses:
- `agent-browser skills get core` — snapshot/click/fill mechanics
- `agent-browser skills get electron` — Electron CDP launch patterns
- `agent-browser skills get dogfood` — exploration + issue documentation pattern

Do not reimplement these. Let the tester orchestrate them.

## Fallback

If `agent-browser connect` fails 3 times or the target is a non-Chromium native app, the tester drops to legacy pair-testing mode:
- Existing `~/.claude/scripts/cdp-listener.js` captures what it can
- User is asked to click manually
- Tester still produces the same report format

Never silently downgrade. Always tell the user why.

## Destructive actions

The tester will NOT click destructive buttons (delete-all, broadcast, charge, purge, reset-data, etc.) without an explicit `YES` on the terminal. This is hardcoded and not configurable.

## Integration with power-range scorecard

The tester's verdict becomes the gate on session close:
- `READY-FOR-PUBLIC` → session closes with green scorecard
- `BLOCKED` → CTO spawns fix-cycle, re-runs tester, does NOT close until green
- `NEEDS-USER` → session closes with yellow scorecard + pending manual items list
