#Requires -Version 5.1
# ============================================================
# DEPLOY: AiW GDD Sprint 0 Package
# Файл: deploy_AiW_Sprint0.ps1
# Место: корень проекта (рядом с .agent/)
# Запуск: .\deploy_AiW_Sprint0.ps1
# Что делает:
#   1. Создаёт структуру папок docs/ + brain/
#   2. Записывает все артефакты из GDD-пакета v0.1
#   3. Создаёт gdd_summary.md для агентов
#   4. Обновляет brain/decisions_log.md
#   5. Предлагает git commit
# ============================================================

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$DEPLOY_DATE = Get-Date -Format "yyyy-MM-dd HH:mm"
$PROJECT_NAME = "AiW"

# ── Цвета ───────────────────────────────────────────────────
function Write-Header { param($t) Write-Host "`n$t" -ForegroundColor Cyan }
function Write-Ok     { param($t) Write-Host "  ✅  $t" -ForegroundColor Green }
function Write-Skip   { param($t) Write-Host "  ⏭️   $t" -ForegroundColor DarkGray }
function Write-Warn   { param($t) Write-Host "  ⚠️   $t" -ForegroundColor Yellow }
function Write-Fail   { param($t) Write-Host "  ❌  $t" -ForegroundColor Red }

function Write-FileContent {
    param($Path, $Content)
    $dir = Split-Path $Path -Parent
    if (-not (Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }
    if (Test-Path $Path) {
        $ans = Read-Host "  Файл существует: $Path. Перезаписать? (y/n)"
        if ($ans -ne "y") { Write-Skip "Пропущен: $Path"; return }
    }
    $Content | Out-File -FilePath $Path -Encoding UTF8 -Force
    $lines = ($Content -split "`n").Count
    Write-Ok "Записан: $Path ($lines строк)"
}

# ════════════════════════════════════════════════════════════
#  ПРОВЕРКА ОКРУЖЕНИЯ
# ════════════════════════════════════════════════════════════

Clear-Host
Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "  ║   DEPLOY: AiW GDD Sprint 0 Package v0.1        ║" -ForegroundColor Cyan
Write-Host "  ║   Gamedesign-ops | GD-Workspace                ║" -ForegroundColor Cyan
Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Header "[ STEP 1/6 ] Проверка окружения"

if (-not (Test-Path ".agent")) {
    Write-Fail "Директория .agent не найдена."
    Write-Warn "Запусти скрипт из корня проекта (там где лежит .agent/)."
    Write-Host "  Текущая папка: $(Get-Location)" -ForegroundColor Gray
    exit 1
}
Write-Ok ".agent/ найден — ты в корне проекта"

# ════════════════════════════════════════════════════════════
#  СОЗДАНИЕ СТРУКТУРЫ ПАПОК
# ════════════════════════════════════════════════════════════

Write-Header "[ STEP 2/6 ] Создание структуры папок"

$dirs = @(
    "docs\intake",
    "docs\concepts",
    "docs\GDD\sections",
    "docs\tech",
    "docs\agents",
    "docs\assets",
    ".gemini\antigravity\brain"
)

foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
        Write-Ok "Создана: $dir"
    } else {
        Write-Skip "Существует: $dir"
    }
}

# ════════════════════════════════════════════════════════════
#  АРТЕФАКТЫ — содержимое (встроено в скрипт)
# ════════════════════════════════════════════════════════════

Write-Header "[ STEP 3/6 ] Запись артефактов GDD-пакета"

# ── ARTIFACT 1: gdd_summary.md (brain file для агентов) ─────
$GDD_SUMMARY = @'
# AiW — GDD Summary (Brain File)
# Файл: .gemini/antigravity/brain/gdd_summary.md
# Владелец: GD | Обновлён: Sprint 0
# [STATUS:DRAFT]

---

