# QWEN.md — Project Context for Qwen Code

## Project Overview

**Gamedesign-ops** — мультиагентная система разработки мобильных гиперказуальных игр на Unity 6 LTS.

Это инфраструктурный проект для команды из 6 AI-агентов, работающих через **Antigravity IDE** с разделением на Workspaces:

| Workspace | Роль | Rule-файл |
|-----------|------|-----------|
| PRODUCER | Game Producer | `.agent/rules/06_PRODUCER.md` |
| PM | Project Manager | `.agent/rules/01_PM.md` |
| GD | Game Designer | `.agent/rules/02_GD.md` |
| DEV | Unity Lead Developer | `.agent/rules/03_DEV.md` |
| UIUX | UI/UX Designer | `.agent/rules/04_UIUX.md` |
| ART | Art Director | `.agent/rules/05_ART.md` |

**GitHub:** https://github.com/lumowww/Gamedesign-ops.git

---

## Architecture

### Коммуникационная шина
Все агенты общаются через **brain-файлы** в `.gemini/antigravity/brain/`:

```
.gemini/antigravity/brain/
├── project_context.md    — контекст проекта (PM R/W)
├── task_board.md         — доска задач (PM R/W)
├── gdd_summary.md        — GDD сводка (GD R/W)
├── art_bible_summary.md  — арт-библия (ART R/W)
├── asset_registry.md     — реестр ассетов (ART/UI R/W)
└── decisions_log.md      — лог решений (ALL R/W)
```

### Workflows (слэш-команды)
```
.agent/workflows/
├── new-project.md        — /new-project (PM инициализация)
├── concept.md            — /concept (PRODUCER старт)
├── daily-sync.md         — /sync (ежедневная синхронизация)
├── handoff.md            — /handoff (передача контекста)
├── resume.md             — /resume (восстановление контекста)
├── task-done.md          — /done (завершение задачи)
├── asset-request.md      — /asset-request (запрос ассета)
├── gdd-update.md         — /gdd-update (обновление GDD)
└── qwen-autonomous.md    — /qwen-autonomous (автономный режим)
```

### MCP Unity Integration
**Пакет:** `com.gamelovers.mcp-unity` (установлен)

**Архитектура:**
```
Antigravity (MCP client)
    ↕ STDIO
Node.js index.js (StdioServerTransport)
    ↕ WebSocket :8090
Unity Editor (McpUnityServer)
```

**Конфиг для Antigravity Settings:**
```json
{
  "command": "node",
  "args": ["d:\\ASTRA\\My project\\Library\\PackageCache\\com.gamelovers.mcp-unity@e4b7e74ad052\\Server~\\build\\index.js"]
}
```

**Настройки MCP Unity:**
- Порт: `8090`
- AutoStartServer: `true`
- AllowRemoteConnections: `false`

---

## Project Structure

```
D:\ASTRA\My project\
├── .agent/                     # Агентская конфигурация
│   ├── rules/                  # Rule-файлы ролей (00-06)
│   ├── workflows/              # Workflow-протоколы
│   ├── skills/                 # Навыки агентов
│   └── artifacts/              # Артефакты коммуникации
├── .gemini/antigravity/brain/  # Коммуникационная шина
├── .qwen/                      # Qwen Code конфигурация
│   ├── QWEN.md                 # Этот файл
│   ├── skills/                 # Qwen навыки
│   └── tasks/                  # Трекер задач Qwen
├── Assets/                     # Unity ассеты
│   ├── _Project/               # Основной код проекта
│   ├── _ThirdParty/            # Сторонние ассеты
│   └── ...
├── docs/                       # Документация
│   ├── PRODUCER_BRIEF.md       # Бриф продюсера
│   ├── PROJECT_PIPELINE.md     # Пайплайн проекта
│   ├── GDD/                    # GDD документы
│   ├── ArtBible/               # Арт-библия
│   └── UISpec/                 # UI спецификации
├── Packages/                   # Unity пакеты
├── ProjectSettings/            # Unity настройки проекта
└── README.md                   # README
```

