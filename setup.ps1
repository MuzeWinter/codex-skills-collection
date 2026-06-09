# ============================================================
# Codex Skills Collection - 一键部署脚本
# 用法: .\setup.ps1
# ============================================================
$ErrorActionPreference = "Stop"

# 检测 CODEX_HOME
if (-not $env:CODEX_HOME) {
    $env:CODEX_HOME = "$env:USERPROFILE\.codex"
    Write-Host "[INFO] CODEX_HOME 未设置，使用默认路径: $env:CODEX_HOME"
}

$skillsSrc = Join-Path $PSScriptRoot "skills"
$skillsDst = Join-Path $env:CODEX_HOME "skills"

if (-not (Test-Path $skillsSrc)) {
    Write-Host "[ERROR] skills 目录未找到，请确保在仓库根目录运行此脚本" -ForegroundColor Red
    exit 1
}

# 确保目标目录存在
New-Item -ItemType Directory -Force -Path $skillsDst | Out-Null

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Codex Skills Collection - 开始部署" -ForegroundColor Cyan
Write-Host "  源目录: $skillsSrc" -ForegroundColor Cyan
Write-Host "  目标目录: $skillsDst" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$installed = 0
$skipped = 0

Get-ChildItem -Directory $skillsSrc | ForEach-Object {
    $skillName = $_.Name
    $target = Join-Path $skillsDst $skillName
    
    # 跳过 .system
    if ($skillName -eq ".system") { return }
    
    if (Test-Path $target) {
        Write-Host "[SKIP] $skillName - 已存在" -ForegroundColor Yellow
        $skipped++
    } else {
        Copy-Item -Recurse -Force $_.FullName $target
        Write-Host "[OK]   $skillName - 已安装" -ForegroundColor Green
        $installed++
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  部署完成: $installed 新增, $skipped 跳过" -ForegroundColor Cyan
Write-Host "  共 $(($installed + $skipped)) 个技能" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "重启 Codex 即可使用所有技能。" -ForegroundColor White

# 询问是否覆盖已存在的技能
if ($skipped -gt 0) {
    Write-Host "提示: 如需覆盖已有技能，请先删除目标目录后重新运行。" -ForegroundColor DarkYellow
}
