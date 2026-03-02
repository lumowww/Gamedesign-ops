# GAMEDEVGD — Version History

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

https://github.com/lumowww/Gamedesign-ops.git

---

**GAMEDEVGD Team © 2026**
