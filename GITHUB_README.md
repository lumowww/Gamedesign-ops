# 🎮 GAMEDEVGD v1.0

**Multi-Agent Unity Game Development Team**

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/lumowww/Gamedesign-ops/releases)
[![Unity](https://img.shields.io/badge/Unity-6%20LTS-black?logo=unity)](https://unity.com/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## 📋 О проекте

**GAMEDEVGD** — мультиагентная система разработки мобильных гиперказуальных игр на Unity.

**6 AI-агентов** работают вместе в отдельных Workspaces через Antigravity IDE:
- 🎯 **PRODUCER** — Game Producer, анализ рынка, концепты
- 📋 **PM** — Project Manager, владелец задач
- 🎮 **GD** — Game Designer, GDD, механики, баланс
- 💻 **DEV** — Unity Lead Dev, код, MCP, билды
- 🎨 **UIUX** — UI/UX Designer, интерфейсы
- 🖼️ **ART** — Art Director, ассеты, визуал

---

## ✨ Последнее обновление (v1.0 — 2026-03-03)

### GD-Workspace добавлен!

**Новые возможности:**
- ✅ 5 workflow для GD: `/feature-spec`, `/balance-review`, `/design-review`, `/liveops-plan`, `/concept-gd`
- ✅ 4 skill: `design-heuristics`, `loops-and-arcs`, `mobile-design-checklist`, `agent-tz-template`
- ✅ Расширенный `gdd_summary.md` template
- ✅ PowerShell deploy скрипт

### MCP Unity интеграция

- ✅ MCP клиент для Qwen Code (`.qwen/mcp-client.js`)
- ✅ Проверенные инструменты: `get_scene_info`, `get_scenes_hierarchy`, `get_console_logs`
- ✅ Порт 8090, AutoStartServer=true

---

## 🚀 Быстрый старт

```bash
# 1. Клонировать
git clone https://github.com/lumowww/Gamedesign-ops.git
cd Gamedesign-ops

# 2. Открыть в Unity Editor 6 LTS

# 3. Настроить Antigravity MCP Settings
# См. .gemini/antigravity/mcp_config.json

# 4. Запустить /concept в PRODUCER-Workspace
```

---

## 📁 Структура проекта

```
GAMEDEVGD/
├── AGENTS.md                     ← Правила для всех агентов
├── README.md                     ← Этот файл
├── VERSION_HISTORY.md            ← История версий
│
├── .agent/                       ← Конфигурация агентов
│   ├── rules/                    # Rule-файлы (00-06)
│   ├── workflows/                # Workflow-протоколы
│   └── skills/                   # Навыки агентов
│
├── .gemini/antigravity/brain/    ← Коммуникационная шина
│   ├── project_context.md        # Контекст проекта
│   ├── task_board.md             # Доска задач
│   ├── gdd_summary.md            # GDD сводка
│   └── decisions_log.md          # Лог решений
│
├── .qwen/                        ← Qwen Code (DEV агент)
│   ├── QWEN.md                   # Контракт поведения
│   └── mcp-client.js             # MCP клиент для Unity
│
├── Assets/                       ← Unity ассеты
└── docs/                         ← Документация
    ├── GDD/                      # GDD документы
    ├── ArtBible/                 # Арт-библия
    └── UISpec/                   # UI спецификации
```

---

## ⚡ Слэш-команды

| Команда | Кто | Описание |
|---------|-----|----------|
| `/concept [текст]` | PRODUCER | Старт нового концепта |
| `/new-project` | PM | Инициализация проекта |
| `/feature-spec [название]` | GD | Написать feature spec |
| `/balance-review` | GD | Аудит экономики |
| `/design-review [TASK-ID]` | GD | Ревью реализации |
| `/liveops-plan [тип]` | GD | Спроектировать LiveOps |
| `/sync` | PM | Ежедневная сводка |
| `/done TASK-ID` | Все | Задача выполнена |

---

## 🔧 MCP Unity инструменты

- `get_scene_info` — информация о сцене
- `get_scenes_hierarchy` — иерархия объектов
- `get_gameobject` — детали GameObject
- `get_console_logs` — логи Unity Console
- `update_gameobject` — создать/обновить объект
- `update_component` — добавить/настроить компонент
- `execute_menu_item` — выполнить команду меню

---

## 📊 Статус проекта

| Параметр | Значение |
|----------|----------|
| **Версия** | 1.0.0 |
| **Статус** | ✅ ГОТОВ К РАБОТЕ |
| **MCP Unity** | ✅ ПОДКЛЮЧЁН (порт 8090) |
| **GD-Workspace** | ✅ РАЗВЁРНУТ |
| **Следующий шаг** | Запустить `/concept` в PRODUCER |

---

## 📚 Документация

- [README.md](README.md) — основная документация
- [AGENTS.md](AGENTS.md) — правила команды
- [VERSION_HISTORY.md](VERSION_HISTORY.md) — история версий
- [docs/WIKI.md](docs/WIKI.md) — полное руководство
- [.qwen/MCP_CLIENT.md](.qwen/MCP_CLIENT.md) — MCP клиент

---

## 🔗 Ссылки

- **Репозиторий:** https://github.com/lumowww/Gamedesign-ops
- **Unity:** https://unity.com/
- **MCP Unity:** https://github.com/CoderGamester/mcp-unity
- **Antigravity:** https://antigravity.dev/

---

**GAMEDEVGD Team © 2026 | MIT License**
