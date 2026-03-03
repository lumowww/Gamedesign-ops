# WORKFLOW: CONCEPT-GD
# Файл: .agent/workflows/concept-gd.md
# Триггер: /concept-gd (после получения Producer Brief)
# Агент: GD

## PROTOCOL: СОЗДАНИЕ GDD v0.1

Используется когда PRODUCER передал Producer Brief и PM создал задачу
TASK-GD-001: «Создать GDD v0.1 на основе Producer Brief».

---

## Step 1 — Получение контекста

1. Прочесть `docs/PRODUCER_BRIEF.md` (получен от PRODUCER)
2. Прочесть `docs/PROJECT_PIPELINE.md` (сроки, milestone)
3. Прочесть `brain/project_context.md` (дедлайн, платформа)
4. Загрузить skills:
   - `.agent/skills/gdd-template/SKILL.md`
   - `.agent/skills/hypercasual-patterns/SKILL.md`
   - `.agent/skills/concept-intake/SKILL.md`

---

## Step 2 — Анализ Producer Brief

Выделить ключевые элементы:

```
## Из Producer Brief извлечь:

**Elevator Pitch:** [одна строка]
**Жанр:** [Hypercasual / Hybrid-Casual]
**Core Mechanic:** [один глагол]
**Референсы:** [список игр]
**Platform:** [iOS / Android]
**Дедлайн прототипа:** [дата]
**Целевые KPI:**
  - CPI: < $[N]
  - D1: > [N]%
  - D7: > [N]%
```

---

## Step 3 — Reverse Engineering референсов

Для каждой референсной игры из Producer Brief:

```markdown
## [GAME_NAME] — Reverse Engineering

### Core Mechanic
[Один глагол: что делает игрок]

### Core Loop
[Action] → [Reward] → [Progress] → [Action]
Длительность: ~[N] секунд

### Retention Hook
[Что заставляет вернуться: D1 / D7]

### Monetization
[Ads / IAP / Hybrid] — [где и как]

### Что копируем
[список элементов]

### Что улучшаем
[список улучшений]

### Что выбрасываем
[список лишнего]
```

---

## Step 4 — Создание GDD v0.1

Создать `docs/GDD/GDD_[ProjectName]_v0.1.md`:

```markdown
# GDD: [PROJECT_NAME]
# Версия: 0.1 | Дата: [ДАТА] | [STATUS:DRAFT]

***

## 1. Concept [ID:CONCEPT]
**Elevator Pitch:** [одна строка]
**Жанр:** [Hypercasual / Hybrid-Casual]
**Платформы:** [iOS / Android]
**Референсы:** [список]

## 2. Core Mechanic [ID:CORE_MECHANIC]
**One Verb:** [глагол — что делает игрок]
**Описание:** [2-3 предложения]
**Input:** [tap / hold / swipe / tilt]
**Feedback:** [visual / audio / haptic]

## 3. Core Loop [ID:CORE_LOOP]
**Micro Loop:** [Action] → [Feedback] → [Result] | ~[N] сек
**Meta Loop:** [Session end] → [Earn] → [Upgrade] → [New session] | ~[N] мин
**Progression:** [levels / endless / waves]

## 4. Visual Hook [ID:VISUAL_HOOK]
[Что цепляет с первого взгляда: 3 слова]

## 5. Feel [ID:FEEL]
**Ощущение:** [3 прилагательных]
**Референсы:** [игры / видео / скриншоты]

## 6. Level Progression [ID:LEVEL_PROGRESSION]
### Формула сложности
[формула или таблица]

### Таблица 10 уровней
| Level | Difficulty | Time | Reward |
|-------|------------|------|--------|
| 1 | 1.0 | 30 сек | +10 coins |
| 2 | 1.2 | 35 сек | +12 coins |
| ... | ... | ... | ... |

## 7. Economy [ID:ECONOMY]
### Ресурсы
- Soft Currency: [название] | earn: ~[N/сессию] | spend: [на что]
- Hard Currency: [название] | earn: [источник] | spend: [на что]
- Energy: [max N] | regen: [N/min]

### Монетизация
**Model:** [F2P / Hybrid / Sub]
**IAP:** [список офферов]
**Ads:** [Rewarded / Interstitial] — [placement]

### Balance Constants
```
SOFT_CAP = [N]
ENERGY_MAX = [N]
LEVEL_XP_SCALE = [N]
```

## 8. Tech Requirements [ID:TECH]
**Unity Version:** [6 LTS]
**Render Pipeline:** [URP]
**Target FPS:** [30 / 60]
**Performance Budget:**
  - Draw Calls: < [N]
  - RAM: < [N] MB
  - APK Size: < [N] MB

## 9. Art Requirements [ID:ART]
**Style:** [3 слова]
**Palette:** [основные цвета]
**Reference Board:** [ссылка]

## 10. UI Requirements [ID:UI]
**Screens:**
- Main Menu
- Gameplay HUD
- Win/Lose Screen
- Meta Screen (если есть)

**UX Flow:**
[Splash] → [Menu] → [Gameplay] → [Win/Lose] → [Menu]

## 11. Prototype Scope [ID:SCOPE]
**In scope (MVP):**
- [ ] Core mechanic реализована
- [ ] Win/Lose условия
- [ ] [N] тестовых уровней
- [ ] Basic UI (score + restart)

**Out of scope (пост-прототип):**
- Meta systems
- Монетизация
- LiveOps
- Tutorial (заменить заглушкой)

## 12. KPIs [ID:KPI]
**Целевые метрики:**
- CPI: < $[N]
- D1 Retention: > [N]%
- D7 Retention: > [N]%
- Session Length: [N]-[N] мин
- Sessions/Day: [N]-[N]

## 13. Open Questions [ID:QUESTIONS]
- [ ] [Вопрос 1]
- [ ] [Вопрос 2]
```

---

## Step 5 — Интеграция

1. Обновить `brain/gdd_summary.md` (краткая версия GDD)
2. Создать артефакты для команды:
   - `GD_to_DEV_GDD_v0.1.md` — Tech Requirements
   - `GD_to_ART_GDD_v0.1.md` — Art Requirements
   - `GD_to_UIUX_GDD_v0.1.md` — UI Requirements
3. Записать в `decisions_log.md`
4. Вызвать `/done TASK-GD-001`

---

## Step 6 — Presentation для PRODUCER

Подготовить краткую презентацию (1 страница):

```markdown
# GDD v0.1 — Summary для PRODUCER

**Elevator Pitch:** [строка]

**Core Mechanic:** [глагог + описание]

**Core Loop:** [схема]

**Visual Hook:** [3 слова]

**Prototype Scope:** [что входит в MVP]

**KPI Targets:** [CPI, D1, D7]

**Timeline:** [Milestone 1-3 даты]

**Open Questions:** [список]
```

Отправить PRODUCER через PM.

---

## Чек-лист /concept-gd

- [ ] Producer Brief прочитан
- [ ] Reverse engineering референсов выполнен
- [ ] GDD v0.1 создан в `docs/GDD/`
- [ ] 12 обязательных разделов заполнены
- [ ] `brain/gdd_summary.md` обновлён
- [ ] Артефакты для DEV/ART/UIUX созданы
- [ ] `decisions_log.md` обновлён
- [ ] Summary для PRODUCER подготовлен
- [ ] `/done TASK-GD-001` вызван
