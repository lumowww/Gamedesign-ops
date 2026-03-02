# GDD TEMPLATE SKILL
# Файл: .agent/skills/gdd-template/SKILL.md
---
name: gdd-template
description: >
  Создание и структурирование Game Design Document (GDD).
  Активируется при: 'создай GDD', 'напиши GDD', 'game design document',
  'опиши механику', 'опиши игру', 'проанализируй игру', 'реверс инжиниринг',
  'скопируй механику', 'core loop', 'game concept', 'level progression'.
---

# SKILL: GDD CREATION TEMPLATE

## Шаблон GDD для гиперказуального прототипа

```markdown
# GAME DESIGN DOCUMENT
## [PROJECT_NAME]
**Версия:** 0.1 | **Автор:** GD Agent | **Дата:** [дата]
**Статус:** DRAFT → REVIEW → APPROVED

---

## 1. CONCEPT
**Elevator Pitch:** [Одно предложение — ЧТО делает игрок, ЗАЧЕМ, ЧТО особенного]
**Genre:** Hypercasual / Casual / Hybrid-casual
**Platform:** iOS + Android
**Target Audience:** 18-35, мобильные казуальные игроки
**Reference Games:** [игра 1], [игра 2], [игра 3]

---

## 2. CORE MECHANIC
**Глагол действия:** [ОДИН глагол: прыгать / стрелять / строить / тапать]
**Описание:** [2-3 предложения — что именно делает игрок]
**One-sentence rule:** Игрок [ГЛАГОЛ], чтобы [ЦЕЛЬ], избегая [ПРЕПЯТСТВИЕ].

---

## 3. CORE LOOP
```
[Action] 
    ↓
[Immediate Feedback] (визуальный/звуковой отклик)
    ↓
[Small Reward] (монеты / очки / прогресс)
    ↓
[Progress Toward Goal] (следующий уровень / разблокировка)
    ↓
[New Challenge] (усложнение)
    ↓
[Action]
```

**Meta Loop:** [Что мотивирует возвращаться — скины / коллекция / PB / соревнование]

---

## 4. VISUAL HOOK (для CPI)
[Что в первые 2 секунды привлекает взгляд на рекламу / скриншот]
- Ключевой элемент: [...]
- Цветовой акцент: [...]
- Движение/анимация: [...]

---

## 5. FEEL
**Ощущение:** [3 прилагательных: Satisfying, Fast, Juicy]
**Референс feel:** [Игра X — как она ощущается]
**Ключевые feedback-моменты:**
- При успехе: [звук + анимация]
- При ошибке: [звук + анимация]  
- При рекорде: [звук + анимация + эффект]

---

## 6. LEVEL PROGRESSION

| Уровень | Сложность | Новый элемент | Скорость | ETA | Тип уровня |
|---------|-----------|---------------|---------|-----|------------|
| 1 | Tutorial | Основная механика | Медленно | 30с | Normal |
| 2 | Easy | + элемент X | Медленно | 45с | Normal |
| 3 | Easy | + элемент Y | Чуть быстрее | 60с | Challenge |
| ... | | | | | |
| 10 | Hard | Комбинация всего | Быстро | 90с | Boss |

---

## 7. ECONOMY

| Ресурс | Источник | Сток | Монетизация |
|--------|---------|------|-------------|
| Монеты | Уровни, ежедневка | Скины | Удвоение за рекламу |
| Жизни | Старт=5, реген | Продолжить | Купить жизни |

**Модель монетизации:** Ads (rewarded/interstitial) + [IAP опционально]
**Rewarded Ad Placement:** [где и когда показывать рекламу]

---

## 8. TECH REQUIREMENTS (для DEV)
- [ ] [Система 1] — описание
- [ ] [Система 2]
- [ ] Physics: [2D / 3D / нет]
- [ ] Special: [особые требования]

---

## 9. ART REQUIREMENTS (для ART)
- Стиль: [описание]
- Персонаж: [описание + состояния]
- Окружение: [описание]
- VFX: [список эффектов]
- Аудио: [список SFX + музыка]

---

## 10. UI REQUIREMENTS (для UIUX)
**Экраны:**
- [ ] Main Menu
- [ ] Gameplay HUD: [элементы — Score, Lives, Progress bar]
- [ ] Pause Menu
- [ ] Level Complete (Win)
- [ ] Game Over (Lose)
- [ ] Settings

---

## 11. PROTOTYPE SCOPE (Sprint 1)
**В прототип ВХОДИТ:**
- [ ] Core mechanic работает
- [ ] Game Loop: Start → Play → Win/Lose
- [ ] [N] уровней
- [ ] Базовый UI (кнопки без дизайна)

**В прототип НЕ ВХОДИТ:**
- Онбординг
- Монетизация
- Аналитика
- Полировка

---

## 12. SUCCESS METRICS (KPIs прототипа)
- D1 Retention: целевой [N]%
- Session Length: целевой [N] мин
- Sessions/Day: целевой [N]
- Тест-критерий: [что должно произойти чтобы двигаться дальше]
```

