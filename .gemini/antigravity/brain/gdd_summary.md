# GDD SUMMARY (EXTENDED — для GD-Workspace)
# Файл: .gemini/antigravity/brain/gdd_summary.md
# ВЛАДЕЛЕЦ: GD — обновляет после каждой версии GDD и каждой завершённой задачи
# Лимит: ~500 слов (оптимально для вставки в контекст агента)

---

## GAMEDEVGD — GDD Summary v2.0

**Последнее обновление:** 2026-03-04
**GDD версия:** v2.0
**Спринт:** 0 (Инициализация)
**Статус:** [STATUS:WAITING_FOR_CONCEPT]

---

### 🎮 Player Promise

> «Я — геймдизайнер, который создаёт гиперказуальные игры через AI-агентов и чувствует контроль над пайплайном»

---

### 🔄 Core Loop

| Уровень | Структура | Длительность |
|---------|-----------|--------------|
| **Micro** | Идея → Concept → Producer Brief | ~15 мин |
| **Meta** | Producer Brief → GDD → Sprint Plan → Prototype | ~1-2 недели |
| **Macro** | Prototype → Soft Launch → LiveOps | ~1-3 месяца |

---

### 🎯 Prototype Scope (текущий спринт)

**In scope:**
- [ ] Настройка мультиагентного пайплайна — [статус: DONE]
- [ ] Интеграция MCP Unity — [статус: DONE]
- [ ] Создание базовой структуры проекта — [статус: DONE]
- [ ] GDD v0.1 для первого концепта — [статус: TODO]

**Out of scope (пост-прототип):**
- [ ] Meta systems
- [ ] Монетизация
- [ ] LiveOps

---

### 💰 Economy (кратко)

*Примечание: Экономика будет определена после получения концепта от PRODUCER*

| Валюта | Earn | Spend | Баланс |
|--------|------|-------|--------|
| Soft: TBD | TBD | TBD | balanced |
| Hard: TBD | TBD | TBD | balanced |

**Model:** Hypercasual (F2P с IAP + Ads)

**Key constants:**
```
SOFT_CAP = TBD
ENERGY_MAX = TBD
LEVEL_XP_SCALE = TBD
```

---

### 🎨 For DEV

**Active systems:**
- EventBus (Core) — DONE
- GameManager (Core) — DONE
- ObjectPool (Core) — DONE

**ScriptableObjects:**
| Name | Fields | Purpose |
|------|--------|---------|
| GameConfigSO | gameName, version, targetFPS | Глобальные настройки игры |
| LevelConfigSO | levelId, difficulty, timeLimit | Настройки уровня |

**Key scenes:**
- `Main` — загрузочная сцена
- `SampleScene` — тестовая сцена

**Analytics events (required):**
```
event_name: game_start | params: { session_id, timestamp }
event_name: level_complete | params: { level_id, duration, stars }
```

**Performance budget:**
- Draw calls: < 100
- RAM: < 200 MB
- FPS target: 60

---

### 🖼️ For ART

**Active asset requests:**
| Asset | Type | Size | Deadline | Status |
|-------|------|------|----------|--------|
| TBD | TBD | TBD | TBD | TODO |

**Art style TL;DR:**
- TBD (ожидает концепта от PRODUCER)

**Priority assets (P0):**
- TBD

---

### 📱 For UIUX

**Active screens:**
| Screen | Purpose | Status |
|--------|---------|--------|
| Main Menu | Навигация | TODO |
| Gameplay HUD | Игровой интерфейс | TODO |
| Settings | Настройки | TODO |

**Screen graph TL;DR:**
```
[Splash] → [Main Menu] → [Gameplay] → [Win/Lose] → [Main Menu]
```

**UX priority:**
- [x] FTUE (First Time User Experience)
- [ ] HUD
- [ ] Meta
- [ ] Shop

---

### ⚠️ Open Design Questions

*Вопросы которые GD ещё не решил — потенциальные блокеры*

- [ ] Жанр первого проекта — нужно решить до: /concept от PRODUCER
- [ ] Целевая платформа (iOS/Android) — нужно решить до: Sprint 1

---

### 📌 Recent Decisions (последние 3)

*Полный лог в `decisions_log.md`*

1. 2026-03-04 [ID:INFRA-001] — Создана структура Assets/_Project/ с Core системами
2. 2026-03-04 [ID:INFRA-002] — decisions_log.md очищен от null-байтов, конвертирован в UTF-8
3. 2026-03-04 [ID:DOC-001] — Документация обновлена до v2.0 (PRODUCER как точка входа)

---

### 🔢 Features in Pipeline

| Feature | Status | GDD Block | Sprint | Owner |
|---------|--------|-----------|--------|-------|
| Core Systems | DONE | N/A | 0 | DEV |
| GDD v0.1 | TODO | N/A | 1 | GD |
| First Playable | TODO | GDD-001 | 1-2 | DEV |

---

### 📊 KPI Targets

| Метрика | Target | Current | Status |
|---------|--------|---------|--------|
| CPI | < $0.50 | HYPOTHESIS | ⏳ |
| D1 Retention | > 40% | HYPOTHESIS | ⏳ |
| D7 Retention | > 15% | HYPOTHESIS | ⏳ |
| Session Length | 3-5 мин | HYPOTHESIS | ⏳ |

---

**Последнее обновление:** 2026-03-04
**Следующее ревью:** После получения /concept от PRODUCER
**Владелец:** GD
