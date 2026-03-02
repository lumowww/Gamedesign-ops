# PROJECT CONTEXT

**Владелец:** PM  
**Статус:** ✅ ГОТОВ К РАБОТЕ (v1.0)  
**Последнее обновление:** 2026-03-03

---

## 📋 Проект

| Параметр | Значение |
|----------|----------|
| **Название** | GAMEDEVGD |
| **Версия** | 1.0 |
| **Repository** | https://github.com/lumowww/Gamedesign-ops.git |
| **Дата старта** | 2026-03-02 |
| **Дата релиза v1.0** | 2026-03-03 |
| **Статус** | ✅ ИНИЦИАЛИЗИРОВАН |

---

## 👥 Команда

**6 агентов в Antigravity Workspaces:**

| Workspace | Роль | Статус |
|-----------|------|--------|
| PRODUCER | Game Producer | ✅ Готов |
| PM | Project Manager | ✅ Готов |
| GD | Game Designer | ✅ Готов |
| DEV | Unity Lead Dev (Qwen Code) | ✅ Готов |
| UIUX | UI/UX Designer | ✅ Готов |
| ART | Art Director | ✅ Готов |

---

## 🔧 MCP Unity

**Статус:** ✅ ПОДКЛЮЧЁН И РАБОТАЕТ

| Параметр | Значение |
|----------|----------|
| **Пакет** | `com.gamelovers.mcp-unity@1.2.0` |
| **Порт** | 8090 |
| **AutoStartServer** | true |
| **AllowRemoteConnections** | true |
| **RequestTimeoutSeconds** | 10 |

### Архитектура подключения

```text
Antigravity (MCP client)
    ↕ STDIO
Node.js index.js (StdioServerTransport)
    ↕ WebSocket :8090
Unity Editor (McpUnityServer)
```

**Важно:**
- Node.js `index.js` работает в **STDIO режиме**
- Unity Editor слушает `ws://localhost:8090`
- Порт 8090 открывается **только когда открыт Unity Editor**

### Конфиг MCP для Antigravity Settings

```json
{
  "command": "node",
  "args": ["d:/ASTRA/My project/Library/PackageCache/com.gamelovers.mcp-unity@e4b7e74ad052/Server~/build/index.js"]
}
```

### Проверенные инструменты MCP

- ✅ `get_scene_info` — информация о сцене
- ✅ `get_scenes_hierarchy` — иерархия объектов
- ✅ `get_console_logs` — логи консоли Unity

---

## 📁 Активные сцены

| Сцена | Статус | В сборке |
|-------|--------|----------|
| `Assets/Main.unity` | 📁 В проекте | ❌ |
| `Assets/Scenes/SampleScene.unity` | 📁 В проекте | ✅ |
| `Assets/Settings/Scenes/URP2DSceneTemplate.unity` | 📁 В проекте | ❌ |

**Текущая активная сцена в Editor:** (unsaved) — 1 объект (Main Camera)

---

## 🚀 Как начать работу

### Для нового проекта:

1. **PRODUCER-Workspace:** `/concept [описание игры]`
2. **PM-Workspace:** `/new-project` (после получения Producer Brief)
3. **DEV-Workspace:** Qwen Code автоматически определит роль и задачи

### Для продолжения работы:

1. Прочитать `.gemini/antigravity/brain/task_board.md`
2. Прочитать `.gemini/antigravity/brain/project_context.md`
3. Начать работу согласно активной задаче

---

## 📊 Следующие шаги

- [ ] Запустить `/concept` в PRODUCER-Workspace для старта нового проекта
- [ ] Получить Producer Brief и PROJECT_PIPELINE
- [ ] PM создаст Sprint 0 в task_board.md