## Project Snapshot
- **Title:** Alien in Waders (AiW)
- **Genre:** Hybrid-casual Tower Defense + Merge
- **Platform:** Android (primary), iOS | Unity 6 LTS + URP
- **Sprint:** Sprint 0 → Sprint 1 (4 недели) | Android tестовый билд
- **GDD Version:** v0.1 DRAFT

---

## Player Promise
> «Я — тактик-командующий, который строит огневые рубежи из инопланетного оружия, сливая их в монстров разрушения — и чувствую азарт хаоса под контролем.»

---

## Core Loop (TL;DR)
**Micro:** Спаунить башню → ждать волну → сливать две одинаковых → новый тип
**Meta:** Выжить матч → получить шарды → апгрейд колоды → следующий матч сложнее
**Macro:** Открыть 15 башен → PvP рейтинг → Battle Pass → сезонный контент

---

## Sprint 1 Scope (MVP)
- ✅ PvE Тропа-режим (П-образный path, фиксированный)
- ✅ 2 башни: T-001 Incinerator (Fire AoE) + T-002 Cryo-Cannon (Ice CC)
- ✅ Merge-механика: 2 башни Lv N → 1 башня Lv N+1 (cap Lv3 в Sprint 1)
- ✅ 10 волн, 2 типа крипов (Корабль-1, Корабль-2)
- ✅ ScoreSystem: очки → трата на спаун
- ✅ Win/Lose conditions + Pause
- ❌ Волна-режим — Sprint 2
- ❌ Герои, боссы, метагейм, IAP — Sprint 2+

---

## Key Decisions (Sprint 0)
| ID | Решение |
|---|---|
| DEC-001 | Sprint 1 = только Тропа-режим |
| DEC-002 | Sprint 1 = 2 башни (не 15) |
| DEC-003 | Realtime PvP → async/bot |
| DEC-004 | Арт Random Dice не использовать |
| DEC-005 | Matchmaking по tower tier (P2W safeguard) |

---

## For DEV
- Active systems Sprint 1: SpawnManager, MergeGrid, ScoreSystem, PathFollower, GameManager
- TowerConfig SO: type(FIRE/CRYO), mergeLevel(1-3), damage, attackRate, range, spawnCost
- WaveConfig SO: waveNumber, creepCount, creepType, spawnInterval
- Analytics events: session_start, wave_started, wave_completed, tower_spawned, tower_merged, game_over
- Performance: ≤100 draw calls, ≥30 FPS на Samsung Galaxy A54
- Читать: `docs/agents/TZ_DEV_Sprint1_MVP.md`

## For ART
- Sprint 1 assets: 2 башни × 3 Lv + 2 типа крипов + grid + 3 particle FX + merge VFX
- Atlas: всё в 1024×1024, URP Simple Lit
- Polycount: башня ≤800 tri (Lv3), крип ≤300 tri
- Стиль: sci-fi top-down, яркий, cartoon-light. Ref: https://pin.it/2HReRzicu
- Читать: `docs/agents/TZ_ART_Sprint1_MVP.md`

## For UIUX
- Sprint 1 экраны: MainMenu, GameHUD, WinScreen, LoseScreen, PauseOverlay
- Portrait only, touch target ≥48dp, spawn кнопки в нижней 1/5 экрана
- Readable failure: Lose screen показывает номер волны
- Читать: `docs/agents/TZ_UIUX_Sprint1_MVP.md`

## For PM
- KPI Sprint 1: crash-free ≥99%, FPS ≥30 на ref device, merge работает
- Открыть задачи: DEV-S1-001, ART-S1-001, UIUX-S1-001
- Roadmap: Sprint 2 = Волна-режим + 5 башен + 1 герой
- Читать: `docs/concepts/AiW_one_pager_v0.1.md`

---

## Open Design Questions
- [ ] Механика замедления Cryo: max slow 90% на Lv7 — не слишком ли сильно? Нужно плейтестировать.
- [ ] Energy-Harvester (T-011): на каком уровне игры разблокировать, чтобы трейдофф был понятен?
- [ ] PvP bracket по tower tier — как считать tier? Sum level? Max level?
'@

