---
name: asset-store
description: >
  Поиск и оценка бесплатных ассетов для Unity проекта.
  Активируется при: 'найди ассет', 'бесплатный ассет', 'asset store', 
  'free asset', 'найди спрайт', 'откуда взять', 'где скачать',
  'kenney', 'itch.io', 'open game art', 'ассет листе нужно', 'нужен ассет'.
---

# SKILL: FREE ASSET SEARCH

## Приоритетные источники (отсортированы по качеству)

### 1. Unity Asset Store (Free tier)
URL: https://assetstore.unity.com/?category=all&free=true

**Лучшие бесплатные пакеты 2D:**
- `Kenney Game Assets` — тысячи 2D/3D ассетов, CC0
- `Kay Lousberg` — Cartoon low-poly, CC0
- `Quaternius` — Low-poly 3D, CC0
- `Synty Studios Samples` — иногда выпускают бесплатные паки
- `DOTween (HOTween v2)` — анимации, ОБЯЗАТЕЛЬНО
- `TextMeshPro` — встроен в Unity 6
- `Cinemachine` — встроен в Unity 6
- `Universal Render Pipeline` — встроен

**Бесплатные UI-паки:**
- `Simple UI` различные авторы
- `Casual Game UI` паки

### 2. Kenney.nl
URL: https://kenney.nl/assets

Все ассеты: CC0 (коммерческое использование: ДА, Attribution: НЕ обязательно)

**Лучшие паки для гиперказуальных:**
- Kenney Platformer Pack (500+ спрайтов)
- Kenney UI Pack (кнопки, иконки, фоны)
- Kenney Particle Pack (VFX)
- Kenney Interface Sounds (UI аудио)
- Kenney Music Jingles (музыка)

### 3. Itch.io
URL: https://itch.io/game-assets/free

Поиск: filter by "Free" + "Top rated" + тип

**Популярные авторы:**
- Ansimuz (платформер ассеты)
- Pixel Frog (2D персонажи)
- Cup Nooble (окружение)

### 4. OpenGameArt.org
URL: https://opengameart.org/

Лицензии: CC0, CC-BY (проверять!)

### 5. Freesound.org (только аудио)
URL: https://freesound.org/

## Чеклист перед добавлением ассета

```
□ Лицензия позволяет коммерческое использование?
□ Attribution требуется? (записать в CREDITS.md)
□ Совместим с Unity 6?
□ Стиль соответствует арт-библии?
□ Размер приемлем для мобайла?
□ Путь в проекте определён?
□ Добавлен в asset_registry.md?
```

## Формат записи в asset_registry.md

```markdown
| [ID] | [Название] | [Тип] | [Источник + URL] | [Лицензия] | [Attribution?] | [Статус] | [Путь] |
```

## Запрос к поиску ассета

При поиске ассета всегда уточнять:
1. Тип (спрайт / аудио / шрифт / 3D модель / prefab)
2. Стиль (пиксель / вектор / low-poly / cartoon)
3. Цветовая схема (тёплая / холодная / конкретные цвета)
4. Размер / количество анимаций
5. Лицензионные требования (только CC0 / CC-BY ок / любые бесплатные)