### Unity Project Conventions

**Структура Assets:**
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

**Соглашения именования:**
- Классы C#: `PascalCase`
- Переменные: `camelCase`, приватные с `_` (например, `_health`)
- Константы: `UPPER_SNAKE_CASE`
- ScriptableObjects: суффикс `SO` (например, `LevelConfigSO`)
- Prefabs: суффикс `Pfb` (например, `PlayerPfb`)
- Сцены: `snake_case` (например, `gameplay_main`)

**Conventional Commits:**
```
feat(gameplay): add double jump mechanic
fix(ui): correct score display overflow
art(sprites): add player idle animation frames
design(gdd): update level progression curve
docs(readme): update setup instructions
```

---

## Qwen Code Configuration

### Роль и контекст
Qwen Code интегрирован в Antigravity IDE для автономной реализации задач.

**Текущая роль:** DEV (определяется автоматически по структуре проекта и активным rule-файлам)

### RBAC и безопасность

| Уровень риска | Действия | Требуется подтверждение |
|---------------|----------|------------------------|
| НИЗКИЙ | venv, npm install, docker restart | ❌ |
| СРЕДНИЙ | cache clean, docker-compose restart | ❌ + лог |
| ВЫСОКИЙ | .lock файлы, конфиги | ✅ |
| ОЧЕНЬ ВЫСОКИЙ | prod конфиги, git reset --hard | 🚫 ЗАПРЕЩЕНО |

**Human-in-the-Loop — обязательно подтверждение перед:**
- Удалением файлов/директорий
- `git push --force` или работа с `main`
- Деплоем в production
- Изменением `config/prod.*`
- Командами с повышенными привилегиями

### Qwen Skills

```
.qwen/skills/
├── docker-health/SKILL.md    # Docker healthcheck
├── ps-fix/SKILL.md           # PowerShell fix
└── env-healing/SKILL.md      # Environment healing
```

### Environment Healing

**Автоматическое восстановление (риск: НИЗКИЙ):**
- Перезапуск локального сервиса
- Создание директории `.cache`
- `npm install` при отсутствии `node_modules`

**Автоматическое + лог (риск: СРЕДНИЙ):**
- Очистка кеша (`npm cache clean --force`)
- `docker-compose restart <service>`

**Требует подтверждения (риск: ВЫСОКИЙ):**
- Удаление `.lock` файлов
- Изменение конфигов (кроме `.dev.env`)

**Запрещено:**
- Изменение `config/` production
- `git reset --hard`
- Работа с prod-данными

---

## Building and Running

### Unity Project Setup

1. **Открыть проект в Unity 6 LTS**
2. **MCP Unity уже установлен** через Packages/manifest.json
3. **Настроить MCP в Antigravity Settings:**
   ```json
   {
     "command": "node",
     "args": ["d:\\ASTRA\\My project\\Library\\PackageCache\\com.gamelovers.mcp-unity@e4b7e74ad052\\Server~\\build\\index.js"]
   }
   ```

### Запуск нового проекта

1. **PRODUCER:** `/concept [описание игры]` — старт концепта
2. **PRODUCER:** Создаёт `docs/PRODUCER_BRIEF.md` + `docs/PROJECT_PIPELINE.md`
3. **PM:** `/new-project` — инициализация Sprint 0
4. **Агенты:** Выполняют задачи из `task_board.md`

### Ключевые команды

| Команда | Кто использует | Описание |
|---------|---------------|----------|
| `/concept [текст]` | Пользователь → PRODUCER | Старт нового проекта |
| `/report [AGENT]` | PRODUCER | Запрос отчёта у агента |
| `/milestone [N]` | PRODUCER | Контрольная точка |
| `/market [жанр]` | PRODUCER | Анализ рынка (Perplexity) |
| `/sync` | PM | Ежедневная сводка |
| `/done TASK-ID` | Все агенты | Задача выполнена |
| `/handoff` | Все агенты | Передача контекста |
| `/resume` | Все агенты | Восстановление контекста |
| `/asset-request [тип] [описание]` | Все агенты | Запрос ассета |