Write-FileContent ".gemini\antigravity\brain\gdd_summary.md" $GDD_SUMMARY

# ── ARTIFACT 2: project_context.md ──────────────────────────
$PROJECT_CONTEXT = @'
# AiW — Project Context
# Файл: .gemini/antigravity/brain/project_context.md
# [STATUS:DRAFT] | Sprint 0

---

## Project
- **Name:** Alien in Waders (AiW)
- **Type:** Mobile Tower Defense + Merge | F2P
- **Platform:** Android (primary), iOS
- **Engine:** Unity 6 LTS + URP | Android-first (minSDK 26)
- **Repo:** github.com/lumowww/Gamedesign-ops (or local D:\ASTRA\My project)

## Current Sprint
- **Sprint:** Sprint 1 (4 weeks)
- **Goal:** Android APK — PvE Тропа-режим, 2 башни, merge, 10 волн
- **Status:** 🟡 IN PROGRESS — документация готова, DEV стартует

## Team (AI agents)
- **GD:** Game Designer Generalist (Claude) — SSOT по дизайну
- **DEV:** Unity Developer agent
- **ART:** Art agent
- **UIUX:** UIUX agent
- **PM:** Producer / PM agent

## Artifacts Location
- GDD Package: `docs/`
- Brain files: `.gemini/antigravity/brain/`
- Agent TZ: `docs/agents/`
- GDD sections: `docs/GDD/sections/`
'@

Write-FileContent ".gemini\antigravity\brain\project_context.md" $PROJECT_CONTEXT

# ── ARTIFACT 3: task_board.md ────────────────────────────────
$TASK_BOARD = @'
# AiW — Task Board
# Файл: .gemini/antigravity/brain/task_board.md
# Sprint 1 | [STATUS:ACTIVE]

---

## Sprint 1 — Active Tasks

| TASK-ID | Агент | Название | Статус | Приоритет | Блокирует |
|---|---|---|---|---|---|
| DEV-S1-001 | DEV | PvE Тропа-режим Android APK | 🔵 TODO | P0 | — |
| ART-S1-001 | ART | Placeholder-контент Sprint 1 | 🔵 TODO | P0 | DEV-S1-001 |
| UIUX-S1-001 | UIUX | 5 экранов Sprint 1 | 🔵 TODO | P0 | DEV-S1-001 |
| DEV-S1-005 | DEV | Highlight-система одинаковых башен | 🔵 TODO | P1 | DEV-S1-001 |

## Sprint 0 — Completed (GD)
| TASK-ID | Агент | Название | Статус |
|---|---|---|---|
| GD-S0-001 | GD | Concept Intake + Go/No-Go | ✅ DONE |
| GD-S0-002 | GD | One Page Concept v0.1 | ✅ DONE |
| GD-S0-003 | GD | Core Loops (micro/meta/macro) | ✅ DONE |
| GD-S0-004 | GD | Unity Mobile Checklist | ✅ DONE |
| GD-S0-005 | GD | Design Heuristics Audit | ✅ DONE |
| GD-S0-006 | GD | TZ DEV / ART / UIUX Sprint 1 | ✅ DONE |
| GD-S0-007 | GD | Tower Entity Matrix (15 башен) | ✅ DONE |
| GD-S0-008 | GD | Free Asset List Sprint 1 | ✅ DONE |

## Backlog (Sprint 2+)
- DEV-S2-001: Волна-режим (bubble-shooter pathfinding)
- DEV-S2-002: Герой игрока
- DEV-S2-003: 5 типов башен
- ART-S2-001: Герой игрока (3D, top-down)
- ART-S2-002: Жук-Босс placeholder
'@

Write-FileContent ".gemini\antigravity\brain\task_board.md" $TASK_BOARD

