# WORKFLOW: /done [TASK-ID]
# Версия: 2.0 | Обновлено: 2026-03-03
# Триггер: /done TASK-042
# Агент: любой

## ШАГ 1 — Определить тип задачи

**DESIGN задача** (теги: GAMEPLAY, ECONOMY, UX, FTUE, BALANCE, LIVEOPS):
→ Переходи к ШАГ 2A

**NON-DESIGN задача** (теги: CI, BUILD, DEVOPS, LINT, DEPENDENCIES, PLACEHOLDER_ART):
→ Переходи к ШАГ 2B

---

## ШАГ 2A — DESIGN задача (GD Gate)

1. Обновить `task_board.md`: статус → **REVIEW** (не DONE!)
2. Обновить brain-файл своей роли
3. Записать в `decisions_log.md`:
   ```markdown
   ## [Дата ЧЧ:ММ] — TASK-[ID] → REVIEW
   Агент: [роль]
   Результат: [что создано/изменено]
   Файлы: [список]
   GDD anchor: [ID:BLOCK]
   Следующий шаг: GD Design Review
   ```
4. Сообщить PM: «**TASK-[ID] в REVIEW**. [Краткий результат]. Нужен Design Review от GD.»

PM → уведомляет GD → GD запускает `/design-review TASK-[ID]`

После PASS от GD:
5. Обновить `task_board.md`: статус → **DONE**
6. Уведомить PM о DONE

---

## ШАГ 2B — NON-DESIGN задача (прямой DONE)

1. Обновить `task_board.md`: статус → **DONE**
2. Обновить brain-файл своей роли (если релевантно)
3. Записать в `decisions_log.md`:
   ```markdown
   ## [Дата ЧЧ:ММ] — TASK-[ID] DONE
   Агент: [роль]
   Результат: [что создано/изменено]
   Файлы: [список]
   Следующий шаг: TASK-[ID] или ожидание PM
   ```
4. Уведомить PM: «**TASK-[ID] DONE**. [Краткий результат]. Жду задачу.»
