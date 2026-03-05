# AiW — Task Board

# Файл: .gemini/antigravity/brain/task_board.md

# Sprint 1 | [STATUS:ACTIVE]

---

## Sprint 1 — Active Tasks

| TASK-ID | Агент | Название | Статус | Приоритет | Блокирует |
|---|---|---|---|---|---|
| DEV-S1-001 | DEV | Code Phase: PvE Тропа-режим | ✅ DONE | P0 | — |
| ART-S1-001 | ART | Placeholder-контент Sprint 1 | ✅ DONE | P0 | — |
| UIUX-S1-001 | UIUX | 5 экранов Sprint 1 | 🟡 IN_PROGRESS | P0 | — |
| DEV-S1-005 | DEV | Highlight-система одинаковых башен | 🔵 TODO | P1 | UIUX-S1-001 |

### DEV-S1-001 Deliverables (Completed)
**Core Systems:** `GameManager.cs`, `EventBus.cs`, `ObjectPool.cs` (+ tests)
**Gameplay:** `Tower.cs`, `TowerDragger.cs`, `TowerAttack.cs`, `MergeGrid.cs`, `GridCell.cs`
**Systems:** `SpawnManager.cs`, `PathFollower.cs`, `ScoreSystem.cs`, `CreepHealth.cs`
**Data:** `GameConfigSO.cs`, `TowerConfigSO.cs`, `WaveConfigSO.cs`
**Editor:** `PlaceholderArtGenerator.cs` (3D model generator)
**A2A:** `DEV_to_TEAM_DragAndDrop.md` (merge mechanic: Drag&Drop instead of click-to-merge)

## Sprint 0 — Completed (GD)

| TASK-ID | Агент | Название | Статус |
|---|---|---|---|
| GD-S0-001 | GD | Concept Intake + Go/No-Go | ✅ DONE |
| GD-S0-002 | GD | One Page Concept v0.1 | ✅ DONE |
| GD-S0-003 | GD | Core Loops (micro/meta/macro) | ✅ DONE |
| GD-S0-004 | GD | Unity Mobile Checklist | ✅ DONE |
| GD-S0-005 | GD | Design Heuristics Audit | ✅ DONE |
| GD-S0-006 | GD | TZ DEV / ART / UIUX Sprint 1 | ✅ DONE |
| GD-S0-007 | GD | Tower Entity Matrix (15 башен) | ✅ DONE |
| GD-S0-008 | GD | Free Asset List Sprint 1 | ✅ DONE |

## Backlog (Sprint 2+)

- DEV-S2-001: Волна-режим (bubble-shooter pathfinding)
- DEV-S2-002: Герой игрока
- DEV-S2-003: 5 типов башен
- ART-S2-001: Герой игрока (3D, top-down)
- ART-S2-002: Жук-Босс placeholder
