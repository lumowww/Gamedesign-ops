# MCP Unity Client — Antigravity Integration (Multi-Model)

**Версия:** 2.0  
**Роль:** Все агенты (DEV, PM, GD, UIUX, ART)  
**Интеграция:** Нативная (Google Antigravity IDE)

---

## 📋 Описание

В отличие от внешних скриптов (как в Qwen), **Antigravity связывается с MCP-сервером Unity напрямую**. Любая Large Language Model (LLM), выбранная пользователем в выпадающем меню IDE (Gemini 3 Flash/Pro, Claude Sonnet/Opus, GPT-OSS), автоматически получает набор `mcp-unity` инструментов.

Инструменты передаются в модель как доступные функции (Function Calling) и не требуют ручного запуска через CLI или Node.js.

---

## 🛠️ Нативный набор инструментов (Tools)

Вам, как AI-агенту, доступны следующие инструменты (tools) для работы с Unity. Вызывайте их напрямую через API интерфейса:

| Имя инструмента в Antigravity | Назначение |
|-------------------------------|-------------|
| `mcp_mcp-unity_get_scene_info`| Получить дерево объектов на текущей сцене |
| `mcp_mcp-unity_create_gameobject`| Спавн нового объекта |
| `mcp_mcp-unity_get_gameobject`| Прочитать параметры объекта (Transform, Components) |
| `mcp_mcp-unity_update_gameobject`| Изменить параметры объекта |
| `mcp_mcp-unity_update_component`| Изменить значения внутри компонента (C# скрипта) |
| `mcp_mcp-unity_execute_menu_item`| Вызвать команду из меню `Window/`, `GameObject/` и т.д. |
| `mcp_mcp-unity_get_console_logs`| Прочитать ошибки и варнинги Unity Console |
| `mcp_mcp-unity_run_tests` | Запустить Test Runner (EditMode/PlayMode) |

> **Внимание:** В Antigravity нельзя использовать URI ресурсы вроде `unity://scenes_hierarchy` через команду терминала. Используйте свои встроенные инструменты API (например, `get_scene_info`).

---

## 🔁 Система смены моделей (Handoff Protocol)

Так как разработка идёт в парадигме **Agentic Software Development**, пользователь может менять модели "на лету" (например, Gemini для планирования, Claude для UI, GPT для сложных алгоритмов).

Чтобы новая модель не теряла контекст, разработаны два макроса-сценария (Workflows):

1. **Перед сменой модели:** Сказать `/handoff`. Текущая модель запишет весь контекст (что делает, что сломано, на чём остановилась) в `.gemini/antigravity/brain/session_handoff.md`.
2. **После смены модели:** Сказать `/resume`. Новая модель прочитает `session_handoff.md` и мгновенно продолжит работу с того же места.

---

## 💡 Best Practices для мульти-модельной работы

1. **Не фантазируй:** Если вызвана новая модель (через `/resume`), сначала прочитай логи Unity и `session_handoff.md`, и лишь потом пиши код.
2. **Атомарность:** Старайся заканчивать логические блоки до выполнения `/handoff`, чтобы другой модели было проще подхватить задачу.
3. **SSOT (Single Source of Truth):** Все решения должны дублироваться в `decisions_log.md`, так как история чата может быть недоступна новой модели после `/resume`.
