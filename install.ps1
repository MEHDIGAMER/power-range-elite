# Power-Range Elite — Installer for Claude Code (Windows)
# Installs all 4 slash commands globally so they work in any project.

$ErrorActionPreference = "Stop"

$ClaudeDir = "$env:USERPROFILE\.claude\commands"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "  POWER-RANGE ELITE" -ForegroundColor Yellow
Write-Host "  18 AI Agents. 13-Step Pipeline. Zero Shortcuts." -ForegroundColor DarkGray
Write-Host ""

# Create commands directory
if (-not (Test-Path $ClaudeDir)) {
    New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
}

# Copy command files
Write-Host "  Installing commands..." -ForegroundColor White
Copy-Item "$ScriptDir\commands\power-range.md" "$ClaudeDir\power-range.md" -Force
Write-Host "    + /power-range          — CTO Orchestrator (18 agents)" -ForegroundColor Green
Copy-Item "$ScriptDir\commands\power-load.md" "$ClaudeDir\power-load.md" -Force
Write-Host "    + /power-load           — Project installer" -ForegroundColor Green
Copy-Item "$ScriptDir\commands\power-mapout.md" "$ClaudeDir\power-mapout.md" -Force
Write-Host "    + /power-mapout         — Codebase mapper" -ForegroundColor Green
Copy-Item "$ScriptDir\commands\power-range-escalate.md" "$ClaudeDir\power-range-escalate.md" -Force
Write-Host "    + /power-range-escalate — Pipeline escalation" -ForegroundColor Green

Write-Host ""
Write-Host "  Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "  Usage:" -ForegroundColor White
Write-Host "    1. Open any project in Claude Code"
Write-Host "    2. Run: /power-load          (one-time project setup)"
Write-Host "    3. Run: /power-mapout        (optional: map codebase)"
Write-Host "    4. Run: /power-range         (start building with 18 agents)"
Write-Host ""
Write-Host "  Free. No paywall. No API keys." -ForegroundColor DarkGray
Write-Host ""
