# WORKFLOW: FEATURE-SPEC
# Файл: .agent/workflows/feature-spec.md
# Триггер: /feature-spec [название фичи]
# Агент: GD

## PROTOCOL: НАПИСАНИЕ FEATURE SPEC

Используется когда PM ставит задачу TASK-GD-XXX: «Спроектировать [фичу]».

---

## Step 1 — Контекст

1. Прочесть `brain/project_context.md` (спринт, платформа, дедлайн)
2. Прочесть `brain/gdd_summary.md` (текущий Core Loop и мета)
3. Найти в `docs/GDD/GDD_[Name]_v[N].md` блоки, связанные с фичей
4. Загрузить skills:
   - `.agent/skills/design-heuristics/SKILL.md`
   - `.agent/skills/mobile-design-checklist/SKILL.md`
   - `.agent/skills/agent-tz-template/SKILL.md`

---

## Step 2 — Черновик фичи (GD думает)

Ответить письменно на 5 вопросов перед тем как писать спек:

1. **Player Promise:** как эта фича усиливает или расширяет обещание игры?
2. **Core Loop fit:** куда эта фича встраивается в micro/meta/macro loop?
3. **KPI hypothesis:** какую метрику целим и на сколько % ожидаем движение?
4. **Unity cost:** сложность Low/Med/High/Epic? Есть ли perf-риски?
5. **Design heuristics:** какие из 9 правил поддерживаются / нарушаются?

---

## Step 3 — Feature Spec документ

Создать `docs/GDD/FeatureSpec_[FeatureName]_v0.1.md`:

```markdown
# Feature Spec: [НАЗВАНИЕ]
# [STATUS:DRAFT] | Версия: 0.1 | Дата: [ДАТА]
# GDD блоки: [ID:RELATED_BLOCK_1], [ID:RELATED_BLOCK_2]

***

## 1. Overview [ID:FS_OVERVIEW]
- **Feature Name:** [название]
- **Type:** New Feature / Improvement / LiveOps / Economy / UX
- **Player Promise fit:** [одно предложение]
- **Loop layer:** Micro / Meta / Macro / LiveOps

## 2. Problem / Opportunity [ID:FS_PROBLEM]
[2–3 предложения: что сейчас не работает или какая возможность]

## 3. Solution [ID:FS_SOLUTION]

### Описание
[Что делает игрок. Что происходит на экране. Как это ощущается.]

### User Flow
[Экран A] → [триггер] → [Экран/Механика B] → [результат] → [Экран C]

### Edge Cases
- Что если инвентарь пуст?
- Что если нет интернета?
- Что если игрок первый раз видит этот экран?

## 4. Progression & Economy Impact [ID:FS_ECONOMY]
- Новые ресурсы: [есть/нет, какие]
- Изменения в sources/sinks: [описание]
- Balance constants:
  [CONSTANT_NAME] = [значение]   # [комментарий]
- Fairness check: [нет P2W нарушений? pity rules соблюдены?]

## 5. KPI & Metrics [ID:FS_KPI]
- **Primary metric:** [D1 / D7 / session_length / ARPDAU / conversion]
- **Baseline:** [HYPOTHESIS — нет данных / данные от [источник]]
- **Expected impact:** [+/- N%]
- **Measurement:** [event name, A/B план]
- **Success threshold:** [при каком значении считаем успехом]
- **Rollback trigger:** [при каком значении откатываем]

## 6. Design Heuristics Check [ID:FS_HEURISTICS]
- ✅/⚠️/❌ Player Promise: [комментарий]
- ✅/⚠️/❌ Clarity: [комментарий]
- ✅/⚠️/❌ Agency: [комментарий]
- ✅/⚠️/❌ Fair Challenge: [комментарий]
- Tricks задействованы: [список из 12 Tricks]

## 7. For Agents [ID:FS_AGENTS]

### → DEV
- Systems: [список]
- ScriptableObjects: [список с полями]
- Analytics events: [event_name | params]
- Performance estimate: [Low/Med/High] | ~[N] дней

### → UIUX
- Screens: [список экранов]
- UX Flow: [короткий граф]
- New UI elements: [список]

### → ART
- New assets: [список с размерами/типами]
- Animation needs: [список]
- Placeholder OK: [да/нет]

### → PM
- Dependencies: [TASK-IDs]
- Recommended sprint: [Sprint N]
- Risk: [Low/Med/High] — [описание]

## 8. Open Questions [ID:FS_QUESTIONS]
- [ ] [Вопрос к команде / требует решения]
- [ ] [Вопрос к аналитике / нет данных]
```

---

## Step 4 — Интеграция в GDD

1. Если фича принята (STATUS меняется на FINAL) —
   добавить соответствующие блоки в `docs/GDD/GDD_[Name]_v[N+1].md`
2. Запустить `/gdd-update`

---

## Step 5 — Brain & Артефакты

1. Добавить в `brain/gdd_summary.md` секцию «Фичи в разработке»
2. Создать артефакты из секции «For Agents»:
   - `GD_to_DEV_[TASK-ID].md`
   - `GD_to_UIUX_[TASK-ID].md`
   - `GD_to_ART_[TASK-ID].md`
3. Записать в `decisions_log.md`
4. Вызвать `/done [TASK-GD-ID]`

---

## Чек-лист /feature-spec

- [ ] 5 вопросов предварительного анализа заполнены
- [ ] Feature Spec создан в `docs/GDD/FeatureSpec_[Name]_v0.1.md`
- [ ] Секция «For Agents» заполнена для DEV/UIUX/ART/PM
- [ ] KPI hypothesis зафиксирована (даже если [HYPOTHESIS])
- [ ] Design Heuristics Check заполнен
- [ ] A2A артефакты созданы
- [ ] `decisions_log.md` обновлён
