# GAMEDEVGD TEAM — AGENTS.md v1.0

**Проект:** GAMEDEVGD  
**Версия:** 1.0  
**Дата обновления:** 2026-03-03

---

## ⚠️ ЧИТАЕТСЯ ПЕРВЫМ ПРИ ЛЮБОМ ВХОДЕ АГЕНТА В ПРОЕКТ

---

## 🎯 Что это за проект

Мультиагентная команда разработки мобильных гиперказуальных игр на Unity.  
**6 агентов** в **6 отдельных Workspaces** Antigravity IDE работают в одном Unity-проекте,  
общаясь через файловую систему (`.gemini/antigravity/brain/`), без прямого вызова друг друга.

### Стек проекта

| Компонент | Версия |
|-----------|--------|
| **Unity** | 6 LTS (6000.3.9f1) + URP |
| **Платформы** | iOS + Android |
| **IDE** | Antigravity (VSCode + Agent Manager) |
| **MCP Server** | `com.gamelovers.mcp-unity@1.2.0` |
| **AI Агенты** | Qwen Code (DEV), Producer, PM, GD, UIUX, ART |

---

## 👥 Структура команды

| Workspace | Роль | Rule-файл | Точка входа |
|-----------|------|-----------|-------------|
| **PRODUCER-Workspace** | **Game Producer** | `.agent/rules/06_PRODUCER.md` | ← СТАРТ ДЛЯ НОВЫХ ПРОЕКТОВ |
| PM-Workspace | Project Manager | `.agent/rules/01_PM.md` | ← После Producer Brief |
| GD-Workspace | Game Designer | `.agent/rules/02_GD.md` | |
| DEV-Workspace | Unity Lead Dev | `.agent/rules/03_DEV.md` | |
| UIUX-Workspace | UI/UX Designer | `.agent/rules/04_UIUX.md` | |
| ART-Workspace | Art Director | `.agent/rules/05_ART.md` | |

---

## 🚀 Точка входа: PRODUCER

**Все новые проекты начинаются через PRODUCER-Workspace.**

Команда НЕ запускается без утверждённого **Producer Brief**.

### Алгоритм запуска нового проекта:

1. **Пользователь → PRODUCER:** `/concept [описание игры]`
2. **PRODUCER:** Анализ концепта, marketability, feasibility check
3. **PRODUCER:** Создание `docs/PRODUCER_BRIEF.md` + `docs/PROJECT_PIPELINE.md`
4. **PRODUCER → PM:** Передача брифа
5. **PM:** Создание задач в `task_board.md`, запуск Sprint 0

---

## 📋 Первые действия при входе в проект

1. **Определить свою роль** по активному Rule-файлу воркспейса
2. **Прочитать** `.gemini/antigravity/brain/project_context.md`
3. **Прочитать** `.gemini/antigravity/brain/task_board.md`
4. **Начать работу** согласно протоколам своей роли

---

## 🗺️ Иерархия и коммуникация

```
ПОЛЬЗОВАТЕЛЬ
    │
    ▼
PRODUCER ←──── единственная точка входа для новых проектов
    │           запрашивает отчёты у всех агентов
    │           проводит Milestone Reviews
    │
    ▼
   PM ←──────── получает Producer Brief + Pipeline
    │           управляет task_board, ежедневный sync
    │
    ├──► GD ────► GDD, механики, баланс
    ├──► DEV ───► Unity код, MCP, билды
    ├──► UIUX ──► UI спеки, UX flows
    └──► ART ───► Арт-библия, ассеты, VFX
```

---

## 📡 Коммуникационная шина

Все агенты общаются через **`.gemini/antigravity/brain/`**:

| Файл | Владелец | Описание |
|------|----------|----------|
| `project_context.md` | PM | Контекст проекта, статус, дедлайны |
| `task_board.md` | PM | Доска задач (TODO/IN_PROGRESS/DONE/BLOCKED) |
| `gdd_summary.md` | GD | Краткое GDD |
| `art_bible_summary.md` | ART | Арт-стиль кратко |
| `asset_registry.md` | ART/UIUX | Реестр всех ассетов |
| `decisions_log.md` | Все агенты | Лог решений (append-only) |

**Артефакты и планы:** `.agent/artifacts/`  
**Продюсерские документы:** `docs/`

---

## ⚡ Ключевые команды

| Команда | Кто использует | Что делает |
|---------|---------------|------------|
| `/concept [текст]` | Пользователь → PRODUCER | Старт нового проекта |
| `/report [AGENT]` | PRODUCER | Запрос отчёта у агента |
| `/milestone [N]` | PRODUCER | Контрольная точка |
| `/market [жанр]` | PRODUCER | Анализ рынка (Perplexity) |
| `/sync` | PM | Ежедневная сводка |
| `/done TASK-ID` | Все агенты | Задача выполнена |
| `/handoff` | Все агенты | Сохранение контекста |
| `/resume` | Все агенты | Восстановление контекста |
| `/asset-request [тип] [описание]` | Все агенты | Запрос ассета у ART |
| `/qwen-autonomous [TASK-ID]` | Qwen Code | Автономный режим DEV |

---

## 🆘 Экстренные контакты

| Ситуация | Действие |
|----------|----------|
| **Блокер** | Эскалировать к PM через `task_board.md` (статус BLOCKED) |
| **Конфликт архитектурный** | `decisions_log.md` + уведомление PM + PRODUCER |
| **Pivot концепта** | PRODUCER принимает решение |
| **Критический баг в прототипе** | DEV → PM → PRODUCER (если влияет на сроки) |

---

## 🔧 MCP Unity интеграция

**Статус:** ✅ ПОДКЛЮЧЁН (порт 8090)

**Конфиг для Antigravity Settings:**

```json
{
  "command": "node",
  "args": ["d:/ASTRA/My project/Library/PackageCache/com.gamelovers.mcp-unity@e4b7e74ad052/Server~/build/index.js"]
}
```

**Важно:** Unity Editor должен быть открыт для работы MCP сервера.

### Доступные MCP инструменты

- `get_scene_info` — информация о сцене
- `get_scenes_hierarchy` — иерархия объектов
- `get_gameobject` — детали GameObject
- `get_console_logs` — логи Unity Console
- `update_gameobject` — создать/обновить объект
- `update_component` — добавить/настроить компонент
- `execute_menu_item` — выполнить команду меню
- `load_scene` / `save_scene` / `create_scene` — управление сценами

---

## 📚 Дополнительные ресурсы

| Файл | Описание |
|------|----------|
| [README.md](README.md) | Основная документация проекта |
| [docs/WIKI.md](docs/WIKI.md) | Полное руководство команды |
| [docs/TEAM_PIPELINE.md](docs/TEAM_PIPELINE.md) | Визуализация пайплайна |
| [.qwen/QWEN.md](.qwen/QWEN.md) | Контракт поведения Qwen Code |

---

## 📊 Текущий статус проекта

| Параметр | Значение |
|----------|----------|
| **Проект** | GAMEDEVGD v1.0 |
| **Статус** | ✅ ГОТОВ К РАБОТЕ |
| **MCP Unity** | ✅ ПОДКЛЮЧЁН |
| **Следующий шаг** | Запустить `/concept` в PRODUCER-Workspace |

---

**GAMEDEVGD Team © 2026**
