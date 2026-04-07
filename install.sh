#!/bin/bash
# ============================================================
#  POWER-RANGE ELITE — Installer
#  18 AI Agents. 13-Step Quality Pipeline. Zero Shortcuts.
# ============================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

clear

echo ""
echo -e "${RED}    ██████╗  ██████╗ ██╗    ██╗███████╗██████╗ ${NC}"
echo -e "${RED}    ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗${NC}"
echo -e "${YELLOW}    ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝${NC}"
echo -e "${CYAN}    ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗${NC}"
echo -e "${MAGENTA}    ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║${NC}"
echo -e "${MAGENTA}    ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝${NC}"
echo ""
echo -e "${WHITE}    ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗${NC}"
echo -e "${WHITE}    ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔════╝${NC}"
echo -e "${GREEN}    ██████╔╝███████║██╔██╗ ██║██║  ███╗█████╗  ${NC}"
echo -e "${GREEN}    ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══╝  ${NC}"
echo -e "${CYAN}    ██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗${NC}"
echo -e "${CYAN}    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝${NC}"
echo ""
echo -e "${DIM}    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}              E L I T E   E D I T I O N${NC}"
echo -e "${DIM}       18 Agents. 13 Steps. Zero Shortcuts.${NC}"
echo -e "${DIM}    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 1

# ── Detect OS ──
CLAUDE_DIR=""
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "mingw"* || "$OSTYPE" == "cygwin" ]]; then
    CLAUDE_DIR="$USERPROFILE/.claude"
    # Also try standard path
    if [ -z "$USERPROFILE" ]; then
        CLAUDE_DIR="$HOME/.claude"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    CLAUDE_DIR="$HOME/.claude"
else
    CLAUDE_DIR="$HOME/.claude"
fi

COMMANDS_DIR="$CLAUDE_DIR/commands"
AGENTS_DIR="$CLAUDE_DIR/agents"

# ── Verify Claude Code exists ──
echo -e "${CYAN}[1/6]${NC} ${WHITE}Checking prerequisites...${NC}"
sleep 0.5

if ! command -v claude &> /dev/null; then
    echo -e "  ${YELLOW}!${NC} Claude Code CLI not found in PATH"
    echo -e "  ${DIM}Install it first: https://docs.anthropic.com/en/docs/claude-code${NC}"
    echo -e "  ${DIM}Continuing anyway — files will be placed in $CLAUDE_DIR${NC}"
else
    echo -e "  ${GREEN}+${NC} Claude Code CLI detected"
fi

if [ -d "$CLAUDE_DIR" ]; then
    echo -e "  ${GREEN}+${NC} Claude directory found: $CLAUDE_DIR"
else
    echo -e "  ${YELLOW}!${NC} Creating Claude directory: $CLAUDE_DIR"
    mkdir -p "$CLAUDE_DIR"
fi

echo ""

# ── Create directories ──
echo -e "${CYAN}[2/6]${NC} ${WHITE}Preparing directories...${NC}"
sleep 0.5
mkdir -p "$COMMANDS_DIR"
mkdir -p "$AGENTS_DIR"
echo -e "  ${GREEN}+${NC} $COMMANDS_DIR"
echo -e "  ${GREEN}+${NC} $AGENTS_DIR"
echo ""

# ── Get script directory ──
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Install Commands ──
echo -e "${CYAN}[3/6]${NC} ${WHITE}Installing Power-Range commands...${NC}"
sleep 0.3

commands=("power-range.md" "power-load.md" "power-range-escalate.md")
for cmd in "${commands[@]}"; do
    if [ -f "$SCRIPT_DIR/commands/$cmd" ]; then
        cp "$SCRIPT_DIR/commands/$cmd" "$COMMANDS_DIR/$cmd"
        name="${cmd%.md}"
        echo -e "  ${GREEN}+${NC} /${name} installed"
    else
        echo -e "  ${RED}x${NC} $cmd not found in package!"
    fi
    sleep 0.2
done
echo ""

# ── Install Agents ──
echo -e "${CYAN}[4/6]${NC} ${WHITE}Deploying 18 elite agents...${NC}"
sleep 0.3

