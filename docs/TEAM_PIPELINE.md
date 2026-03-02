# 🔄 PIPELINE ВЗАИМОДЕЙСТВИЯ КОМАНДЫ v2.0
## Протоколы коммуникации AI-агентов в Unity GameDev
## (с интеграцией PRODUCER как точки входа)

---

## ВИЗУАЛИЗАЦИЯ ПАЙПЛАЙНА v2.0

```
┌──────────────────────────────────────────────────────────────────────────┐
│                        ANTIGRAVITY AGENT MANAGER                         │
├────────────┬──────────┬──────────┬──────────┬──────────┬────────────────┤
│  PRODUCER  │    PM    │    GD    │   DEV    │  UI/UX   │   ART          │
│  Workspace │ Workspace│ Workspace│ Workspace│ Workspace│   Workspace    │
└─────┬──────┴────┬─────┴────┬─────┴────┬─────┴────┬─────┴────┬──────────┘
      │           │          │          │          │          │
      │     ┌─────▼──────────▼──────────▼──────────▼──────────▼───────┐
      │     │              .gemini/antigravity/brain/                   │
      │     │  project_context.md  (PM R/W)                            │
      │     │  task_board.md       (PM R/W)                            │
      │     │  gdd_summary.md      (GD R/W)                            │
      │     │  art_bible_summary.md (ART R/W)                          │
      │     │  asset_registry.md  (ART/UI W)                           │
      │     │  decisions_log.md   (ALL R/W)                            │
      │     └──────────────────────────────────────────────────────────┘
      │
      │     ┌───────────────────────────────────────────────────────────┐
      └────►│                    docs/                                  │
            │  PRODUCER_BRIEF.md    ← PRODUCER создаёт                 │
            │  PROJECT_PIPELINE.md  ← PRODUCER создаёт, PM исполняет  │
            │  GDD/                 ← GD создаёт                       │
            │  ArtBible/            ← ART создаёт                      │
            │  UISpec/              ← UIUX создаёт                     │
            └───────────────────────────────────────────────────────────┘
```

---

## ЖИЗНЕННЫЙ ЦИКЛ ПРОЕКТА

### ФАЗА 0: КОНЦЕПЦИЯ (PRODUCER ведёт)
```
ПОЛЬЗОВАТЕЛЬ → /concept [описание игры]
       │
       ▼
PRODUCER: Анализ концепта (concept-intake skill)
       │
       ├── Нужна информация? ──► Вопросы пользователю ──► Ждём
       │
       ├── ОК → Market Analysis (market-pulse skill + Perplexity)
       │
       ├── Feasibility Check ──► PM распределяет вопросы агентам
       │                              DEV: "реализуемо?"
       │                              GD: "достаточно глубины?"
       │                              ART: "арт-стиль?"
       │                         ◄── агенты отвечают через artifacts/
       │
       ├── Producer Brief → docs/PRODUCER_BRIEF.md
       ├── Pipeline → docs/PROJECT_PIPELINE.md
       │
       └── PRODUCER → PM: "Запускай"
```

### ФАЗА 1: SPRINT 0 — SETUP (PM ведёт, День 1)
```
PM читает PRODUCER_BRIEF + PROJECT_PIPELINE
PM создаёт task_board.md (Sprint 0 задачи)
PM распределяет параллельно:
  ├── GD: GDD v0.1
  ├── ART: Art Direction
  └── DEV: Unity Project Setup
```

### ФАЗА 2: SPRINTS 1-3 — РАЗРАБОТКА (PM ведёт)
```
PM ведёт task_board, ежедневные sync
Агенты работают по задачам из PROJECT_PIPELINE
Коммуникация: через brain/ и artifacts/

PRODUCER мониторит:
├── Milestone 1 (День 4): Core Mechanic feel check
├── Milestone 2 (День 8): Full Loop review
└── Milestone 3 (День 13): GO/NO-GO для CPI-теста
```

### ФАЗА 3: POST-PROTOTYPE
```
GO  → PRODUCER инициирует Sprint 4 (Test Prep)
       DEV: Build + TestFlight
       ART: Creative video материалы
       Пользователь: записывает gameplay video

NO-GO → PRODUCER проводит Pivot Session
         Пересматривает бриф → новый пайплайн → PM перестраивает task_board
```

---

## МАТРИЦА ПОЛНОМОЧИЙ

| Решение | Кто принимает | Кто уведомляется |
|---------|---------------|-----------------|
| Старт нового проекта | PRODUCER | PM, все агенты |
| Изменение scope | PRODUCER | PM |
| Приоритет задачи | PM | Соответствующий агент |
| Технические решения | DEV | PM, PRODUCER (если влияет на сроки) |
| Дизайн-решения | GD | PM |
| Арт-решения | ART | UIUX, PM |
| Pivot концепта | PRODUCER | Все |
| GO/NO-GO для теста | PRODUCER | Все |
| Разблокирование BLOCKED | PM (малое) / PRODUCER (крупное) | Соответствующий агент |

---

## A2A КОММУНИКАЦИОННЫЕ ПРОТОКОЛЫ

### PRODUCER → PM
```
Через: docs/PRODUCER_BRIEF.md + docs/PROJECT_PIPELINE.md
Плюс запись в: decisions_log.md
Формат: "PRODUCER → PM: [дата] — [инструкция]"
```

### PM → Агент (постановка задачи)
```
Через: task_board.md (добавить задачу)
Агент читает task_board при каждом запуске
```

### Агент → PM (задача готова)
```
/done TASK-ID
PM обновляет статус в task_board.md
```

### Агент → Другой агент (передача артефакта)
```
1. Создать файл: .agent/artifacts/[тип]_[from]_[to]_[дата].md
2. Обновить зависимый brain-файл
3. PM уведомить через task_board
```

### PRODUCER → Агент (запрос отчёта)
```
/report [AGENT]
Агент отвечает: создаёт .agent/artifacts/report_[agent]_[date].md
PM дублирует ключевую информацию в task_board
```

---

## ИНСТРУМЕНТЫ ПО АГЕНТАМ

| Агент | Основные инструменты | Перплексити |
|-------|---------------------|------------|
| PRODUCER | Perplexity Deep Research, Market tools | ✅ Активно |
| PM | task_board.md, project_context.md | ✅ При необходимости |
| GD | GDD Template skill, Level Balance | ❌ Нет |
| DEV | Unity MCP, Unity Editor, C# | ❌ Нет |
| UIUX | Figma/спеки, UI Templates | ❌ Нет |
| ART | Asset Store, AI-генерация | ❌ Нет |
