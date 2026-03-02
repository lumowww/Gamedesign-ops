# MCP Unity Client — Qwen Code Integration

**Версия:** 1.0  
**Проект:** GAMEDEVGD

---

## 📋 Описание

MCP клиент для прямого вызова инструментов Unity MCP из Qwen Code.  
Позволяет получать информацию из Unity Editor в реальном времени.

---

## 🔧 Установка

Зависимости уже установлены в проекте:

```bash
npm install ws
```

---

## 📖 Использование

### CLI режим

```bash
# Получить информацию о сцене
node .qwen/mcp-client.js get_scene_info

# Получить иерархию сцены (resource)
node .qwen/mcp-client.js --resource unity://scenes_hierarchy

# Получить логи консоли Unity
node .qwen/mcp-client.js get_console_logs

# Справка
node .qwen/mcp-client.js
```

### Программный вызов (ES modules)

```javascript
import { callMcpTool, readMcpResource } from './.qwen/mcp-client.js';

// Вызов инструмента
const sceneInfo = await callMcpTool('get_scene_info');
console.log(sceneInfo);

// Чтение ресурса
const hierarchy = await readMcpResource('unity://scenes_hierarchy');
console.log(hierarchy);
```

---

## 🛠️ Доступные инструменты MCP

### Tools

| Инструмент | Описание |
|------------|----------|
| `get_scene_info` | Информация о текущей сцене |
| `get_console_logs` | Логи Unity Console |
| `get_gameobject` | Детали GameObject по ID |
| `select_gameobject` | Выбрать объект в сцене |
| `update_gameobject` | Создать/обновить GameObject |
| `update_component` | Добавить/настроить компонент |
| `execute_menu_item` | Выполнить команду меню Unity |
| `load_scene` | Загрузить сцену |
| `save_scene` | Сохранить сцену |
| `create_scene` | Создать новую сцену |
| `add_package` | Установить Unity пакет |
| `run_tests` | Запустить тесты |

### Resources

| Ресурс | Описание |
|--------|----------|
| `unity://scenes_hierarchy` | Иерархия объектов сцены |
| `unity://gameobject/{id}` | Детали объекта по ID |
| `unity://logs` | Консоль логи |
| `unity://packages` | Установленные пакеты |
| `unity://assets` | Поиск ассетов |
| `unity://menu-items` | Доступные меню |
| `unity://tests/{testMode}` | Тесты (EditMode/PlayMode) |

---

## 🏗️ Архитектура

```
Qwen Code (mcp-client.js)
    ↕ STDIO
Node.js MCP Server (index.js)
    ↕ WebSocket :8090
Unity Editor (McpUnityServer)
```

**Важно:**
- Unity Editor должен быть открыт
- Порт 8090 должен быть свободен
- MCP сервер запускается автоматически через `index.js`

---

## 📁 Конфигурация

**Путь к MCP серверу:**
```
Library/PackageCache/com.gamelovers.mcp-unity@e4b7e74ad052/Server~/build/index.js
```

**Настройки MCP Unity:**
- Порт: `8090`
- AutoStartServer: `true`
- AllowRemoteConnections: `true`

---

## 🆘 Типичные ошибки

| Ошибка | Решение |
|--------|---------|
| `Connection refused :8090` | Откройте Unity Editor |
| `MCP initialization timeout` | Проверьте путь к MCP серверу |
| `Tool not found` | Убедитесь в правильности имени инструмента |
| `Resource not found` | Проверьте URI ресурса |

---

## 📚 Ссылки

- [Unity MCP Documentation](../Library/PackageCache/com.gamelovers.mcp-unity@e4b7e74ad052/README.md)
- [MCP Specification](https://modelcontextprotocol.io/)
- [GAMEDEVGD README](../README.md)

---

**GAMEDEVGD Team © 2026**