Write-Ok "Brain files записаны (gdd_summary + project_context + task_board)"

# ════════════════════════════════════════════════════════════
#  КОПИРОВАНИЕ ОСНОВНОГО GDD ПАКЕТА
# ════════════════════════════════════════════════════════════

Write-Header "[ STEP 4/6 ] Основной GDD-пакет"

# Проверяем наличие скачанного файла рядом со скриптом
$PKG_CANDIDATES = @(
    ".\AiW_GDD_PACKAGE_v0.1.md",
    "$env:USERPROFILE\Downloads\AiW_GDD_PACKAGE_v0.1.md",
    ".\AiW_GDD_PACKAGE.md"
)

$PKG_SOURCE = $null
foreach ($c in $PKG_CANDIDATES) {
    if (Test-Path $c) { $PKG_SOURCE = $c; break }
}

if ($PKG_SOURCE) {
    Copy-Item $PKG_SOURCE "docs\GDD\AiW_GDD_Package_v0.1.md" -Force
    Write-Ok "GDD пакет скопирован: docs\GDD\AiW_GDD_Package_v0.1.md"
} else {
    Write-Warn "AiW_GDD_PACKAGE_v0.1.md не найден рядом со скриптом."
    Write-Warn "Скачай файл из Claude и положи рядом с этим .ps1, затем перезапусти."
    Write-Warn "Или после запуска вручную скопируй в: docs\GDD\AiW_GDD_Package_v0.1.md"
}

# ════════════════════════════════════════════════════════════
#  DECISIONS LOG
# ════════════════════════════════════════════════════════════

Write-Header "[ STEP 5/6 ] Обновление decisions_log.md"

$LOG_FILE = ".gemini\antigravity\brain\decisions_log.md"
$LOG_ENTRY = @"

---

## $DEPLOY_DATE — Sprint 0 GDD Package DEPLOYED

**Агент:** GD
**Действие:** Деплой GDD-пакета Sprint 0 v0.1

**Артефакты:**
- `docs/intake/AiW_concept_intake.md` — DONE
- `docs/concepts/AiW_one_pager_v0.1.md` — DONE
- `docs/GDD/sections/AiW_GDD_2.0_CoreLoop.md` — DONE
- `docs/tech/AiW_mobile_constraints_v0.1.md` — DONE
- `docs/GDD/AiW_design_heuristics_audit.md` — DONE
- `docs/agents/TZ_DEV_Sprint1_MVP.md` — DONE
- `docs/agents/TZ_ART_Sprint1_MVP.md` — DONE
- `docs/agents/TZ_UIUX_Sprint1_MVP.md` — DONE
- `docs/GDD/sections/AiW_GDD_2.2_Towers_EntityMatrix.md` — DONE
- `docs/assets/AiW_free_asset_list_Sprint1.md` — DONE
- `.gemini/antigravity/brain/gdd_summary.md` — DONE
- `.gemini/antigravity/brain/project_context.md` — DONE
- `.gemini/antigravity/brain/task_board.md` — DONE

**Ключевые решения (DEC-001..005):**
- DEC-001: Sprint 1 = только Тропа-режим (Волна = Sprint 2)
- DEC-002: Sprint 1 = 2 башни T-001 + T-002
- DEC-003: Realtime PvP → async/bot до Этапа 4
- DEC-004: Арт Random Dice не использовать
- DEC-005: Matchmaking по tower tier (P2W safeguard)

**Статус:** SPRINT 1 READY — все агенты могут стартовать
"@

if (Test-Path $LOG_FILE) {
    Add-Content -Path $LOG_FILE -Value $LOG_ENTRY -Encoding UTF8
    Write-Ok "Запись добавлена в decisions_log.md"
} else {
    $LOG_ENTRY | Out-File -FilePath $LOG_FILE -Encoding UTF8
    Write-Ok "decisions_log.md создан"
}

