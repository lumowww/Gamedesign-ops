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
Путь к серверу: Library/PackageCache/com.gamelovers.mcp-unity@e4b7e74ad052/Server~/build/index.js
Следующий шаг: Добавить конфиг MCP в Antigravity Settings → запустить /new-project

---

## 2026-03-02 — TASK-QWEN-SETUP-001: ИНТЕГРАЦИЯ QWEN CODE

Агент: Qwen Code
Роль: DEV
Задача: TASK-QWEN-SETUP-001
Действие: Настроена интеграция Qwen Code в Antigravity
Файлы:

- .qwen/QWEN.md (конфигурация)
- .qwen/skills/docker-health/SKILL.md
- .qwen/skills/ps-fix/SKILL.md
- .qwen/skills/env-healing/SKILL.md
- .agent/workflows/qwen-autonomous.md
Риск: НИЗКИЙ
Статус: УСПЕХ

Определение роли:

- Project context: ИНИЦИАЛИЗИРОВАН (Инфраструктура)
- Активные rule-файлы: 00_global.md, 03_DEV.md
- Тип задач: код, Git, локальные сервисы
- Роль определена: DEV ✅

Следующий шаг: Завершить TASK-QWEN-SETUP-001, готов к автономной работе

---

## 2026-03-02 — GD-WORKSPACE v2.0 DEPLOYED

Агент: DEPLOY
Действие: Развёрнут GD-Workspace v2.0 (Game Designer)
Файлы:

- .agent/skills/doc-extractor/SKILL.md
- Обновлён: .agent/rules/02_GD.md (таблица навыков)
- Обновлён: AGENTS.md
- **Назначение:** Анализ входящих документов -> Extraction Report -> заполнение GDD
- **Статус:** DEPLOYED

---

## 2026-03-03 06:15 — PM RULE UPDATED: v1.x → v2.0 (GD-Aware)

- **Кто:** Lead Developer (on behalf of PM)
- **Задача:** /upgrade-pm-v2
- **Решение:** Обновление 01_PM.md до версии 2.0. Интеграция с GD-Workspace v2 (design gate, A2A артефакты).
- **Импакт:** Изменение флоу задач: теперь дизайн-задачи требуют Design Review от GD.
- **Статус:** DONE

---

## 2026-03-03 07:02 — FULL TEAM v2.0 DEPLOYED

- **Агент:** DEPLOY (on behalf of User)
- **Действие:** Обновление всех rule-файлов и workflows до версии 2.0
- **Ключевые изменения:**
  - 00_global.md: добавлен GD Gate, A2A артефакты, SSOT, словарь
  - 03_DEV.md: GDD Integration Protocol, balance constants от GD, analytics schema
  - 04_UIUX.md: Feature Spec как hard constraint, UIUX_to_GD feedback channel
  - 05_ART.md: Asset status protocol (PLACEHOLDER/WIP/FINAL), gdd_summary priority
  - 06_PRODUCER.md: GD Handoff Protocol с обязательными полями, Pivot Protocol
  - task-done.md: DESIGN/NON-DESIGN routing с GD Gate
  - new-project.md: правильный порядок старта (GD первый, остальные после GDD)
- **Статус:** DEPLOYED

---

## 2026-03-03 14:15 — FULL TEAM INFRASTRUCTURE v2.0 DEPLOYED

- **Агент:** Lead Developer (on behalf of Infrastructure)
- **Действие:** Обновление всех rule-файлов (00_global, 03_DEV, 04_UIUX, 05_ART, 06_PRODUCER) и workflows (new-project, task-done) до версии 2.0.
- **Импакт:** Вся команда теперь работает в режиме GD-Aware. Внедрены A2A артефакты, GD Gate и чёткий порядок старта проекта (GD First).
- **Статус:** DONE

---

## 2026-03-03 16:50 — FULL TEAM INFRASTRUCTURE v2.0 READY

- **Агент:** Lead Developer
- **Задача:** Развёртывание GameDev Team Инфраструктуры
- **Решение:** Вручную перенесены все правила v2.0 из ТЗ в .agent/rules и воркфлоу в .agent/workflows. AGENTS.md синхронизирован.
- **Статус:** DONE

---

## 2026-03-04 12:30 — AUDIT v1.0: ПРОЕКТ ПРОАНАЛИЗИРОВАН

