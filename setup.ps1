# ============================================================
# Codex Skills Collection - 一键部署脚本
# 用法: .\setup.ps1
# ============================================================
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
Write-Host "--- Phase 1: 技能 ---" -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $skillsDst | Out-Null
$skillInstalled = 0
$skillSkipped = 0

Get-ChildItem -Directory $skillsSrc | ForEach-Object {
    $target = Join-Path $skillsDst $_.Name
    if ($_.Name -eq ".system") { return }
    if (Test-Path $target) {
        Write-Host "[SKIP] $($_.Name)" -ForegroundColor Yellow
        $skillSkipped++
    } else {
        Copy-Item -Recurse -Force $_.FullName $target
        Write-Host "[OK]   $($_.Name)" -ForegroundColor Green
        $skillInstalled++
    }
}
Write-Host "Skills: $skillInstalled new, $skillSkipped skipped ($(($skillInstalled + $skillSkipped)) total)"

# ============================================================
# Phase 2: 部署插件 (Plugins)
# ============================================================
Write-Host ""
Write-Host "--- Phase 2: 插件 ---" -ForegroundColor Cyan

if (Test-Path $pluginsSrc) {
    Get-ChildItem -Directory $pluginsSrc | ForEach-Object {
        $pn = $_.Name
        Get-ChildItem -Directory $_.FullName | ForEach-Object {
            $vn = $_.Name
            $target = Join-Path $pluginsDst "$pn\$vn"
            if (-not (Test-Path $target)) {
                New-Item -ItemType Directory -Force -Path $target | Out-Null
                Copy-Item -Recurse -Force "$($_.FullName)\*" $target
                Write-Host "[OK]   Plugin: $pn v$vn" -ForegroundColor Green
            } else {
                Write-Host "[SKIP] Plugin: $pn v$vn" -ForegroundColor Yellow
            }
        }
    }
}

# ============================================================
# Phase 3: Computer Use 初始化
# ============================================================
Write-Host ""
Write-Host "--- Phase 3: Computer Use 初始化 ---" -ForegroundColor Cyan

$cuScript = Join-Path $skillsDst "codex-windows-fast-patch\scripts\install-computer-use-local.ps1"
if (Test-Path $cuScript) {
    Write-Host "[RUN] install-computer-use-local.ps1 -VerifyOnly"
    powershell -NoProfile -ExecutionPolicy Bypass -File $cuScript -VerifyOnly
    Write-Host "[RUN] install-computer-use-local.ps1"
    powershell -NoProfile -ExecutionPolicy Bypass -File $cuScript
} else {
    Write-Host "[WARN] install-computer-use-local.ps1 not found, skipping" -ForegroundColor Yellow
}

# ============================================================
# Phase 4: Fast Patch (可选)
# ============================================================
Write-Host ""
Write-Host "--- Phase 4: Fast Patch 检查 ---" -ForegroundColor Cyan
$repatchScript = Join-Path $skillsDst "codex-windows-fast-patch\scripts\repatch-codex-windows.ps1"

if (Test-Path $repatchScript) {
    $runPatch = Read-Host "是否需要运行 Codex Fast Patch? (y/n, 默认n)"
    if ($runPatch -eq "y") {
        Write-Host "[RUN] repatch-codex-windows.ps1 -DryRun"
        powershell -NoProfile -ExecutionPolicy Bypass -File $repatchScript -DryRun
        $confirm = Read-Host "DryRun 完成，是否正式打补丁? (y/n)"
        if ($confirm -eq "y") {
            Write-Host "[RUN] repatch-codex-windows.ps1"
            powershell -NoProfile -ExecutionPolicy Bypass -File $repatchScript
        }
    }
}

# ============================================================
# 完成
# ============================================================
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  部署完成！重启 Codex 即可使用。" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan