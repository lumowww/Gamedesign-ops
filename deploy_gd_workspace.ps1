# DEPLOY: GD-Workspace files
# Файл: deploy_gd_workspace.ps1
# Запускать из корня проекта: .\deploy_gd_workspace.ps1
# Создаёт все папки и пустые файлы-плейсхолдеры

$base = "."

$dirs = @(
    ".agent\rules",
    ".agent\workflows",
    ".agent\skills\gdd-template",
    ".agent\skills\design-heuristics",
    ".agent\skills\loops-and-arcs",
    ".agent\skills\mobile-design-checklist",
    ".agent\skills\agent-tz-template",
    ".agent\artifacts",
    ".gemini\antigravity\brain",
    "docs\GDD"
)

$files = @(
    ".agent\rules\02_GD.md",
    ".agent\workflows\gdd-update.md",
    ".agent\workflows\concept-gd.md",
    ".agent\workflows\feature-spec.md",
    ".agent\workflows\balance-review.md",
    ".agent\workflows\design-review.md",
    ".agent\workflows\liveops-plan.md",
    ".agent\skills\gdd-template\SKILL.md",
    ".agent\skills\design-heuristics\SKILL.md",
    ".agent\skills\loops-and-arcs\SKILL.md",
    ".agent\skills\mobile-design-checklist\SKILL.md",
    ".agent\skills\agent-tz-template\SKILL.md",
    ".gemini\antigravity\brain\gdd_summary.md"
)

Write-Host "🎮 Deploying GD-Workspace files..." -ForegroundColor Cyan

foreach ($dir in $dirs) {
    $path = Join-Path $base $dir
    if (-not (Test-Path $path)) {
        New-Item -Path $path -ItemType Directory -Force | Out-Null
        Write-Host "  ✅ Created dir: $dir" -ForegroundColor Green
    } else {
        Write-Host "  ⏭️  Exists: $dir" -ForegroundColor Gray
    }
}

foreach ($file in $files) {
    $path = Join-Path $base $file
    if (-not (Test-Path $path)) {
        New-Item -Path $path -ItemType File -Force | Out-Null
        Write-Host "  ✅ Created file: $file" -ForegroundColor Green
    } else {
        Write-Host "  ⏭️  Exists (skip): $file" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "✅ GD-Workspace structure ready!" -ForegroundColor Cyan
Write-Host "📝 Next steps:" -ForegroundColor White
Write-Host "   1. В файлах уже содержится актуальное содержимое" -ForegroundColor White
Write-Host "   2. В Antigravity: Settings → Rules → .agent/rules/02_GD.md" -ForegroundColor White
Write-Host "   3. Запустить /concept в PRODUCER-Workspace для старта проекта" -ForegroundColor White
Write-Host ""

# Git commit
$confirm = Read-Host "Commit to git? (y/n)"
if ($confirm -eq "y") {
    git add .agent\rules\02_GD.md
    git add .agent\workflows\gdd-update.md
    git add .agent\workflows\concept-gd.md
    git add .agent\workflows\feature-spec.md
    git add .agent\workflows\balance-review.md
    git add .agent\workflows\design-review.md
    git add .agent\workflows\liveops-plan.md
    git add ".agent\skills\"
    git add ".gemini\antigravity\brain\gdd_summary.md"
    git add "AGENTS.md"
    git commit -m "feat(gd): добавить GD-Workspace rules, workflows и skills"
    Write-Host "✅ Committed!" -ForegroundColor Green
}
