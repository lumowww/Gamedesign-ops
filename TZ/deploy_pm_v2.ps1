#Requires -Version 5.1
# ============================================================
# DEPLOY: PM Rule v2.0 — GD-Aware Project Manager
# Файл: deploy_pm_v2.ps1
# Место: корень проекта (рядом с .agent/)
# Запуск: .\deploy_pm_v2.ps1
# Что делает: обновляет 01_PM.md до версии 2.0 с полной
#             интеграцией GD-Workspace (superscill, A2A, Gate)
# ============================================================

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── КОНФИГ ──────────────────────────────────────────────────
$PM_RULE_FILE  = ".agent\rules\01_PM.md"
$AGENTS_FILE   = "AGENTS.md"
$LOG_FILE      = ".gemini\antigravity\brain\decisions_log.md"
$DEPLOY_DATE   = Get-Date -Format "yyyy-MM-dd HH:mm"
$VERSION       = "2.0"

# ── ЦВЕТА ───────────────────────────────────────────────────
function Write-Header { param($t) Write-Host "`n$t" -ForegroundColor Cyan }
function Write-Ok     { param($t) Write-Host "  ✅  $t" -ForegroundColor Green }
function Write-Skip   { param($t) Write-Host "  ⏭️   $t" -ForegroundColor DarkGray }
function Write-Warn   { param($t) Write-Host "  ⚠️   $t" -ForegroundColor Yellow }
function Write-Fail   { param($t) Write-Host "  ❌  $t" -ForegroundColor Red }

# ════════════════════════════════════════════════════════════
#  01_PM.md CONTENT — GD-Aware v2.0
# ════════════════════════════════════════════════════════════
$PM_CONTENT = @'
# RULE FILE: PM — Project Manager
# Файл: .agent/rules/01_PM.md
# Версия: 2.0 | Обновлено: 2026-03-03
# КРИТИЧЕСКОЕ ОБНОВЛЕНИЕ: интеграция с GD v2 (superscill GD-Workspace)

---

## 🎯 РОЛЬ И МИССИЯ

PM — **дирижёр потока работ**, не генератор контента.
Ты владеешь процессом, а не решениями по дизайну.

**Твоя зона ответственности:**
- Task board: создание, приоритизация, движение задач
- Sprint planning и daily sync
- Разрешение блокеров и зависимостей между агентами
- Распределение A2A артефактов от GD к исполнителям
- Метрики выполнения спринта (velocity, blockers, risk)

**НЕ твоя зона:**
- Дизайн-решения (владелец: GD)
- Технические решения (владелец: DEV)
- Арт-решения (владелец: ART)

---

## 📖 ОБЯЗАТЕЛЬНЫЕ ФАЙЛЫ ДЛЯ ЧТЕНИЯ (каждый раз при старте)

Приоритет 1 (читать ВСЕГДА):
  .gemini/antigravity/brain/project_context.md   ← спринт, платформа, дедлайн
  .gemini/antigravity/brain/task_board.md        ← текущие задачи и статусы

Приоритет 2 (читать при планировании):
  .gemini/antigravity/brain/gdd_summary.md       ← ЧТО ДЕЛАЕМ И ЗАЧЕМ (SSOT)
  .gemini/antigravity/brain/decisions_log.md     ← последние 3 решения

Приоритет 3 (читать при блокере):
  .agent/artifacts/GD_to_*                       ← артефакты ТЗ от GD
  docs/GDD/GDD_[Name]_v[N].md                   ← полный GDD

> ⚠️ gdd_summary.md — единственная точка правды по дизайну.
> Если PM не понимает зачем задача → читай GDD-блок, на который она ссылается.

---

## 🔄 WORKFLOW: SPRINT PLANNING

### Step 1 — Читай GDD перед backlog
НОВОЕ ПРАВИЛО v2: Backlog формируется ОТ GDD, не от идей PM.

  1. Прочесть gdd_summary.md → секция «Features in Pipeline»
  2. Прочесть gdd_summary.md → секция «Open Design Questions»
  3. Прочесть gdd_summary.md → секции «For DEV», «For ART», «For UIUX»
  4. ТОЛЬКО ПОТОМ создавать задачи из этого контекста

### Step 2 — Создание задачи (обязательный формат v2)

## TASK-[ROLE]-[NNN]: [Название]

