#Requires -Version 5.1
# ============================================================
# DEPLOY: FULL TEAM v2.0 — все rule-файлы и workflows
# Файл: deploy_team_v2.ps1
# Запуск: .\deploy_team_v2.ps1
# Что делает: обновляет все 6 rule-файлов и 2 workflow до v2.0
# ============================================================

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$DEPLOY_DATE = Get-Date -Format "yyyy-MM-dd HH:mm"
$LOG_FILE    = ".gemini\antigravity\brain\decisions_log.md"

function Write-Header { param($t) Write-Host "`n$t" -ForegroundColor Cyan }
function Write-Ok     { param($t) Write-Host "  ✅  $t" -ForegroundColor Green }
function Write-Skip   { param($t) Write-Host "  ⏭️   $t" -ForegroundColor DarkGray }
function Write-Warn   { param($t) Write-Host "  ⚠️   $t" -ForegroundColor Yellow }
function Write-Fail   { param($t) Write-Host "  ❌  $t" -ForegroundColor Red }

# ── Проверка окружения ────────────────────────────────────
Clear-Host
Write-Host ""
Write-Host "  ╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "  ║   DEPLOY: Full Team v2.0 — GD-Aware Pipeline      ║" -ForegroundColor Cyan
Write-Host "  ║   Gamedesign-ops | $DEPLOY_DATE         ║" -ForegroundColor Cyan
Write-Host "  ╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Header "[ STEP 1/4 ] Проверка окружения"

if (-not (Test-Path ".agent")) {
    Write-Fail "Директория .agent не найдена. Запусти из корня проекта."
    exit 1
}
Write-Ok ".agent/ найден"

# Папка для бэкапов
$backupDir = ".agent\rules\backups\$(Get-Date -Format 'yyyyMMdd_HHmm')"
New-Item -Path $backupDir -ItemType Directory -Force | Out-Null
Write-Ok "Папка бэкапов: $backupDir"

# ── Бэкап старых файлов ────────────────────────────────────
Write-Header "[ STEP 2/4 ] Бэкап текущих файлов"

$filesToBackup = @(
    ".agent\rules\00_global.md",
    ".agent\rules\03_DEV.md",
    ".agent\rules\04_UIUX.md",
    ".agent\rules\05_ART.md",
    ".agent\rules\06_PRODUCER.md",
    ".agent\workflows\task-done.md",
    ".agent\workflows\new-project.md"
)

foreach ($f in $filesToBackup) {
    if (Test-Path $f) {
        $name = Split-Path $f -Leaf
        Copy-Item $f "$backupDir\$name"
        Write-Ok "Бэкап: $name"
    } else {
        Write-Skip "Не найден (создаётся): $f"
    }
}

# ════════════════════════════════════════════════════════════
# СОДЕРЖИМОЕ ФАЙЛОВ — встроено как here-strings
# ════════════════════════════════════════════════════════════

# ── 00_global.md ─────────────────────────────────────────
$GLOBAL_CONTENT = @'
# GAMEDEV TEAM — ГЛОБАЛЬНЫЕ ПРАВИЛА КОМАНДЫ
# Версия: 2.0 | Обновлено: 2026-03-03
# Тип: ВСЕГДА АКТИВЕН во всех воркспейсах

---

## SSOT: ЕДИНАЯ ТОЧКА ПРАВДЫ

По дизайну игры: .gemini/antigravity/brain/gdd_summary.md (владелец: GD)
По задачам: .gemini/antigravity/brain/task_board.md (владелец: PM)
По ассетам: .gemini/antigravity/brain/asset_registry.md (владелец: ART)

Если твоя работа противоречит SSOT → стоп, задай вопрос владельцу.

---

## ЖИЗНЕННЫЙ ЦИКЛ ЗАДАЧИ

TODO → IN_PROGRESS → REVIEW → [GD_GATE] → DONE

GD_GATE ОБЯЗАТЕЛЕН для тегов: GAMEPLAY ECONOMY UX FTUE BALANCE LIVEOPS
GD_GATE ПРОПУСКАЕТСЯ для: CI/CD BUILD DEVOPS LINT DEPENDENCIES PLACEHOLDER_ART

---

## A2A АРТЕФАКТЫ

.agent/artifacts/[FROM]_to_[TO]_[TASK-ID].md

Примеры:
  GD_to_DEV_TASK-042.md          — ТЗ от GD для DEV
  GD_to_UIUX_TASK-015.md         — экранный флоу и требования
  GD_to_ART_TASK-007.md          — список ассетов с контекстом
  UIUX_to_GD_note_TASK-015.md    — UX проблема, требует ответа GD
  ART_to_GD_note_TASK-007.md     — ассет не соответствует GDD
  DEV_to_GD_TASK-042.md          — архитектурный конфликт с GDD

