---
name: pipeline-generator
description: >
  SKILL продюсера для генерации полного пайплайна разработки.
  Активируется после завершения concept-intake и получения Green Light.
  Триггеры: 'сформируй пайплайн', 'запускай команду', 'создай план',
  'Producer Brief готов', '/pipeline'.
---

# SKILL: PIPELINE GENERATOR

## Что делает этот скилл
Продюсер формирует два финальных документа:
1. `docs/PRODUCER_BRIEF.md` — итоговый бриф проекта
2. `docs/PROJECT_PIPELINE.md` — полный пайплайн с задачами для всей команды

После создания → передаёт PM для исполнения.

---

## ШАБЛОН: PRODUCER BRIEF

```markdown
# PRODUCER BRIEF: [PROJECT_NAME]
Версия: 1.0 | Дата: [дата] | Статус: APPROVED

---

## 1. ПРОЕКТ

**Название (рабочее):** [название]
**Жанр:** Hypercasual / Hybrid-Casual
**Elevator Pitch:** [одно предложение: Игрок [глагол], чтобы [цель], избегая [препятствие]]
**Платформы:** iOS + Android
**Целевой рейтинг:** 4.5+ (App Store / Google Play)

---

## 2. CORE CONCEPT

**Core Mechanic:** [один глагол + описание 2-3 предложения]
**Visual Hook:** [что цепляет за 2 секунды в рекламе]
**Core Loop:**
Action: [что делает игрок]
Feedback: [что происходит немедленно]
Reward: [что получает]
Progress: [что накапливается]
Next Challenge: [почему играет дальше]

**Референсы:**
- [Игра 1]: берём [что именно]
- [Игра 2]: берём [что именно]
- Наш дифференциатор: [чем отличаемся]

---

## 3. SCOPE (MVP PROTOTYPE)

### ВХОДИТ в прототип
- Core mechanic (полностью)
- Game Loop: Win + Fail + Restart
- Уровни: 1-[N] (базовые)
- Basic UI: Score / Level / Restart
- Арт: prototype-grade (читаемый, не финальный)
- Звук: базовые SFX

### НЕ ВХОДИТ в прототип
- Онбординг / туториал (если не ключевой)
- Монетизация (ads / IAP)
- Аналитика
- Финальный арт / анимации
- Meta-progression
- Сохранения

---

## 4. ДЕДЛАЙНЫ

| Milestone | Содержание | Дата |
|-----------|-----------|------|
| M1: Core Mechanic | Механика playable | День [N] |
| M2: Full Loop | Win/Fail/5 уровней | День [N] |
| M3: Prototype | Готов к CPI-тесту | День [N] |
| M4: Test Launch | Запуск первого теста | День [N] |

---

## 5. ЦЕЛЕВЫЕ KPI

| Метрика | Цель | Красная черта |
|---------|------|---------------|
| CPI (iOS) | $[N] | $[N] |
| D1 Retention | [N]% | [N]% |
| D7 Retention | [N]% | [N]% |
| Session Length | [N] мин | [N] мин |

---

## 6. РИСКИ И МИТИГАЦИЯ

| Риск | Вероятность | Митигация |
|------|-------------|-----------|
| [Риск 1] | HIGH/MED/LOW | [Что делаем] |
| [Риск 2] | HIGH/MED/LOW | [Что делаем] |

---

## 7. МОНЕТИЗАЦИЯ (план после прототипа)

**Модель:** [Ads-Heavy / Hybrid / IAP-First]
**Rewarded Ads:** [где, за что]
**Interstitials:** [частота, триггеры]
**IAP (если hybrid):** [что продаём]

---

## 8. РЕШЕНИЕ ПРОДЮСЕРА

✅ **ЗЕЛЁНЫЙ СВЕТ** — передаю PM для запуска пайплайна.

**Примечания:** [особые инструкции для команды]
```

---

## ШАБЛОН: PROJECT PIPELINE

