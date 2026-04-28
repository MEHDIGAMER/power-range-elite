#!/bin/bash
# Power-Range Elite — Installer for Claude Code
# v3.0: 20-step pipeline + elite debate layer + autonomous tester + auto CLAUDE.md hook

set -e

CLAUDE_DIR="$HOME/.claude/commands"
HOOKS_DIR="$HOME/.claude/hooks"
SKILLS_DIR="$HOME/.claude/skills/power-range-tester"
RANGERS_DIR="$HOME/.power-rangers"
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
echo "  E L I T E   v3.0"
echo "  20-Step Pipeline. 10-Model Debate. Autonomous Tester. Zero Shortcuts."
echo ""

mkdir -p "$CLAUDE_DIR" "$HOOKS_DIR" "$SKILLS_DIR" "$RANGERS_DIR"

# Slash commands
echo "  Installing slash commands..."
cp "$SCRIPT_DIR/commands/power-range.md"          "$CLAUDE_DIR/power-range.md"
echo "    ✓ /power-range          — 20-step pipeline (CTO + agent team)"
cp "$SCRIPT_DIR/commands/elite-power-range.md"    "$CLAUDE_DIR/elite-power-range.md"
echo "    ✓ /elite-power-range    — same pipeline + 10-model OpenRouter debate"
cp "$SCRIPT_DIR/commands/power-load.md"           "$CLAUDE_DIR/power-load.md"
echo "    ✓ /power-load           — one-time project setup"
cp "$SCRIPT_DIR/commands/power-mapout.md"         "$CLAUDE_DIR/power-mapout.md"
echo "    ✓ /power-mapout         — codebase intelligence mapper"
cp "$SCRIPT_DIR/commands/power-range-escalate.md" "$CLAUDE_DIR/power-range-escalate.md"
echo "    ✓ /power-range-escalate — pipeline escalation"

# Tester skill
echo ""
echo "  Installing tester skill..."
cp "$SCRIPT_DIR/skills/power-range-tester/SKILL.md" "$SKILLS_DIR/SKILL.md"
echo "    ✓ power-range-tester    — autonomous Step 19 tester (drives app via CDP)"

# Hook
echo ""
echo "  Installing auto-CLAUDE.md hook..."
cp "$SCRIPT_DIR/hooks/power-range-claude-md-updater.js" "$HOOKS_DIR/"
echo "    ✓ power-range-claude-md-updater.js"

# Elite mode runtime
echo ""
echo "  Installing elite-mode runtime..."
cp "$SCRIPT_DIR/debate_runner.py" "$RANGERS_DIR/debate_runner.py"
if [ ! -f "$RANGERS_DIR/config.json" ]; then
  cp "$SCRIPT_DIR/config.example.json" "$RANGERS_DIR/config.json"
  echo "    ✓ debate_runner.py + config.json (template — paste your OpenRouter key)"
else
  echo "    ✓ debate_runner.py (existing config.json kept untouched)"
fi

echo ""
echo "  ✅ Installation complete!"
echo ""
echo "  Quick start:"
echo "    1. Open any project in Claude Code"
echo "    2. /power-load           — one-time project setup"
echo "    3. /power-mapout         — optional: map your codebase"
echo "    4. /power-range          — build with the 20-step pipeline"
echo ""
echo "  Want elite mode (10 AI consultants in parallel)?"
echo "    a. Get an OpenRouter key:  https://openrouter.ai/keys"
echo "    b. pip install aiohttp"
echo "    c. Edit  $RANGERS_DIR/config.json  (or export OPENROUTER_API_KEY)"
echo "    d. Use   /elite-power-range   instead of /power-range"
echo ""
echo "  Free. No paywall."
echo ""
