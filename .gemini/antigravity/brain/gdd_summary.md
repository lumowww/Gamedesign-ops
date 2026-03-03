# GDD SUMMARY (EXTENDED — для GD-Workspace)
# Файл: .gemini/antigravity/brain/gdd_summary.md
# ВЛАДЕЛЕЦ: GD — обновляет после каждой версии GDD и каждой завершённой задачи
# Лимит: ~500 слов (оптимально для вставки в контекст агента)

---

## [PROJECT_NAME] — GDD Summary v[N]

**Последнее обновление:** [ДАТА]  
**GDD версия:** v[N]  
**Спринт:** [N]  
**Статус:** [DRAFT / FINAL / IN_PROGRESS]

---

### 🎮 Player Promise

> «Я — [X], который делает [Y] и чувствует [Z]»

---

### 🔄 Core Loop

| Уровень | Структура | Длительность |
|---------|-----------|--------------|
| **Micro** | [Action] → [Feedback] → [Result] | ~[N] сек |
| **Meta** | [Session end] → [Earn] → [Upgrade] → [New session] | ~[N] мин |
| **Macro** | [Campaign/Season arc] | ~[N] дней |

---

### 🎯 Prototype Scope (текущий спринт)

**In scope:**
- [ ] [Механика 1] — [статус: TODO/WIP/DONE]
- [ ] [Механика 2] — [статус]
- [ ] Game Loop (Start/Play/Win/Lose) — [статус]
- [ ] [N] тестовых уровней

**Out of scope (пост-прототип):**
- [ ] Meta systems
- [ ] Монетизация
- [ ] LiveOps

---

### 💰 Economy (кратко)

| Валюта | Earn | Spend | Баланс |
|--------|------|-------|--------|
| Soft: [название] | ~[N]/сессию | [на что] | [surplus/balanced/deficit] |
| Hard: [название] | [источник] | [на что] | [surplus/balanced/deficit] |

**Model:** [F2P / Hybrid / Sub]

**Key constants:**
```
SOFT_CAP = [N]
ENERGY_MAX = [N]
LEVEL_XP_SCALE = [N]
```

---

### 🎨 For DEV

**Active systems:**
- [список системы которые сейчас в работе]

**ScriptableObjects:**
| Name | Fields | Purpose |
|------|--------|---------|
| [Name]SO | [field1, field2] | [описание] |

**Key scenes:**
- `gameplay_main` — [описание]
- `hub_main` — [описание]

**Analytics events (required):**
```
event_name: [name] | params: [param1, param2]
```

**Performance budget:**
- Draw calls: < [N]
- RAM: < [N] MB
- FPS target: [30/60]

---

### 🖼️ For ART

**Active asset requests:**
| Asset | Type | Size | Deadline | Status |
|-------|------|------|----------|--------|
| [name] | sprite | 512x512 | [date] | TODO/WIP/DONE |

**Art style TL;DR:**
- [3 слова]

**Priority assets (P0):**
- [список]

---

### 📱 For UIUX

**Active screens:**
| Screen | Purpose | Status |
|--------|---------|--------|
| [name] | [описание] | TODO/WIP/DONE |

**Screen graph TL;DR:**
```
[Splash] → [Menu] → [Gameplay] → [Win/Lose] → [Menu]
```

**UX priority:**
- [ ] FTUE
- [ ] HUD
- [ ] Meta
- [ ] Shop

---

### ⚠️ Open Design Questions

*Вопросы которые GD ещё не решил — потенциальные блокеры*

- [ ] [Вопрос 1] — нужно решить до: [DATE/TASK]
- [ ] [Вопрос 2]

---

### 📌 Recent Decisions (последние 3)

*Полный лог в `decisions_log.md`*

1. [ДАТА] [ID:BLOCK] — [суть решения]
2. [ДАТА] [ID:BLOCK] — [суть решения]
3. [ДАТА] [ID:BLOCK] — [суть решения]

---

### 🔢 Features in Pipeline

| Feature | Status | GDD Block | Sprint | Owner |
|---------|--------|-----------|--------|-------|
| [Feature A] | DRAFT/SPEC/DEV/DONE | [ID:...] | [N] | GD/DEV |
| [Feature B] | DRAFT | [ID:...] | [N+1] | GD |

---

### 📊 KPI Targets

| Метрика | Target | Current | Status |
|---------|--------|---------|--------|
| CPI | < $[N] | [HYPOTHESIS] | ⏳ |
| D1 Retention | > [N]% | [HYPOTHESIS] | ⏳ |
| D7 Retention | > [N]% | [HYPOTHESIS] | ⏳ |
| Session Length | [N]-[N] мин | [HYPOTHESIS] | ⏳ |

---

**Последнее обновление:** [ДАТА]  
**Следующее ревью:** [DATE]  
**Владелец:** GD