- **Агент:** Lead Developer (Antigravity)
- **Задача:** Полный аудит проекта GAMEDEVGD
- **Результат:** Выявлены 3 критические проблемы, 7 противоречий, 7 слабостей. Создан план исправлений из 4 фаз.
- **Статус:** DONE

---

## 2026-03-04 12:45 — QWEN CODE: ИСПОЛНЕНИЕ ПЛАНА ИСПРАВЛЕНИЙ

- **Агент:** Qwen Code (DEV)
- **Задача:** Реализация плана исправлений из аудита
- **Результат:** Выполнено 9/12 шагов (75%): структура _Project/ создана, документация v2.0, тесты расширены. decisions_log.md НЕ починен (двойная перекодировка).
- **Статус:** PARTIAL

---

## 2026-03-04 13:03 — DECISIONS_LOG.MD ПЕРЕСОЗДАН

- **Агент:** Lead Developer (Antigravity)
- **Задача:** Полная перезапись decisions_log.md в чистом UTF-8
- **Причина:** Файл был повреждён null-байтами (UCS-2 мусор) и Mojibake (двойная перекодировка UTF-8 → CP1251 → UTF-8)
- **Действие:** Восстановлены все 10 исторических записей из контекста проекта, добавлены записи аудита
- **Статус:** DONE

---

## 2026-03-05 [ID:INFRA-003] — Принудительная синхронизация v2.0

- **Агент:** DEV
- **Результат:** Правила и воркфлоу в .agent/ принудительно обновлены из TZ/0303. Корень проекта очищен от мусора (mnt/, node_modules/ и др.).
- **Файлы:** .agent/rules/*.md, .agent/workflows/*.md
- **Следующий шаг:** Ожидание /concept от PRODUCER

---

## 2026-03-05 [ID:SPRINT0-001] — AiW Sprint 0 GDD Package DEPLOYED

- **Агент:** GD
- **Действие:** Полное развёртывание GDD-пакета Sprint 0 v0.1 (Alien in Waders)
- **Артефакты созданы:**
  - **Brain files:**
    - `.gemini/antigravity/brain/gdd_summary.md` — GDD сводка для агентов
    - `.gemini/antigravity/brain/project_context.md` — контекст проекта
    - `.gemini/antigravity/brain/task_board.md` — доска задач Sprint 1
  - **Документация:**
    - `docs/intake/AiW_concept_intake.md` — Concept Intake + Go/No-Go ✅
    - `docs/concepts/AiW_one_pager_v0.1.md` — One Page Concept (11 блоков) ✅
    - `docs/GDD/sections/AiW_GDD_2.0_CoreLoop.md` — Core Loops (micro/meta/macro) ✅
    - `docs/GDD/AiW_design_heuristics_audit.md` — Design Heuristics Audit (9 Rules + 12 Tricks) ✅
    - `docs/tech/AiW_mobile_constraints_v0.1.md` — Unity Mobile Checklist ✅
    - `docs/GDD/sections/AiW_GDD_2.2_Towers_EntityMatrix.md` — Tower Entity Matrix (15 башен) ✅
    - `docs/assets/AiW_free_asset_list_Sprint1.md` — Free Asset List Sprint 1 ✅
  - **ТЗ для агентов:**
    - `docs/agents/TZ_DEV_Sprint1_MVP.md` — ТЗ для DEV (Core системы, SO, analytics) ✅
    - `docs/agents/TZ_ART_Sprint1_MVP.md` — ТЗ для ART (placeholder ассеты) ✅
    - `docs/agents/TZ_UIUX_Sprint1_MVP.md` — ТЗ для UIUX (5 экранов UI) ✅
- **Ключевые решения (DEC-001..005):**
  - DEC-001: Sprint 1 = только Тропа-режим (Волна = Sprint 2)
  - DEC-002: Sprint 1 = 2 башни T-001 + T-002
  - DEC-003: Realtime PvP → async/bot до Этапа 4
  - DEC-004: Арт Random Dice не использовать
  - DEC-005: Matchmaking по tower tier (P2W safeguard)
- **Статус:** ✅ SPRINT 1 READY — DEV/ART/UIUX могут стартовать

## 2026-03-05 [ID:INFRA-004]  ����������� ���������������� MCP-Unity
�����: DEV
���������: ��������� ����� ��� ���������� �������� ����� LLM-�������� (Gemini/Claude).
�����: docs/MCP_ANTIGRAVITY.md, .agent/workflows/handoff.md, .agent/workflows/resume.md, brain/session_handoff.md
��������� ���: �������� ������-��������
