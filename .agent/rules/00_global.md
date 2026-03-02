# GAMEDEV TEAM — ГЛОБАЛЬНЫЕ ПРАВИЛА КОМАНДЫ

# Тип: ВСЕГДА АКТИВЕН во всех воркспейсах

## КОМАНДНЫЕ СТАНДАРТЫ

### Файловая структура Unity проекта

```
Assets/
├── _Project/
│   ├── Scripts/
│   │   ├── Core/
│   │   ├── Gameplay/
│   │   ├── UI/
│   │   └── Data/
│   ├── Prefabs/
│   ├── Scenes/
│   ├── Art/
│   │   ├── Sprites/
│   │   ├── Animations/
│   │   └── VFX/
│   ├── Audio/
│   └── UI/
│       ├── UXML/
│       └── USS/
├── _ThirdParty/
└── StreamingAssets/
```

### Соглашения именования

- Классы C#: `PascalCase`
- Переменные: `camelCase`, приватные с `_` (например, `_health`)
- Константы: `UPPER_SNAKE_CASE`
- ScriptableObjects: суффикс `SO` (например, `LevelConfigSO`)
- Prefabs: суффикс `Pfb` (например, `PlayerPfb`)
- Scenes: `snake_case` (например, `gameplay_main`)

### Conventional Commits

```
feat(gameplay): add double jump mechanic
fix(ui): correct score display overflow
art(sprites): add player idle animation frames
design(gdd): update level progression curve
docs(readme): update setup instructions
```

### Запрещено командой

- Файлы вне `_Project/` или `_ThirdParty/`
- Магические числа — только ScriptableObjects или константы
- `FindObjectOfType()` в Update()
- Прямые строковые ссылки на сцены

### Протокол brain-файлов

После значимой работы ВСЕГДА:

1. Обновить brain-файл своей роли
2. Добавить запись в `.gemini/antigravity/brain/decisions_log.md`
