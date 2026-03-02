# GAMEDEVGD v1.0 — Multi-Agent Unity Game Development Team

**Версия:** 1.0  
**Дата релиза:** 2026-03-03  
**Репозиторий:** https://github.com/lumowww/Gamedesign-ops.git

---

## 🎯 О проекте

**GAMEDEVGD** — это мультиагентная система разработки мобильных гиперказуальных игр на Unity.  
6 AI-агентов работают в отдельных Workspaces через Antigravity IDE, общаясь через единую коммуникационную шину.

### Стек технологий

| Компонент | Версия / Описание |
|-----------|-------------------|
| **Unity** | 6 LTS (6000.3.9f1) |
| **Render Pipeline** | URP (Universal Render Pipeline) |
| **Платформы** | iOS + Android |
| **IDE** | Antigravity (VSCode + Agent Manager) |
| **MCP Server** | Unity MCP (`com.gamelovers.mcp-unity@1.2.0`) |
| **AI Агенты** | Qwen Code (DEV), Producer, PM, GD, UIUX, ART |

---

## 👥 Команда агентов

| Workspace | Роль | Rule-файл | Описание |
|-----------|------|-----------|----------|
| **PRODUCER** | Game Producer | `.agent/rules/06_PRODUCER.md` | Точка входа, анализ рынка, концепты |
| **PM** | Project Manager | `.agent/rules/01_PM.md` | Владелец задач, синхронизация команды |
| **GD** | Game Designer | `.agent/rules/02_GD.md` | GDD, механики, баланс |
| **DEV** | Unity Lead Dev | `.agent/rules/03_DEV.md` | Код, MCP, билды (Qwen Code) |
| **UIUX** | UI/UX Designer | `.agent/rules/04_UIUX.md` | UI спеки, UX flows |
| **ART** | Art Director | `.agent/rules/05_ART.md` | Арт-библия, ассеты |

---

## 🚀 Быстрый старт

### Предварительные требования

1. **Unity 6 LTS** (6000.3.9f1 или новее)
2. **Node.js 18+** (для MCP сервера)
3. **Antigravity IDE** (VSCode с Agent Manager)
4. **Git**

### Установка

```bash
# 1. Клонировать репозиторий
git clone https://github.com/lumowww/Gamedesign-ops.git
cd Gamedesign-ops

# 2. Открыть проект в Unity Editor
# Unity автоматически импортирует пакеты

# 3. Проверить MCP Unity пакет
# Tools → MCP Unity → Server Window

# 4. Настроить Antigravity MCP Settings
# См. .gemini/antigravity/mcp_config.json
```

### Настройка MCP

**Файл:** `.gemini/antigravity/mcp_config.json`

```json
{
  "mcpServers": {
    "unity-mcp-coplay": {
      "command": "node",
      "args": [
        "Library/PackageCache/com.gamelovers.mcp-unity@e4b7e74ad052/Server~/build/index.js"
      ],
      "env": {
        "UNITY_PROJECT_PATH": "<path-to-project>",
        "MCP_SERVER_PORT": "8090",
        "MCP_AUTO_START": "true",
        "MCP_ALLOW_REMOTE": "true"
      },
      "enabled": true
    }
  }
}
```

**Важно:** Unity Editor должен быть открыт для работы MCP сервера (порт 8090).

---

## 📁 Структура проекта

```
GAMEDEVGD/
├── AGENTS.md                     ← Правила для всех агентов
├── README.md                     ← Этот файл
├── CREDITS.md                    ← Attribution ассетов
│
├── .agent/                       ← Конфигурация агентов
│   ├── rules/                    # Rule-файлы ролей (00-06)
│   ├── workflows/                # Workflow-протоколы
│   └── skills/                   # Навыки агентов
│
├── .gemini/antigravity/brain/    ← Коммуникационная шина
│   ├── project_context.md        # Контекст проекта (PM)
│   ├── task_board.md             # Доска задач (PM)
│   ├── gdd_summary.md            # GDD сводка (GD)
│   ├── art_bible_summary.md      # Арт-библия (ART)
│   ├── asset_registry.md         # Реестр ассетов (ART/UIUX)
│   └── decisions_log.md          # Лог решений (все)
│
├── .qwen/                        ← Qwen Code (DEV агент)
│   ├── QWEN.md                   # Контракт поведения
│   ├── mcp-client.js             # MCP клиент для Unity
│   ├── skills/                   # Навыки Qwen
│   └── tasks/                    # Задачи Qwen
│
├── Assets/
│   ├── _Project/                 # Основной код проекта
│   │   ├── Scripts/
│   │   ├── Prefabs/
│   │   ├── Scenes/
│   │   └── ...
│   └── _ThirdParty/              # Сторонние ассеты
│
├── docs/                         ← Документация
│   ├── PRODUCER_BRIEF.md         # Бриф продюсера
│   ├── PROJECT_PIPELINE.md       # Пайплайн проекта
│   ├── GDD/                      # GDD документы
│   ├── ArtBible/                 # Арт-библия
│   └── UISpec/                   # UI спецификации
│
└── ProjectSettings/
    └── McpUnitySettings.json     # Настройки MCP Unity
```

