# GAMEDEV TEAM — AGENTS.md v2.0
# Читается ПЕРВЫМ при любом входе агента в проект

## Что это за проект
Мультиагентная команда разработки мобильных гиперказуальных игр на Unity.
6 агентов, 6 Workspaces в Antigravity IDE.

## ⚠️ ТОЧКА ВХОДА: PRODUCER
**Все новые проекты начинаются через PRODUCER-Workspace.**
Команда НЕ запускается без утверждённого Producer Brief.

## Первые действия при входе в проект
1. Определить свою роль по активному Rule-файлу воркспейса
2. Прочитать `.gemini/antigravity/brain/project_context.md`
3. Прочитать `.gemini/antigravity/brain/task_board.md`
4. Начать работу согласно протоколам своей роли

## Структура команды

| Workspace | Роль | Rule-файл | Точка входа |
|-----------|------|-----------|-------------|
| **PRODUCER**-Workspace | **Game Producer** | `.agent/rules/06_PRODUCER.md` | ← СТАРТ ЗДЕСЬ |
| PM-Workspace | Project Manager | `.agent/rules/01_PM.md` | ← После Producer Brief |
| GD-Workspace | Game Designer | `.agent/rules/02_GD.md` | |
| DEV-Workspace | Unity Lead Dev | `.agent/rules/03_DEV.md` | |
| UIUX-Workspace | UI/UX Designer | `.agent/rules/04_UIUX.md` | |
| ART-Workspace | Art Director | `.agent/rules/05_ART.md` | |

## Иерархия и коммуникация

```
ПОЛЬЗОВАТЕЛЬ
    │
    ▼
PRODUCER ←──── единственная точка входа для новых проектов
    │           запрашивает отчёты у всех агентов
    │           проводит Milestone Reviews
    │
    ▼
   PM ←──────── получает Producer Brief + Pipeline
    │           управляет task_board, ежедневный sync
    │
    ├──► GD ────► GDD, механики, баланс
    ├──► DEV ───► Unity код, MCP, билды
    ├──► UIUX ──► UI спеки, UX flows
    └──► ART ───► Арт-библия, ассеты, VFX
```

## Коммуникационная шина
Все агенты общаются через `.gemini/antigravity/brain/`
Артефакты и планы — через `.agent/artifacts/`
Продюсерские документы — через `docs/`

## Ключевые команды

| Команда | Кто использует | Что делает |
|---------|---------------|------------|
| `/concept [текст]` | Пользователь → PRODUCER | Старт нового проекта |
| `/report [AGENT]` | PRODUCER | Запрос отчёта у агента |
| `/milestone [N]` | PRODUCER | Контрольная точка |
| `/market [жанр]` | PRODUCER | Анализ рынка (Perplexity) |
| `/sync` | PM | Ежедневная сводка |
| `/done TASK-ID` | Все агенты | Задача выполнена |
| `/handoff` | Все агенты | Сохранение контекста |
| `/resume` | Все агенты | Восстановление контекста |

## Экстренные контакты
- Блокер → эскалировать к PM через task_board.md (статус BLOCKED)
- Конфликт архитектурный → decisions_log.md + уведомление PM + PRODUCER
- Pivot концепта → PRODUCER принимает решение
- Критический баг в прототипе → DEV → PM → PRODUCER (если влияет на сроки)