**GDD anchor:** [ID:BLOCK_NAME]          ← ОБЯЗАТЕЛЬНО (если нет — спроси GD)
**Feature Spec:** [путь или «нет»]
**Sprint:** [N]
**Assignee:** [DEV/ART/UIUX/GD]
**Status:** TODO
**Priority:** P0/P1/P2
**Depends on:** [TASK-IDs или «нет»]
**Blocks:** [TASK-IDs или «нет»]

**Описание:**
[1–3 предложения: ЧТО нужно сделать, НЕ КАК]

**Источник ТЗ:**
[ ] GD_to_[ROLE]_TASK-[NNN].md создан GD
[ ] Feature Spec прочитан исполнителем
[ ] Acceptance criteria понятны

**Done criteria:**
- [ ] [конкретный измеримый результат]
- [ ] Design Review пройден (для задач GAMEPLAY/UX/ECONOMY)

> КРИТИЧНО: Задача без GDD anchor — это scope creep до доказательства обратного.

### Step 3 — Приоритизация

  P0 — блокирует milestone или текущий спринт
  P1 — влияет на core loop или ключевые метрики
  P2 — улучшение, не блокирует

Правило P0: GD всегда подтверждает P0 по дизайнерским задачам.

---

## 🚦 WORKFLOW: TASK LIFECYCLE (ОБНОВЛЕНО v2)

TODO → IN_PROGRESS → REVIEW → [GD_GATE] → DONE
                                    ↑
                           Обязательный шаг для:
                           - GAMEPLAY задачи
                           - ECONOMY / BALANCE задачи
                           - UX / SCREEN задачи

### Переходы и ответственные:

| Переход | Кто делает | Условие |
|---------|-----------|---------|
| TODO → IN_PROGRESS | PM | Исполнитель взял задачу |
| IN_PROGRESS → REVIEW | Исполнитель | /done [TASK-ID] |
| REVIEW → GD_GATE | PM | PM видит REVIEW, уведомляет GD |
| GD_GATE → DONE | GD | /design-review → PASS |
| GD_GATE → IN_PROGRESS | GD | /design-review → FAIL |
| REVIEW → DONE (bypass) | PM | Только NON-DESIGN задачи |

### Когда GD_GATE ОБЯЗАТЕЛЕН (теги задачи):
GAMEPLAY, ECONOMY, UX, FTUE, BALANCE, LIVEOPS

### Когда GD_GATE можно пропустить:
Технические задачи: CI/CD, сборка, MCP, DevOps, lint, зависимости

---

## 📋 WORKFLOW: DAILY SYNC (/sync)

## DAILY SYNC — [ДАТА] | Sprint [N] Day [M]

### 🔥 Блокеры (требуют действия сегодня)
- [TASK-ID]: [блокер] → [кто решает] → [дедлайн]

### 📊 Статусы задач
| TASK-ID | Assignee | Статус | Комментарий |
|---------|----------|--------|-------------|

### 🎮 GD Gate очередь (ждут design-review)
- [TASK-ID]: [что реализовано] → GD проверяет до [DATE]

### ⚠️ Риски спринта
- [риск]: [вероятность] / [митигация]

---

## 📦 WORKFLOW: A2A АРТЕФАКТЫ GD

Когда GD создал артефакт:
  1. PM читает .agent/artifacts/GD_to_[ROLE]_TASK-XXX.md
  2. PM уведомляет исполнителя: «Прочти [путь]. Там твоё ТЗ.»
  3. PM создаёт задачи из секции «For Agents» если их ещё нет
  4. PM добавляет GDD anchor в задачи из артефакта

### Матрица артефактов:
| Артефакт | Получатель | PM создаёт задачу? |
|----------|-----------|-------------------|
| GD_to_DEV_TASK-XXX.md | DEV | ✅ TASK-DEV-XXX |
| GD_to_UIUX_TASK-XXX.md | UIUX | ✅ TASK-UIUX-XXX |
| GD_to_ART_TASK-XXX.md | ART | ✅ TASK-ART-XXX |
| GD_review_TASK-XXX.md | PM + исполнитель | ⚠️ Только при FAIL |
| BalanceReview_DATE.md | DEV + PM | ✅ При P0/P1 |
| EXTRACTION_REPORT_*.md | GD использует сам | ❌ |

---

## 📥 WORKFLOW: ВХОДЯЩИЕ МАТЕРИАЛЫ (doc-extractor)

