# AiW — GDD Summary (Brain File)
# Файл: .gemini/antigravity/brain/gdd_summary.md
# Владелец: GD | Обновлён: Sprint 0
# [STATUS:DRAFT]

---

## Project Snapshot
- **Title:** Alien in Waders (AiW)
- **Genre:** Hybrid-casual Tower Defense + Merge
- **Platform:** Android (primary), iOS | Unity 6 LTS + URP
- **Sprint:** Sprint 0 → Sprint 1 (4 недели) | Android тестовый билд
- **GDD Version:** v0.1 DRAFT

---

## Player Promise
> «Я — тактик-командующий, который строит огневые рубежи из инопланетного оружия, сливая их в монстров разрушения — и чувствую азарт хаоса под контролем.»

---

## Core Loop (TL;DR)
**Micro:** Спаунить башню → ждать волну → сливать две одинаковых → новый тип
**Meta:** Выжить матч → получить шарды → апгрейд колоды → следующий матч сложнее
**Macro:** Открыть 15 башен → PvP рейтинг → Battle Pass → сезонный контент

---

## Sprint 1 Scope (MVP)
- ✅ PvE Тропа-режим (П-образный path, фиксированный)
- ✅ 2 башни: T-001 Incinerator (Fire AoE) + T-002 Cryo-Cannon (Ice CC)
- ✅ Merge-механика: 2 башни Lv N → 1 башня Lv N+1 (cap Lv3 в Sprint 1)
- ✅ 10 волн, 2 типа крипов (Корабль-1, Корабль-2)
- ✅ ScoreSystem: очки → трата на спаун
- ✅ Win/Lose conditions + Pause
- ❌ Волна-режим — Sprint 2
- ❌ Герои, боссы, метагейм, IAP — Sprint 2+

---

## Key Decisions (Sprint 0)
| ID | Решение |
|---|---|
| DEC-001 | Sprint 1 = только Тропа-режим |
| DEC-002 | Sprint 1 = 2 башни (не 15) |
| DEC-003 | Realtime PvP → async/bot |
| DEC-004 | Арт Random Dice не использовать |
| DEC-005 | Matchmaking по tower tier (P2W safeguard) |

---

## For DEV
- Active systems Sprint 1: SpawnManager, MergeGrid, ScoreSystem, PathFollower, GameManager
- TowerConfig SO: type(FIRE/CRYO), mergeLevel(1-3), damage, attackRate, range, spawnCost
- WaveConfig SO: waveNumber, creepCount, creepType, spawnInterval
- Analytics events: session_start, wave_started, wave_completed, tower_spawned, tower_merged, game_over
- Performance: ≤100 draw calls, ≥30 FPS на Samsung Galaxy A54
- Читать: `docs/agents/TZ_DEV_Sprint1_MVP.md`

## For ART
- Sprint 1 assets: 2 башни × 3 Lv + 2 типа крипов + grid + 3 particle FX + merge VFX
- Atlas: всё в 1024×1024, URP Simple Lit
- Polycount: башня ≤800 tri (Lv3), крип ≤300 tri
- Стиль: sci-fi top-down, яркий, cartoon-light. Ref: https://pin.it/2HReRzicu
- Читать: `docs/agents/TZ_ART_Sprint1_MVP.md`

## For UIUX
- Sprint 1 экраны: MainMenu, GameHUD, WinScreen, LoseScreen, PauseOverlay
- Portrait only, touch target ≥48dp, spawn кнопки в нижней 1/5 экрана
- Readable failure: Lose screen показывает номер волны
- Читать: `docs/agents/TZ_UIUX_Sprint1_MVP.md`

## For PM
- KPI Sprint 1: crash-free ≥99%, FPS ≥30 на ref device, merge работает
- Открыть задачи: DEV-S1-001, ART-S1-001, UIUX-S1-001
- Roadmap: Sprint 2 = Волна-режим + 5 башен + 1 герой
- Читать: `docs/concepts/AiW_one_pager_v0.1.md`

---

## Open Design Questions
- [ ] Механика замедления Cryo: max slow 90% на Lv7 — не слишком ли сильно? Нужно плейтестировать.
- [ ] Energy-Harvester (T-011): на каком уровне игры разблокировать, чтобы трейдофф был понятен?
- [ ] PvP bracket по tower tier — как считать tier? Sum level? Max level?
