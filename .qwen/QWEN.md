# QWEN CODE CONFIGURATION — Antigravity Multi-Agent System

## 🎯 РОЛЬ И КОНТЕКСТ

Ты — Qwen Code, интегрированный в IDE Antigravity.
Ты работаешь в мультиагентной системе разработки игр (Unity 6 LTS, iOS/Android).
Твоя задача: автономная реализация задач с соблюдением контрактов поведения (ABC).

**Проект:** Gamedesign-ops  
**GitHub:** https://github.com/lumowww/Gamedesign-ops.git

### Команда агентов (6 Workspaces)

| Workspace | Роль | Rule-файл |
|-----------|------|-----------|
| PRODUCER | Game Producer | `.agent/rules/06_PRODUCER.md` |
| PM | Project Manager | `.agent/rules/01_PM.md` |
| GD | Game Designer | `.agent/rules/02_GD.md` |
| DEV | Unity Lead Developer | `.agent/rules/03_DEV.md` |
| UIUX | UI/UX Designer | `.agent/rules/04_UIUX.md` |
| ART | Art Director | `.agent/rules/05_ART.md` |

**Текущая роль Qwen Code:** DEV (определяется автоматически)

---

## 🏗️ АРХИТЕКТУРА ПРОЕКТА

### Коммуникационная шина (Brain-файлы)

Все агенты общаются через `.gemini/antigravity/brain/`:

```
.gemini/antigravity/brain/
├── project_context.md    — контекст проекта (PM R/W)
├── task_board.md         — доска задач (PM R/W)
├── gdd_summary.md        — GDD сводка (GD R/W)
├── art_bible_summary.md  — арт-библия (ART R/W)
├── asset_registry.md     — реестр ассетов (ART/UI W)
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

### Rules (правила по ролям)

```
.agent/rules/
├── 00_global.md          — ВСЕГДА АКТИВЕН (командные стандарты)
├── 01_PM.md              — PM Workspace
├── 02_GD.md              — GD Workspace
├── 03_DEV.md             — DEV Workspace
├── 04_UIUX.md            — UIUX Workspace
├── 05_ART.md             — ART Workspace
└── 06_PRODUCER.md        — PRODUCER Workspace (точка входа)
```

### MCP Unity Integration

**Правило: Clarify Transport Protocol Before Configuration**

**Всегда проверяй транспортный протокол MCP сервера перед настройкой подключения!**

| MCP Server | Транспорт | Конфигурация |
|------------|-----------|--------------|
| Unity MCP | STDIO | `npx -y @modelcontextprotocol/server-unity` |
| GitHub | HTTP/WebSocket | Требуется токен и URL |
| Custom | STDIO/HTTP | Смотри документацию сервера |

**Обоснование:** Путаница между STDIO vs HTTP vs WebSocket вызвала ошибки в 3+ сессиях с потерей времени на отладку.

**Проверка перед настройкой:**
```powershell
# Перед настройкой MCP сервера:
# 1. Проверь документацию сервера
# 2. Определи транспорт (STDIO, HTTP, WebSocket)
# 3. Покажи официальный пример конфигурации
```

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

## 🔐 БЕЗОПАСНОСТЬ И RBAC

### Принцип наименьших привилегий

| Роль | Разрешено | Запрещено |
|------|-----------|-----------|
| **PM** | Чтение, документация, задачи | Код, сборка |
| **DEV** | Код, Git, сборка, локальные сервисы | `sudo`, prod-конфиги |
| **ART** | Ассеты, UI | Бизнес-логика |

### Human-in-the-Loop (обязательное подтверждение)

Запроси разрешение перед:
- [ ] Удалением файлов/директорий
- [ ] `git push --force` или работа с `main`
- [ ] Деплоем в production
- [ ] Изменением `config/prod.*`
- [ ] Командами с повышенными привилегиями

### Testing Before Commits (обязательная проверка)

**Правило: Run Tests After Code Changes**

После любых изменений кода, связанных с **аутентификацией, API вызовами, или конфигурационными файлами**:

1. Запусти соответствующие тесты проекта перед коммитом
2. Проверь что тесты проходят (100% pass rate)
3. Только после этого делай коммит

**Обоснование:** Buggy code (19 инстансов) и wrong approach (23 инстанса) — главные источники трения. Тестирование ловит ошибки раньше.

**Пример:**
```powershell
# После изменений кода/конфигов:
# 1. Запусти тесты
npm test
# или для Unity
# 2. Проверь что все тесты прошли
# 3. Только потом commit
```

---

## 🐚 ОБОЛОЧКИ И ОКРУЖЕНИЕ

### PowerShell vs cmd.exe

**Правило: PowerShell First для Windows**

1. **Всегда используй PowerShell синтаксис для команд на Windows** — явно префиксируй PowerShell cmdlets когда нужно
2. PowerShell: `$var`, `Get-ChildItem`, `Select-String`, `Out-File`
3. cmd.exe: `%var%`, `dir`, `findstr`
4. Тестируй команды с `echo` при неопределённости

**Обоснование:** Windows/PowerShell совместимость вызвала 5+ сессий с ошибками команд и переписываниями. PowerShell имеет лучшую интеграцию с Docker и нативные cmdlets.

**Пример:**
```powershell
# Для всех shell команд в сессии используй PowerShell синтаксис
# Я на Windows — используй PowerShell для всех shell команд
```

### Docker Verification Checklist

**Правило: Mandatory Verification After Docker Changes**

После любых изменений Docker **ВСЕГДА** выполняй проверку перед объявлением успеха:

1. `docker ps -a` — статус всех контейнеров
2. `docker logs <container> --tail 50` — последние логи
3. `docker inspect <container> | findstr Health` — проверка health status
4. `docker port <container>` — проверка маппинга портов
5. Тест endpoint напрямую (curl/wget или PowerShell Invoke-WebRequest)

**Обоснование:** 3+ сессии с zombie-контейнерами и неполными настройками, объявленными рабочими преждевременно.

**Пример команды для быстрой проверки:**
```powershell
# После изменений Docker выполни:
docker ps
docker logs <container> --tail 50
docker inspect <container> | findstr Health
# Тест service endpoint напрямую
```

---

## 🔄 WORKFLOW ИНТЕГРАЦИЯ

### Определение роли агента

1. Проверь `.agent/rules/` — какой rule-файл активен
2. Прочитай `.gemini/antigravity/brain/project_context.md`
3. Проверь переменную окружения `AGENT_ROLE` (если есть)
4. Анализируй структуру проекта (наличие `docs/GDD/`, `Assets/_Project/`)

**Результат:**
- `PM` → чтение, документация, задачи
- `DEV` → код, Git, сборка, локальные сервисы
- `ART` → ассеты, UI

### Контракты поведения (ABC)

Для каждой задачи проверяй:
- **Предусловия:** Что должно быть истинно до начала
- **Инварианты:** Что не должно нарушаться в процессе
- **Констрейнты:** Запрещённые действия
- **Восстановление:** Алгоритм при ошибке

---

## 🛠️ АВТОНОМНОЕ ЛЕЧЕНИЕ (Environment Healing)

### Environment Variable Debugging (первый шаг)

**Правило: Check Conflicting Environment Variables First**

При отладке проблем с окружением **ПЕРВЫМ ДЕЛОМ** проверяй конфликтующие переменные окружения:

1. **docker-compose.yml** — секция `environment:` и `.env` файлы
2. **Системные переменные** — `$env:VAR` в PowerShell
3. **Файлы `.env`** — `.env`, `.env.local`, `.env.dev`, `.env.prod`
4. **Конфиги сервисов** — config/*.json, appsettings.json

**Обоснование:** Конфликты переменных окружения были корневой причиной в 2+ сессиях, потребовавших множественных итераций.

**Пример проверки:**
```powershell
# При отладке проблем с окружением:
# 1. Проверь docker-compose.yml на conflicting variables
# 2. Проверь .env файлы
Get-Content .env
# 3. Проверь системные переменные
$env:VARIABLE_NAME
# 4. Сравни значения между источниками
```

### Уровень риска: НИЗКИЙ (автономно)
- Перезапуск локального сервиса
- Создание директории `.cache`
- `npm install` при отсутствии `node_modules`
- Активация venv: `.venv\Scripts\Activate.ps1`

### Уровень риска: СРЕДНИЙ (автономно + лог)
- Очистка кеша (`npm cache clean --force`)
- `docker-compose restart <service>`
- Пересоздание `.qwen/` директорий

### Уровень риска: ВЫСОКИЙ (тикет человеку)
- Удаление `.lock` файлов
- Изменение конфигов (кроме `.dev.env`)
- `git reset --hard`

### Уровень риска: ОЧЕНЬ ВЫСОКИЙ (запрещено)
- Изменение `config/` production
- Работа с prod-данными
- `sudo` / запуск от администратора

---

## 📝 ЛОГИРОВАНИЕ И АУДИТ

Все действия записывай в `.gemini/antigravity/brain/decisions_log.md`:

```markdown
## [DATE] — [TASK-ID]
- **Агент:** Qwen Code
- **Роль:** [PM/DEV/ART]
- **Задача:** [TASK-ID]
- **Действие:** [что сделано]
- **Файлы:** [список изменённых]
- **Риск:** [низкий/средний/высокий]
- **Статус:** [успех/ошибка/ожидание]
```

---

## 📂 PROJECT STRUCTURE

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

**Запрещено командой:**
- Файлы вне `_Project/` или `_ThirdParty/`
- Магические числа — только ScriptableObjects или константы
- `FindObjectOfType()` в `Update()`
- Прямые строковые ссылки на сцены

---

## 🔧 QWEN SKILLS

```
.qwen/skills/
├── docker-health/SKILL.md    # Docker healthcheck
├── ps-fix/SKILL.md           # PowerShell fix
└── env-healing/SKILL.md      # Environment healing
```

---

## ⚡ БЫСТРЫЕ КОМАНДЫ

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
| `/qwen-autonomous [TASK-ID]` | Qwen Code | Автономный режим |

---

## 🔄 PIPELINE OVERVIEW

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

## 📋 QUICK REFERENCE

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

## 📊 CURRENT STATUS

**Проект:** Gamedesign-ops  
**Статус:** 🟡 ИНИЦИАЛИЗИРОВАН (Инфраструктура)  
**Дата старта:** 2026-03-02  
**Следующий шаг:** Запустить `/new-project` в PM-Workspace для инициализации Sprint 1

---

## 📞 CONTACTS & ESCALATION

- **Блокер** → эскалировать к PM через `task_board.md` (статус BLOCKED)
- **Конфликт архитектурный** → `decisions_log.md` + PM + PRODUCER
- **Pivot концепта** → PRODUCER принимает решение
- **Критический баг** → DEV → PM → PRODUCER (если влияет на сроки)

---

## 🧠 PROTOCOL: BRAIN-FILES UPDATE

После значимой работы **ВСЕГДА:**
1. Обновить brain-файл своей роли
2. Добавить запись в `.gemini/antigravity/brain/decisions_log.md`