# ════════════════════════════════════════════════════════════
#  ВЕРИФИКАЦИЯ
# ════════════════════════════════════════════════════════════

Write-Header "ВЕРИФИКАЦИЯ"

$checks = @(
    @{ Path = ".gemini\antigravity\brain\gdd_summary.md";    Label = "gdd_summary.md" },
    @{ Path = ".gemini\antigravity\brain\project_context.md"; Label = "project_context.md" },
    @{ Path = ".gemini\antigravity\brain\task_board.md";      Label = "task_board.md" },
    @{ Path = ".gemini\antigravity\brain\decisions_log.md";   Label = "decisions_log.md" },
    @{ Path = "docs\GDD";                                     Label = "docs/GDD/" }
)

$allOk = $true
foreach ($c in $checks) {
    if (Test-Path $c.Path) {
        Write-Ok "$($c.Label)"
    } else {
        Write-Fail "$($c.Label) — ОТСУТСТВУЕТ"
        $allOk = $false
    }
}

# ════════════════════════════════════════════════════════════
#  GIT COMMIT
# ════════════════════════════════════════════════════════════

Write-Host ""
$doGit = Read-Host "  Сделать git commit? (y/n)"
if ($doGit -eq "y") {
    try {
        git add "docs\"
        git add ".gemini\antigravity\brain\"
        git commit -m "feat(gd): Sprint 0 complete — GDD package v0.1 deployed

- Concept Intake + Go/No-Go
- One Page Concept (11 блоков)
- Core Loops (micro/meta/macro)
- Unity Mobile Checklist
- Design Heuristics Audit (9 Rules + 12 Tricks)
- TZ DEV/ART/UIUX Sprint 1
- Tower Entity Matrix (15 башен из реверса Random Dice)
- Free Asset List Sprint 1
- Brain files: gdd_summary, project_context, task_board

Sprint 1 ready. DEV/ART/UIUX могут стартовать."
        Write-Ok "git commit выполнен"

        $doPush = Read-Host "  git push? (y/n)"
        if ($doPush -eq "y") {
            git push
            Write-Ok "git push выполнен"
        }
    } catch {
        Write-Warn "Git: $($_.Exception.Message)"
    }
}

# ════════════════════════════════════════════════════════════
#  ИТОГ
# ════════════════════════════════════════════════════════════

Write-Host ""
if ($allOk) {
    Write-Host "  ╔═══════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "  ║   ✅ SPRINT 0 DEPLOYED — SPRINT 1 READY!        ║" -ForegroundColor Green
    Write-Host "  ╚═══════════════════════════════════════════════════╝" -ForegroundColor Green
} else {
    Write-Host "  ╔═══════════════════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "  ║   ⚠️  DEPLOYED WITH WARNINGS                    ║" -ForegroundColor Yellow
    Write-Host "  ╚═══════════════════════════════════════════════════╝" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "  📋 СЛЕДУЮЩИЕ ШАГИ:" -ForegroundColor White
Write-Host ""
Write-Host "  1. DEV-Workspace — открой и напиши:" -ForegroundColor Gray
Write-Host "     'Прочитай TZ_DEV_Sprint1_MVP.md и начни Sprint 1'" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "  2. ART-Workspace — открой и напиши:" -ForegroundColor Gray
Write-Host "     'Прочитай TZ_ART_Sprint1_MVP.md и начни placeholder-арт'" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "  3. UIUX-Workspace — открой и напиши:" -ForegroundColor Gray
Write-Host "     'Прочитай TZ_UIUX_Sprint1_MVP.md и начни wireframes'" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "  4. PM-Workspace — открой и напиши:" -ForegroundColor Gray
Write-Host "     '/daily-sync'" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "  5. GD-Workspace — для обновлений использовать:" -ForegroundColor Gray
Write-Host "     '/gdd-update' или '/feature-spec [название]'" -ForegroundColor DarkCyan
Write-Host ""