---

## Development Practices

### Протокол brain-файлов
После значимой работы **ВСЕГДА:**
1. Обновить brain-файл своей роли
2. Добавить запись в `.gemini/antigravity/brain/decisions_log.md`

### Формат логирования
```markdown
## [DATE] — [TASK-ID]
- **Агент:** [имя]
- **Роль:** [PM/DEV/ART/GD/UIUX/PRODUCER]
- **Действие:** [описание]
- **Файлы:** [список изменённых]
- **Риск:** [низкий/средний/высокий]
- **Статус:** [успех/ошибка/ожидание]
```

### Запрещено командой
- Файлы вне `_Project/` или `_ThirdParty/`
- Магические числа — только ScriptableObjects или константы
- `FindObjectOfType()` в `Update()`
- Прямые строковые ссылки на сцены

---

## Pipeline Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    ANTIGRAVITY AGENT MANAGER                    │
├──────────┬──────────┬──────────┬──────────┬──────────┬─────────┤
│ PRODUCER │    PM    │    GD    │   DEV    │  UI/UX   │   ART   │
└────┬─────┴────┬─────┴────┬─────┴────┬─────┴────┬─────┴────┬────┘
     │          │          │          │          │          │
     │    ┌─────▼──────────▼──────────▼──────────▼──────────▼───┐
     │    │         .gemini/antigravity/brain/                   │
     │    │  project_context.md, task_board.md, decisions_log.md │
     │    └──────────────────────────────────────────────────────┘
     │
     │    ┌──────────────────────────────────────────────────────┐
     └───►│                    docs/                             │
          │  PRODUCER_BRIEF.md, PROJECT_PIPELINE.md, GDD/, ...   │
          └──────────────────────────────────────────────────────┘
```

### Фазы проекта

**ФАЗА 0: КОНЦЕПЦИЯ (PRODUCER)**
- Анализ концепта → Market Analysis → Feasibility Check
- Producer Brief → Pipeline → "Запускай"

**ФАЗА 1: SPRINT 0 — SETUP (PM)**
- GDD v0.1, Art Direction, Unity Setup

**ФАЗА 2: SPRINTS 1-3 — РАЗРАБОТКА (PM)**
- Core Mechanic → Full Loop → GO/NO-GO

**ФАЗА 3: POST-PROTOTYPE**
- GO → Test Prep / NO-GO → Pivot Session

---

## Quick Reference

### PowerShell команды (Windows)
```powershell
# Проверка пути
Test-Path <path>

# Список файлов
Get-ChildItem <dir>

# Создание файла
New-Item -Path <file> -ItemType File -Force

# Чтение файла
Get-Content <file>

# Запись в файл
Add-Content -Path <file> -Value "текст"
```

### Git команды
```powershell
git status
git add .
git commit -m "feat(scope): description"
git push origin main
```

### Docker healthcheck
```powershell
docker ps
docker inspect --format='{{.State.Health.Status}}' <container>
docker logs <container> --tail 50
```

---

## Current Status

**Проект:** Gamedesign-ops  
**Статус:** 🟡 ИНИЦИАЛИЗИРОВАН (Инфраструктура)  
**Дата старта:** 2026-03-02  
**Следующий шаг:** Запустить `/new-project` в PM-Workspace для инициализации Sprint 1

---

## Contacts & Escalation

- **Блокер** → эскалировать к PM через `task_board.md` (статус BLOCKED)
- **Конфликт архитектурный** → `decisions_log.md` + PM + PRODUCER
- **Pivot концепта** → PRODUCER принимает решение
- **Критический баг** → DEV → PM → PRODUCER (если влияет на сроки)
