<#
.SYNOPSIS
    Codex Skills Collection - 一键部署
.DESCRIPTION
    部署全部 35 个技能 + Browser/Chrome/Computer Use 插件
.PARAMETER SkipFastPatch
    跳过 Fast Patch（默认在非交互模式下跳过）
.PARAMETER RunFastPatch
    强制执行 Fast Patch
.EXAMPLE
    .\setup.ps1                    # 交互模式
    .\setup.ps1 -SkipFastPatch     # AI 友好：跳过补丁
    .\setup.ps1 -RunFastPatch      # 强制执行补丁
#>
param(
    [switch]$SkipFastPatch,
    [switch]$RunFastPatch
)
$ErrorActionPreference = "Continue"

if (-not $env:CODEX_HOME) {
    $env:CODEX_HOME = "$env:USERPROFILE\.codex"
    Write-Host "[INFO] CODEX_HOME: $env:CODEX_HOME"
}

$repo = $PSScriptRoot
$skillsSrc = Join-Path $repo "skills"
$skillsDst = Join-Path $env:CODEX_HOME "skills"
$pluginsSrc = Join-Path $repo "plugins"
$pluginsDst = Join-Path $env:CODEX_HOME "plugins\cache\openai-bundled"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Codex Skills + Plugins - 开始部署" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# ============================================================
# Phase 1: 部署技能 (Skills)
# ============================================================
Write-Host ""
Write-Host "--- Phase 1: Skills ---" -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $skillsDst | Out-Null
$skillInstalled = 0
$skillSkipped = 0

Get-ChildItem -Directory $skillsSrc | ForEach-Object {
    $target = Join-Path $skillsDst $_.Name
    if ($_.Name -eq ".system") { return }
    if (Test-Path $target) {
        $skillSkipped++
    } else {
        Copy-Item -Recurse -Force $_.FullName $target
        $skillInstalled++
    }
}
Write-Host "Skills: $skillInstalled new, $skillSkipped skipped ($(($skillInstalled + $skillSkipped)) total)"

# ============================================================
# Phase 2: 部署插件 (Plugins)
# ============================================================
Write-Host ""
Write-Host "--- Phase 2: Plugins ---" -ForegroundColor Cyan

# Bundled plugins (Browser/Chrome/Computer Use) -> openai-bundled
if (Test-Path $pluginsSrc) {
    $bundledNames = @("browser", "chrome", "computer-use")
    Get-ChildItem -Directory $pluginsSrc | ForEach-Object {
        $pn = $_.Name
        $sourceType = if ($bundledNames -contains $pn) { "openai-bundled" } else { "openai-curated" }
        $pluginDst = Join-Path $env:CODEX_HOME "plugins\cache\$sourceType"
        Get-ChildItem -Directory $_.FullName | ForEach-Object {
            $vn = $_.Name
            $target = Join-Path $pluginDst "$pn\$vn"
            if (-not (Test-Path $target)) {
                New-Item -ItemType Directory -Force -Path $target | Out-Null
                Copy-Item -Recurse -Force "$($_.FullName)\*" $target
            }
        }
    }
    Write-Host "Plugins deployed (bundled + curated)"
}

# ============================================================
# Phase 3: Computer Use 初始化
# ============================================================
Write-Host ""
Write-Host "--- Phase 3: Computer Use init ---" -ForegroundColor Cyan

$cuScript = Join-Path $skillsDst "codex-windows-fast-patch\scripts\install-computer-use-local.ps1"
if (Test-Path $cuScript) {
    Write-Host "[RUN] install-computer-use-local.ps1"
    powershell -NoProfile -ExecutionPolicy Bypass -File $cuScript
    Write-Host "Computer Use init done"
} else {
    Write-Host "[WARN] install-computer-use-local.ps1 not found"
}

# ============================================================
# Phase 4: Fast Patch (仅显式指定时才运行)
# ============================================================
$repatchScript = Join-Path $skillsDst "codex-windows-fast-patch\scripts\repatch-codex-windows.ps1"

if ($RunFastPatch -and (Test-Path $repatchScript)) {
    Write-Host ""
    Write-Host "--- Phase 4: Fast Patch ---" -ForegroundColor Cyan
    Write-Host "[RUN] repatch-codex-windows.ps1"
    powershell -NoProfile -ExecutionPolicy Bypass -File $repatchScript
} elseif ($SkipFastPatch) {
    Write-Host ""
    Write-Host "--- Phase 4: Fast Patch skipped ---" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "--- Phase 4: Fast Patch ---" -ForegroundColor Yellow
    Write-Host "Skipped. Run with -RunFastPatch to apply, or run manually:"
    Write-Host "  powershell -File `"$repatchScript`""
}

# ============================================================
# 完成
# ============================================================
Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  Done. Restart Codex to use all 35 skills." -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green