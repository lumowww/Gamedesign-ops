---
name: agent-tz-template
description: >
  Шаблон ТЗ для агентов (DEV/ART/UIUX) от GD.
  Активируется при: 'создать ТЗ', 'task specification', 'agent brief',
  'GD to DEV', 'GD to ART', 'GD to UIUX'.
---

# SKILL: AGENT TZ TEMPLATE

## Шаблон ТЗ для агентов

Используется для создания артефактов вида:
- `GD_to_DEV_[TASK-ID].md`
- `GD_to_ART_[TASK-ID].md`
- `GD_to_UIUX_[TASK-ID].md`

---

## Универсальная структура

```markdown
# ТЗ: [НАЗВАНИЕ ЗАДАЧИ]
# От: GD | Кому: [DEV/ART/UIUX] | Дата: [ДАТА]
# Связано с: TASK-[ID] | GDD Block: [ID:...]

---

## 1. Контекст

### Что делаем
[2-3 предложения о задаче]

### Зачем
[Какую проблему решает / какую метрику улучшает]

### Связанные документы
- GDD: `docs/GDD/GDD_[Name]_v[N].md` → [ID:BLOCK]
- Feature Spec: `docs/GDD/FeatureSpec_[Name]_v[N].md` (если есть)
- Producer Brief: `docs/PRODUCER_BRIEF.md` (если применимо)

---

## 2. Требования

### Functional Requirements
- [ ] [Требование 1]
- [ ] [Требование 2]
- [ ] [Требование 3]

### Non-Functional Requirements
- Performance: [ограничения]
- Compatibility: [платформы]
- Constraints: [технические ограничения]

---

## 3. Deliverables

### Что нужно создать
| Артефакт | Формат | Путь | Deadline |
|----------|--------|------|----------|
| [название] | [.cs/.prefab/.png/.fig] | [путь] | [дата] |

### Критерии готовности (Definition of Done)
- [ ] [Критерий 1]
- [ ] [Критерий 2]
- [ ] [Критерий 3]

---

## 4. Референсы

### Визуальные
- [Ссылка на скриншот/видео 1]
- [Ссылка на скриншот/видео 2]

### Игровые
- [Игра 1]: [что именно посмотреть]
- [Игра 2]: [что именно посмотреть]

---

## 5. Технические детали

### Для DEV
**Systems:**
- [список систем]

**ScriptableObjects:**
```csharp
[CreateAssetMenu]
public class [Name]SO : ScriptableObject
{
    public [FieldType] [fieldName]; // [комментарий]
}
```

**Analytics Events:**
```
event_name: [name]
params: [param1, param2, ...]
trigger: [когда отправляется]
```

**Performance:**
- FPS target: [30/60]
- Memory budget: [N] MB
- Draw calls: < [N]

### Для ART
**Asset List:**
| Название | Тип | Размер | Формат | Примечания |
|----------|-----|--------|--------|------------|
| [name] | sprite | 512x512 | PNG | [комментарий] |

**Art Style:**
- Palette: [основные цвета]
- Style: [3 слова]
- Reference: [ссылка]

**Animation:**
- [animation name]: [duration, loop, frames]

### Для UIUX
**Screens:**
- [Screen name]: [описание]

**UX Flow:**
```
[Screen A] → [trigger] → [Screen B] → [result] → [Screen C]
```

**UI Elements:**
| Элемент | Тип | Размер | Текст | Action |
|---------|-----|--------|-------|--------|
| [name] | button | 200x60 | «Start» | start game |

**States:**
- Normal: [описание]
- Hover: [описание]
- Pressed: [описание]
- Disabled: [описание]

---

## 6. Edge Cases

- [ ] Что если [ситуация 1]?
- [ ] Что если [ситуация 2]?
- [ ] Что если [ситуация 3]?

---

## 7. Open Questions

- [ ] [Вопрос 1] — нужно решить до [DATE]
- [ ] [Вопрос 2]

---

## 8. Acceptance Criteria

**Задача считается выполненной когда:**

1. [ ] [Критерий 1]
2. [ ] [Критерий 2]
3. [ ] [Критерий 3]

**Design Review:** GD проведёт /design-review после завершения

---

## 9. Dependencies

**Зависит от:**
- TASK-[ID]: [название]

**Блокирует:**
- TASK-[ID]: [название]

**Рекомендуемый спринт:** Sprint [N]

---

## 10. Risk Assessment

| Риск | Вероятность | Влияние | Митигация |
|------|-------------|---------|-----------|
| [риск] | Low/Med/High | Low/Med/High | [как снизить] |
```

---

## Примеры для разных ролей

### Пример для DEV

```markdown
# ТЗ: Реализовать механику двойного прыжка
# От: GD | Кому: DEV | Дата: 2026-03-03
# Связано с: TASK-DEV-015 | GDD Block: [ID:CORE_MECHANIC]

## 1. Контекст

### Что делаем
Добавить возможность игроку сделать второй прыжок в воздухе.

### Зачем
Увеличить agency игрока и добавить skill ceiling.

## 2. Требования

### Functional
- [ ] Игрок может прыгнуть второй раз пока в воздухе
- [ ] Визуальный эффект второго прыжка
- [ ] Звук второго прыжка

### Non-Functional
- Performance: no impact on FPS
- Input lag: < 50ms

## 3. Deliverables

| Артефакт | Формат | Путь |
|----------|--------|------|
| PlayerController.cs | .cs | Assets/_Project/Scripts/Gameplay/ |
| DoubleJumpVFX.prefab | .prefab | Assets/_Project/Prefabs/VFX/ |

## 4. ScriptableObjects

```csharp
[CreateAssetMenu]
public class PlayerJumpConfigSO : ScriptableObject
{
    public float jumpForce = 5f;
    public float doubleJumpForce = 4f;
    public GameObject doubleJumpVFX;
}
```

## 5. Analytics

```
event_name: player_double_jump
params: [level_id, player_level]
trigger: когда игрок использует double jump
```

## 6. Acceptance Criteria

- [ ] Второй прыжок работает только в воздухе
- [ ] Высота второго прыжка 80% от первого
- [ ] VFX проигрывается в момент прыжка
```

---

## Integration с Workflow

После создания ТЗ:

1. Сохранить в `.agent/artifacts/GD_to_[ROLE]_[TASK-ID].md`
2. Упомянуть в `task_board.md` в соответствующей задаче
3. Записать в `decisions_log.md`
