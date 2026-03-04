# TASK BOARD v2.0

**Владелец:** PM (только PM создаёт и архивирует задачи)
**Формат:** v2.0 (с GDD anchor и A2A артефактами)
**Последнее обновление:** 2026-03-04

---

## 📊 Спринт 0 — Инициализация Инфраструктуры

**Цель:** Подготовить проект к работе мультиагентной команды
**Статус:** ✅ ЗАВЕРШЁН
**GDD Anchor:** N/A (инфраструктурный спринт)

### ✅ DONE

| ID | Задача | Агент | Критерии готовности |
|----|--------|-------|---------------------|
| TASK-001 | Исправить decisions_log.md (null-байты, UCS-2 → UTF-8) | DEV | ✅ Файл в UTF-8 без BOM, тест проходит |
| TASK-002 | Очистить мусорные директории (-Force, .pytest_cache, mnt) | DEV | ✅ Директории удалены, .gitignore обновлён |
| TASK-003 | Создать структуру Assets/_Project/ | DEV | ✅ Scripts/Core, Gameplay, UI, Data, Prefabs, Scenes, Art, Audio, UI |
| TASK-004 | Обновить документацию до v2.0 | DEV | ✅ WIKI.md, VERSION_HISTORY.md, project_context.md, AGENTS.md |
| TASK-005 | Исправить hardcoded пути в Python тестах | DEV | ✅ PROJECT_ROOT через Path(__file__) |
| TASK-006 | Обновить Tests.asmdef до формата UTF v1.6+ | DEV | ✅ overrideReferences: true, defineConstraints |
| TASK-007 | Добавить тесты: null-байты, UTF-8, placeholders | DEV | ✅ Тесты в brain_schema_tests.py |
| TASK-008 | Обновить .gitignore для Python тестов | DEV | ✅ .agent/tests/**/*.meta, __pycache__/ |
| TASK-009 | Заполнить gdd_summary.md (убрать placeholders) | GD | ✅ [PROJECT_NAME] заменён на GAMEDEVGD |
| TASK-010 | Обновить task_board.md (формат v2.0 с GDD anchor) | PM | ✅ Таблица задач, GDD Anchor поле |

---

## 📊 Спринт 1 — Ожидание концепта

**Цель:** Получить концепт от PRODUCER и создать GDD v0.1
**Статус:** ⏳ ОЖИДАНИЕ (/concept от PRODUCER)
**GDD Anchor:** GDD-v0.1 (в работе)

### 📋 TODO

| ID | Задача | Агент | Зависит от | GDD Anchor | Приоритет |
|----|--------|-------|------------|------------|-----------|
| TASK-011 | Получить Producer Brief от PRODUCER | PM | — | N/A | P0 |
| TASK-012 | Создать GDD v0.1 (Core Loop, механики) | GD | TASK-011 | GDD-v0.1 | P0 |
| TASK-013 | Создать Арт-библию v0.1 | ART | TASK-012 | ART-BIBLE-v0.1 | P1 |
| TASK-014 | Создать UI Asset List | UIUX | TASK-012 | UI-LIST-v0.1 | P1 |
| TASK-015 | Настроить MCP Unity для разработки | DEV | TASK-012 | N/A | P0 |

### 🔄 IN PROGRESS

*(пусто — ожидание /concept от PRODUCER)*

### ✅ DONE

*(см. Спринт 0)*

### 🔴 BLOCKED

*(пусто)*

---

## 📋 Архив спринтов

### Спринт -1 — Начальная инициализация проекта

**Статус:** ✅ АРХИВ
**GDD Anchor:** N/A

| ID | Задача | Агент | Статус |
|----|--------|-------|--------|
| TASK-INIT-001 | Инициализация проекта | PM | ✅ DONE |

---

## 📝 Примечания

**GD Gate:** Все DESIGN задачи требуют `/design-review [TASK-ID]` перед закрытием

**A2A Артефакты:**
- `.agent/artifacts/GD_to_DEV_[TASK-ID].md` — ТЗ для DEV
- `.agent/artifacts/GD_to_ART_[TASK-ID].md` — ТЗ для ART
- `.agent/artifacts/GD_to_UIUX_[TASK-ID].md` — ТЗ для UIUX

**Следующее ревью спринта:** После получения /concept от PRODUCER
