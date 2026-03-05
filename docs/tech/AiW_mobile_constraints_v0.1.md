# AiW — Mobile Constraints (Unity 6 LTS)
# Файл: docs/tech/AiW_mobile_constraints_v0.1.md
# Проект: Alien in Waders (AiW)
# Версия: 0.1

---

## 📱 Целевые устройства

**Android (Primary):**

| Класс | Устройство | GPU | RAM | Resolution |
|-------|------------|-----|-----|------------|
| **Low** | Samsung Galaxy A54 | Mali-G68 | 6 GB | 1080×2340 |
| **Mid** | Pixel 7 | Mali-G710 | 8 GB | 1080×2400 |
| **High** | ROG Phone 7 | Adreno 740 | 16 GB | 1080×2448 |

**iOS (Secondary):**

| Класс | Устройство | GPU | RAM | Resolution |
|-------|------------|-----|-----|------------|
| **Mid** | iPhone 12 | A14 Bionic | 4 GB | 1170×2532 |
| **High** | iPhone 15 Pro | A17 Pro | 8 GB | 1179×2556 |

---

## ⚡ Performance Budget

| Метрика | Low | Mid | High |
|---------|-----|-----|------|
| **FPS** | ≥30 | ≥60 | ≥90 |
| **Draw Calls** | ≤100 | ≤200 | ≤400 |
| **Triangles** | ≤50K | ≤100K | ≤200K |
| **Memory** | ≤500 MB | ≤750 MB | ≤1 GB |
| **Storage** | ≤200 MB | ≤300 MB | ≤500 MB |
| **Battery** | ≤10%/час | ≤8%/час | ≤5%/час |

---

## 🎨 Графика

### Модели

| Ассет | Triangles | LOD |
|-------|-----------|-----|
| Башня Lv1/2 | ≤500 | LOD0 only |
| Башня Lv3 | ≤800 | LOD0 + LOD1 (400 tri) |
| Крип | ≤300 | LOD0 only |
| Grid-ячейка | ≤200 | LOD0 only |

### Текстуры

| Тип | Размер | Формат | Компрессия |
|-----|--------|--------|------------|
| **Башни** | 512×512 | PNG | ASTC 6×6 |
| **Крипы** | 256×256 | PNG | ASTC 6×6 |
| **UI** | 1024×1024 (атлас) | PNG | ASTC 4×4 |
| **VFX** | 256×256 | PNG | ASTC 8×8 |

### Материалы

- **Shader:** URP Simple Lit (mobile-friendly)
- **Instancing:** Включён для башен/крипов
- **Batching:** Static + Dynamic batching

---

## 🔊 Аудио

| Параметр | Значение |
|----------|----------|
| **Sample Rate** | 44.1 kHz |
| **Format** | Vorbis |
| **Bitrate** | 128 kbps (SFX), 256 kbps (Music) |
| **Max Voices** | 16 одновременных |
| **Memory** | ≤50 MB на аудио |

---

## 📦 Сборка

### Android

| Настройка | Значение |
|-----------|----------|
| **Min SDK** | API 26 (Android 8.0) |
| **Target SDK** | API 34 (Android 14) |
| **Architecture** | ARM64 |
| **Scripting Backend** | IL2CPP |
| **Strip Level** | Medium |
| **Android App Bundle** | ✅ (AAB) |

### iOS

| Настройка | Значение |
|-----------|----------|
| **Min iOS** | 13.0 |
| **Target iOS** | 16.0 |
| **Architecture** | ARM64 |
| **Scripting Backend** | IL2CPP |
| **Strip Level** | Medium |

---

## 🧹 Оптимизация

### Code

- **Object Pooling:** Обязательно для крипов, башен, VFX
- **Coroutine:** Избегать `WaitForSeconds`, использовать кастомный таймер
- **Update:** Не использовать `FindObjectOfType()` в Update
- **Events:** Использовать EventBus для decoupling

### Rendering

- **Occlusion Culling:** Включён
- **Frustum Culling:** Включён
- **GPU Instancing:** Для одинаковых префабов
- **Atlas Sprites:** Всё в 1-2 атласах

### Memory

- **Resources.Load:** ❌ Запрещён
- **Addressables:** ✅ Для загрузки ассетов
- **Unload Unused Assets:** Каждые 60 сек

---

## 📊 Profiler Checkpoints

**Запускать на Low-устройстве (Galaxy A54):**

| Чекпоинт | CPU | GPU | Memory |
|----------|-----|-----|--------|
| **Main Menu** | ≤10 ms | ≤5 ms | ≤200 MB |
| **Gameplay (5 волн)** | ≤20 ms | ≤15 ms | ≤350 MB |
| **Gameplay (10 волн)** | ≤25 ms | ≤20 ms | ≤450 MB |
| **Win/Lose Screen** | ≤10 ms | ≤5 ms | ≤400 MB |

---

## ✅ Checklist для Sprint 1

- [ ] Draw Calls ≤100 (Galaxy A54)
- [ ] FPS ≥30 (Galaxy A54)
- [ ] Memory ≤500 MB
- [ ] APK размер ≤100 MB
- [ ] Object Pooling для крипов
- [ ] Object Pooling для башен
- [ ] URP Simple Lit shader
- [ ] ASTC компрессия текстур
- [ ] IL2CPP + Medium stripping

---

**Агент:** GD (с использованием Unity Mobile Checklist)  
**Дата:** 2026-03-05  
**Статус:** DRAFT v0.1