```markdown
# PROJECT PIPELINE: [PROJECT_NAME]
Создан: Продюсер | Дата: [дата]
Версия: 1.0 | PM отвечает за исполнение

---

## SPRINT 0: SETUP (День 1, параллельно)

### GD-001: Game Design Document v0.1
Агент: GD | Приоритет: P0 | ETA: День 1
Вход: Producer Brief
Выход: docs/GDD/GDD_v01.md + gdd_summary.md
Критерии: Core Mechanic описана, Level Progression таблица 1-10

### ART-001: Art Direction
Агент: ART | Приоритет: P0 | ETA: День 1
Вход: Producer Brief + GDD_v01 (gdd_summary)
Выход: docs/ArtBible/ArtBible_v01.md + art_bible_summary.md  
Критерии: Цветовая палитра, стиль персонажа, стиль окружения

### DEV-001: Unity Project Setup
Агент: DEV | Приоритет: P0 | ETA: День 1
Вход: Producer Brief
Выход: Проект с правильной структурой + Package list
Критерии: Структура Assets/_Project/, URP настроен, core packages

---

## SPRINT 1: CORE MECHANIC (День 2-4)

### DEV-002: Core Mechanic Implementation
Агент: DEV | Приоритет: P0 | ETA: День 4
Вход: GDD_v01 (core mechanic)
Выход: Playable mechanic в Unity
Критерии: Игрок может [глагол], feedback работает, feel ощутим
Консультации: GD (feel), ART (визуальный feedback)

### ART-002: Core Visual Assets  
Агент: ART | Приоритет: P0 | ETA: День 3
Вход: ArtBible_v01
Выход: Персонаж (базовые состояния) + тайлы окружения
Критерии: Prototype-grade, читаемо за 2 сек, соответствует арт-библии

### ⚙️ MILESTONE 1 REVIEW (День 4)
Продюсер: Тестирует Core Mechanic Feel
Критерии GO: [список]
Критерии NO-GO → Pivot: [план]

---

## SPRINT 2: GAME LOOP (День 5-8)

### DEV-003: Win/Fail States
Агент: DEV | Приоритет: P0 | ETA: День 5
Вход: GDD_v01 + ArtBible
Выход: Win Screen + Fail Screen + Restart логика
Консультации: UIUX (экраны)

### UIUX-001: UI Screens Spec
Агент: UIUX | Приоритет: P0 | ETA: День 5
Вход: GDD_v01 + ArtBible_v01
Выход: docs/UISpec/screens_v01.md (Main Menu, Gameplay HUD, Win, Fail)
Критерии: Wireframes + typography + цвета

### DEV-004: Levels 1-5
Агент: DEV | Приоритет: P0 | ETA: День 7
Вход: GDD Level Progression + ArtBible
Выход: 5 playable уровней в Unity
Консультации: GD (баланс сложности)

### GD-002: Level Balance v1
Агент: GD | Приоритет: P1 | ETA: День 6
Вход: Playable mechanic (DEV-002)
Выход: docs/GDD/LevelBalance_v01.md — таблица сложности уровней 1-10

### ART-003: UI Assets
Агент: ART | Приоритет: P1 | ETA: День 7
Вход: UIUX screens_v01
Выход: Все UI-ассеты в asset_registry.md
Критерии: Кнопки, иконки, фреймы — соответствуют арт-библии

### ⚙️ MILESTONE 2 REVIEW (День 8)
Продюсер: Полный игровой цикл проходим?
Критерии GO: Win + Fail + 5 уровней + Basic UI работают

---

## SPRINT 3: POLISH → PROTOTYPE (День 9-13)

### DEV-005: Levels 6-10 + Game Feel Polish
Агент: DEV | Приоритет: P0 | ETA: День 11
Вход: LevelBalance_v01 + GD feedback
Выход: 10 уровней + juice (camera shake, particles, sfx)
Консультации: GD (feel), ART (VFX референсы)

### DEV-006: Basic Analytics Integration
Агент: DEV | Приоритет: P1 | ETA: День 12
Вход: KPI goals из Producer Brief
Выход: Session tracking + Level complete events
Примечание: GameAnalytics SDK (бесплатный)

### UIUX-002: UI Implementation Check
Агент: UIUX | Приоритет: P1 | ETA: День 12
Вход: Реализованные DEV экраны
Выход: Список несоответствий + исправления

### ART-004: VFX + Final Assets
Агент: ART | Приоритет: P1 | ETA: День 12
Вход: Реализованная игра
Выход: Particle systems + анимации win/fail

### ⚙️ MILESTONE 3: GO/NO-GO (День 13-14)
Продюсер: Финальная оценка прототипа
Критерии GO для CPI-теста:
- [ ] Game loop завершён
- [ ] Визуал читаем за 2 секунды
- [ ] Нет критических багов
- [ ] 10 уровней playable
- [ ] Analytics работает
- [ ] Gameplay видео для creative (30 сек)

---

## SPRINT 4: TEST PREPARATION (День 14-16, если GO)

### MARKETING-001: Creative Video
Исполнитель: Пользователь (при поддержке ART)
Выход: 30-секундный gameplay видео для рекламы
Правило: Лучший/WTF момент — в первые 3 секунды

### DEV-007: Build → TestFlight / Internal Test
Агент: DEV | Приоритет: P0
Выход: iOS TestFlight build + Android APK

---

## КОММУНИКАЦИОННАЯ МАТРИЦА

| От кого | Кому | Когда | Через что |
|---------|------|-------|-----------|
| PRODUCER | PM | После брифа | Личная передача + файлы |
| PRODUCER | Все | Milestone | `/milestone` команда |
| PM | Все | Ежедневно | task_board.md |
| Агент | PM | Задача готова | `/done TASK-ID` |
| Агент | PRODUCER | По запросу | `/report [AGENT]` |
| Агент | Другой агент | При зависимости | artifacts/ + brain/ |
```