---

## ⚡ Слэш-команды

| Команда | Кто | Описание |
|---------|-----|----------|
| `/concept [текст]` | Пользователь → PRODUCER | Запуск нового концепта |
| `/new-project` | PM | Инициализация проекта |
| `/sync` | PM | Ежедневная синхронизация |
| `/done TASK-ID` | Все агенты | Завершение задачи |
| `/report [AGENT]` | PRODUCER | Запрос отчёта у агента |
| `/handoff` | Все агенты | Передача контекста |
| `/resume` | Все агенты | Восстановление контекста |
| `/asset-request [тип] [описание]` | Все агенты | Запрос ассета |
| `/qwen-autonomous [TASK-ID]` | Qwen Code | Автономный режим |

---

## 🔧 MCP Unity инструменты

### Tools (вызов через MCP)

- `get_scene_info` — информация о текущей сцене
- `get_scenes_hierarchy` — иерархия объектов сцены
- `get_gameobject` — детали GameObject по ID
- `get_console_logs` — логи Unity Console
- `select_gameobject` — выбрать объект в сцене
- `update_gameobject` — создать/обновить GameObject
- `update_component` — добавить/настроить компонент
- `execute_menu_item` — выполнить команду меню Unity
- `load_scene` / `save_scene` / `create_scene` — управление сценами
- `add_package` — установить Unity пакет
- `run_tests` — запустить Unity Test Runner

### Resources (чтение через MCP)

- `unity://scenes-hierarchy` — иерархия сцены
- `unity://gameobject/{id}` — детали объекта
- `unity://logs` — консоль логи
- `unity://packages` — установленные пакеты
- `unity://assets` — поиск ассетов
- `unity://menu-items` — доступные меню
- `unity://tests/{testMode}` — тесты (EditMode/PlayMode)

---

## 🔄 Пайплайн разработки

```
┌─────────────────────────────────────────────────────────────┐
│                    ANTIGRAVITY AGENT MANAGER                │
├──────────┬──────────┬──────────┬──────────┬──────────┬─────┤
│ PRODUCER │    PM    │    GD    │   DEV    │  UI/UX   │ ART │
└────┬─────┴────┬─────┴────┬─────┴────┬─────┴────┬─────┴────┘
     │          │          │          │          │
     │    ┌─────▼──────────▼──────────▼──────────▼───────────┐
     │    │         .gemini/antigravity/brain/                │
     │    │  project_context.md, task_board.md, ...          │
     │    └───────────────────────────────────────────────────┘
     │
     │    ┌───────────────────────────────────────────────────┐
     └───►│                    docs/                          │
          │  PRODUCER_BRIEF.md, PROJECT_PIPELINE.md, ...     │
          └───────────────────────────────────────────────────┘
```

### Фазы проекта

1. **Фаза 0: Концепция (PRODUCER)** — анализ, marketability, бриф
2. **Фаза 1: Sprint 0 (PM)** — инициализация, GDD, арт-библия
3. **Фаза 2: Спринты 1-3 (DEV/GD/ART/UIUX)** — разработка
4. **Фаза 3: Прототип** — GO/NO-GO для CPI теста

---

## 📊 Текущий статус

| Параметр | Значение |
|----------|----------|
| **Версия проекта** | 1.0 |
| **Статус** | ✅ Инициализирован |
| **MCP Unity** | ✅ Подключён (порт 8090) |
| **Qwen Code** | ✅ Интегрирован (DEV роль) |
| **Сцена по умолчанию** | `Assets/Scenes/SampleScene.unity` |

---

## 🆘 Типичные проблемы

| Проблема | Решение |
|----------|---------|
| `Connection refused :8090` | Откройте Unity Editor |
| MCP tools не отвечают | Проверьте конфиг в Antigravity → Settings → MCP Servers |
| Compile errors в Unity | `get_console_logs` → исправить → `refresh_asset_database` |
| Потерян контекст | Используйте `/resume` для восстановления |

---

## 📚 Документация

- [AGENTS.md](AGENTS.md) — правила для всех агентов
- [TEAM_PIPELINE.md](docs/TEAM_PIPELINE.md) — визуализация пайплайна
- [WIKI.md](docs/WIKI.md) — полное руководство команды
- [QWEN.md](.qwen/QWEN.md) — контракт поведения Qwen Code

---

## 📄 Лицензия

MIT License — см. [LICENSE](LICENSE) (если применимо)

---

## 👤 Контакты

**Владелец репозитория:** https://github.com/lumowww  
**Проект:** Gamedesign-ops  
**Версия:** 1.0 (2026-03-03)
