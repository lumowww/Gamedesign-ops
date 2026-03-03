# WORKFLOW: DESIGN-REVIEW
# Файл: .agent/workflows/design-review.md
# Триггер: /design-review [TASK-ID]
# Агент: GD

## PROTOCOL: РЕВЬЮ РЕАЛИЗАЦИИ НА СООТВЕТСТВИЕ GDD

Используется когда DEV или UIUX сообщают о завершении реализации
и GD должен проверить соответствие GDD / feature spec до закрытия задачи.

---

## Step 1 — Подготовка

1. Прочесть закрываемую задачу в `brain/task_board.md`
2. Найти связанный GDD-блок и/или Feature Spec:
   - `docs/GDD/GDD_[Name]_v[N].md` → секции `[ID:...]`
   - `docs/GDD/FeatureSpec_[Name]_v[N].md` (если есть)
3. Запросить у DEV/UIUX ссылку на реализацию:
   - **Для DEV:** название сцены, скриншот или `git diff HEAD~1`
   - **Для UIUX:** ссылка на Figma или скриншот экрана

---

## Step 2 — Чек-лист ревью

### Gameplay Review (для DEV-задач)

- [ ] Core mechanic реализована как описано в GDD `[ID:CORE_MECHANIC]`?
- [ ] Win/Lose условия корректны `[ID:WIN_LOSE]`?
- [ ] Feedback на действия игрока читаем? (juice, audio, visual)
- [ ] FTUE шаги соответствуют `[ID:FTUE]`?
- [ ] Нет незапланированных механик (scope creep)?
- [ ] Performance: FPS в норме на target device?
- [ ] Analytics events реализованы (event names из feature spec)?

### Economy Review (для задач с балансом)

- [ ] Balance constants соответствуют GDD `[ID:BALANCE]`?
- [ ] ScriptableObjects заполнены корректными значениями?
- [ ] Нет магических чисел в коде (только через SO)?

### UX Review (для UIUX-задач)

- [ ] Screen flow соответствует `[ID:SCREEN_GRAPH]`?
- [ ] HUD элементы присутствуют `[ID:HUD]`?
- [ ] Edge cases обработаны (empty state, no internet)?
- [ ] Шрифты читаемы на малых экранах (min 14sp)?
- [ ] Первый экран FTUE без попапов?

---

## Step 3 — Решение

### PASS (всё соответствует)

```markdown
## DESIGN REVIEW — PASS
**Задача:** [TASK-ID]
**Reviewer:** GD
**Дата:** [ДАТА]
**Результат:** Реализация соответствует GDD и Feature Spec.
**Замечания (minor):** [список незначительных]
**Решение:** PM может закрывать задачу.
```

### PASS WITH NOTES (мелкие расхождения, не блокируют)

```markdown
## DESIGN REVIEW — PASS WITH NOTES
**Задача:** [TASK-ID]
**Reviewer:** GD
**Дата:** [ДАТА]
**Результат:** Реализация соответствует GDD с незначительными отклонениями.
**Notes:** [список с TODO для следующего спринта]
**Решение:** Задачу можно закрыть. Notes → Backlog.
```

### FAIL (критическое расхождение с GDD)

```markdown
## DESIGN REVIEW — FAIL
**Задача:** [TASK-ID]
**Reviewer:** GD
**Дата:** [ДАТА]
**Блокер:** [что именно не соответствует GDD, ссылка на [ID:BLOCK]]
**Требуется:** [конкретное исправление]
**Приоритет:** P0 / P1
**Решение:** Задача возвращается в IN_PROGRESS. DEV/UIUX исправляет.
```

---

## Step 4 — После ревью

1. Сохранить результат в `.agent/artifacts/GD_review_[TASK-ID].md`
2. Записать в `decisions_log.md`
3. Уведомить PM:
   - **PASS** → PM закрывает задачу (`/done [TASK-ID]`)
   - **FAIL** → PM меняет статус на IN_PROGRESS, DEV/UIUX получают фидбек

---

## Чек-лист /design-review

- [ ] GDD блоки прочитаны
- [ ] Feature Spec прочитан (если есть)
- [ ] Реализация получена от DEV/UIUX
- [ ] Чек-лист заполнен (Gameplay / Economy / UX)
- [ ] Решение вынесено (PASS / PASS WITH NOTES / FAIL)
- [ ] Артефакт сохранён в `.agent/artifacts/`
- [ ] PM уведомлён
- [ ] `decisions_log.md` обновлён
