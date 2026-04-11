#!/bin/bash
# Power-Range Elite — Installer for Claude Code
# Installs all 4 slash commands globally so they work in any project.

set -e

CLAUDE_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "  ██████╗  ██████╗ ██╗    ██╗███████╗██████╗"
echo "  ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗"
echo "  ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝"
echo "  ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗"
echo "  ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║"
echo "  ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝"
echo "  ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗"
echo "  ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔════╝"
echo "  ██████╔╝███████║██╔██╗ ██║██║  ███╗█████╗  "
echo "  ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══╝  "
echo "  ██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗"
echo "  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝"
echo ""
echo "  E L I T E"
echo "  18 AI Agents. 13-Step Pipeline. Zero Shortcuts."
echo ""

# Create commands directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# Copy all command files
echo "  Installing commands..."
cp "$SCRIPT_DIR/commands/power-range.md" "$CLAUDE_DIR/power-range.md"
echo "    ✓ /power-range     — CTO Orchestrator (18 agents, full pipeline)"
cp "$SCRIPT_DIR/commands/power-load.md" "$CLAUDE_DIR/power-load.md"
echo "    ✓ /power-load      — Project installer (PRD, rules, config)"
cp "$SCRIPT_DIR/commands/power-mapout.md" "$CLAUDE_DIR/power-mapout.md"
echo "    ✓ /power-mapout    — Codebase intelligence mapper"
cp "$SCRIPT_DIR/commands/power-range-escalate.md" "$CLAUDE_DIR/power-range-escalate.md"
echo "    ✓ /power-range-escalate — Pipeline escalation"

echo ""
echo "  ✅ Installation complete!"
echo ""
echo "  Usage:"
echo "    1. Open any project in Claude Code"
echo "    2. Run: /power-load          (one-time project setup)"
echo "    3. Run: /power-mapout        (optional: map codebase for faster debugging)"
echo "    4. Run: /power-range         (start building with 18 agents)"
echo ""
echo "  That's it. No API keys, no subscriptions, no paywall."
echo "  Just Claude Code + Power-Range = full engineering team."
echo ""