## Реверс-инжиниринг — протокол анализа игры

При анализе референса по видео/описанию:
1. **Core Mechanic** (один глагол)
2. **Core Loop** (Action→Reward→Progress)
3. **Feel** (3 прилагательных)
4. **Monetization** (где реклама, что покупают)
5. **Visual Hook** (что привлекает в первые 2с)
6. **Что копируем** / **Что улучшаем** / **Что выбрасываем**

---

# ART BIBLE SKILL
# Файл: .agent/skills/art-bible/SKILL.md
---
name: art-bible
description: >
  Создание и ведение Арт-библии проекта. Активируется при: 'создай арт библию',
  'art bible', 'арт стиль', 'цветовая палитра', 'визуальный стиль',
  'стиль проекта', 'mood board', 'референсы арта', 'описание стиля'.
---

# SKILL: ART BIBLE CREATION

## Шаблон Арт-библии

```markdown
# АРТ-БИБЛИЯ: [PROJECT_NAME]
**Версия:** 0.1 | **Автор:** ART Agent | **Дата:** [дата]

---

## 1. VISION STATEMENT
**Ключевое слово стиля:** [ОДНО слово: Juicy / Clean / Dark / Cozy / Hyper]
**Описание:** [2-3 предложения о визуальном ощущении игры]

---

## 2. COLOR PALETTE

| Роль | Hex | RGB | Использование |
|------|-----|-----|---------------|
| Primary | #4A90D9 | 74,144,217 | Главный персонаж, CTA-кнопки |
| Secondary | #F5A623 | 245,166,35 | Акценты, монеты, highlights |
| Background | #1A1A2E | 26,26,46 | Фоны |
| Ground | #2D5A27 | 45,90,39 | Платформы, земля |
| UI Base | #FFFFFF | 255,255,255 | Панели, карточки |
| UI Text | #2C2C2C | 44,44,44 | Основной текст |
| Success | #27AE60 | 39,174,96 | Win, позитивные события |
| Danger | #E74C3C | 231,76,60 | Game over, опасность |

---

## 3. TYPOGRAPHY

| Роль | Шрифт | Размер (pt) | Вес | Стиль |
|------|-------|-------------|-----|-------|
| Score/Numbers | [Шрифт] | 48-72 | Bold | Stroke 2px |
| Button Labels | [Шрифт] | 24-32 | SemiBold | Normal |
| Body Text | [Шрифт] | 14-18 | Regular | Normal |
| Accent/Title | [Шрифт] | 36-48 | ExtraBold | Shadow |

**Источник шрифтов:** Google Fonts (OFL лицензия — коммерческое использование OK)

---

## 4. CHARACTER STYLE
- **Пропорции:** [cartoon 2:3 / realistic / chibi]
- **Outline:** [2px чёрный / нет / цветной]
- **Тени:** [Drop Shadow / None / Cel-shading]
- **Анимационный стиль:** [Skeletal (Spine) / Frame-by-frame / Tween]
- **Размер спрайта:** [128x128 / 256x256 px]

**Состояния персонажа:**
- Idle: [N] кадров, [N]fps
- Run/Move: [N] кадров
- Jump: [N] кадров
- Win: [N] кадров
- Die: [N] кадров

---

## 5. ENVIRONMENT STYLE
- **Тип уровней:** [тайловый / процедурный / готовые сцены]
- **Перспектива:** [side-scrolling / top-down / isometric]
- **Parallax слои:** BG1 (скорость 0.1) / BG2 (0.3) / MG (0.6) / FG (1.0)
- **Тайлы:** [размер px] × [тип — seamless/bordered]

---

## 6. VFX STYLE
- **Частицы:** [pixelated / smooth / cartoon burst]
- **Impact:** [splash / sparkle / stars]
- **Trail:** [есть / нет / тип]
- **UI FX:** [confetti / stars / glow]

---

## 7. AUDIO DIRECTION
- **Музыка:** [Upbeat electronic / Casual pop / Relaxing ambient]
- **SFX стиль:** [Cartoon / Realistic / Minimal]
- **Обязательные SFX:** tap, success, fail, collect, level-up
- **Источник аудио:** Freesound.org / Kenney / [другое]

---

## 8. REFERENCES
| Игра | Что берём | Скриншот/ссылка |
|------|-----------|----------------|
| [Игра 1] | Цветовая палитра | |
| [Игра 2] | Стиль персонажа | |
| [Игра 3] | UI/иконографика | |

---

## 9. WHAT NOT TO DO (Anti-patterns)
- НЕ смешивать стили (pixel art + 3D)
- НЕ использовать больше 3 шрифтов
- НЕ нарушать цветовую палитру без согласования
- НЕ добавлять ассеты без одобрения ART

---

## CHANGELOG
| Версия | Дата | Изменение | Причина |
|--------|------|-----------|---------|
| 0.1 | [дата] | Создание | Старт проекта |
```