Правило получателя: получил артефакт → прочитал ПЕРЕД началом работы.
Правило создателя: создал артефакт → уведомил PM.

---

## ФАЙЛОВАЯ СТРУКТУРА UNITY

Assets/
├── _Project/
│   ├── Scripts/ (Core, Gameplay, UI, Data)
│   ├── Prefabs/
│   ├── Scenes/
│   ├── Art/ (Sprites, Animations, VFX)
│   ├── Audio/
│   └── UI/ (UXML, USS)
├── _ThirdParty/
└── StreamingAssets/

---

## СОГЛАШЕНИЯ ИМЕНОВАНИЯ

Классы C#: PascalCase
Переменные: camelCase, приватные с _ (_health)
Константы: UPPER_SNAKE_CASE
ScriptableObjects: суффикс SO (LevelConfigSO)
Prefabs: суффикс Pfb (PlayerPfb)
Scenes: snake_case (gameplay_main)
A2A артефакты: [FROM]_to_[TO]_[TASK-ID].md

---

## CONVENTIONAL COMMITS

feat(gameplay): add double jump mechanic
fix(ui): correct score display overflow
art(sprites): add player idle animation frames
design(gdd): update level progression curve
docs(readme): update setup instructions
chore(infra): update rule to v2.0

---

## ЗАПРЕЩЕНО КОМАНДОЙ

- Файлы вне _Project/ или _ThirdParty/
- Магические числа — только ScriptableObjects или константы
- FindObjectOfType() в Update()
- Прямые строковые ссылки на сцены
- Изменять balance constants в SO без согласования с GD
- Закрывать DESIGN задачи без GD Gate
- Создавать GAMEPLAY/ECONOMY/UX задачи без GDD anchor [ID:BLOCK]

---

## ПРОТОКОЛ BRAIN-ФАЙЛОВ

После значимой работы ВСЕГДА:
1. Обновить brain-файл своей области (если ты владелец)
2. Создать A2A артефакт для зависимых агентов
3. Добавить запись в decisions_log.md:

## [ДАТА ЧЧ:ММ] — [КРАТКОЕ НАЗВАНИЕ]
- Агент: [роль]
- Задача: [TASK-ID]
- Решение: [суть]
- Файлы: [список]
- Статус: DONE / PENDING

---

## МАТРИЦА КОММУНИКАЦИИ

| От кого → Кому | Как |
|----------------|-----|
| PRODUCER → GD | PRODUCER_to_GD_[PROJECT].md |
| PM → Агент | task_board.md TASK-XXX |
| GD → Агент | GD_to_[ROLE]_TASK-XXX.md |
| DEV → GD | /design-review TASK-XXX |
| UIUX → GD | UIUX_to_GD_note_TASK-XXX.md |
| ART → GD | ART_to_GD_note_TASK-XXX.md |
| Агент → PM | /done TASK-XXX |

---

## СЛОВАРЬ КОМАНДЫ

GDD anchor   — ссылка [ID:BLOCK_NAME] на блок GDD
GD Gate      — design review от GD перед DONE для DESIGN задач
A2A артефакт — файл ТЗ/уведомления между агентами
SSOT         — Single Source of Truth
PLACEHOLDER  — временный ассет, DEV может использовать
FINAL        — финальный ассет, прошёл проверку ART
[HYPOTHESIS] — данные без верификации
[FACT]       — верифицированные данные
P0/P1/P2     — приоритет (P0 = блокирует milestone)
'@

# ── Массив файлов для деплоя ─────────────────────────────
# Скрипт записывает файлы из текущей директории (копии уже должны быть рядом)
# или встраивает контент напрямую (для 00_global.md)

Write-Header "[ STEP 3/4 ] Деплой файлов"

