---
name: mobile-design-checklist
description: >
  Чек-лист ограничений и best practices для мобильного геймдева на Unity.
  Активируется при: 'mobile design', 'performance', 'Unity mobile',
  'оптимизация', 'мобильная разработка'.
---

# SKILL: MOBILE DESIGN CHECKLIST

## Unity Mobile Constraints

### Performance Budget

| Метрика | Target (Low-end) | Target (Mid-range) | Блокер если |
|---------|------------------|-------------------|-------------|
| **FPS** | 30 stable | 60 stable | < 25 FPS |
| **Draw Calls** | < 100 | < 200 | > 300 |
| **Triangles** | < 50K | < 100K | > 150K |
| **RAM** | < 200 MB | < 400 MB | > 500 MB |
| **APK Size** | < 50 MB | < 100 MB | > 150 MB |
| **Load Time** | < 3 сек | < 5 сек | > 10 сек |
| **Battery** | < 5% / 30 мин | < 10% / 30 мин | > 15% / 30 мин |

---

### Input Design

**Touch Controls:**
- [ ] Минимальный размер touch target: 44x44 points (iOS HIG)
- [ ] Расстояние между кнопками: ≥ 8 points
- [ ] Поддержка multi-touch (если нужно)
- [ ] Нет overlap с системными зонами (notch, home indicator)

**Gesture Design:**
- [ ] Tap: < 200ms
- [ ] Long press: 300-500ms
- [ ] Swipe: минимальная дистанция 30 points
- [ ] Pinch: коэффициент 0.5-2.0

**Feedback:**
- [ ] Visual feedback на tap: < 100ms
- [ ] Haptic feedback: где уместно (не спамить)
- [ ] Audio feedback: не критичен для gameplay

---

### Screen Real Estate

**Priority Zones:**
```
┌─────────────────────────────────┐
│ ⚠️ System Zone (notch/status)  │
├─────────────────────────────────┤
│                                 │
│  🔴 High Priority (центр)       │
│  - Core gameplay elements       │
│  - Primary action buttons       │
│                                 │
│  🟡 Medium Priority (края)      │
│  - Secondary UI                 │
│  - Meta information             │
│                                 │
├─────────────────────────────────┤
│ ⚠️ System Zone (home indicator) │
└─────────────────────────────────┘
```

**Text Legibility:**
- [ ] Минимальный размер шрифта: 14sp (Android) / 17pt (iOS)
- [ ] Контраст текста: ≥ 4.5:1 (WCAG AA)
- [ ] Не более 3 размеров шрифта в игре

---

### Session Design

**Для гиперказуальных:**
- [ ] Session length: 1-5 минут
- [ ] Можно прервать в любой момент
- [ ] Быстрый рестарт: < 3 секунд
- [ ] Нет long cutscenes (или skipable)

**Для гибрид-казуальных:**
- [ ] Session length: 5-15 минут
- [ ] Checkpoint system
- [ ] Energy system: max 3-5 часов regen
- [ ] Offline progress (если уместно)

---

### Monetization Placement

**Ads:**
- [ ] Rewarded: добровольные, reward ясен
- [ ] Interstitial: не чаще 1 per 3 минуты
- [ ] Interstitial: не прерывает геймплей
- [ ] Interstitial: есть close button через 5 сек

**IAP:**
- [ ] Первый оффер: после первого win
- [ ] Prices: локализованы
- [ ] Restore purchases кнопка
- [ ] Нет paywalls в первых 5 минутах (для HC)

---

### Performance Optimization

**Rendering:**
- [ ] Batch sprites (same atlas)
- [ ] Use Sprite Atlas
- [ ] Disable unused cameras
- [ ] Use GPU instancing (если 3D)
- [ ] LOD для 3D объектов

**Scripts:**
- [ ] Нет `FindObjectOfType()` в `Update()`
- [ ] Нет `GetComponent()` в `Update()`
- [ ] Кэшировать ссылки в `Awake()`/`Start()`
- [ ] Использовать `ObjectPool` для частых instantiate/destroy

**Assets:**
- [ ] Texture compression: ASTC (Android), PVRTC (iOS)
- [ ] Audio compression: Vorbis
- [ ] Unused assets: не включать в build

---

### Testing Checklist

**Devices для теста:**
- [ ] Low-end Android (2GB RAM, 4 ядра)
- [ ] Mid-range Android (4GB RAM, 8 ядер)
- [ ] iPhone (последние 3 поколения)
- [ ] iPad (если поддерживается)

**Network Conditions:**
- [ ] WiFi (стабильный)
- [ ] 4G (средний)
- [ ] 3G (медленный)
- [ ] Offline mode

**Edge Cases:**
- [ ] Low battery mode
- [ ] Low storage warning
- [ ] Incoming call interruption
- [ ] App background/foreground

---

## GDD Integration

Добавить в GDD секцию:

```markdown
## Mobile Design Constraints [ID:MOBILE]

### Performance Budget
- FPS: [target]
- Draw Calls: < [N]
- RAM: < [N] MB
- APK Size: < [N] MB

### Input
- Controls: [tap/hold/swipe]
- Touch targets: ≥ [N] points

### Session
- Length: [N]-[N] минут
- Interruptible: [да/нет]
- Restart time: < [N] сек

### Monetization
- Ads: [placement]
- IAP: [first offer timing]
```

---

## Quick Reference

### Do's ✅
- Простые тап/свайп контролы
- Сессии 1-5 минут
- Ясный visual feedback
- Оптимизированные спрайты
- Audio опционален

### Don'ts ❌
- Сложные multi-button комбинации
- Сессии > 10 минут без checkpoint
- Длинные cutscenes без skip
- Более 200 draw calls
- Paywall в первые 5 минут
