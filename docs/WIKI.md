# 📖 WIKI: GAMEDEV TEAM — РУКОВОДСТВО ДЛЯ НОВЫХ УЧАСТНИКОВ v2.0

> Последнее обновление: 2026-03-04 | Проект: `d:\ASTRA\My project` | **FULL TEAM v2.0 — Обновлённая**

---

## 🗺️ Что такое этот проект

Мультиагентная команда разработки мобильных игр на Unity.
**6 AI-агентов в 6 отдельных Workspaces** (включая автономного агента Qwen Code) работают в одном Unity-проекте,
общаясь через файловую систему (`brain/`), без прямого вызова друг друга.

**Стек:**

- Unity 6 LTS + URP | iOS + Android
- Antigravity IDE с Agent Manager
- Qwen Code — автономный кодер, интегрированный в среду Antigravity
- MCP-Unity (`com.gamelovers.mcp-unity`) — прямое управление Editor через AI
- Brain-файлы (`.gemini/antigravity/brain/`) — единая коммуникационная шина

---

## 👥 Команда: роли и Workspaces

| Workspace | Агент | Роль | Rule-файл |
|-----------|-------|------|-----------|
| PRODUCER-Workspace | **PRODUCER** | Game Producer — концепт, анализ рынка, точка входа | `.agent/rules/06_PRODUCER.md` |
| PM-Workspace | **PM** | Project Manager — владелец задач, ритм команды | `.agent/rules/01_PM.md` |
| GD-Workspace | **GD** | Game Designer — GDD, механики, баланс | `.agent/rules/02_GD.md` |
| DEV-Workspace | **DEV** | Unity Lead Dev — код, MCP, интеграция (роль по умолчанию для Qwen Code) | `.agent/rules/03_DEV.md` |
| UIUX-Workspace | **UIUX** | UI/UX Designer — экраны, спеки, Figma | `.agent/rules/04_UIUX.md` |
| ART-Workspace | **ART** | Art Director — арт-библия, ассеты | `.agent/rules/05_ART.md` |

> Глобальные правила для всех: `.agent/rules/00_global.md`

---

## 📁 Структура проекта

```
<КОРЕНЬ>/
├── AGENTS.md                    ← читать ПЕРВЫМ при входе в проект
├── CREDITS.md                   ← реестр attribution для ассетов
│
├── .agent/
│   ├── rules/                   ← правила агентов (00_global + 01-06)
│   ├── workflows/               ← инструкции для слэш-команд
│   ├── skills/                  ← навыки: unity-mcp, concept-intake и др.
│   └── artifacts/               ← временные A2A артефакты между агентами
│
├── .qwen/                       ← конфигурация автономного Qwen Code
│   ├── QWEN.md                  ← контракт поведения Qwen Code
│   ├── skills/                  ← навыки (например, docker-health, ps-fix)
│   └── tasks/                   ← задачи Qwen
│
├── .gemini/antigravity/brain/   ← КОММУНИКАЦИОННАЯ ШИНА
│   ├── project_context.md       ← кто мы, дедлайн, статус (PM владелец)
│   ├── task_board.md            ← задачи и спринты (PM владелец)
│   ├── gdd_summary.md           ← краткое GDD (GD владелец)
│   ├── art_bible_summary.md     ← арт-стиль кратко (ART владелец)
│   ├── asset_registry.md        ← все ассеты проекта (ART + UIUX)
│   └── decisions_log.md         ← лог решений, append-only (все агенты)
│
├── docs/
│   ├── GDD/                     ← полные версии GDD
│   ├── ArtBible/                ← полные версии арт-библии
│   ├── UISpec/                  ← спеки экранов от UIUX
│   ├── AssetLists/              ← листы ассетов
│   ├── TEAM_PIPELINE.md         ← визуализация пайплайна команды
│   ├── all_workflows.md         ← все workflow подробно
│   └── BRAIN_TEMPLATES.md       ← шаблоны для brain-файлов
│
└── Assets/
    ├── _Project/                ← КОД ТОЛЬКО ЗДЕСЬ (DEV пишет)
    │   ├── Scripts/Core|Gameplay|UI|Data
    │   ├── Prefabs/ · Scenes/ · Art/ · Audio/ · UI/
    └── _ThirdParty/             ← импортированные ассеты (только чтение!)
```

---

## 🚀 Как начать новый проект (порядок действий)

### Шаг 1 — Настройка MCP-Unity (один раз)

