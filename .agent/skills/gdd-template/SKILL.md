---
name: gdd-template
description: >
  Создание GDD, анализ игр, реверс-инжиниринг механик. Активируется при:
  'создай GDD', 'game design document', 'опиши механику', 'проанализируй игру',
  'реверс инжиниринг', 'core loop', 'level progression', 'game concept'.
---

# SKILL: GDD TEMPLATE

## Шаблон GDD (минимальный для прототипа)

```markdown
# GDD: [PROJECT_NAME] v0.1
Дата: [дата] | Статус: DRAFT

## 1. CONCEPT
Elevator Pitch: [Одно предложение]
Genre: Hypercasual | Platform: iOS + Android
Reference Games: [игра 1], [игра 2]

## 2. CORE MECHANIC
Глагол: [ОДИН глагол]
Игрок [ГЛАГОЛ], чтобы [ЦЕЛЬ], избегая [ПРЕПЯТСТВИЕ].

## 3. CORE LOOP
[Action] → [Feedback] → [Reward] → [Progress] → [New Challenge] → [Action]

## 4. VISUAL HOOK
[Что цепляет за 2 секунды: элемент + цвет + движение]

## 5. FEEL
Ощущение: [3 прилагательных]
Референс: [Игра X]

## 6. LEVEL PROGRESSION
| Уровень | Сложность | Новый элемент | ETA |
|---------|-----------|---------------|-----|
| 1 | Tutorial | Core mechanic | 30с |
| 2 | Easy | + элемент X | 45с |
| 10 | Hard | Комбо | 90с |

## 7. ECONOMY
| Ресурс | Источник | Монетизация |
|--------|---------|-------------|
| Монеты | Уровни | Rewarded ads |

## 8. PROTOTYPE SCOPE (Sprint 1)
ВХОДИТ: Core mechanic + Game Loop + 3 уровня + Basic UI
НЕ ВХОДИТ: Онбординг / Монетизация / Аналитика

## 9. KPIs
D1 Retention: [N]% | Session Length: [N] мин
```

## Реверс-инжиниринг протокол

1. Core Mechanic → 1 глагол
2. Core Loop → Action→Reward→Progress
3. Retention Hook → что заставляет вернуться
4. Monetization → где реклама, что покупают
5. Решение: копируем / улучшаем / выбрасываем
