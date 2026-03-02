---
name: unity-mcp
description: >
  Управление Unity Editor через MCP-сервер. Активируется при: 'создай объект',
  'добавь компонент', 'открой сцену', 'запусти PlayMode', 'прочитай консоль Unity',
  'проверь иерархию', 'найди ассет в проекте', 'запусти тесты Unity', 'создай prefab',
  'create gameobject', 'Unity scene', 'unity console', 'unity editor'.
---

# SKILL: UNITY MCP INTEGRATION

## Инструменты READ (всегда безопасно)

- `get_scene_hierarchy` — структура текущей сцены
- `get_console_logs` — логи Unity Console
- `get_assets` — поиск ассетов по имени/типу
- `get_gameobject_details` — подробности об объекте
- `get_project_settings` — настройки проекта

## Инструменты CREATE (требует плана)

- `create_gameobject` — создать объект или из prefab
- `create_script` — создать C# скрипт
- `create_prefab` — создать prefab из объекта сцены

## Инструменты MODIFY (подтвердить!)

- `modify_component` — изменить значения компонента
- `add_component` — добавить компонент
- `remove_component` — удалить (ОСТОРОЖНО!)
- `set_transform` — позиция/ротация/масштаб
- `execute_menu_item` — команда Unity-меню

## Управление редактором

- `set_playmode` — запуск/остановка Play Mode
- `run_tests` — Unity Test Runner
- `refresh_asset_database` — обновить Asset DB

## Обязательный порядок

1. READ → get_scene_hierarchy + get_console_logs
2. PLAN → артефакт с перечнем изменений
3. CONFIRM → "Планирую: [список]. Подтверждаете?"
4. EXECUTE → по одному шагу
5. VERIFY → get_console_logs после каждого изменения
6. DOCUMENT → decisions_log.md

## Архитектура подключения

```text
Antigravity IDE (MCP-клиент)
    ↕ STDIO
node index.js (StdioServerTransport) — нет своего порта!
    ↕ WebSocket ws://localhost:8090
Unity Editor (McpUnityServer открыт)
```

## Конфиг пакета (этот проект)

```text
Пакет:     com.gamelovers.mcp-unity@e4b7e74ad052
Режим:     STDIO (StdioServerTransport)
Unity WS:  ws://localhost:8090 (открывается Unity Editor)
index.js:  Library\PackageCache\com.gamelovers.mcp-unity@e4b7e74ad052\Server~\build\index.js
```

### MCP конфиг для Antigravity Settings

```json
{
  "command": "node",
  "args": ["d:\\ASTRA\\My project\\Library\\PackageCache\\com.gamelovers.mcp-unity@e4b7e74ad052\\Server~\\build\\index.js"]
}
```

### Предусловия для работы

1. **Unity Editor открыт** — иначе WebSocket :8090 не поднят
2. **Конфиг вставлен** в Antigravity → Settings → MCP Servers
3. Сервер стартует автоматически при запуске Antigravity

## Частые ошибки

| Ошибка | Решение |
|--------|---------|
| `Connection refused :8090` | Unity Editor закрыт — открой проект в Unity |
| MCP tools не отвечают | Проверь что конфиг вставлен в Antigravity MCP Settings |
| Compile errors в Unity | get_console_logs → исправить → refresh_asset_database |
| Missing prefab | get_assets("PrefabName") → найти правильный путь |
| PlayMode не стартует | Сначала исправить compile errors |
