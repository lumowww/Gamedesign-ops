# GAMEDEV TEAM — ГЛОБАЛЬНЫЕ ПРАВИЛА КОМАНДЫ
# Версия: 2.0 | Обновлено: 2026-03-03
# Тип: ВСЕГДА АКТИВЕН во всех воркспейсах

---

## 👥 РОЛИ И ОБЯЗАННОСТИ (RESPONSIBILITIES)

**Все агенты команды:**
- Следить за SSOT файлами своей области
- Соблюдать жизненный цикл задач
- Создавать A2A артефакты при передаче работы
- Вести brain-файлы и decisions_log

---

## 🧭 SSOT: ЕДИНАЯ ТОЧКА ПРАВДЫ

**По дизайну игры:** `.gemini/antigravity/brain/gdd_summary.md` (владелец: GD)
**По задачам:** `.gemini/antigravity/brain/task_board.md` (владелец: PM)
**По ассетам:** `.gemini/antigravity/brain/asset_registry.md` (владелец: ART)

Если твоя работа противоречит SSOT файлу своей области → **стоп, задай вопрос владельцу**.
Не интерпретируй самостоятельно. Не делай «как кажется логичным».

---

## 🔄 ЖИЗНЕННЫЙ ЦИКЛ ЗАДАЧИ

```
TODO → IN_PROGRESS → REVIEW → [GD_GATE] → DONE
```

**GD_GATE — обязательный шаг** для задач с тегами:
`GAMEPLAY` `ECONOMY` `UX` `FTUE` `BALANCE` `LIVEOPS`

**GD_GATE — пропускается** для:
`CI/CD` `BUILD` `DEVOPS` `LINT` `DEPENDENCIES` `PLACEHOLDER_ART`

Переход REVIEW → DONE без GD Gate для DESIGN задач = **нарушение протокола**.

---

## 📦 A2A АРТЕФАКТЫ

Когда один агент завершает работу, влияющую на другого — создаётся артефакт:

```
.agent/artifacts/[FROM]_to_[TO]_[TASK-ID].md
```

Примеры:
- `GD_to_DEV_TASK-042.md` — ТЗ от GD для DEV
- `GD_to_UIUX_TASK-015.md` — экранный флоу и требования
- `GD_to_ART_TASK-007.md` — список ассетов с контекстом
- `UIUX_to_GD_note_TASK-015.md` — UX проблема, требует ответа GD
- `ART_to_DEV_TASK-007.md` — ассет готов, параметры интеграции

**Правило получателя:** получил артефакт → прочитал ПЕРЕД началом работы.
**Правило создателя:** создал артефакт → уведомил PM (он создаст задачу).

---

## 📁 ФАЙЛОВАЯ СТРУКТУРА UNITY ПРОЕКТА

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

---

## ✍️ СОГЛАШЕНИЯ ИМЕНОВАНИЯ

- Классы C#: `PascalCase`
- Переменные: `camelCase`, приватные с `_` (например, `_health`)
- Константы: `UPPER_SNAKE_CASE`
- ScriptableObjects: суффикс `SO` (например, `LevelConfigSO`)
- Prefabs: суффикс `Pfb` (например, `PlayerPfb`)
- Scenes: `snake_case` (например, `gameplay_main`)
- A2A артефакты: `[FROM]_to_[TO]_[TASK-ID].md`
- GD Review артефакты: `GD_review_[TASK-ID].md`

---

## 📝 CONVENTIONAL COMMITS

```
feat(gameplay): add double jump mechanic
fix(ui): correct score display overflow
art(sprites): add player idle animation frames
design(gdd): update level progression curve
docs(readme): update setup instructions
chore(infra): update PM rule to v2.0
```

---

## ⛔ ЗАПРЕЩЕНО КОМАНДОЙ

- Файлы вне `_Project/` или `_ThirdParty/`
- Магические числа в коде — только ScriptableObjects или константы
- `FindObjectOfType()` в `Update()`
- Прямые строковые ссылки на сцены
- Изменять balance constants в SO без согласования с GD
- Закрывать DESIGN задачи без GD Gate
- Создавать GAMEPLAY/ECONOMY/UX задачи без GDD anchor `[ID:BLOCK]`

---

## 🔔 ПРОТОКОЛ BRAIN-ФАЙЛОВ

После значимой работы ВСЕГДА:

1. Обновить brain-файл своей области (если ты владелец)
2. Создать A2A артефакт для зависимых агентов (если твоя работа влияет на них)
3. Добавить запись в `.gemini/antigravity/brain/decisions_log.md`:

```markdown
## [ДАТА ЧЧ:ММ] — [КРАТКОЕ НАЗВАНИЕ]
- **Агент:** [роль]
- **Задача:** [TASK-ID]
- **Решение:** [суть одной строкой]
- **Файлы:** [список изменённых]
- **Статус:** DONE / PENDING
```

---

## 🗣️ МАТРИЦА КОММУНИКАЦИИ

| От кого | К кому | Как |
|---------|--------|-----|
| PRODUCER → GD | Передача брифа | `PRODUCER_BRIEF.md` + обязательные поля |
| PM → Агент | Новая задача | `task_board.md` TASK-XXX |
| GD → Агент | ТЗ | `GD_to_[ROLE]_TASK-XXX.md` в `.agent/artifacts/` |
| DEV → GD | Задача выполнена, нужен review | `/design-review TASK-XXX` |
| UIUX → GD | UX проблема в дизайне | `UIUX_to_GD_note_TASK-XXX.md` |
| ART → GD | Ассет не соответствует GDD | `ART_to_GD_note_TASK-XXX.md` |
| Агент → PM | Задача выполнена | `/done TASK-XXX` |

---

## 🎓 СЛОВАРЬ КОМАНДЫ

| Термин | Значение |
|--------|----------|
| `GDD anchor` | Ссылка `[ID:BLOCK_NAME]` на блок GDD |
| `GD Gate` | Design review от GD перед DONE для DESIGN задач |
| `A2A артефакт` | Файл ТЗ/уведомления между агентами |
| `SSOT` | Single Source of Truth — авторитетный источник правды |
| `brain/` | Summary-файлы для быстрого контекста агентов |
| `[STATUS:DRAFT/FINAL]` | Зрелость документа или блока |
| `[HYPOTHESIS]` | Данные без верификации — требуют подтверждения |
| `[FACT]` | Верифицированные данные из документов или аналитики |
| `P0/P1/P2` | Приоритет задачи (P0 = блокирует milestone) |
| `PLACEHOLDER` | Временный ассет, DEV может использовать |
| `FINAL` | Финальный ассет, прошедший GD review |
