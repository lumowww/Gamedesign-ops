# 📖 WIKI: GAMEDEV TEAM — РУКОВОДСТВО ДЛЯ НОВЫХ УЧАСТНИКОВ 1.0

> Последнее обновление: 2026-03-01 | Проект: `d:\ASTRA\My project`

---

## 🗺️ Что такое этот проект

Мультиагентная команда разработки мобильных гиперказуальных игр на Unity.
**5 AI-агентов в 5 отдельных Workspaces** работают в одном Unity-проекте,
общаясь через файловую систему (`brain/`), без прямого вызова друг друга.

**Стек:**

- Unity 6 LTS + URP | iOS + Android
- Antigravity IDE с Agent Manager
- MCP-Unity (`com.gamelovers.mcp-unity`) — прямое управление Editor через AI
- Brain-файлы (`.gemini/antigravity/brain/`) — единая коммуникационная шина

---

## 👥 Команда: роли и Workspaces

| Workspace | Агент | Роль | Rule-файл |
|-----------|-------|------|-----------|
| PM-Workspace | **PM** | Project Manager — владелец задач, ритм команды | `.agent/rules/01_PM.md` |
| GD-Workspace | **GD** | Game Designer — GDD, механики, баланс | `.agent/rules/02_GD.md` |
| DEV-Workspace | **DEV** | Unity Lead Dev — код, MCP, интеграция | `.agent/rules/03_DEV.md` |
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
│   ├── rules/                   ← правила агентов (00_global + 01-05)
│   ├── workflows/               ← инструкции для слэш-команд
│   ├── skills/                  ← навыки: unity-mcp, hypercasual-patterns и др.
│   └── artifacts/               ← временные A2A артефакты между агентами
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

MCP-Unity уже установлен (`com.gamelovers.mcp-unity@e4b7e74ad052`).

Добавь конфиг в **Antigravity → Settings → MCP Servers**:

```json
{
  "command": "node",
  "args": ["d:\\ASTRA\\My project\\Library\\PackageCache\\com.gamelovers.mcp-unity@e4b7e74ad052\\Server~\\build\\index.js"]
}
```

> ⚠️ Unity Editor должен быть открыт — иначе MCP не подключится.

### Шаг 2 — Создать Workspaces в Agent Manager

Создай 5 Workspaces и в каждом активируй соответствующий Rule-файл:
`Settings → Rules → .agent/rules/01_PM.md` (для PM) и т.д.

### Шаг 3 — Запустить первый проект

В **PM-Workspace** написать:

```
/new-project
```

PM запросит: название, концепт, платформу, дедлайн → создаст **Sprint 1**.

---

## ⚡ Слэш-команды (быстрая шпаргалка)

| Команда | Кто | Что делает |
|---------|-----|-----------|
| `/new-project` | PM | Инициализация проекта, сбор данных, Sprint 1 |
| `/sync` | PM | Ежедневная сводка: done / in-progress / blockers |
| `/done TASK-ID` | любой | Закрыть задачу, обновить brain |
| `/handoff` | любой | Сохранить контекст перед сменой модели |
| `/resume` | любой | Восстановить контекст из handoff |
| `/asset-request тип "описание"` | DEV/UIUX | Запросить ассет у ART |
| `/gdd-update` | GD | Обновить GDD + уведомить команду |

---

## 🔄 Пайплайн от идеи до прототипа

```
USER → PM: "Запускаем игру [концепт]"
  │
  ├─ PM: создаёт project_context.md + task_board.md (Sprint 0)
  │
  ├─ GD  → TASK-001: GDD v0.1 (Core Mechanic + Loop + Scope)     [День 1]
  ├─ ART → TASK-002: Арт-библия v0.1 (после GDD)                 [День 1-2]
  ├─ UIUX→ TASK-003: Список экранов + UI Asset List               [День 2]
  └─ DEV → TASK-004: Настройка Unity (структура + MCP)            [День 1]
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
