# ТЗ для DEV-агента — Sprint 1 MVP
# Файл: docs/agents/TZ_DEV_Sprint1_MVP.md
# Проект: Alien in Waders (AiW)
# Спринт: Sprint 1 (4 недели) | Android APK

---

## 🎯 Цель спринта

Создать рабочий Android APK с базовым PvE режимом («Тропа»), подтверждающим core-механики.

---

## 📋 Scope работ (Sprint 1)

### ✅ Реализовать

| Функция | Описание | Приоритет |
|---------|----------|-----------|
| **П-образная тропа** | Pathfinding по фиксированным точкам (A→B→C) | P0 |
| **Спаун противников** | Волнами, 10 волн, 2 типа крипов | P0 |
| **Спаун башен** | По клику, за очки, на grid-ячейки | P0 |
| **Merge башен** | 2 одинаковых Lv N → 1 башня Lv N+1 (cap Lv3) | P0 |
| **Боевая система** | Урон, HP, скорость атаки, дальность | P0 |
| **ScoreSystem** | Начисление/списание очков | P0 |
| **Win/Lose условия** | Победа: 10 волн пройдено; Поражение: 10 крипов в финише | P0 |
| **Пауза** | PauseOverlay с кнопками Resume/Restart | P1 |
| **Highlight одинаковых** | Подсветка башен одного уровня | P1 |

### ❌ Отложить (Sprint 2+)

- Волна-режим (bubble-shooter pathfinding)
- Герой игрока
- 5+ типов башен
- Боссы
- PvP/Coop с ботом

---

## 🏗️ Архитектура

### Core системы

```
Assets/_Project/Scripts/Core/
├── EventBus.cs              ← Уже есть (из GAMEDEVGD)
├── GameManager.cs           ← Уже есть (из GAMEDEVGD)
├── ObjectPool.cs            ← Уже есть (из GAMEDEVGD)
└── [Новые]
    ├── SpawnManager.cs      ← Спаун крипов/башен
    ├── MergeGrid.cs         ← Логика merge
    ├── ScoreSystem.cs       ← Очки, покупка, продажа
    ├── PathFollower.cs      ← Движение крипов
    └── WaveConfig.cs        ← SO конфигурация волн
```

### ScriptableObjects

**TowerConfigSO** (для каждой башни):
```csharp
public class TowerConfigSO : ScriptableObject
{
    public TowerType type;        // FIRE, CRYO
    public int mergeLevel;        // 1, 2, 3
    public float damage;
    public float attackRate;      // выстрелов в секунду
    public float range;
    public int spawnCost;         // стоимость в очках
}
```

**WaveConfigSO**:
```csharp
public class WaveConfigSO : ScriptableObject
{
    public int waveNumber;
    public int creepCount;
    public CreepType creepType;   // SHIP_1, SHIP_2
    public float spawnInterval;   // секунды между крипами
}
```

---

## 📊 Analytics события

Отправлять через EventBus:

```csharp
// Session
EventBus.Trigger("session_start");
EventBus.Trigger("session_end", duration_sec, waves_completed);

// Wave
EventBus.Trigger("wave_started", wave_number);
EventBus.Trigger("wave_completed", wave_number, time_sec);

// Tower
EventBus.Trigger("tower_spawned", tower_type, merge_level);
EventBus.Trigger("tower_merged", from_level, to_level);

// Game Over
EventBus.Trigger("game_over", is_win, waves_completed);
```

---

## ⚡ Performance требования

| Метрика | Значение | Устройство теста |
|---------|----------|------------------|
| **Draw Calls** | ≤100 | Samsung Galaxy A54 |
| **FPS** | ≥30 | Samsung Galaxy A54 |
| **Memory** | ≤500 MB | Любое Android |

---

## 🔧 MCP Unity инструменты

Используй для работы:

```bash
# Проверка сцены
node .qwen/mcp-client.js get_scene_info

# Проверка логов
node .qwen/mcp-client.js get_console_logs

# Создание GameObject
node .qwen/mcp-client.js update_gameobject --name "SpawnPoint" --position "0,0,0"
```

---

## 📁 Зависимости

| От кого | Что | Файл |
|---------|-----|------|
| **ART** | Placeholder башни (2 типа × 3 уровня) | `docs/agents/TZ_ART_Sprint1_MVP.md` |
| **UIUX** | UI схемы (MainMenu, GameHUD, Win/Lose) | `docs/agents/TZ_UIUX_Sprint1_MVP.md` |
| **GD** | GDD Summary | `.gemini/antigravity/brain/gdd_summary.md` |

---

## ✅ Критерии готовности (DoD)

- [ ] APK собирается без ошибок
- [ ] П-образная тропа работает (крипы идут A→B→C)
- [ ] Спаун башен по клику (за очки)
- [ ] Merge работает (2→1, Lv1→Lv2→Lv3)
- [ ] Боевка: башни атакуют, крипы получают урон, умирают
- [ ] 10 волн проходятся, Win/Lose условия срабатывают
- [ ] FPS ≥30 на Android (эмулятор/девайс)
- [ ] Analytics события отправляются

---

## 🚀 Следующие шаги

1. **Прочитай** `.gemini/antigravity/brain/gdd_summary.md` (раздел "For DEV")
2. **Создай** структуру папок `Assets/_Project/Scripts/Gameplay/`
3. **Напиши** `SpawnManager.cs`, `MergeGrid.cs`, `ScoreSystem.cs`
4. **Создай** SO для T-001 Incinerator и T-002 Cryo-Cannon
5. **Настрой** тестовую сцену с 1 волной
6. **Собери** APK, протестируй на Android

---

**DEV-S1-001** | P0 | Блокирует: ART-S1-001, UIUX-S1-001
