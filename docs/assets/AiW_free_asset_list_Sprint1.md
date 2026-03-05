# AiW — Free Asset List (Sprint 1)
# Файл: docs/assets/AiW_free_asset_list_Sprint1.md
# Проект: Alien in Waders (AiW)
# Спринт: Sprint 1

---

## 📋 Overview

Список бесплатных ассетов с Asset Store и других источников для использования в Sprint 1.

**Бюджет:** $0 (только бесплатные ассеты)

---

## 🎨 3D Модели

### Башни (Placeholder)

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Simple Towers Pack** | Asset Store | [ссылка] | CC0 |
| **Sci-Fi Props** | Sketchfab | [ссылка] | CC BY |
| **Low Poly Towers** | itch.io | [ссылка] | CC0 |

**Альтернатива (самодельные):**
- Использовать простые цилиндры/кубы в Unity
- Добавить цвета: T-001 (красный), T-002 (голубой)
- Polycount: ≤800 tri на башню Lv3

### Крипы

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Simple Ships** | Asset Store | [ссылка] | CC0 |
| **Low Poly Enemies** | Kenney.nl | [ссылка] | CC0 |

**Альтернатива (самодельные):**
- Использовать простые сферы/капсулы
- Добавить движение по тропе (анимация rotation)
- Polycount: ≤300 tri

### Grid / Игровое поле

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Grid Textures** | Poly Haven | [ссылка] | CC0 |
| **Simple Grid** | Asset Store | [ссылка] | CC0 |

---

## ✨ VFX / Particles

### Выстрелы

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Fire VFX** | Asset Store | [ссылка] | CC0 |
| **Ice VFX** | Asset Store | [ссылка] | CC0 |
| **Simple Projectiles** | Kenney.nl | [ссылка] | CC0 |

**Альтернатива (самодельные):**
- Unity Particle System
- Fire: оранжевые частицы, trail renderer
- Ice: голубые частицы, slow motion effect

### Взрывы

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Explosion Pack** | Asset Store | [ссылка] | CC0 |
| **Cartoon Explosions** | itch.io | [ссылка] | CC0 |

### Merge Effect

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Magic Merge** | Asset Store | [ссылка] | CC0 |
| **Glow Effects** | Asset Store | [ссылка] | CC0 |

---

## 🔊 Звуки

### Выстрелы

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Fire Sounds** | Freesound.org | [ссылка] | CC0 |
| **Ice Sounds** | Freesound.org | [ссылка] | CC BY |

### Взрывы

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Explosion SFX** | Kenney.nl | [ссылка] | CC0 |
| **Cartoon Explosions** | Freesound.org | [ссылка] | CC0 |

### UI Звуки

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **UI Sounds Pack** | Asset Store | [ссылка] | CC0 |
| **Button Clicks** | Freesound.org | [ссылка] | CC0 |

### Музыка

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Casual Game Music** | Asset Store | [ссылка] | CC0 |
| **Sci-Fi Ambient** | FreeMusicArchive | [ссылка] | CC BY |

---

## 🖼️ UI / Иконки

### Иконки башен

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Tower Icons** | GameIcons.net | [ссылка] | CC BY |
| **Sci-Fi Icons** | Asset Store | [ссылка] | CC0 |

**Альтернатива (самодельные):**
- Использовать простые формы в Figma
- T-001: огненный треугольник
- T-002: ледяной круг

### Кнопки UI

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Mobile UI Pack** | Asset Store | [ссылка] | CC0 |
| **Simple Buttons** | Kenney.nl | [ссылка] | CC0 |

### Шрифты

| Ассет | Источник | Ссылка | Лицензия |
|-------|----------|--------|----------|
| **Roboto** | Google Fonts | [ссылка] | OFL |
| **Noto Sans** | Google Fonts | [ссылка] | OFL |

---

## 📁 Структура импорта

```
Assets/_ThirdParty/
├── Models/
│   ├── Towers/
│   ├── Creeps/
│   └── Grid/
├── VFX/
│   ├── Fire/
│   ├── Ice/
│   └── Explosions/
├── Audio/
│   ├── SFX/
│   │   ├── Fire/
│   │   ├── Ice/
│   │   └── UI/
│   └── Music/
└── UI/
    ├── Icons/
    └── Buttons/
```

---

## ✅ Checklist для Sprint 1

- [ ] Найти/создать 6 префабов башен (2 типа × 3 уровня)
- [ ] Найти/создать 2 префаба крипов
- [ ] Найти/создать 1 префаб grid-ячейки
- [ ] Найти/создать 3 particle FX (выстрелы + взрыв)
- [ ] Найти/создать 1 merge VFX
- [ ] Найти/создать 5-10 SFX (выстрелы, взрывы, UI)
- [ ] Найти/создать 1 фоновую музыку
- [ ] Найти/создать иконки для UI

---

## 🔗 Полезные ресурсы

| Ресурс | Ссылка |
|--------|--------|
| **Kenney.nl** | https://kenney.nl/ (CC0 ассеты) |
| **Sketchfab** | https://sketchfab.com/ (CC BY) |
| **Freesound** | https://freesound.org/ (звуки) |
| **Google Fonts** | https://fonts.google.com/ (шрифты) |
| **GameIcons.net** | https://game-icons.net/ (иконки) |
| **Poly Haven** | https://polyhaven.com/ (текстуры) |
| **Unity Asset Store** | https://assetstore.unity.com/ (бесплатные) |

---

**Агент:** GD (с использованием skill: asset-store)  
**Дата:** 2026-03-05  
**Статус:** DRAFT v0.1
