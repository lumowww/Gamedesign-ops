# PROJECT CONTEXT
# Файл: .gemini/antigravity/brain/project_context.md
# ВЛАДЕЛЕЦ: PM — обновляет после каждого изменения

## Проект: [PROJECT_NAME]

**Дата старта:** [ДАТА]
**Дедлайн прототипа:** [ДАТА]
**Текущий Sprint:** Sprint [N]
**Статус:** 🔴 НЕ НАЧАТ | 🟡 В ПРОЦЕССЕ | 🟢 ПРОТОТИП ГОТОВ

---

## Концепт
[Одно предложение описывающее игру]

## Платформа
iOS + Android | Target: Unity 6 LTS + URP

## Команда (воркспейсы Antigravity)
- PM Workspace: Project Management
- GD Workspace: Game Design
- DEV Workspace: Unity Development
- UIUX Workspace: UI/UX Design
- ART Workspace: Art Direction

## Ключевые документы
- GDD: `docs/GDD/GDD_[Name]_v[N].md`
- Арт-библия: `docs/ArtBible/ArtBible_[Name]_v[N].md`
- UI Specs: `docs/UISpec/`
- Asset Lists: `docs/AssetLists/`

## MCP Сервер Unity
- Статус: ✅ Запущен / ❌ Остановлен
- Порт: 8090 (WebSocket)
- Путь: `[PATH]/mcp-unity/Server~/build/index.js`

---
---

# TASK BOARD
# Файл: .gemini/antigravity/brain/task_board.md
# ВЛАДЕЛЕЦ: PM — единственный кто создаёт/архивирует задачи

## Sprint [N] — [Дата начала] → [Дата конца]

### 🔴 BLOCKED
*(нет)*

### 🔄 IN PROGRESS

### 📋 TODO

### ✅ DONE

---

## Backlog (следующий sprint)

---
---

# GDD SUMMARY
# Файл: .gemini/antigravity/brain/gdd_summary.md
# ВЛАДЕЛЕЦ: GD — обновляет после каждой версии GDD

## [PROJECT_NAME] — GDD Summary v[N]
*Последнее обновление: [дата]*

### Core Mechanic
[Один глагол/действие игрока]

### Core Loop
[Action] → [Reward] → [Progress] → [Action]

### Prototype Scope (что в первом прототипе)
- [ ] [Механика 1]
- [ ] [Механика 2]
- [ ] Базовый Game Loop (Start/Play/End)
- [ ] [N] тестовых уровней

### Для DEV (технические требования прототипа)
- [Список систем нужных DEV]

### Для ART (арт требования прототипа)
- [Список ассетов нужных ART]

### Для UIUX (экраны прототипа)
- [ ] Main Menu
- [ ] Gameplay HUD
- [ ] Level Complete
- [ ] Level Failed

---
---

# ART BIBLE SUMMARY
# Файл: .gemini/antigravity/brain/art_bible_summary.md
# ВЛАДЕЛЕЦ: ART — обновляет после каждой версии арт-библии

## [PROJECT_NAME] — Art Bible Summary v[N]
*Последнее обновление: [дата]*

### Стиль
[Ключевое слово + 2-3 предложения описания]

### Цветовая палитра
| Роль | Hex | Использование |
|------|-----|---------------|
| Primary | #FFFFFF | Главные объекты |
| Secondary | #FFFFFF | Акценты |
| Background | #FFFFFF | Фоны |
| UI | #FFFFFF | Интерфейс |

### Референсы (стиль)
- [Игра 1] — чем вдохновляемся
- [Игра 2]

### Asset Source Priority
1. Unity Asset Store
2. Kenney.nl
3. Itch.io

---
---

# ASSET REGISTRY
# Файл: .gemini/antigravity/brain/asset_registry.md
# ВЛАДЕЛЬЦЫ: ART (арт ассеты) + UIUX (UI ассеты)

## [PROJECT_NAME] — Asset Registry
*Последнее обновление: [дата]*

| ID | Название | Категория | Источник | Лицензия | Статус | Путь в проекте |
|----|----------|-----------|---------|---------|--------|----------------|
| ART-001 | | | | | | |
| UI-001 | | | | | | |
| AUD-001 | | | | | | |

---
---

# DECISIONS LOG
# Файл: .gemini/antigravity/brain/decisions_log.md
# ВЛАДЕЛЬЦЫ: Все агенты пишут сюда

## [PROJECT_NAME] — Decisions Log

---

## [ДАТА] — PROJECT INITIALIZED
**Агент:** PM
**Решение:** Старт проекта [Name]
**Причина:** [причина]

---
