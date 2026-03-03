# WORKFLOW: LIVEOPS-PLAN
# Файл: .agent/workflows/liveops-plan.md
# Триггер: /liveops-plan [тип события]
# Агент: GD

## PROTOCOL: ПРОЕКТИРОВАНИЕ LIVEOPS СОБЫТИЯ

Используется при планировании сезонов, недельных ивентов,
limited time offers и holiday events.

---

## Типы событий

| Тип | Описание | Примеры |
|-----|----------|---------|
| `progression` | Доп. прогрессия | бонусные уровни, XP буст |
| `economy` | Экономические события | скидки, бонусы валюты |
| `competitive` | Турниры, PvP | leaderboards, PvP-ивенты |
| `vanity` | Косметический контент | коллекции, сезонный тематический |
| `retention` | Спецзадания | login rewards, comeback mechanics |

---

## Step 1 — Анализ контекста

1. Прочесть `[ID:LIVEOPS]` в текущем GDD
2. Проверить LiveOps Calendar (если есть в `docs/GDD/`)
3. Определить:
   - Текущий retention (D1/D7) — [HYPOTHESIS] если нет данных
   - Дата ивента: сколько дней на production?
   - Нужные ресурсы: DEV/ART/UIUX effort?

---

## Step 2 — Event Design Document

Создать `docs/GDD/LiveOps_[EventName]_[Date].md`:

```markdown
# LiveOps Event: [НАЗВАНИЕ]
# [STATUS:DRAFT] | Тип: [progression/economy/competitive/vanity/retention]
# Даты: [START] → [END] | Production start: [DATE]

***

## [ID:LO_OVERVIEW]
- **Event Name:** [название]
- **Tagline:** [одна строка для игрока: «Собери 5 драконов за 7 дней!»]
- **Type:** [тип]
- **Duration:** [N дней / недель]
- **Cadence:** [разовый / еженедельный / сезонный]

## [ID:LO_MECHANIC]
### Механика события
[Что игрок делает во время ивента. Отличается ли от обычного геймплея?]

### Entry point
[Откуда игрок узнаёт об ивенте: Main Menu banner / push / lobby popup]

### Event Loop
[Action] → [Event Currency Earn] → [Spend in Event Shop] → [Milestone Reward]

## [ID:LO_REWARDS]
### Reward Structure
| Milestone | Требование | Награда | Тип |
|-----------|------------|---------|-----|
| 1 | [N actions] | [reward] | soft/hard/cosmetic |
| 2 | [N actions] | [reward] | soft/hard/cosmetic |
| Final | [N actions] | [GRAND REWARD] | exclusive |

### Event Shop (если есть)
- Event Currency: [название]
- Items available: [список]
- Prices: [список]
- Leftover currency handling: [конвертируется / сгорает]

## [ID:LO_MONETIZATION]
### Monetization Touch Points
- [ ] Booster pack (ускорение прогресса)
- [ ] Skip to milestone (IAP)
- [ ] Premium track (battle pass style)
- [ ] Cosmetic only bundle

### Fairness Rules
- F2P completion rate: [% игроков должны завершить ивент бесплатно]
- Soft gate: платить нужно только для [финальная награда / топ leaderboard]

## [ID:LO_KPI]
### Target Metrics
- D1 (event period): [target %]
- DAU lift vs baseline: [+N%] [HYPOTHESIS]
- IAP conversion: [target %] [HYPOTHESIS]
- Event completion rate: [target %]

## [ID:LO_PRODUCTION]
### Content Required

**DEV:**
- [ ] Event Manager system (если первый ивент)
- [ ] Event UI screens: [список]
- [ ] Event currency и shop logic
- [ ] Remote config / CMS integration

**ART:**
- [ ] Event banner: [размер]
- [ ] Event icon set: [N иконок]
- [ ] Grand reward asset: [описание]
- [ ] Background/theme: [описание]

**UIUX:**
- [ ] Event entry popup
- [ ] Event progress screen
- [ ] Event shop screen
- [ ] Event end / claim screen

### Timeline
| Дата | Milestone |
|------|-----------|
| [DATE] | Event spec FINAL |
| [DATE] | DEV + ART + UIUX tasks started |
| [DATE] | Internal playtest |
| [DATE] | Event live (remote config toggle) |
| [DATE] | Event ends |

## [ID:LO_ROLLBACK]
### Rollback Plan
- Trigger: [метрика < порог или критический баг]
- Action: [remote config disable / hotfix / revert]
- Compensation: [что получают игроки если ивент отменён]
```

---

## Step 3 — Integration

1. Добавить событие в LiveOps Calendar (`docs/GDD/LiveOps_Calendar.md`)
2. Обновить `[ID:LIVEOPS]` в текущем GDD
3. Создать артефакты для DEV/ART/UIUX
4. Создать задачи в task_board (через PM)
5. Записать в `decisions_log.md`

---

## Чек-лист /liveops-plan

- [ ] Event type определён
- [ ] Механика события описана (event loop)
- [ ] Reward structure заполнена (включая Grand Reward)
- [ ] F2P completion rate задан
- [ ] Монетизация проверена на fairness
- [ ] KPI hypotheses зафиксированы
- [ ] Content list для DEV/ART/UIUX составлен
- [ ] Timeline реалистичен
- [ ] Rollback plan есть
- [ ] LiveOps Calendar обновлён
- [ ] Артефакты для агентов созданы
