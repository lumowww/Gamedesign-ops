# AiW — One Page Concept v0.1
# Файл: docs/concepts/AiW_one_pager_v0.1.md
# Проект: Alien in Waders (AiW)
# Версия: 0.1 DRAFT

---

## 🎯 Project Overview

| Параметр | Значение |
|----------|----------|
| **Название** | Alien in Waders (AiW) |
| **Жанр** | Hybrid-casual Tower Defense + Merge |
| **Платформа** | Android (primary), iOS |
| **Движок** | Unity 6 LTS + URP |
| **Ориентация** | Portrait |
| **Сессия** | 3-5 минут |
| **Монетизация** | F2P (IAP, Ads, Battle Pass) |

---

## 🎮 Player Promise

> «Я — тактик-командующий, который строит огневые рубежи из инопланетного оружия, сливая их в монстров разрушения — и чувствую азарт хаоса под контролем.»

---

## 🔄 Core Loop

```
┌─────────────────────────────────────────────────────┐
│  Micro: Спаун → Атака → Merge → Новый тип         │
│    ↓                                                │
│  Meta: Выжить → Шарды → Апгрейд колоды → Сложнее  │
│    ↓                                                │
│  Macro: 15 башен → PvP → Battle Pass → Сезон      │
└─────────────────────────────────────────────────────┘
```

---

## 📋 Sprint 1 Scope (MVP)

**Цель:** Android APK с базовым PvE режимом

| Функция | Статус |
|---------|--------|
| П-образная тропа (pathfinding) | ✅ |
| 2 башни: T-001 Fire + T-002 Cryo | ✅ |
| Merge: 2 Lv N → 1 Lv N+1 (cap Lv3) | ✅ |
| 10 волн, 2 типа крипов | ✅ |
| ScoreSystem (очки → спаун) | ✅ |
| Win/Lose условия | ✅ |
| Пауза | ✅ |

**Отложено (Sprint 2+):**
- ❌ Волна-режим
- ❌ Герои, боссы
- ❌ 5+ типов башен
- ❌ PvP/Coop

---

## 🎨 Art Direction

**Стиль:** Sci-fi top-down, яркий, cartoon-light

**Референсы:**
- Pinterest: https://pin.it/2HReRzicu
- Random Dice (не копировать)

**Технические требования:**
- Atlas: 1024×1024
- Polycount: башня ≤800 tri, крип ≤300 tri
- Shader: URP Simple Lit

---

## 📊 KPI Цели

| Метрика | Цель |
|---------|------|
| **D1 Retention** | >40% |
| **D7 Retention** | >15% |
| **CPI** | <$2.50 |
| **Playtime** | >10 мин/день |
| **Crash-free** | >99% |

---

## 🗓️ Roadmap

| Этап | Длительность | Цель |
|------|--------------|------|
| **Sprint 0** | 1 неделя | GDD, ТЗ, документация |
| **Sprint 1** | 4 недели | Android APK (MVP) |
| **Sprint 2** | 4 недели | Волна-режим + 5 башен + герой |
| **Sprint 3** | 4 недели | Метагейм + PvP + IAP |
| **Launch** | 8 недель | Полиш + туториал + контент |

---

## 🔑 Key Decisions

| ID | Решение |
|----|---------|
| DEC-001 | Sprint 1 = только Тропа-режим |
| DEC-002 | Sprint 1 = 2 башни (не 15) |
| DEC-003 | Realtime PvP → async/bot до Этапа 4 |
| DEC-004 | Арт Random Dice не использовать |
| DEC-005 | Matchmaking по tower tier (P2W safeguard) |

---

## 📁 Связанные документы

| Документ | Путь |
|----------|------|
| Concept Intake | `docs/intake/AiW_concept_intake.md` |
| GDD Summary | `.gemini/antigravity/brain/gdd_summary.md` |
| TZ DEV | `docs/agents/TZ_DEV_Sprint1_MVP.md` |
| TZ ART | `docs/agents/TZ_ART_Sprint1_MVP.md` |
| TZ UIUX | `docs/agents/TZ_UIUX_Sprint1_MVP.md` |

---

**Агент:** GD  
**Дата:** 2026-03-05  
**Статус:** DRAFT v0.1