MCP-Unity уже установлен (`com.gamelovers.mcp-unity@1.2.0`).

Добавь конфиг в **Antigravity → Settings → MCP Servers**:

```json
{
  "mcpServers": {
    "unity": {
      "command": "node",
      "args": ["d:\\ASTRA\\My project\\Library\\PackageCache\\com.gamelovers.mcp-unity@1.2.0\\Server~\\build\\index.js"]
    }
  }
}
```

> ⚠️ Unity Editor должен быть открыт — иначе MCP не подключится.

### Шаг 2 — Создать Workspaces в Agent Manager

Создай 6 Workspaces и в каждом активируй соответствующий Rule-файл:
`Settings → Rules → .agent/rules/06_PRODUCER.md` (для PRODUCER), `01_PM.md` (для PM) и т.д.

### Шаг 3 — Запустить первый проект

**Важно:** Все проекты начинаются через **PRODUCER-Workspace**.

В **PRODUCER-Workspace** написать:

```
/concept [описание игры]
```

PRODUCER создаст **Producer Brief** и **Project Pipeline** → передаст PM.

### Шаг 4 — PM инициализирует разработку

После получения брифа от PRODUCER, в **PM-Workspace** написать:

```
/new-project
```

PM запросит уточнения, создаст **Sprint 0** и задачи в `task_board.md`.

### Шаг 5 — GD создаёт GDD v0.1

GD получает задачу от PM → создаёт **GDD v0.1** (Core Loop, механики, scope).

Только после GDD v0.1 команда начинает разработку.

---

## ⚡ Слэш-команды (быстрая шпаргалка)

| Команда | Кто | Что делает |
|---------|-----|-----------|
| `/concept` | PRODUCER | Старт проекта, валидация концепта, пайплайн |
| `/new-project` | PM | Инициализация проекта на стороне разработки (после /concept) |
| `/sync` | PM | Ежедневная сводка: done / in-progress / blockers |
| `/done TASK-ID` | любой | Закрыть задачу, обновить brain |
| `/handoff` | любой | Сохранить контекст перед сменой модели |
| `/resume` | любой | Восстановить контекст из handoff |
| `/asset-request тип "описание"` | DEV/UIUX | Запросить ассет у ART |
| `/gdd-update` | GD | Обновить GDD + уведомить команду |
| `/feature-spec [название]` | GD | Написать feature spec + ТЗ агентам |
| `/balance-review` | GD | Аудит экономики и прогрессии |
| `/design-review [TASK-ID]` | GD | Ревью реализации на соответствие GDD |
| `/liveops-plan [тип]` | GD | Спроектировать LiveOps событие |
| `/qwen-autonomous` | Qwen/DEV | Вызов Qwen Code для автономной работы по задаче |

---

## 🔑 Ключевые концепции v2.0

### GD Gate (Design Review)

**Все DESIGN задачи проходят обязательный GD Gate перед закрытием.**

```
DEV завершает задачу → Статус: DONE → GD получает уведомление
GD → `/design-review TASK-ID` → Проверка на соответствие GDD
→ ✅ PASS: Задача закрыта
→ ❌ FAIL: Задача возвращается в BACKLOG с комментариями
```

**GD Gate проверяет:**
- Соответствие GDD и feature spec
- Корректность игровой механики
- Баланс и экономику (если применимо)
- UX/UI соответствие гайдлайнам

### A2A Артефакты (Agent-to-Agent)

Агенты общаются через **A2A артефакты** в `.agent/artifacts/`:

```
GD_to_DEV_TASK-001.md — ТЗ для DEV по задаче TASK-001
GD_to_ART_TASK-002.md — ТЗ для ART по задаче TASK-002
PM_to_ALL_Sprint1.md — План спринта для всех
```

**Формат артефакта:**
- Задача (что сделать)
- Контекст (зачем)
- Критерии готовности (Definition of Done)
- Зависимости (от каких задач зависит)
- Дедлайн (ETA)

### RBAC (Rights-Based Access Control)

| Файл/Директория | R/W | Read-only | Append-only |
|-----------------|-----|-----------|-------------|
| `task_board.md` | PM | Все | — |
| `docs/GDD/` | GD | Все | — |
| `docs/ArtBible/` | ART | Все | — |
| `docs/UISpec/` | UIUX | Все | — |
| `Assets/_Project/Scripts/` | DEV | Все | — |
| `decisions_log.md` | — | Все | Все |
| `gdd_summary.md` | GD | Все | — |

---

## 🔄 Пайплайн от идеи до прототипа

