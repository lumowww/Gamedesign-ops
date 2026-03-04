# GAMEDEVGD — Version History

## v1.1.0 (2026-03-04)

**Core Systems & Infrastructure Fixes**

### ✨ Что нового

- ✅ Создана структура `Assets/_Project/Scripts/Core/`
- ✅ Реализованы базовые Core скрипты: `EventBus.cs`, `GameManager.cs`, `ObjectPool.cs`
- ✅ Установлен пакет `CoreScripts.asmdef` для контроля зависимостей

### 🔧 Исправления (Hotfixes)

- 🐛 **CRITICAL**: `decisions_log.md` пересоздан в чистом UTF-8 (восстановлены все записи, устранены null-байты и двойная перекодировка).
- 🐛 Исправлен баг `EventBus.Unsubscribe()`: внедрена Subscription model для корректного удаления обработчиков (решена проблема сравнения лямбд).
- 🐛 Изменён scope `GameState`: enum вынесен на уровень namespace для более удобного доступа.
- 🐛 Исправлен анти-паттерн производительности: `FindObjectOfType` в EventBus заменён на `FindAnyObjectByType` (Unity 6).
- 🐛 Удалено исключение `Assets/_Project/Tests/` из `.gitignore` для корректного трекинга Unity C# тестов.

---

## v2.0.0 (2026-03-04)

**Обновление инфраструктуры мультиагентной системы**

### ✨ Что нового

#### Инфраструктура

- ✅ 7 Rule-файлов агентов (00_global + 01-06) — обновлены до v2.0
- ✅ **14 Workflow-файлов** (concept, new-project, sync, done, handoff, resume, asset-request, gdd-update, qwen-autonomous, feature-spec, balance-review, design-review, liveops-plan, concept-gd)
- ✅ **13 Skill-файлов** (unity-mcp, concept-intake, market-pulse, pipeline-generator, gdd-template, art-bible, asset-store, hypercasual-patterns, design-heuristics, loops-and-arcs, mobile-design-checklist, agent-tz-template, doc-extractor)
- ✅ 6 Brain-файлов коммуникационной шины

#### GD-Workspace добавлен

- ✅ 5 workflow для GD: `/feature-spec`, `/balance-review`, `/design-review`, `/liveops-plan`, `/concept-gd`
- ✅ 4 skill: `design-heuristics`, `loops-and-arcs`, `mobile-design-checklist`, `agent-tz-template`
- ✅ Расширенный `gdd_summary.md` template
- ✅ GD Gate — обязательный design review для DESIGN задач

#### A2A коммуникация

- ✅ Стандартизированные артефакты для Agent-to-Agent коммуникации
- ✅ RBAC модель прав доступа к файлам

#### MCP Unity интеграция

- ✅ Пакет `com.gamelovers.mcp-unity@1.2.0` установлен и настроен
- ✅ Порт 8090, AutoStartServer=true, **AllowRemoteConnections=false**
- ✅ MCP клиент для Qwen Code (`.qwen/mcp-client.js`)
- ✅ Проверенные инструменты: `get_scene_info`, `get_scenes_hierarchy`, `get_console_logs`

#### Qwen Code интеграция

- ✅ TASK-QWEN-SETUP-001 завершена
- ✅ Qwen Code определён как DEV агент
- ✅ MCP клиент для прямого вызова Unity инструментов

#### Документация

- ✅ README.md — основная документация проекта
- ✅ AGENTS.md v2.0 — правила команды с PRODUCER как точкой входа
- ✅ docs/WIKI.md v2.0 — полное руководство команды
- ✅ docs/TEAM_PIPELINE.md — визуализация пайплайна
- ✅ .qwen/QWEN.md — контракт поведения Qwen Code
- ✅ .qwen/MCP_CLIENT.md — документация MCP клиента

#### Unity проект

- ✅ Unity 6 LTS (6000.3.9f1)
- ✅ URP настроен
- ✅ Структура `Assets/_Project/` создана (Scripts/Core, Gameplay, UI, Data, Prefabs, Scenes, Art, Audio, UI)
- ✅ MCP Unity Server работает на порту 8090

#### Тесты

- ✅ Python тесты в `.agent/tests/` (brain, rules, workflows)
- ✅ Unity C# тесты в `Assets/_Project/Tests/` (EventBus, GameManager)
- ✅ `run-tests.ps1` — единая точка запуска

### 🔧 Исправления

- ✅ `decisions_log.md` — пересоздан в чистом UTF-8 (полная перезапись, восстановлены все записи)
- ✅ Удалены мусорные директории (`-Force/`, `.pytest_cache/`)
- ✅ `Tests.asmdef` обновлён до формата Unity Test Framework v1.6+
- ✅ `.gitignore` обновлён для Python тестов

