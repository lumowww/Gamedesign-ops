---
name: loops-and-arcs
description: >
  Nested Loops модель для проектирования игровых циклов.
  Активируется при: 'core loop', 'meta loop', 'прогрессия', 'nested loops',
  'игровой цикл', 'game loop design'.
---

# SKILL: LOOPS AND ARCS

## Nested Loops Model

Игра состоит из вложенных циклов разной длительности.

---

## Уровни циклов

### Micro Loop (секунды)
**Длительность:** 3-30 секунд
**Вопрос:** «Что игрок делает прямо сейчас?»

**Компоненты:**
- Action (ввод игрока)
- Feedback (реакция игры)
- Result (исход действия)

**Примеры:**
- Subway Surfers: Swipe → coin/dodge → score +1
- Candy Crush: Match → cascade → clear + earn

---

### Session Loop (минуты)
**Длительность:** 1-5 минут
**Вопрос:** «Что игрок завершил за сессию?»

**Компоненты:**
- Start (начало сессии)
- Play (серия micro loops)
- End (win/lose/exit)
- Reward (награда за сессию)

**Примеры:**
- Level completion → 3★ + coins
- Run ended → distance + coins earned

---

### Meta Loop (часы/дни)
**Длительность:** 10-60 минут / несколько сессий
**Вопрос:** «Как игрок прогрессирует между сессиями?»

**Компоненты:**
- Earn (ресурсы за сессию)
- Upgrade (траты на улучшения)
- Unlock (новый контент)
- New session (с новыми возможностями)

**Примеры:**
- Coins → upgrade character → new abilities
- Gems → unlock new world → new enemies

---

### Macro Loop (недели/месяцы)
**Длительность:** Несколько дней / недель
**Вопрос:** «Что удерживает игрока в долгосрочной перспективе?»

**Компоненты:**
- Season/Chapter (тематический период)
- Collection (сбор элементов)
- Social (сравнение/соревнование)
- Prestige (сброс с бонусом)

**Примеры:**
- Season Pass → exclusive rewards
- Collection complete → bonus + status

---

## Loop Design Template

### Для каждого цикла заполнить:

```markdown
## [MICRO / SESSION / META / MACRO] LOOP

**Длительность:** [N секунд/минут/часов/дней]

### Структура
[Step 1] → [Step 2] → [Step 3] → [возврат к Step 1]

### Действия игрока
- [Action 1]: [описание]
- [Action 2]: [описание]

### Награды
- Immediate: [что получает сразу]
- Short-term: [что получает за цикл]
- Long-term: [что получает за много циклов]

### Progression
- Количественная: [числа: +coins, +XP]
- Качественная: [новые возможности]

### Exit Points
- [Когда игрок может выйти]
- [Hook для возврата]
```

---

## Loop Analysis Framework

### Для reverse engineering:

1. **Identify loops:**
   - Сколько циклов в игре?
   - Какова длительность каждого?

2. **Map rewards:**
   - Что получает игрок на каждом уровне?
   - Какие rewards immediate vs delayed?

3. **Find hooks:**
   - Что заставляет начать следующий цикл?
   - Что заставляет вернуться после выхода?

4. **Check pacing:**
   - Нет ли «мёртвых зон»?
   - Есть ли перегрузка наградами?

---

## Common Patterns

### Hypercasual
```
Micro: Tap → avoid/collect → score
Session: Run → end → score + coins
Meta: Coins → unlock skin → new run
Macro: Нет (или seasonal skins)
```

### Hybrid-Casual
```
Micro: Action → result → reward
Session: Level → win/lose → stars + coins
Meta: Coins → upgrade → new levels
Macro: Season pass → exclusive rewards
```

### Mid-Core
```
Micro: Combat → win → loot
Session: Dungeon → boss → epic loot
Meta: Gear → power → new dungeon
Macro: Guild/PvP → prestige → season rewards
```

---

## Loop Health Check

### Вопросы для аудита:

**Micro Loop:**
- [ ] Action понятен за 1 секунду?
- [ ] Feedback читаем?
- [ ] Result удовлетворителен?

**Session Loop:**
- [ ] Длительность соответствует платформе?
- [ ] Есть ли clear win/lose?
- [ ] Reward соответствует усилиям?

**Meta Loop:**
- [ ] Есть ли meaningful upgrades?
- [ ] Нет ли paywalls слишком рано?
- [ ] Есть ли long-term goal?

**Macro Loop:**
- [ ] Есть ли причина вернуться через неделю?
- [ ] Социальный hook присутствует?
- [ ] Нет ли burnout риска?

---

## Integration with GDD

В GDD добавить секцию:

```markdown
## Core Loop Design [ID:CORE_LOOP]

### Micro Loop (~[N] сек)
[диаграмма + описание]

### Session Loop (~[N] мин)
[диаграмма + описание]

### Meta Loop (~[N] часов)
[диаграмма + описание]

### Macro Loop (~[N] дней)
[диаграмма + описание]

### Loop Health Check
- ✅ Micro: [комментарий]
- ✅ Session: [комментарий]
- ✅ Meta: [комментарий]
- ⚠️ Macro: [комментарий / нет в scope]
```
