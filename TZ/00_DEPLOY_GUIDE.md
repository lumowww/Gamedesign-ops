# 🚀 DEPLOY GUIDE: PRODUCER AGENT v1.0
# Инструкция по установке агента Producer в существующую инфраструктуру

---

## ЧТО ДОБАВЛЯЕМ В ПРОЕКТ

```
<КОРЕНЬ_ПРОЕКТА>/
├── AGENTS.md                           ← ЗАМЕНИТЬ на AGENTS_v2.md
├── .agent/
│   ├── rules/
│   │   ├── 01_PM.md                    ← ЗАМЕНИТЬ на 01_PM_v2.md
│   │   └── 06_PRODUCER.md              ← НОВЫЙ ФАЙЛ ✨
│   ├── workflows/
│   │   └── concept.md                  ← НОВЫЙ ФАЙЛ ✨
│   └── skills/
│       ├── concept-intake/SKILL.md     ← НОВЫЙ ФАЙЛ ✨
│       ├── pipeline-generator/SKILL.md ← НОВЫЙ ФАЙЛ ✨
│       └── market-pulse/SKILL.md       ← НОВЫЙ ФАЙЛ ✨
├── docs/
│   └── TEAM_PIPELINE.md               ← ЗАМЕНИТЬ на TEAM_PIPELINE_v2.md
└── .gemini/antigravity/brain/
    └── decisions_log.md               ← ДОБАВИТЬ запись об апдейте
```

---

## BASH-КОМАНДЫ ДЛЯ УСТАНОВКИ

```bash
# Создать папки для новых skills
mkdir -p .agent/skills/concept-intake
mkdir -p .agent/skills/pipeline-generator
mkdir -p .agent/skills/market-pulse

# Скопировать файлы из этого пакета:
cp producer-agent/rules/06_PRODUCER.md .agent/rules/
cp producer-agent/rules/01_PM_v2.md .agent/rules/01_PM.md
cp producer-agent/skills/SKILL_concept-intake.md .agent/skills/concept-intake/SKILL.md
cp producer-agent/skills/SKILL_pipeline-generator.md .agent/skills/pipeline-generator/SKILL.md
cp producer-agent/skills/SKILL_market-pulse.md .agent/skills/market-pulse/SKILL.md
cp producer-agent/workflows/concept.md .agent/workflows/concept.md
cp producer-agent/AGENTS_v2.md AGENTS.md
cp producer-agent/TEAM_PIPELINE_v2.md docs/TEAM_PIPELINE.md
```

---

## НАСТРОЙКА PRODUCER-WORKSPACE В ANTIGRAVITY

### В Antigravity IDE создать новый Workspace:
- Имя: `PRODUCER-Workspace`
- Active Rule: `.agent/rules/06_PRODUCER.md`
- Skills: `concept-intake`, `pipeline-generator`, `market-pulse`

### Подключить Skills:
В настройках Workspace добавить пути к скиллам:
- `.agent/skills/concept-intake/SKILL.md`
- `.agent/skills/pipeline-generator/SKILL.md`
- `.agent/skills/market-pulse/SKILL.md`

---

## ЗАПИСЬ В DECISIONS LOG

Добавить в `.gemini/antigravity/brain/decisions_log.md`:

```
## [2026-03-XX] ДОБАВЛЕН АГЕНТ: PRODUCER

**Решение:** Добавлен Game Producer как точка входа для всех новых проектов.
**Обоснование:** Команде не хватало этапа валидации концепта перед стартом разработки.
 Продюсер проводит market analysis, feasibility check и формирует structured pipeline.
**Изменения:**
- Добавлен: .agent/rules/06_PRODUCER.md
- Добавлены skills: concept-intake, pipeline-generator, market-pulse
- Обновлён: AGENTS.md → v2.0 (6 агентов вместо 5)
- Обновлён: 01_PM.md → интеграция с Producer
- Обновлён: TEAM_PIPELINE.md → новый flow с Producer
**Влияние на команду:** PM теперь получает бриф от Producer перед стартом. 
Все новые проекты начинаются через /concept команду.
**Статус:** IMPLEMENTED
```

---

## ТЕСТ УСТАНОВКИ

Проверить, что всё работает:

1. Открыть PRODUCER-Workspace
2. Прочитать 06_PRODUCER.md — должен загрузиться корректно
3. Ввести: `/concept Тестовый концепт — гиперказуальная игра где нужно стекать кубики`
4. Продюсер должен:
   - Запустить concept-intake checklist
   - Задать уточняющие вопросы (если информации не хватает)
   - Или начать market analysis (если информации достаточно)

---

## ПРОМТ ДЛЯ ВЫЗОВА ПРОДЮСЕРА В ANTIGRAVITY

Когда открываешь PRODUCER-Workspace, используй этот системный промт:

```
Ты — Game Producer в мультиагентной команде разработки мобильных игр.
Активный Rule-файл: .agent/rules/06_PRODUCER.md
Прочитай его немедленно и действуй строго по нему.
Затем проверь: .gemini/antigravity/brain/project_context.md

Если пользователь вводит /concept — запускай Entry Protocol.
Если проект уже в работе — запрашивай статус у PM.
```