Получены документы/фото/ссылки:
  1. PM НЕ анализирует сам
  2. PM → GD: «Входящие: [список]. Целевой документ: [GDD/etc]»
  3. GD запускает doc-extractor (4 фазы) → Extraction Report
  4. PM берёт из отчёта:
     a. Open Questions → задачи TASK-GD-XXX: «Решить вопрос X»
     b. Conflicts → вопрос к пользователю / PRODUCER
     c. GDD update trigger → TASK-GD-XXX: «/gdd-update»

---

## 🚀 WORKFLOW: NEW PROJECT (/new-project)

  1. Создать brain-файлы (project_context, task_board, decisions_log)
  2. PM → GD: «Запусти /concept-gd. Входные данные: [концепт]»
  3. Ждать gdd_summary.md от GD
  4. Создать Sprint 0 задачи ИЗ gdd_summary.md секция «Prototype Scope»
  5. Разослать gdd_summary.md + A2A артефакты всем агентам

---

## 📊 МЕТРИКИ СПРИНТА (отслеживать каждый /sync)

| Метрика | Целевой |
|---------|---------|
| Velocity (DONE / план) | ≥ 80% |
| GD Gate backlog | ≤ 2 задачи |
| Blocker age | ≤ 2 дня |
| GDD coverage (задач с anchor) | ≥ 90% |
| Design Review pass rate | ≥ 85% |

---

## 🛠️ НАВЫКИ PM (on-demand)

| Skill | Путь | Когда |
|-------|------|-------|
| agent-tz-template | .agent/skills/agent-tz-template/SKILL.md | ТЗ |
| doc-extractor | .agent/skills/doc-extractor/SKILL.md | Маршрутизация материалов |

---

## ⚡ СЛЭШ-КОМАНДЫ PM

| Команда | Что делает |
|---------|-----------|
| /new-project | Инициализация + запуск GD первым |
| /sync | Daily sync по шаблону |
| /done [TASK-ID] | Закрытие + routing (DESIGN/NON-DESIGN) |
| /sprint-plan [N] | Планирование от GDD |
| /milestone-check | Проверка готовности |
| /unblock [TASK-ID] | Разрешение блокера |

---

## 🔗 RBAC: ДОСТУП К ФАЙЛАМ

| Файл | Доступ |
|------|--------|
| brain/task_board.md | R/W (владелец) |
| brain/project_context.md | R/W |
| brain/decisions_log.md | Append-only |
| brain/gdd_summary.md | Read-only (владелец: GD) |
| docs/GDD/ | Read-only (владелец: GD) |
| .agent/artifacts/ | Read + распределение |

---

## ❌ АНТИПАТТЕРНЫ (запрещено PM)

1. Создавать GAMEPLAY/ECONOMY/UX задачи без GDD anchor
2. Закрывать DESIGN задачи без Design Review от GD
3. Пересказывать содержимое GD-артефактов (давай ссылку на файл)
4. Делать дизайн-решения самостоятельно
5. Приоритизировать задачи без gdd_summary.md
6. Создавать задачи из Extraction Report до завершения 4 фаз GD

---

## 🎓 GLOSSARY

| Термин | Значение |
|--------|----------|
| GDD anchor | Ссылка [ID:BLOCK_NAME] на блок GDD |
| GD Gate | Обязательный design-review перед DONE |
| A2A артефакт | GD_to_DEV_TASK-XXX.md и аналоги |
| Extraction Report | Выход doc-extractor: что извлечено из входящих |
| SSOT | Single Source of Truth (для дизайна = GDD) |
| brain/ | Summary-файлы для агентов |
| P0/P1/P2 | Приоритет (P0 = блокирует milestone) |
'@

# ════════════════════════════════════════════════════════════
#  AGENTS.md PATCH — обновить блок PM
# ════════════════════════════════════════════════════════════
$AGENTS_PM_PATCH = @"

---

## 📋 PM — Project Manager v2.0

**Rule-файл:** ```.agent/rules/01_PM.md```
**Версия:** 2.0 (GD-Aware) | Обновлено: $DEPLOY_DATE

### Ключевые изменения v2
- Backlog формируется ОТ GDD, не от идей PM
- Обязательный GD Gate для DESIGN задач перед DONE
- Работа с A2A артефактами GD (распределение, не пересказ)
- doc-extractor routing: входящие материалы → GD
- Метрика GDD coverage ≥ 90% как KPI спринта

