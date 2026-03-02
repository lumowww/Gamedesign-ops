---
name: market-pulse
description: >
  SKILL продюсера для анализа рынка мобильных игр. Активируется при:
  '/market', 'анализ рынка', 'что в тренде', 'конкуренты', 
  'marketability', 'CPI потенциал', 'актуально ли', 'топ чарты'.
  Использует Perplexity для глубокого поиска.
---

# SKILL: MARKET PULSE ANALYSIS

## Назначение
Продюсер использует этот скилл для оценки:
1. Актуальности идеи (тренд или нет)
2. Конкурентной среды
3. CPI-потенциала жанра
4. Уникального дифференциатора

---

## PERPLEXITY ЗАПРОСЫ (оптимизированные)

### Для анализа жанра/тренда

```
PROMPT ДЛЯ PERPLEXITY (Deep Research):

Analyze the current mobile hypercasual/hybrid-casual game market for [GENRE/MECHANIC].

Research the following:
1. Top 10 games in this category on App Store and Google Play (as of [current date])
2. Average CPI range for this genre in 2024-2025
3. D1/D7 retention benchmarks for top performers
4. Key trends: what's working, what's declining
5. White spaces: underserved niches or missing mechanics
6. Top publishers active in this space (Voodoo, Supersonic, Homa, CrazyLabs)

Format: structured report with:
- Market Status: GROWING / STABLE / DECLINING
- Competition Level: LOW / MEDIUM / HIGH / SATURATED
- CPI Benchmark: $[range]
- Top Games Table: Name | Publisher | Downloads est. | Key mechanic
- Trend Analysis: 3 bullet points
- Opportunity Assessment: specific differentiators that could win
- Risk Assessment: what could fail

Sources: Sensor Tower, data.ai (App Annie), publisher blog posts, industry reports 2024-2025.
```

### Для референс-анализа конкретной игры

```
PROMPT ДЛЯ PERPLEXITY:

Analyze [GAME NAME] mobile game for a game developer who wants to create a similar game.

Provide:
1. Core mechanic (what does player do in 1 verb)
2. Core loop breakdown (action → feedback → reward → progress)
3. Retention hooks (what brings players back)
4. Monetization breakdown (ad types, IAP, frequency)
5. Level progression structure (how difficulty scales)
6. Visual style analysis (art direction, color palette rationale)
7. Performance metrics if available (downloads, ratings, retention estimates)
8. What made it successful (top 3 reasons)
9. What could be improved (top 3 weaknesses = our opportunities)

Format: structured breakdown for game producer use.
```

### Для оценки CPI-потенциала концепта

```
PROMPT ДЛЯ PERPLEXITY:

I'm developing a mobile hypercasual game with this concept:
[КРАТКОЕ ОПИСАНИЕ КОНЦЕПТА]

Reference games: [список референсов]

Research and answer:
1. What is the typical CPI for games with this mechanic type?
2. Are there successful recent (2024-2025) examples of this concept?
3. What creative video styles perform best for this type of game?
4. What ad networks work best for this genre?
5. What meta/progression elements do top hybrid-casual games add to this type of core mechanic?

Provide specific data, not generic advice. Cite sources where possible.
```

---

## ШАБЛОН ОТЧЁТА MARKET PULSE

```markdown
# MARKET PULSE REPORT: [ЖАНР/КОНЦЕПТ]
Дата: [дата] | Продюсер: [Workspace]
Источники: Perplexity Deep Research

## СТАТУС РЫНКА
Тренд: 📈 GROWING / ➡️ STABLE / 📉 DECLINING
Конкуренция: 🟢 LOW / 🟡 MEDIUM / 🔴 HIGH / ⛔ SATURATED
CPI Бенчмарк: $[min] - $[max] (iOS)

## ТОП КОНКУРЕНТЫ
| Игра | Издатель | Позиция | Ключевая механика |
|------|---------|---------|-------------------|
| [Игра 1] | [Кто] | Top [N] | [механика] |
| [Игра 2] | [Кто] | Top [N] | [механика] |

## ТРЕНДЫ (из исследования)
1. [Тренд 1]
2. [Тренд 2]  
3. [Тренд 3]

## ВОЗМОЖНОСТИ (white spaces)
- [Возможность 1]
- [Возможность 2]

## РИСКИ
- [Риск 1]
- [Риск 2]

## РЕКОМЕНДАЦИЯ ПРОДЮСЕРА
[Решение + обоснование на основе данных]

## MARKETABILITY SCORE: [N]/10
[Обоснование оценки]
```

---

## КРИТЕРИИ ОЦЕНКИ РЫНКА

### Когда ВХОДИМ в жанр
- Топ 5 игр жанра старше 6 месяцев (есть место для нового хита)
- CPI бенчмарк < $0.60 для HC
- Есть чёткий дифференциатор
- Тренд GROWING или STABLE с устойчивыми позициями

### Когда ОСТОРОЖНО
- Топ 10 заняты активно обновляемыми играми крупных издателей
- CPI бенчмарк $0.60 - $1.20
- Жанр в фазе насыщения (2-3 года активного роста позади)

### Когда ПЕРЕСМАТРИВАЕМ КОНЦЕПТ
- Жанр DECLINING (меньше 12 месяцев до спада)
- CPI > $1.50 для HC (невозможна прибыль)
- Нет дифференциатора от топ-5 игр
- Крупные издатели уже "закрыли" нишу

---

## ИНТЕГРАЦИЯ С КОМАНДОЙ

После Market Pulse Report продюсер:
1. Делится выводами с GD → влияет на механики и progression
2. Делится с ART → конкурентный арт-анализ
3. Передаёт в Producer Brief → раздел Market Context
4. Информирует PM → приоритеты по KPI targets

Артефакт сохраняется: `.agent/artifacts/market_pulse_[date].md`