### 📊 Статус

| Компонент | Статус |
|-----------|--------|
| Инфраструктура | ✅ Готово |
| MCP Unity | ✅ Подключён |
| Qwen Code | ✅ Интегрирован |
| GD-Workspace | ✅ Развёрнут |
| Документация | ✅ Полная |
| Команда агентов | ✅ Готова к работе |

---

## v1.0.0 (2026-03-03)

**Первый релиз GAMEDEVGD** — мультиагентной системы разработки игр на Unity.

### ✨ Что нового

#### Инфраструктура

- ✅ 6 Rule-файлов агентов (00_global + 01-06)
- ✅ 7 Workflow-файлов (concept, new-project, sync, handoff, resume, task-done, asset-request, gdd-update, qwen-autonomous)
- ✅ 7 Skill-файлов агентов (unity-mcp, concept-intake, market-pulse, pipeline-generator, gdd-template, art-bible, asset-store, hypercasual-patterns)
- ✅ 6 Brain-файлов коммуникационной шины

#### MCP Unity интеграция

- ✅ Пакет `com.gamelovers.mcp-unity@1.2.0` установлен и настроен
- ✅ Порт 8090, AutoStartServer=true, AllowRemoteConnections=true
- ✅ MCP клиент для Qwen Code (`.qwen/mcp-client.js`)
- ✅ Проверенные инструменты: `get_scene_info`, `get_scenes_hierarchy`, `get_console_logs`

#### Qwen Code интеграция

- ✅ TASK-QWEN-SETUP-001 завершена
- ✅ Qwen Code определён как DEV агент
- ✅ MCP клиент для прямого вызова Unity инструментов

#### Документация

- ✅ README.md — основная документация проекта
- ✅ AGENTS.md — правила для всех агентов
- ✅ docs/WIKI.md — полное руководство команды
- ✅ docs/TEAM_PIPELINE.md — визуализация пайплайна
- ✅ .qwen/QWEN.md — контракт поведения Qwen Code
- ✅ .qwen/MCP_CLIENT.md — документация MCP клиента

#### Unity проект

- ✅ Unity 6 LTS (6000.3.9f1)
- ✅ URP настроен
- ✅ Сцены: `Assets/Main.unity`, `Assets/Scenes/SampleScene.unity`
- ✅ MCP Unity Server работает на порту 8090

### 📁 Структура проекта

```
GAMEDEVGD/
├── AGENTS.md                     ← Правила для всех агентов
├── README.md                     ← Основная документация
├── CREDITS.md                    ← Attribution ассетов
│
├── .agent/                       ← Конфигурация агентов
│   ├── rules/                    # Rule-файлы ролей (00-06)
│   ├── workflows/                # Workflow-протоколы
│   └── skills/                   # Навыки агентов
│
├── .gemini/antigravity/brain/    ← Коммуникационная шина
│   ├── project_context.md        # Контекст проекта
│   ├── task_board.md             # Доска задач
│   ├── gdd_summary.md            # GDD сводка
│   ├── art_bible_summary.md      # Арт-библия
│   ├── asset_registry.md         # Реестр ассетов
│   └── decisions_log.md          # Лог решений
│
├── .qwen/                        ← Qwen Code (DEV агент)
│   ├── QWEN.md                   # Контракт поведения
│   ├── MCP_CLIENT.md             # Документация MCP клиента
│   └── mcp-client.js             # MCP клиент для Unity
│
├── Assets/
│   ├── _Project/                 # Основной код проекта
│   └── _ThirdParty/              # Сторонние ассеты
│
├── docs/                         ← Документация
│   ├── TEAM_PIPELINE.md          # Пайплайн команды
│   ├── WIKI.md                   # Руководство
│   ├── GDD/                      # GDD документы
│   ├── ArtBible/                 # Арт-библия
│   └── UISpec/                   # UI спецификации
│
└── ProjectSettings/
    └── McpUnitySettings.json     # Настройки MCP Unity
```

### 🚀 Быстрый старт

1. **Открыть проект в Unity Editor**
2. **Настроить Antigravity MCP Settings** (см. `.gemini/antigravity/mcp_config.json`)
3. **Запустить `/concept` в PRODUCER-Workspace** для старта нового проекта

### 📊 Статус

| Компонент | Статус |
|-----------|--------|
| Инфраструктура | ✅ Готово |
| MCP Unity | ✅ Подключён |
| Qwen Code | ✅ Интегрирован |
| Документация | ✅ Полная |
| Команда агентов | ✅ Готова к работе |

### 🔗 Репозиторий

<https://github.com/lumowww/Gamedesign-ops.git>

---

**GAMEDEVGD Team © 2026**
