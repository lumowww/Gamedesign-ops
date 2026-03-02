# PROJECT CONTEXT

Владелец: PM | Статус: 🔴 НЕ ИНИЦИАЛИЗИРОВАН

## Проект

Название: [ЗАПОЛНИТЬ — запусти /new-project]
Дата старта: —
Дедлайн прототипа: —
Концепт: —
Платформа: iOS + Android
Текущий Sprint: —
Статус: 🔴 ОЖИДАНИЕ ИНИЦИАЛИЗАЦИИ

## Команда

PM / GD / DEV / UIUX / ART — Antigravity Workspaces

## MCP Unity

Статус: ✅ УСТАНОВЛЕН И ГОТОВ
Пакет: `com.gamelovers.mcp-unity@e4b7e74ad052`

### Архитектура (важно!)

```text
MCP-клиент (Antigravity)
    ↕ STDIO
Node.js сервер (index.js) — режим StdioServerTransport
    ↕ WebSocket :8090
Unity Editor (McpUnityServer)
```

- Node.js `index.js` работает в **STDIO режиме** — не имеет собственного порта
- Unity Editor слушает `ws://localhost:8090` и ждёт подключения от `index.js`
- Порт 8090 открывается **только когда открыт Unity Editor**

### Конфиг MCP для Antigravity Settings

```json
{
  "command": "node",
  "args": ["d:\\ASTRA\\My project\\Library\\PackageCache\\com.gamelovers.mcp-unity@e4b7e74ad052\\Server~\\build\\index.js"]
}
```

## Как начать

1. Запусти /new-project в PM-Workspace
2. PM соберёт информацию и создаст Sprint 1