agent_names=(
    "cto"
    "bookkeeper"
    "prompt-translator"
    "what-if-agent"
    "architect"
    "backend-engineer"
    "frontend-engineer"
    "challenger"
    "integration-engineer"
    "role-access-engineer"
    "security-sentinel"
    "test-coverage-engineer"
    "qa-engineer"
    "code-reviewer"
    "business-kpi-analyst"
    "tester"
    "documentation-engineer"
    "tech-lead"
)

agent_labels=(
    "CTO Orchestrator"
    "Bookkeeper (Architecture Memory)"
    "Prompt Translator"
    "What-If Agent (Failure Simulator)"
    "Architect (Technical Planner)"
    "Backend Engineer"
    "Frontend Engineer"
    "Challenger (Adversarial Reviewer)"
    "Integration Engineer"
    "Role & Access Engineer"
    "Security Sentinel"
    "Test Coverage Engineer"
    "QA Engineer"
    "Code Reviewer"
    "Business KPI Analyst"
    "Tester (Live App Testing)"
    "Documentation Engineer"
    "Tech Lead (Final Gate)"
)

count=0
total=${#agent_names[@]}
for i in "${!agent_names[@]}"; do
    agent="${agent_names[$i]}"
    label="${agent_labels[$i]}"
    file="$SCRIPT_DIR/agents/${agent}.md"

    if [ -f "$file" ]; then
        cp "$file" "$AGENTS_DIR/${agent}.md"
        count=$((count + 1))
        printf "  ${GREEN}+${NC} [%2d/%d] %s\n" "$count" "$total" "$label"
    else
        printf "  ${RED}x${NC} [%2d/%d] %s — NOT FOUND\n" "$((i+1))" "$total" "$label"
    fi
    sleep 0.15
done
echo ""

# ── Verify Installation ──
echo -e "${CYAN}[5/6]${NC} ${WHITE}Verifying installation...${NC}"
sleep 0.5

errors=0

# Check commands
for cmd in "${commands[@]}"; do
    if [ -f "$COMMANDS_DIR/$cmd" ]; then
        echo -e "  ${GREEN}✓${NC} $cmd"
    else
        echo -e "  ${RED}✗${NC} $cmd MISSING"
        errors=$((errors + 1))
    fi
done

# Check agents
agent_count=$(ls -1 "$AGENTS_DIR"/*.md 2>/dev/null | wc -l)
echo -e "  ${GREEN}✓${NC} $agent_count agent files in $AGENTS_DIR"

if [ $errors -gt 0 ]; then
    echo ""
    echo -e "  ${RED}! $errors file(s) failed to install${NC}"
    echo -e "  ${DIM}Try running the installer again${NC}"
else
    echo -e "  ${GREEN}✓${NC} All files verified"
fi
echo ""

# ── Done ──
echo -e "${CYAN}[6/6]${NC} ${WHITE}Installation complete!${NC}"
echo ""
echo -e "${DIM}    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}${BOLD}POWER-RANGE ELITE IS NOW INSTALLED${NC}"
echo ""
echo -e "  ${WHITE}Commands available:${NC}"
echo -e "    ${CYAN}/power-load${NC}             First-time project setup"
echo -e "    ${CYAN}/power-range${NC}            Run the full 13-step pipeline"
echo -e "    ${CYAN}/power-range-escalate${NC}   Escalate failures to 4 AI models"
echo ""
echo -e "  ${WHITE}Quick start:${NC}"
echo -e "    ${DIM}1.${NC} Open Claude Code in your project"
echo -e "    ${DIM}2.${NC} Type ${CYAN}/power-load${NC} to install on the project"
echo -e "    ${DIM}3.${NC} Type ${CYAN}/power-range${NC} + describe what you want"
echo ""
echo -e "  ${YELLOW}Power-Range is getting dangerous.${NC}"
echo -e "  ${RED}${BOLD}Power-Range will solve everything.${NC}"
echo ""
echo -e "${DIM}    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