```
USER → PRODUCER: "/concept [идея]"
  │
  ├─ PRODUCER: Market анализ, Feasibility Check, пайплайн (PRODUCER_BRIEF)
  │
  └─ PM: перехватывает после PRODUCER, создаёт Sprint 0
         ↓
  GD  → TASK-001: GDD v0.1 (Core Mechanic + Loop + Scope)
  ART → TASK-002: Арт-библия v0.1
  UIUX→ TASK-003: Список экранов + UI Asset List
  DEV → TASK-004: Настройка Unity (MCP) или запуск Qwen Code автономно
         ↓
  PM: /sync → выдаёт Sprint 1 (разработка механик)
         ↓
  DEV реализует Core Mechanic → Game Loop → Visual Feedback → UI
         ↓
  Прототип готов к тесту [1-2 недели]
```

---

## 📋 Как читать task_board.md

```markdown
## TASK-015: [Название задачи]
**Агент:** DEV                         ← кто выполняет
**Статус:** TODO → IN_PROGRESS → DONE  ← текущий статус
**Приоритет:** P0 (критично) / P1 / P2
**Зависит от:** TASK-001               ← нельзя начать без неё
**Описание:** Чёткое ТЗ
**Критерии готовности:** Как проверить
**ETA:** Sprint 1, День 3
```

---

## 🏗️ Конвенции кода (DEV)

```csharp
// Именование
public class PlayerController : MonoBehaviour  // PascalCase
{
    [SerializeField] private float _speed = 5f; // _camelCase для приватных
    public bool IsAlive { get; private set; }    // PascalCase для public

    private void Awake() => _rb = GetComponent<Rigidbody2D>();
}

// Константы: UPPER_SNAKE_CASE
// ScriptableObjects: суффикс SO  → LevelConfigSO
// Prefabs: суффикс Pfb           → PlayerPfb
// Scenes: snake_case             → gameplay_main
```

**Запрещено:**

- `FindObjectOfType()` в `Update()`
- Магические числа (только через ScriptableObjects)
- Файлы вне `_Project/` или `_ThirdParty/`

---

## 🔐 Кто владеет чем (контроль конфликтов)

| Файл/Директория | Единственный владелец |
|-----------------|----------------------|
| `task_board.md` | **PM** (только он создаёт/архивирует задачи) |
| `docs/GDD/` | **GD** |
| `docs/ArtBible/` | **ART** |
| `docs/UISpec/` | **UIUX** |
| `Assets/_Project/Scripts/` | **DEV** |
| `decisions_log.md` | **все** (append-only, только добавлять в конец) |
| `asset_registry.md` | **ART** (ART-xxx) + **UIUX** (UI-xxx) |

---

## 🆘 Типичные проблемы

| Проблема | Решение |
|----------|---------|
| MCP не подключается | Открой Unity Editor → убедись что конфиг добавлен в Antigravity Settings |
| MCP `Connection refused :8090` | Unity Editor закрыт — открой проект |
| Ошибка HTTP 501 или curl localhost:8090 не работает | Это нормально. MCP работает через **STDIO транспорт**, а не HTTP. Подключается напрямую из Antigravity. |
| Compile errors блокируют всё | В DEV-Workspace: `get_console_logs` → исправить → `refresh_asset_database` |
| Не знаю текущую задачу | Читай `task_board.md` → найди свою роль |
| Потерял контекст | Вызови `/resume` — восстановит последний handoff |
| Конфликт архитектурный | Запись в `decisions_log.md` + уведомить PM |
| Блокер > 24 часов | Статус → BLOCKED в `task_board.md` + описание причины |

---

## 📚 Дополнительные ресурсы

| Файл | Содержимое |
|------|-----------|
| [TEAM_PIPELINE.md](TEAM_PIPELINE.md) | Визуальная схема всех пайплайнов |
| [all_workflows.md](all_workflows.md) | Детальные инструкции всех слэш-команд |
| [BRAIN_TEMPLATES.md](BRAIN_TEMPLATES.md) | Шаблоны для brain-файлов |
| `.agent/skills/hypercasual-patterns/SKILL.md` | Шаблоны кода: GameManager, Pooling, DOTween |
| `.agent/skills/gdd-template/SKILL.md` | Шаблон GDD и реверс-инжиниринг протокол |
| `.agent/skills/art-bible/SKILL.md` | Шаблон арт-библии |
| `.agent/skills/asset-store/SKILL.md` | Где искать бесплатные ассеты |
