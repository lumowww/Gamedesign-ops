# WORKFLOW: /new-project
# Версия: 2.0 | Обновлено: 2026-03-03
# Триггер: /new-project
# Агент-инициатор: PM

---

## ⚠️ ИЗМЕНЕНИЕ v2: ПОРЯДОК СТАРТА АГЕНТОВ

```
v1 (старый):  PM → GD + ART + UIUX + DEV (все параллельно с Day 1)
v2 (новый):   PM → GD → [GDD v0.1 готов] → ART + UIUX → DEV
```

**Почему:** ART и UIUX не могут начать без GDD — они не знают стиль, screen graph,
core loop. DEV не знает какие системы нужны. Только GD знает всё это.

---

## ФАЗА 1 — Сбор информации (PM)

Убедиться что получен `docs/PRODUCER_BRIEF.md` от PRODUCER.
Если нет → запросить: «Нужен PRODUCER_BRIEF.md перед стартом.»

Дополнительно запросить у пользователя (если не в брифе):
- Название проекта
- Дедлайн прототипа

---

## ФАЗА 2 — Инициализация PM

Создать `.gemini/antigravity/brain/project_context.md`:
```markdown
# PROJECT: [Name]
Дата старта: [дата]
Дедлайн прототипа: [дата]
Концепт: [из PRODUCER_BRIEF.md]
Платформа: [из PRODUCER_BRIEF.md]
Текущий Sprint: Sprint 0
Статус: 🟡 ИНИЦИАЛИЗАЦИЯ
```

Создать начальный `task_board.md` с одной задачей:
```
TASK-GD-001: GDD v0.1
Status: TODO | Priority: P0 | Sprint: 0
```

---

## ФАЗА 3 — ТОЛЬКО GD СТАРТУЕТ ПЕРВЫМ

```
TASK-GD-001 → GD: GDD v0.1 (Concept + Core Mechanic + Prototype Scope)
ETA: День 1

Входные данные для GD:
  - docs/PRODUCER_BRIEF.md
  - .agent/artifacts/PRODUCER_to_GD_[PROJECT].md (обязательные поля)
```

**PM ждёт** пока GD не создаст `gdd_summary.md` и не сообщит о готовности.

---

## ФАЗА 4 — После GDD v0.1 (PM читает gdd_summary.md)

PM читает `brain/gdd_summary.md` и создаёт задачи из секций:

```
Из «For ART»:
  TASK-ART-001: Арт-библия v0.1
  ETA: День 1-2 | P0 | GDD anchor: [ID:ART_BIBLE]

Из «For UIUX»:
  TASK-UIUX-001: Список экранов + UI структура Figma
  ETA: День 2 | P0 | GDD anchor: [ID:SCREEN_GRAPH]

Из «For DEV» (только setup, не механики):
  TASK-DEV-001: Настройка Unity проекта (структура + пакеты + MCP)
  ETA: День 1 | P0 | NON-DESIGN (нет GD Gate)
```

**Механики DEV начинает только после GDD v0.1** — не до.

---

## ФАЗА 5 — Первый /sync (День 2-3)

После выполнения TASK-ART-001, TASK-UIUX-001, TASK-DEV-001:
1. Провести `/sync`
2. GD создаёт A2A артефакты на основе готового GDD:
   - `GD_to_DEV_Sprint1.md` — системы для реализации
   - `GD_to_ART_Sprint1.md` — приоритеты ассетов
   - `GD_to_UIUX_Sprint1.md` — Screen Flow
3. PM создаёт Sprint 1 задачи из A2A артефактов

---

## Чеклист готовности к Sprint 1

- [ ] `docs/PRODUCER_BRIEF.md` получен
- [ ] `brain/project_context.md` создан
- [ ] `brain/gdd_summary.md` заполнен GD (не шаблон)
- [ ] `docs/GDD/GDD_[Name]_v0.1.md` создан GD
- [ ] `docs/ArtBible/` создан ART
- [ ] `docs/UISpec/` структура создана UIUX
- [ ] Unity проект настроен DEV (структура папок, пакеты)
- [ ] A2A артефакты от GD созданы для Sprint 1
- [ ] Sprint 1 задачи созданы PM из GDD