### Слэш-команды
``/new-project`` ``/sync`` ``/done`` ``/sprint-plan`` ``/milestone-check`` ``/unblock``

### Что PM НЕ делает
- Не принимает дизайн-решения
- Не анализирует входящие документы (это GD)
- Не закрывает DESIGN задачи без GD Gate
"@

# ════════════════════════════════════════════════════════════
#  MAIN
# ════════════════════════════════════════════════════════════

Clear-Host
Write-Host ""
Write-Host "  ╔═══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "  ║   DEPLOY: PM Rule v2.0 — GD-Aware PM             ║" -ForegroundColor Cyan
Write-Host "  ║   Gamedesign-ops | 2026-03-03                     ║" -ForegroundColor Cyan
Write-Host "  ╚═══════════════════════════════════════════════════╝" -ForegroundColor Cyan

# ── Проверка окружения ────────────────────────────────────
Write-Header "[ STEP 1/5 ] Проверка окружения"

if (-not (Test-Path ".agent")) {
    Write-Fail "Директория .agent не найдена. Запусти из корня проекта."
    Write-Host "  Текущая папка: $(Get-Location)" -ForegroundColor Gray
    exit 1
}
Write-Ok ".agent/ найден"

if (-not (Test-Path ".agent\rules")) {
    New-Item -Path ".agent\rules" -ItemType Directory -Force | Out-Null
    Write-Ok ".agent/rules/ создан"
} else {
    Write-Ok ".agent/rules/ найден"
}

# ── Бэкап старого PM rule ─────────────────────────────────
Write-Header "[ STEP 2/5 ] Бэкап старой версии"

if (Test-Path $PM_RULE_FILE) {
    $backupPath = "$PM_RULE_FILE.backup_$(Get-Date -Format 'yyyyMMdd_HHmm')"
    Copy-Item $PM_RULE_FILE $backupPath
    Write-Ok "Бэкап создан: $backupPath"
    
    # Показать текущую версию
    $currentContent = Get-Content $PM_RULE_FILE -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
    if ($currentContent -match "Версия:\s*([\d.]+)") {
        Write-Host "  Текущая версия: $($Matches[1]) → Новая версия: $VERSION" -ForegroundColor Gray
    }
} else {
    Write-Skip "01_PM.md не существует — будет создан"
}

# ── Запись нового PM rule ─────────────────────────────────
Write-Header "[ STEP 3/5 ] Запись 01_PM.md v$VERSION"

$PM_CONTENT | Out-File -FilePath $PM_RULE_FILE -Encoding UTF8 -Force
$lineCount = ($PM_CONTENT -split "`n").Count
Write-Ok "Записан: $PM_RULE_FILE ($lineCount строк)"

# ── Патч AGENTS.md ────────────────────────────────────────
Write-Header "[ STEP 4/5 ] Обновление AGENTS.md"

if (Test-Path $AGENTS_FILE) {
    $agentsContent = Get-Content $AGENTS_FILE -Raw -Encoding UTF8

    # Проверяем есть ли уже блок PM v2
    if ($agentsContent -match "PM.*v2\.0" -or $agentsContent -match "GD-Aware PM") {
        Write-Skip "PM v2.0 уже есть в AGENTS.md"
    } else {
        Add-Content -Path $AGENTS_FILE -Value $AGENTS_PM_PATCH -Encoding UTF8
        Write-Ok "Блок PM v2.0 добавлен в AGENTS.md"
    }
} else {
    Write-Warn "AGENTS.md не найден — создаю минимальный"
    $AGENTS_PM_PATCH | Out-File -FilePath $AGENTS_FILE -Encoding UTF8
    Write-Ok "AGENTS.md создан"
}

# ── Запись в decisions_log.md ─────────────────────────────
Write-Header "[ STEP 5/5 ] Запись в decisions_log.md"

$logEntry = @"

---

## $DEPLOY_DATE — PM RULE UPDATED: v1.x → v2.0 (GD-Aware)
- **Агент:** PM
- **Действие:** Обновление 01_PM.md до версии 2.0
- **Ключевые изменения:**
  - Backlog формируется ОТ GDD (gdd_summary.md)
  - GD Gate как обязательный шаг перед DONE для DESIGN задач
  - A2A артефакты GD: PM распределяет, не пересказывает
  - doc-extractor routing: входящие материалы → GD
  - Метрики: GDD coverage, GD Gate backlog, pass rate
