# ============================================================
#  POWER-RANGE ELITE — Windows PowerShell Installer
#  18 AI Agents. 13-Step Quality Pipeline. Zero Shortcuts.
# ============================================================

$ErrorActionPreference = "Stop"

Clear-Host

Write-Host ""
Write-Host "    ██████╗  ██████╗ ██╗    ██╗███████╗██████╗ " -ForegroundColor Red
Write-Host "    ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗" -ForegroundColor Red
Write-Host "    ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝" -ForegroundColor Yellow
Write-Host "    ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗" -ForegroundColor Cyan
Write-Host "    ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║" -ForegroundColor Magenta
Write-Host "    ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝" -ForegroundColor Magenta
Write-Host ""
Write-Host "    ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗" -ForegroundColor White
Write-Host "    ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔════╝" -ForegroundColor White
Write-Host "    ██████╔╝███████║██╔██╗ ██║██║  ███╗█████╗  " -ForegroundColor Green
Write-Host "    ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══╝  " -ForegroundColor Green
Write-Host "    ██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗" -ForegroundColor Cyan
Write-Host "    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "              E L I T E   E D I T I O N" -ForegroundColor Yellow
Write-Host "       18 Agents. 13 Steps. Zero Shortcuts." -ForegroundColor DarkGray
Write-Host "    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
Start-Sleep -Seconds 1

# ── Paths ──
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$CommandsDir = Join-Path $ClaudeDir "commands"
$AgentsDir = Join-Path $ClaudeDir "agents"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# ── Step 1: Prerequisites ──
Write-Host "[1/6] " -ForegroundColor Cyan -NoNewline
Write-Host "Checking prerequisites..." -ForegroundColor White
Start-Sleep -Milliseconds 500

$claudeExists = Get-Command claude -ErrorAction SilentlyContinue
if ($claudeExists) {
    Write-Host "  + Claude Code CLI detected" -ForegroundColor Green
} else {
    Write-Host "  ! Claude Code CLI not found in PATH" -ForegroundColor Yellow
    Write-Host "    Install it first: https://docs.anthropic.com/en/docs/claude-code" -ForegroundColor DarkGray
    Write-Host "    Continuing anyway..." -ForegroundColor DarkGray
}

if (Test-Path $ClaudeDir) {
    Write-Host "  + Claude directory found: $ClaudeDir" -ForegroundColor Green
} else {
    Write-Host "  ! Creating Claude directory: $ClaudeDir" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
}
Write-Host ""

# ── Step 2: Directories ──
Write-Host "[2/6] " -ForegroundColor Cyan -NoNewline
Write-Host "Preparing directories..." -ForegroundColor White
Start-Sleep -Milliseconds 500

New-Item -ItemType Directory -Path $CommandsDir -Force | Out-Null
New-Item -ItemType Directory -Path $AgentsDir -Force | Out-Null
Write-Host "  + $CommandsDir" -ForegroundColor Green
Write-Host "  + $AgentsDir" -ForegroundColor Green
Write-Host ""

# ── Step 3: Commands ──
Write-Host "[3/6] " -ForegroundColor Cyan -NoNewline
Write-Host "Installing Power-Range commands..." -ForegroundColor White
Start-Sleep -Milliseconds 300

$commands = @("power-range.md", "power-load.md", "power-range-escalate.md")
foreach ($cmd in $commands) {
    $src = Join-Path $ScriptDir "commands\$cmd"
    $dst = Join-Path $CommandsDir $cmd
    if (Test-Path $src) {
        Copy-Item $src $dst -Force
        $name = $cmd -replace '\.md$', ''
        Write-Host "  + /$name installed" -ForegroundColor Green
    } else {
        Write-Host "  x $cmd not found in package!" -ForegroundColor Red
    }
    Start-Sleep -Milliseconds 200
}
Write-Host ""

# ── Step 4: Agents ──
Write-Host "[4/6] " -ForegroundColor Cyan -NoNewline
Write-Host "Deploying 18 elite agents..." -ForegroundColor White
Start-Sleep -Milliseconds 300

$agents = @(
    @("cto", "CTO Orchestrator"),
    @("bookkeeper", "Bookkeeper (Architecture Memory)"),
    @("prompt-translator", "Prompt Translator"),
    @("what-if-agent", "What-If Agent (Failure Simulator)"),
    @("architect", "Architect (Technical Planner)"),
    @("backend-engineer", "Backend Engineer"),
    @("frontend-engineer", "Frontend Engineer"),
    @("challenger", "Challenger (Adversarial Reviewer)"),
    @("integration-engineer", "Integration Engineer"),
    @("role-access-engineer", "Role & Access Engineer"),
    @("security-sentinel", "Security Sentinel"),
    @("test-coverage-engineer", "Test Coverage Engineer"),
    @("qa-engineer", "QA Engineer"),
    @("code-reviewer", "Code Reviewer"),
    @("business-kpi-analyst", "Business KPI Analyst"),
    @("tester", "Tester (Live App Testing)"),
    @("documentation-engineer", "Documentation Engineer"),
    @("tech-lead", "Tech Lead (Final Gate)")
)

$count = 0
$total = $agents.Count
foreach ($agent in $agents) {
    $name = $agent[0]
    $label = $agent[1]
    $src = Join-Path $ScriptDir "agents\$name.md"
    $dst = Join-Path $AgentsDir "$name.md"

    if (Test-Path $src) {
        Copy-Item $src $dst -Force
        $count++
        Write-Host ("  + [{0,2}/{1}] {2}" -f $count, $total, $label) -ForegroundColor Green
    } else {
        Write-Host ("  x [{0,2}/{1}] {2} - NOT FOUND" -f ($count+1), $total, $label) -ForegroundColor Red
    }
    Start-Sleep -Milliseconds 150
}
Write-Host ""

# ── Step 5: Verify ──
Write-Host "[5/6] " -ForegroundColor Cyan -NoNewline
Write-Host "Verifying installation..." -ForegroundColor White
Start-Sleep -Milliseconds 500

$errors = 0
foreach ($cmd in $commands) {
    $path = Join-Path $CommandsDir $cmd
    if (Test-Path $path) {
        Write-Host "  ✓ $cmd" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $cmd MISSING" -ForegroundColor Red
        $errors++
    }
}

$agentFiles = Get-ChildItem "$AgentsDir\*.md" -ErrorAction SilentlyContinue
$agentCount = if ($agentFiles) { $agentFiles.Count } else { 0 }
Write-Host "  ✓ $agentCount agent files in $AgentsDir" -ForegroundColor Green

if ($errors -gt 0) {
    Write-Host ""
    Write-Host "  ! $errors file(s) failed to install" -ForegroundColor Red
} else {
    Write-Host "  ✓ All files verified" -ForegroundColor Green
}
Write-Host ""

# ── Step 6: Done ──
Write-Host "[6/6] " -ForegroundColor Cyan -NoNewline
Write-Host "Installation complete!" -ForegroundColor White
Write-Host ""
Write-Host "    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  POWER-RANGE ELITE IS NOW INSTALLED" -ForegroundColor Green
Write-Host ""
Write-Host "  Commands available:" -ForegroundColor White
Write-Host "    /power-load             " -ForegroundColor Cyan -NoNewline
Write-Host "First-time project setup" -ForegroundColor Gray
Write-Host "    /power-range            " -ForegroundColor Cyan -NoNewline
Write-Host "Run the full 13-step pipeline" -ForegroundColor Gray
Write-Host "    /power-range-escalate   " -ForegroundColor Cyan -NoNewline
Write-Host "Escalate failures to 4 AI models" -ForegroundColor Gray
Write-Host ""
Write-Host "  Quick start:" -ForegroundColor White
Write-Host "    1. Open Claude Code in your project" -ForegroundColor Gray
Write-Host "    2. Type /power-load to install on the project" -ForegroundColor Gray
Write-Host "    3. Type /power-range + describe what you want" -ForegroundColor Gray
Write-Host ""
Write-Host "  Power-Range is getting dangerous." -ForegroundColor Yellow
Write-Host "  Power-Range will solve everything." -ForegroundColor Red
Write-Host ""
Write-Host "    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
