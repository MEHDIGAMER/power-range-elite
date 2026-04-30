# Power-Range Elite — Installer for Claude Code (Windows)
# v3.0: 20-step pipeline + elite debate layer + autonomous tester + auto CLAUDE.md hook

$ErrorActionPreference = "Stop"

$ClaudeDir   = "$env:USERPROFILE\.claude\commands"
$HooksDir    = "$env:USERPROFILE\.claude\hooks"
$SkillsDir   = "$env:USERPROFILE\.claude\skills\power-range-tester"
$SecSkillDir = "$env:USERPROFILE\.claude\skills\elite-power-security"
$RangersDir  = "$env:USERPROFILE\.power-rangers"
$ScriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "  POWER-RANGE ELITE  v3.0" -ForegroundColor Yellow
Write-Host "  20-Step Pipeline. 10-Model Debate. Autonomous Tester." -ForegroundColor DarkGray
Write-Host ""

foreach ($d in @($ClaudeDir, $HooksDir, $SkillsDir, $SecSkillDir, $RangersDir)) {
    if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

# Slash commands
Write-Host "  Installing slash commands..." -ForegroundColor White
Copy-Item "$ScriptDir\commands\power-range.md"          "$ClaudeDir\power-range.md" -Force
Write-Host "    + /power-range          — 20-step pipeline (CTO + agent team)" -ForegroundColor Green
Copy-Item "$ScriptDir\commands\elite-power-range.md"    "$ClaudeDir\elite-power-range.md" -Force
Write-Host "    + /elite-power-range    — same pipeline + 10-model OpenRouter debate" -ForegroundColor Green
Copy-Item "$ScriptDir\commands\power-load.md"           "$ClaudeDir\power-load.md" -Force
Write-Host "    + /power-load           — one-time project setup" -ForegroundColor Green
Copy-Item "$ScriptDir\commands\power-mapout.md"         "$ClaudeDir\power-mapout.md" -Force
Write-Host "    + /power-mapout         — codebase intelligence mapper" -ForegroundColor Green
Copy-Item "$ScriptDir\commands\power-range-escalate.md" "$ClaudeDir\power-range-escalate.md" -Force
Write-Host "    + /power-range-escalate — pipeline escalation" -ForegroundColor Green

# Skills
Write-Host ""
Write-Host "  Installing skills..." -ForegroundColor White
Copy-Item "$ScriptDir\skills\power-range-tester\SKILL.md" "$SkillsDir\SKILL.md" -Force
Write-Host "    + power-range-tester    — autonomous Step 19 tester (drives app via CDP)" -ForegroundColor Green
Copy-Item "$ScriptDir\skills\elite-power-security\SKILL.md" "$SecSkillDir\SKILL.md" -Force
Write-Host "    + elite-power-security  — Caelum Bank–inspired security hardening" -ForegroundColor Green

# Hook
Write-Host ""
Write-Host "  Installing auto-CLAUDE.md hook..." -ForegroundColor White
Copy-Item "$ScriptDir\hooks\power-range-claude-md-updater.js" "$HooksDir\" -Force
Write-Host "    + power-range-claude-md-updater.js" -ForegroundColor Green

# Elite mode runtime
Write-Host ""
Write-Host "  Installing elite-mode runtime..." -ForegroundColor White
Copy-Item "$ScriptDir\debate_runner.py" "$RangersDir\debate_runner.py" -Force
if (-not (Test-Path "$RangersDir\config.json")) {
    Copy-Item "$ScriptDir\config.example.json" "$RangersDir\config.json" -Force
    Write-Host "    + debate_runner.py + config.json (template — paste your OpenRouter key)" -ForegroundColor Green
} else {
    Write-Host "    + debate_runner.py (existing config.json kept untouched)" -ForegroundColor Green
}

Write-Host ""
Write-Host "  Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "  Quick start:" -ForegroundColor White
Write-Host "    1. Open any project in Claude Code"
Write-Host "    2. /power-load           — one-time project setup"
Write-Host "    3. /power-mapout         — optional: map your codebase"
Write-Host "    4. /power-range          — build with the 20-step pipeline"
Write-Host ""
Write-Host "  Want elite mode (10 AI consultants in parallel)?" -ForegroundColor White
Write-Host "    a. Get an OpenRouter key:  https://openrouter.ai/keys"
Write-Host "    b. pip install aiohttp"
Write-Host "    c. Edit  $RangersDir\config.json  (or set `$env:OPENROUTER_API_KEY)"
Write-Host "    d. Use   /elite-power-range   instead of /power-range"
Write-Host ""
Write-Host "  Free. No paywall." -ForegroundColor DarkGray
Write-Host ""