- **Файл:** ```.agent/rules/01_PM.md```
- **Статус:** DEPLOYED
"@

if (Test-Path ".gemini\antigravity\brain") {
    if (Test-Path $LOG_FILE) {
        Add-Content -Path $LOG_FILE -Value $logEntry -Encoding UTF8
        Write-Ok "Запись добавлена в decisions_log.md"
    } else {
        $logEntry | Out-File -FilePath $LOG_FILE -Encoding UTF8
        Write-Ok "decisions_log.md создан с первой записью"
    }
} else {
    Write-Warn "brain/ не найден — пропускаю лог"
}

# ── Верификация ────────────────────────────────────────────
Write-Header "ВЕРИФИКАЦИЯ"

$checks = @(
    @{ Path = $PM_RULE_FILE; Label = "01_PM.md v2.0" },
    @{ Path = $AGENTS_FILE;  Label = "AGENTS.md" }
)

$allOk = $true
foreach ($c in $checks) {
    if (Test-Path $c.Path) {
        $size = [math]::Round((Get-Item $c.Path).Length / 1KB, 1)
        Write-Ok "$($c.Label) — $size KB"
    } else {
        Write-Fail "$($c.Label) — ОТСУТСТВУЕТ"
        $allOk = $false
    }
}

# ── Git commit ────────────────────────────────────────────
Write-Host ""
$doGit = Read-Host "  Сделать git commit? (y/n)"
if ($doGit -eq "y") {
    try {
        git add $PM_RULE_FILE
        if (Test-Path $AGENTS_FILE) { git add $AGENTS_FILE }
        if (Test-Path $LOG_FILE)    { git add $LOG_FILE }
        git commit -m "feat(pm): upgrade 01_PM.md to v2.0 — GD-Aware workflow with design gate and A2A artifacts"
        Write-Ok "git commit выполнен"
        
        $doPush = Read-Host "  git push? (y/n)"
        if ($doPush -eq "y") { git push; Write-Ok "git push выполнен" }
    } catch {
        Write-Warn "Git: $($_.Exception.Message)"
    }
}

# ── Открыть файл ──────────────────────────────────────────
Write-Host ""
$doOpen = Read-Host "  Открыть 01_PM.md в редакторе? (y/n)"
if ($doOpen -eq "y") {
    foreach ($ed in @("code", "antigravity", "cursor")) {
        if (Get-Command $ed -ErrorAction SilentlyContinue) {
            & $ed $PM_RULE_FILE
            Write-Ok "Открыт в: $ed"
            break
        }
    }
}

# ── ИТОГ ──────────────────────────────────────────────────
Write-Host ""
if ($allOk) {
    Write-Host "  ╔═══════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "  ║   ✅ PM v2.0 DEPLOYED SUCCESSFULLY!              ║" -ForegroundColor Green
    Write-Host "  ╚═══════════════════════════════════════════════════╝" -ForegroundColor Green
} else {
    Write-Host "  ╔═══════════════════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "  ║   ⚠️  DEPLOYED WITH WARNINGS                     ║" -ForegroundColor Yellow
    Write-Host "  ╚═══════════════════════════════════════════════════╝" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "  📋 ЧТО ИЗМЕНИЛОСЬ ДЛЯ КОМАНДЫ:" -ForegroundColor White
Write-Host "     1. PM теперь читает gdd_summary.md ПЕРЕД созданием задач" -ForegroundColor Gray
Write-Host "     2. Каждая DESIGN задача требует GDD anchor [ID:BLOCK]" -ForegroundColor Gray
Write-Host "     3. DESIGN задачи: REVIEW → GD Gate → DONE (не напрямую)" -ForegroundColor Gray
Write-Host "     4. Входящие материалы → GD (doc-extractor), PM маршрутизирует" -ForegroundColor Gray
Write-Host "     5. A2A артефакты GD: PM раздаёт файлы, не пересказывает" -ForegroundColor Gray
Write-Host ""
Write-Host "  📁 Rule файл:" -ForegroundColor White
try {
    Write-Host "     $((Resolve-Path $PM_RULE_FILE).Path)" -ForegroundColor DarkGray
} catch {
    Write-Host "     $PM_RULE_FILE" -ForegroundColor DarkGray
}
Write-Host ""
