# DECISIONS LOG

Все агенты добавляют записи в КОНЕЦ файла (append-only)

---

## 2026-03-01 — ИНФРАСТРУКТУРА РАЗВЁРНУТА

Агент: DEPLOY
Решение: Создана структура .agent/ и .gemini/antigravity/brain/
Файлы: все .agent/rules/ (00-05), .agent/workflows/ (7 файлов), .agent/skills/ (5 папок), brain-файлы (6 файлов), AGENTS.md, CREDITS.md
Следующий шаг: Запустить /new-project в PM-Workspace

---

## 2026-03-01 — MCP-UNITY ВЕРИФИЦИРОВАН

Агент: DEPLOY
Решение: Пакет com.gamelovers.mcp-unity@e4b7e74ad052 уже установлен и скомпилирован
Настройки: Порт 8090, AutoStartServer=true, AllowRemoteConnections=false
Путь к серверу: Library\PackageCache\com.gamelovers.mcp-unity@e4b7e74ad052\Server~\build\index.js
Следующий шаг: Добавить конфиг MCP в Antigravity Settings → запустить /new-project

---
