# WORKFLOW: BALANCE-REVIEW
# Файл: .agent/workflows/balance-review.md
# Триггер: /balance-review
# Агент: GD

## PROTOCOL: РЕВЬЮ БАЛАНСА И ЭКОНОМИКИ

Используется для аудита текущей экономики проекта.

**Когда вызывать:**
- После каждого milestone
- При изменении монетизации
- При подготовке к soft-launch
- При просадке ARPDAU или retention

---

## Step 1 — Сбор данных

1. Прочесть `brain/gdd_summary.md` и найти раздел Economy
2. Открыть `docs/GDD/GDD_[Name]_v[N].md` блоки:
   - `[ID:ECONOMY]`, `[ID:ECONOMY_RESOURCES]`, `[ID:BALANCE]`
   - `[ID:MONETIZATION]`, `[ID:IAP]`, `[ID:ADS]`
   - `[ID:PROGRESSION]`, `[ID:GATING]`
3. Запросить у PM/DEV актуальные данные если есть (A/B results, telemetry export)
   — иначе работать от дизайн-гипотез

---

## Step 2 — Анализ по блокам

### A. Currency Flow (Источники и стоки)

Проверить для каждой валюты:

```
[CURRENCY_NAME]:
  Sources (откуда приходит):
    - [источник]: [примерный объём в день]
  Sinks (куда уходит):
    - [сток]: [примерный объём в день]
  Balance: [surplus / balanced / deficit]
  Risk: [инфляция / дефицит / нет проблем]
```

**Красные флаги:**
- ❌ Soft currency накапливается без стоков → инфляция → IAP теряет ценность
- ❌ Hard currency слишком легко заработать F2P → конверсия падает
- ❌ Energy regen слишком быстрый → нет retention hook
- ❌ Energy regen слишком медленный → churn Day 1

### B. Progression Curve

Проверить формулу прогрессии:

```
Level XP formula: BASE_XP * SCALE^level
Время на уровень: [N минут]
Ощущение кривой: [экспонента / линия / ступени]
```

**Вопросы:**
- Насколько быстро игрок доходит до первого paywalled контента?
- Есть ли «мёртвые зоны» где нечего делать?
- Первый hard gate на уровне N — это раньше или позже D7?

### C. Monetization Health

Для каждого IAP оффера:

```
[Оффер]:
  Price: $[X]
  Value proposition: [что получает игрок]
  First appearance: [после сессии N / уровня N]
  Fairness check: [P2W риск?]
  Pity/safety system: [есть/нет]
```

**Ads check:**
- Rewarded: добровольные? Reward достаточно ценен?
- Interstitial: частота ≤ 1 per 3 min? Не прерывает геймплей?

### D. LiveOps Economy Impact

- Как ивенты влияют на основную экономику?
- Есть ли риск «ивентовой инфляции»?
- Сезонная валюта — конвертируется в основную? Как?

---

## Step 3 — Итоговый отчёт

Создать `docs/GDD/BalanceReview_[Date].md`:

```markdown
# Balance Review — [ДАТА]
# [PROJECT_NAME] v[N] | [STATUS:DRAFT]

## Executive Summary
[2–3 предложения: общее состояние, главные риски, рекомендация]

## Currency Flow
[таблица источники/стоки для каждой валюты]
Риски: [список]

## Progression Curve
[анализ скорости, гейтов, мёртвых зон]
Риски: [список]

## Monetization
[анализ офферов, ads, fairness]
Риски: [список]

## Recommendations (приоритизированы)
- P0: [критично, блокирует soft-launch]
- P1: [важно, влияет на метрики]
- P2: [желательно, улучшение]

## Changes Required in GDD
- [ID:BALANCE] — обновить: [что именно]
- [ID:ECONOMY] — обновить: [что именно]

## For PM
- Tasks to create: [список]
- Timeline impact: [есть/нет]
```

---

## Step 4 — Обновление GDD

Если найдены P0/P1 проблемы:

1. Обновить соответствующие блоки GDD → `/gdd-update`
2. Создать `GD_to_DEV_BALANCE_[DATE].md` если нужны изменения в коде
3. Записать в `decisions_log.md`

---

## Чек-лист /balance-review

- [ ] Currency flow проанализирован (все валюты)
- [ ] Progression curve проверена (формула + время)
- [ ] Все IAP офферы проверены на fairness
- [ ] Ads placement и frequency проверены
- [ ] Balance Review doc создан
- [ ] Recommendations приоритизированы (P0/P1/P2)
- [ ] GDD обновлён при наличии P0/P1
- [ ] `decisions_log.md` обновлён