# Функция деплоя
function Deploy-File {
    param(
        [string]$DestPath,
        [string]$Content,
        [string]$Label
    )
    $dir = Split-Path $DestPath -Parent
    if (-not (Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }
    $Content | Out-File -FilePath $DestPath -Encoding UTF8 -Force
    $size = [math]::Round((Get-Item $DestPath).Length / 1KB, 1)
    Write-Ok "$Label → $DestPath ($size KB)"
}

# Деплой 00_global.md (встроен)
Deploy-File -DestPath ".agent\rules\00_global.md" -Content $GLOBAL_CONTENT -Label "00_global.md v2.0"

# Деплой остальных файлов — ищем рядом со скриптом
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent

$fileMappings = @(
    @{ Src = "03_DEV.md";      Dst = ".agent\rules\03_DEV.md";         Label = "03_DEV.md v2.0" },
    @{ Src = "04_UIUX.md";     Dst = ".agent\rules\04_UIUX.md";        Label = "04_UIUX.md v2.0" },
    @{ Src = "05_ART.md";      Dst = ".agent\rules\05_ART.md";         Label = "05_ART.md v2.0" },
    @{ Src = "06_PRODUCER.md"; Dst = ".agent\rules\06_PRODUCER.md";    Label = "06_PRODUCER.md v2.0" },
    @{ Src = "task-done.md";   Dst = ".agent\workflows\task-done.md";  Label = "task-done.md v2.0" },
    @{ Src = "new-project.md"; Dst = ".agent\workflows\new-project.md"; Label = "new-project.md v2.0" }
)

foreach ($m in $fileMappings) {
    $srcPath = Join-Path $scriptDir $m.Src
    if (Test-Path $srcPath) {
        $content = Get-Content $srcPath -Raw -Encoding UTF8
        Deploy-File -DestPath $m.Dst -Content $content -Label $m.Label
    } else {
        Write-Warn "$($m.Src) не найден рядом со скриптом — пропускаю"
        Write-Host "    Ожидался путь: $srcPath" -ForegroundColor Gray
    }
}

# ── Decisions log ────────────────────────────────────────
Write-Header "[ STEP 4/4 ] Запись в decisions_log.md"

$logEntry = @"

---

## $DEPLOY_DATE — FULL TEAM v2.0 DEPLOYED

- **Агент:** DEPLOY
- **Действие:** Обновление всех rule-файлов и workflows до версии 2.0
- **Ключевые изменения:**
  - 00_global.md: добавлен GD Gate, A2A артефакты, SSOT, словарь
  - 03_DEV.md: GDD Integration Protocol, balance constants от GD, analytics schema
  - 04_UIUX.md: Feature Spec как hard constraint, UIUX_to_GD feedback channel
  - 05_ART.md: Asset status protocol (PLACEHOLDER/WIP/FINAL), gdd_summary priority
  - 06_PRODUCER.md: GD Handoff Protocol с обязательными полями, Pivot Protocol
  - task-done.md: DESIGN/NON-DESIGN routing с GD Gate
  - new-project.md: правильный порядок старта (GD первый, остальные после GDD)
- **Статус:** DEPLOYED
"@

if (Test-Path ".gemini\antigravity\brain") {
    if (Test-Path $LOG_FILE) {
        Add-Content -Path $LOG_FILE -Value $logEntry -Encoding UTF8
        Write-Ok "Запись добавлена в decisions_log.md"
    } else {
        $logEntry | Out-File -FilePath $LOG_FILE -Encoding UTF8
        Write-Ok "decisions_log.md создан"
    }
} else {
    Write-Warn "brain/ не найден — пропускаю лог"
}

# ── Git commit ────────────────────────────────────────────
Write-Host ""
$doGit = Read-Host "  Сделать git commit? (y/n)"
if ($doGit -eq "y") {
    try {
        git add ".agent\rules\"
        git add ".agent\workflows\task-done.md"
        git add ".agent\workflows\new-project.md"
        if (Test-Path $LOG_FILE) { git add $LOG_FILE }
        git commit -m "feat(team): upgrade all rules to v2.0 — GD-aware pipeline, A2A artifacts, asset statuses, GD Gate"
        Write-Ok "git commit выполнен"
        $doPush = Read-Host "  git push? (y/n)"
        if ($doPush -eq "y") { git push; Write-Ok "git push выполнен" }
    } catch {
        Write-Warn "Git: $($_.Exception.Message)"
    }
}

# ── ИТОГ ──────────────────────────────────────────────────
Write-Host ""
Write-Host "  ╔════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "  ║   ✅ FULL TEAM v2.0 DEPLOYED SUCCESSFULLY!        ║" -ForegroundColor Green
Write-Host "  ╚════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "  📋 ЧТО ИЗМЕНИЛОСЬ:" -ForegroundColor White
Write-Host "     DEV    → читает GD_to_DEV артефакт перед кодом, balance из GDD" -ForegroundColor Gray
Write-Host "     UIUX   → Screen Flow = constraint, feedback канал к GD" -ForegroundColor Gray
Write-Host "     ART    → статусы PLACEHOLDER/WIP/FINAL, приоритеты из gdd_summary" -ForegroundColor Gray
Write-Host "     PRODUCER → обязательный handoff GD с KPI и ограничениями" -ForegroundColor Gray
Write-Host "     /done  → DESIGN задачи идут через GD Gate, не DONE напрямую" -ForegroundColor Gray
Write-Host "     /new-project → GD стартует первым, остальные после GDD v0.1" -ForegroundColor Gray
Write-Host ""
Write-Host "  🚀 СЛЕДУЮЩИЙ ШАГ: запустить /concept в PRODUCER-Workspace" -ForegroundColor Cyan
Write-Host ""
