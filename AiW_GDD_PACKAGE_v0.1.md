# AiW — ПОЛНЫЙ GDD ПАКЕТ MVP
**Проект:** Alien in Waders (AiW)  
**Версия:** v0.1  
**Дата:** Sprint 0 / Pre-Production  
**Исполнитель:** GD-агент  
**Все блоки:** [STATUS:DRAFT]

---

# ═══════════════════════════════════════
# АРТЕФАКТ 1 — CONCEPT INTAKE REPORT
# `docs/intake/AiW_concept_intake.md`
# ═══════════════════════════════════════

[STATUS:DRAFT] | Агент: PRODUCER / GD | /concept

---

## 1. ПОЛНОТА ИНФОРМАЦИИ

| Параметр | Статус | Примечание |
|---|---|---|
| Core mechanic | ✅ | Tower Defense + Merge + два PvE-режима (Тропа / Волна) |
| Жанр | ✅ | Hybrid-casual / Tower Defense |
| Референсы | ✅ | Random Dice (механики), Pinterest (стиль), implied: Merge Tower Defense |
| Платформа | ✅ | Android/iOS, Unity 6 LTS, URP |
| Дедлайн | ✅ | Sprint 1 = 4 недели, Android тестовый билд |
| Монетизация | ⚠️ | Battle Pass + шарды упомянуты, детали F2P модели не заданы → задаём в one-pager |
| Арт-стиль | ✅ | Pinterest-референс, НЕ Random Dice art, sci-fi / alien aesthetic |
| Скоуп | ✅ | 5 этапов roadmap загружены, 38 механик описаны |

**СТАТУС: READY — запускаем пайплайн**

---

## 2. ПЕРВИЧНАЯ ОЦЕНКА

### Marketability (0–10)

- **Visual Hook Score: 7/10** — «Корабли-крипы + башни + слияние» визуально знакомо. Риск: жанр TD воспринимается как «сложный» — hook должен быть merge, не tower.
- **Mechanic Simplicity: 7/10** — Merge mechanic = один глагол «слить». TD добавляет стратегию. Туториал нужен ≤60 сек. Для hybrid-casual — граница.
- **Trend Alignment: 8/10** — Merge TD активен (Merge TD, Tower Merger), не перенасыщен как раннеры. Sci-fi + alien = свежее прочтение жанра.
- **Uniqueness: 7/10** — Два режима PvE (Тропа + Волна) — дифференциатор. Bubble-shooter движение крипов — редкость в TD.

**ИТОГО: 7.25/10 — ПЕРСПЕКТИВНЫЙ КОНЦЕПТ. Дифференциатор есть, нужна чёткая формулировка USP вокруг Волна-режима и merge-фантазии.**

### Feasibility для AI-команды (0–10)

- **Technical Complexity:** MEDIUM — TD-движок + merge grid + два pathfinding алгоритма (path + wave)
- **Art Complexity:** MEDIUM — top-down 3D, sci-fi стиль, много типов юнитов
- **Timeline Fit (Sprint 1 = 4 нед):** РИСКОВАННО если брать оба PvE-режима → рекомендую Sprint 1 = только Тропа, Волна = Sprint 2

**ИТОГО: 7/10 — Реализуемо при правильном скоупинге. Главный риск — параллельная реализация двух pathfinding систем в Sprint 1.**

### Риски

- 🔴 **Sprint 1 scope creep** — два PvE-режима в одном спринте = x1.5 DEV трудоёмкость. Рекомендация: Тропа = MVP, Волна = Sprint 2.
- 🔴 **P2W риск в метагейме** — Колода из 15 пушек + шарды + IAP = классическая P2W воронка. Нужны fairness rails с первого дня.
- 🟡 **Art pipeline**: 6 героев + 7 боссов + 18 типов крипов + 15 башен = тяжёлый арт. Sprint 1 = placeholder-only.
- 🟡 **Realtime PvP** заявлен в Этапе 2 — это ❌ RED FLAG для мобайла (latency, servers). Рекомендация: async PvP или бот-замена.
- 🟢 **Merge mechanic** = низкий порог входа + высокая глубина. Хорошо для UA creatives.

## 3. РЕВЕРС-ИНЖИНИРИНГ КОНКУРЕНТОВ

**Random Dice:** Глагол = «сливать дайсы». Feedback = анимация слияния + новый тип. Progress = мощнее колода. Return hook = PvP рейтинг. AiW берёт механику, добавляет TD-стратегию позиционирования.

**Merge Tower Defense (аналоги):** Слабость конкурентов = нет второго PvE-режима, нет live heroes. AiW дифференциатор = Волна-режим + герои на поле.

## 4. ВЕРДИКТ ПРОДЮСЕРА

**[X] УСЛОВНЫЙ СТАРТ** — запускаем с оговорками:
1. Sprint 1 = только режим Тропа (П-образный путь). Волна = Sprint 2.
2. 2 типа пушек в Sprint 1 (не 15).
3. Realtime PvP заменить на async / бот на всех фазах прototipa.
4. P2W safeguard заложить в экономику до первого IAP.

---

**For Agents:**
- **PM** → Открыть задачи Sprint 0: арт-бриф, структура Unity-проекта, pipeline деплоя через Antigravity
- **DEV** → Начать с одного pathfinding (NavMesh / A* для П-пути), merge grid
- **ART** → Placeholder только: 2 башни, 2 типа крипов, 1 игровое поле
- **UIUX** → Минимальный HUD: Score + Wave indicator + Spawn button

---

---

# ═══════════════════════════════════════
# АРТЕФАКТ 2 — ONE PAGE GAME CONCEPT
# `docs/concepts/AiW_one_pager_v0.1.md`
# ═══════════════════════════════════════

[STATUS:DRAFT]

---

## ⚡ PLAYER PROMISE
> «Я — тактик-командующий, который строит огневые рубежи из инопланетного оружия, сливая их в монстров разрушения — и чувствую азарт хаоса под контролем.»

---

## 1. OVERVIEW [STATUS:DRAFT]

- **Game Title:** Alien in Waders (AiW)
- **Genre / Subgenre:** Hybrid-casual / Tower Defense + Merge
- **Setting:** Ближайшее будущее. Орбита Земли / приграничные планеты. Жуки-захватчики волна за волной прут через пространство. Ты — последний рубеж.
- **Target Audience:** M/F 22–38, casual-to-midcore, TD-фанаты + merge-аудитория, Tier-1/2 (US/EU/KR)
- **Core Fantasy:** «Я строю непробиваемую линию обороны из случайных пушек и чувствую, как хаос превращается в порядок.»
- **Reference:** *Random Dice* meets *Kingdom Rush* with *Merge Dragons* twist + sci-fi alien aesthetic

## 2. AUDIENCE & PLATFORMS [STATUS:DRAFT]

- **Platforms:** Android (первичный), iOS (параллельно), Unity 6 LTS + URP
- **Session length:** 5–12 мин (один PvE-матч), Meta/hub = 2–3 мин
- **Controls:** Portrait, one-thumb, tap-to-place + drag-to-merge
- **Accessibility:** Colorblind mode (типы башен = иконки, не только цвет), 12+

## 3. USP — WHY US / WHY NOW [STATUS:DRAFT]

- **Signature mechanic:** Merge = не просто апгрейд, а трансформация — две одинаковых башни → новый ТИП с другой механикой (цепная молния → яд → лазер). Башни ведут себя как дайсы, но с TD-позиционированием.
- **Differentiation:**
  - vs Random Dice: добавляем TD-стратегию позиции башен, героев на поле, два PvE-режима
  - vs Kingdom Rush: merge вместо upgrade tree = меньше экранов, больше ситуативных решений
  - Режим «Волна» (bubble-shooter движение крипов) — уникален для TD-жанра
- **Production edge:** AI-driven pipeline (Gamedesign-ops), быстрые A/B итерации через remote config

## 4. CORE GAMEPLAY [STATUS:DRAFT]

- **Core Actions:** СТАВИТЬ башню (tap-to-place) + СЛИВАТЬ две одинаковых (drag-to-merge)
- **Core Loop:**
  ```
  Получить очки → Спаунить башню → Расставить стратегически →
  Пережить волну крипов → Слить башни → Получить новый тип →
  Следующая волна сложнее → Новый тип = новое тактическое решение
  ```
- **Camera / POV:** Top-down, статичная (fit-to-screen), portrait
- **Win condition:** Пережить все N волн, не пропустив ни одного крипа к базе
- **Lose condition:** Любой крип достигает базы (HP базы = 1 жизнь, hard variant) или превышен порог пробитых крипов (soft variant)

**PvE Режим А — Тропа (MVP Sprint 1):**
Крипы идут по П-образному фиксированному пути. Башни ставятся по сторонам тропы на фиксированную сетку.

**PvE Режим Б — Волна (Sprint 2):**
Крипы двигаются волнообразно по всему полю, как bubble shooter снаряды. Башни = area control, не line-of-fire.

## 5. PROGRESSION [STATUS:DRAFT]

- **Short-term (сессия 1–3):** FTUE = спаунь → смотри как крипы умирают → слей две одинаковых → ВАУ-момент. Первые 3 уровня = обучение без текста.
- **Mid-term (дни 2–14):** Открытие новых типов башен через шарды, герои 1→3, новые боссы.
- **Long-term (недели+):** Коллекция 15 башен, PvP рейтинг, Battle Pass сезоны, скины героев.
- **Gating:** Новые башни = шарды (дроп из волн + IAP); Герои = уровень аккаунта; PvP = уровень 10+

## 6. META [STATUS:DRAFT]

- **Системы:** Колода (5 слотов башен для матча), Апгрейд башни (шарды + soft валюта), Герой (stats + passive ability), Снаряжение героя
- **Social:** PvP async рейтинг (бот имитирует противника) → лидерборд, Кооп 2P vs боссы
- **Routines:** Daily quests (3 задания/день → soft валюта), Weekly challenge (специальные условия поля → hard валюта), Season events (ограниченный контент)

## 7. LIVEOPS [STATUS:DRAFT]

- **Cadence:** Weekly events (смена условий матча), Сезон = 6 недель
- **Event types:**
  - Progression: «Пройди 5 волн в режиме Волна» → доп. шарды
  - Economy: «2x шарды в выходные»
  - Competitive: Сезонный рейтинг → Battle Pass rewards
  - Vanity: Скины башен / героев по тематике события
- **Target KPIs:** D1 ≥ 45%, D7 ≥ 20%, ARPDAU ≥ $0.03, session ≥ 8 мин

## 8. MONETIZATION [STATUS:DRAFT]

- **Model:** F2P + Ads + IAP + Battle Pass
- **IAPs:**
  - Стартовый оффер: $0.99 (шарды × 10 + soft валюта × 500) — только первые 72ч
  - Шарды: $1.99 / $4.99 / $9.99 (пакеты)
  - Battle Pass: $4.99/сезон (6 недель)
  - No Energy/Lives mechanic — ⚠️ Fairness rule: платный игрок быстрее, не сильнее в core PvE
- **Ads:**
  - Rewarded: удвоить дроп после матча, дополнительная попытка в режиме
  - Interstitial: только на win/lose screen, не чаще 1 раз в 3 мин
  - ❌ Никаких уведомлений в первые 5 минут сессии
- **Economy:**
  - Soft (Энергокристаллы): дроп из матчей, daily quests → трата: апгрейд башен в колоде
  - Hard (Ионы): IAP / редкий дроп → трата: шарды редких башен, скины, ротация магазина
  - Шарды: матч-дроп (common), кейсы (uncommon+) → апгрейд уровня башни в колоде
- **⚠️ P2W риск:** Апгрейд башен через шарды = потенциальный P2W. Safeguard: каждый тип башни доступен бесплатно (просто медленнее), PvP матчмейкинг = по уровню башен, не IAP-статусу.

## 9. REFERENCES & COMPETITORS [STATUS:DRAFT]

| Игра | Что берём | Что НЕ берём |
|---|---|---|
| Random Dice | Merge mechanics, формулы прогрессии башен | Арт, визуальный стиль, RNG-доминирование |
| Kingdom Rush | TD-глубина, герои на поле, wave system | Фиксированные upgrade trees |
| Merge Dragons | Merge moment satisfaction, прогрессия открытий | Idle-механика, нет в реальном времени |

**Benchmark KPIs (Merge TD жанр):** D1 = 42–55%, D7 = 18–25%, D30 = 8–12%

## 10. TECHNICAL [STATUS:DRAFT]

- **Engine:** Unity 6 LTS + URP, Android-first (minSDK 26), iOS 15+
- **Net model:** Offline-first PvE; async PvP (replays/ghosts); Realtime кооп = Этап 4+
- **Tooling:** Remote config (Balance/Wave editor), A/B framework (Firebase), Analytics (GameAnalytics / Amplitude)
- **Performance targets:** 30 FPS stable / 60 FPS high-end, ≤100 draw calls, ≤400 MB RAM, build ≤80MB OBB
- **Risks:**
  - Два pathfinding режима (Тропа + Волна) = DEV сложность x1.5 → решение: Волна = Sprint 2
  - Art pipeline (15 башен + 18 крипов + 7 боссов + 6 героев) = тяжело → placeholder first
  - Realtime PvP latency на мобиле → async/bot first

## 11. ROADMAP [STATUS:DRAFT]

| Этап | Срок | Цель | Гипотеза |
|---|---|---|---|
| **Sprint 1 MVP** | Недели 1–4 | Тестовый билд Android: Тропа-режим, 2 пушки, 10 волн, merge | Merge moment = ключевой retention hook |
| **Sprint 2** | Недели 5–8 | Волна-режим, 5 пушек, герой × 1, Win/Lose screens | Второй режим увеличивает D7 |
| **Этап 2 Production** | Недели 9–16 | 15 пушек, 3 героя, PvP (бот), UI комплект | CPI < $1.5 на creatives с merge |
| **Этап 3 Meta** | Недели 17–24 | Колода, апгрейд башен, battle pass, экономика | IAP conversion ≥ 3% |
| **Soft Launch** | Месяц 6 | Все режимы, монетизация, матчмейкинг | D7 ≥ 20%, ARPDAU ≥ $0.03 |

**Team:** GD + DEV × 2 + ART × 1 + UIUX × 1 (AI-assisted via Gamedesign-ops)

---

**For Agents:**
- **PM** → TASK-PM-S0-001: Создать task_board.md + project_context.md; открыть Sprint 1 задачи
- **DEV** → Начать с NavMesh/A* для П-пути, SpawnManager, базовый merge grid
- **ART** → Pinterest board изучить, задать визуальный язык; placeholder: 2 башни + 2 крипа
- **UIUX** → Wireframe: Game Screen + Win/Lose popup, portrait portrait portrait

---

---

# ═══════════════════════════════════════
# АРТЕФАКТ 3 — CORE LOOPS (MICRO/META/MACRO)
# `docs/GDD/sections/AiW_GDD_2.0_CoreLoop.md`
# ═══════════════════════════════════════

[ID:LOOPS_OVERVIEW] [STATUS:DRAFT]

---

## [2.0] Loops Overview [ID:LOOPS_OVERVIEW]

### Micro Loop — «Момент» (5–120 сек)

**Суть:** Управление ресурсами и позицией в реальном времени во время волны.

```
ACTION                    FEEDBACK                   MICRO REWARD
───────────────────────────────────────────────────────────────────
Таплю → спауню башню  →  Башня появляется на поле  → +1 огневая точка
Жду волну             →  Крипы идут, башни стреляют → Наблюдение / напряжение
Крип умирает          →  VFX взрыва + +N очков      → Очки в реальном времени
Набрал 2 одинаковых   →  Drag-to-merge доступен     → Решение: сейчас или потом?
Сливаю две башни      →  Анимация слияния + новый тип → ВАУ-момент, изменение тактики
Волна закончена       →  Wave Complete screen        → Промежуточная оценка
Крип прорвался        →  ❗ Визуальный удар по базе  → Readable failure
```

**Mastery:** Игрок учится расставлять башни по synergy (огонь рядом с замедлением = больший урон), читать тип крипов заранее, задерживать merge до нужного момента.

**Feedback requirements:**
- Каждая пуля башни должна визуально попадать в цель (не абстрактно)
- HP-бар над крипами = ещё N ударов до смерти
- Score delta (например +15) всплывает над погибшим крипом
- Merge VFX = яркий и узнаваемый (≥0.5 сек)

---

### Meta Loop — «Сессия» (одна игра + хаб, 5–15 мин)

**Суть:** Строить и улучшать колоду между матчами.

```
SESSION GOAL              SPEND / UPGRADE            PROGRESS VISIBLE
────────────────────────────────────────────────────────────────────────
Выбрать колоду (5 башен) → Посмотреть состав / сменить башни →
Сыграть матч             → Получить шарды + мягкую валюту →
Открыть инвентарь        → Апгрейд башни (шарды + soft) →
Видеть Lv башни +1        → Новая стата читаема →
Выбрать следующий матч   → PvE главу / PvP / кооп →
Ежедневный квест         → Выполнить задачу → Soft + Hard валюта
```

**Конвертации (Micro → Meta):**
- Очки из матча = Soft валюта (Энергокристаллы) для апгрейда
- Волны пройдены = Шарды (тип башни = тип шарда, который дропает)
- PvP победа = PvP-очки → рейтинг → Battle Pass прогресс

**Планирование «завтра»:**
- Игрок видит: «До разблокировки башни Тайфун = ещё 8 шардов»
- Daily quest показывает: «Убей 30 крипов огнём → 50 шардов Огнемёта»
- Это = agenda на следующую сессию

---

### Macro Loop — «Долгосрочная фантазия» (недели+)

**Суть:** Стать легендарным командующим с полной коллекцией.

```
LONG GOAL                  COLLECTION / RANK / SEASON
──────────────────────────────────────────────────────────────────
Открыть все 15 башен    → «Полная арсенальная коллекция» — достижение
Прокачать героя до max  → Пассивная ability разблокирована
Подняться в PvP топ-100 → Сезонный скин / ранг «Адмирал»
Пройти все PvE главы    → Сюжетные разблокировки (лор жуков)
Сезон завершён          → Новая тема, новые башни, новые боссы
```

**LiveOps Hooks:**
- Weekly: «Турнир Жука» — специальные условия (только башни Common, 3 жизни)
- Monthly: «Вторжение класса Омега» — ивент-кооп против мега-босса
- Seasonal: новый тип башни (Legendary) доступен только в сезоне

---

### Narrative / Emotional Arc (per session)

```
СПОКОЙНО           НАРАСТАЕТ            ПИК               РАЗВЯЗКА
──────────────────────────────────────────────────────────────────
Хаб: выбор колоды  Волны 1–5 (обучение) Волна 8+: босс   Win / Lose screen
"Я готов"          "Хм, интересно..."   "Щас порвут!"    "Ещё раз!"
                                         merge в панике   награда
```

**Boss fight arc:** Жук-босс появляется без предупреждения после волны, которую игрок «уверенно» прошёл — это нарочный слом уверенности → heightened P2W moment (если честный — просто адреналин).

---

**Anti-patterns исключены:**
- ❌ Meta без micro: каждая пушка имеет тактильный visual feedback
- ❌ Micro без meta: шарды + апгрейд = причина играть завтра
- ❌ Macro без LiveOps: сезоны = 6 недель с новым контентом

---

**For Agents:**
- **GD** → Обновлён раздел GDD [2.0] Core Gameplay, [3.0] Economy & Progression
- **DEV** → Системы: SpawnManager, MergeGrid, ScoreSystem, SessionManager
- **ART** → Нужны: merge VFX (приоритет 1), death VFX крипов, score-popup prefab
- **PM** → KPI: измерять среднее время до первого merge в сессии (target ≤ 90 сек)

---

---

# ═══════════════════════════════════════
# АРТЕФАКТ 4 — UNITY MOBILE CHECKLIST
# `docs/tech/AiW_mobile_constraints_v0.1.md`
# ═══════════════════════════════════════

[STATUS:DRAFT]

### Unity Mobile Notes [ID:MOBILE_NOTES_AiW_MVP]

---

## БЛОК A: Performance Impact — Sprint 1 Assessment

| Компонент | Draw Calls | RAM | FPS Risk | Решение |
|---|---|---|---|---|
| 20 крипов одновременно | ~20-40 (при batching) | ~50 MB | 🟡 MEDIUM | GPU instancing + LOD |
| 2 типа башен × 10 шт | ~10-20 | ~20 MB | 🟢 LOW | Static batching |
| Патикль VFX × 5 систем | ~15-25 | ~30 MB | 🟡 MEDIUM | Pool, ограничить max particles |
| UI (HUD + Score) | ~5-10 | ~15 MB | 🟢 LOW | Canvas batching |
| Игровое поле (grid) | ~10-15 | ~40 MB | 🟢 LOW | Static |
| **ИТОГО** | **~60-100** | **~155 MB** | **🟡 MEDIUM** | В бюджете mid-tier |

**Performance Risk: MEDIUM → с оптимизациями = LOW к концу Sprint 1**

**Implementation Complexity: MEDIUM**
Sprint estimate Sprint 1: 3 недели DEV + 1 неделя QA/Polish

---

## БЛОК B: Prototyping Feasibility

- **Можно ли v0.1 с ProBuilder + примитивы?** ✅ ДА — Sprint 1 вся геометрия = ProBuilder tiles + cylinder-башни + capsule-крипы
- **Работает с простыми URP Lit материалами?** ✅ ДА — vertex color + simple textures достаточно
- **Без онлайн в прототипе?** ✅ ДА — PvE offline, очки локально
- **Без сложных анимаций в Sprint 1?** ✅ ДА — крипы = lerp movement, башни = rotation towards target

---

## БЛОК C: Mobile UX Reality

- **Управление одной рукой portrait?** ✅ — tap to place (нижняя зона), drag to merge (центр поля)
- **UI читается на 5" при солнце?** ⚠️ РИСК — score counter должен быть ≥32pt, высококонтрастный
- **Точки выхода для рекламы?** ✅ — Win/Lose screen = natural break point
- **Offline работа?** ✅ — PvE offline-first

---

## FTUE & Session Design

**Sprint 1 FTUE (3 шага, без текста):**
1. Поле пустое → пульсирующая подсветка слота → игрок тапает → башня появляется (ок)
2. Появляются крипы → идут по пути → башня стреляет сама → игрок понимает: «ах, вот как»
3. Вторая башня того же типа → highlight drag-зона → игрок сливает → MERGE VFX → ВАУ

**Session structure:**
- Волна 1–3: slow pace, 5–8 крипов, 0 боссов = обучение
- Волна 4–7: medium pace, 10 крипов, дебафф-крипы
- Волна 8–10: fast pace, 15 крипов + mini-boss = climax
- Total session: 5–8 мин

---

## Red Flags — что НЕ берём в Sprint 1

- ❌ Realtime PvP — DEV complexity × 10, сервера не готовы
- ❌ Процедурная генерация пути — нужен один хорошо настроенный фиксированный уровень
- ❌ Сложная физика крипов — движение по waypoints, не Rigidbody
- ❌ Второй PvE-режим (Волна) — Sprint 2
- ❌ Метагейм (колода, апгрейд, магазин) — Sprint 2+

---

## Economy & Monetization Checklist (для закладки в архитектуру)

- [x] Ресурсы определены: Soft (Энергокристаллы), Hard (Ионы), Шарды
- [x] Source → Sink: матч → Soft → апгрейд башни; кейс → Шарды → Lv башни
- [x] Rewarded ads ≤ 2× от обычного дропа
- [ ] Ценообразование IAP: финализировать в Этапе 3
- [x] Fairness: бесплатный игрок проходит все PvE главы без платного блока

---

**For Agents:**
- **GD** → Sprint 1 скоуп подтверждён: 1 режим + 2 башни + 10 волн
- **DEV** → GPU instancing обязателен для крипов; Object pooling для VFX и крипов
- **ART** → Texture atlas: всё в одном атласе 1024×1024 для Sprint 1
- **PM** → Метрика Sprint 1: crash-free ≥ 99%, FPS ≥ 30 на Snapdragon 665

---

---

# ═══════════════════════════════════════
# АРТЕФАКТ 5 — DESIGN HEURISTICS AUDIT
# `docs/GDD/AiW_design_heuristics_audit.md`
# ═══════════════════════════════════════

[STATUS:DRAFT]

---

## Design Heuristics Check — AiW MVP

### 9 Rules Audit

| # | Rule | Оценка | Комментарий | Рекомендация |
|---|---|---|---|---|
| 1 | **Player Promise** | ✅ | «Тактик-командующий» работает. Merge = трансформация, не upgrade = обещание выполнено | Подчеркнуть в FTUE: первый merge = кульминация обучения |
| 2 | **Clarity** | ⚠️ | TD + Merge = два концепта. Риск: игрок не понимает когда/зачем сливать | Визуальная подсказка: башни одного типа подсвечиваются при наведении |
| 3 | **Agency** | ✅ | Позиция башни + тайминг merge = meaningful choices. Проигрыш = видно где пробило | Показывать replay последних 5 сек после поражения |
| 4 | **Fair Challenge** | ⚠️ | Риск P2W через апгрейд шардами. В Sprint 1 нет IAP = OK. После = нужен матчмейкинг по уровню | Hard rule: PvP bracket по tier башен, не по кошельку |
| 5 | **Progression** | ✅ | Три уровня прогрессии (micro/meta/macro) заложены. Merge = instant visible progress | Числовой feedback: урон башни +15% после merge = обязателен |
| 6 | **Mastery** | ✅ | Синергии башен (огонь + замедление = × урон) = skill ceiling. Позиция = мастерство | Документировать 5+ синергий в GDD → обучить игрока через achievement |
| 7 | **Social** | ⚠️ | PvP = Этап 2+. Sprint 1 социального нет | Sprint 1 заменить social на «личный рекорд» волны — простейший retention hook |
| 8 | **Immersion** | ⚠️ | Alien sci-fi = задан. Звук = placeholder в Sprint 1. Риск: тихая игра = не immersive | Хотя бы 3 звука в Sprint 1: merge, выстрел, смерть крипа |
| 9 | **Retention** | ✅ | D1 hook = merge WOW. D7 hook = прокачка колоды. D30 = сезонный контент (в плане) | Обеспечить «открытие следующей башни» в конце первой сессии = retention anchor |

---

### 12 Tricks — Применение в AiW

| Trick | Применено? | Как конкретно |
|---|---|---|
| 1. Anchoring | ✅ Sprint 2+ | Магазин: «Пакет шардов стоит 1.99 — сравни: одиночный шард = 0.50» |
| 2. Loss Aversion | ✅ Сейчас | «Волна начнётся через 5 сек» — таймер перед волной создаёт срочность |
| 3. Endowed Progress | ✅ FTUE | В FTUE у игрока с первого матча = 3 шарда Огнемёта → визуально «я уже накопил» |
| 4. Variable Rewards | ✅ Sprint 2 | Кейс с шардами = рандомный тип внутри класса редкости |
| 5. Scarcity | ✅ | Поле = 15 слотов для башен. Нельзя ставить бесконечно = каждая позиция ценна |
| 6. Social Proof | 🔲 Sprint 2+ | Лидерборд «Топ волна этой недели» на Win screen |
| 7. Commitment | ✅ | Daily quest = маленькое «да» каждый день → недельная привязка |
| 8. Framing | ✅ Sprint 2 | Lose screen: «Ты дошёл до волны 7! Рекорд — волна 10. Улучши колоду» вместо «Проигрыш» |
| 9. Peak-End Rule | ✅ | Финальный босс = пик напряжения; Win screen = клин + анимация наград = хорошее завершение |
| 10. Sunk Cost | ✅ Sprint 2+ | «Ты вложил 200 шардов в этот тип башни» — выбор колоды = emotional investment |
| 11. Novelty | ✅ | Каждый merge = новый тип с другой механикой = постоянная новизна |
| 12. Completion | ✅ Sprint 2+ | Коллекция 15 башен с прогресс-баром = completion drive |

---

### Итоговые приоритеты по правилам

**Критично до Sprint 1:**
- Visual clarity: подсветка одинаковых башен (Rule 2)
- Личный рекорд вместо leaderboard (Rule 7 placeholder)
- Минимум 3 звука (Rule 8)

**До Soft Launch:**
- Replay after loss (Rule 3)
- Matcmaking по tier (Rule 4 — P2W safeguard)
- Achievement «Открой синергию» (Rule 6 — mastery)

---

**For Agents:**
- **GD** → Добавить в GDD раздел [2.3] Tower Synergies — список 5+ синергий как обязательный контент
- **DEV** → highlight-система башен одного типа = TASK-DEV-S1-005
- **ART/UIUX** → Личный рекорд на Win screen = TASK-UIUX-S1-003
- **PM** → A/B тест идеи: Endowed Progress в FTUE (3 шарда сразу vs 0) → target D1 +3pp

---

---

# ═══════════════════════════════════════
# АРТЕФАКТ 6А — ТЗ ДЛЯ DEV, Sprint 1
# `docs/agents/TZ_DEV_Sprint1_MVP.md`
# ═══════════════════════════════════════

# DEV-S1-001 — AiW: Тестовый билд PvE (Тропа-режим, Android)
[STATUS:DRAFT] | Агент: DEV | Sprint 1 (4 недели)

---

## 1. Context
**Project:** Alien in Waders (AiW)
**Related GDD blocks:** [ID:LOOPS_OVERVIEW], [ID:MOBILE_NOTES_AiW_MVP]
**Problem:** Нет работающего прототипа. Нужно подтвердить: merge-момент = ключевой hook, TD-управление портрет = OK, 30 FPS на mid-tier = реально.

---

## 2. Goal & Success Criteria
**Goal:** Работающий Android APK с PvE Тропа-режимом, 10 волнами, 2 башнями, merge-механикой.
**KPI impact:** Внутренние playtests — время до первого merge ≤90 сек, crash-free ≥99%, FPS ≥30 на ref device.

---

## 3. Scope of Work

**In-scope:**
- PvE сцена: П-образная тропа (фиксированный waypoint path)
- Grid для размещения башен (15 слотов по обе стороны пути)
- 2 типа башен: Огнемёт (AoE, атакует первого) + Крио-Пушка (замедление, single target)
- Merge-механика: 2 башни одного типа + одного Merge-Level → 1 башня следующего Merge-Level (Level cap = 3)
- SpawnManager: волны по конфигу (JSON/ScriptableObject), 10 волн, 2 типа крипов (Корабль-1, Корабль-2 — разный HP)
- ScoreSystem: +N очков за каждого убитого крипа, отображение в реальном времени, трата на Spawn башни
- Win condition: пережить все 10 волн
- Lose condition: любой крип достигает end-point
- Pause screen: Resume + Quit
- Build: Android APK, minSDK 26, IL2CPP

**Out-of-scope Sprint 1:**
- Волна-режим (bubble-shooter), герои, боссы
- Более 2 типов башен
- Метагейм, магазин, IAP, Battle Pass
- Online / серверная часть
- Готовый арт (placeholder = ProBuilder/primitives)
- Звук (кроме placeholder beep-level)

---

## 4. Inputs
**Files to read:**
- `docs/GDD/sections/AiW_GDD_2.0_CoreLoop.md` → Micro Loop, Win/Lose
- `docs/tech/AiW_mobile_constraints_v0.1.md` → Performance targets, FTUE structure
- `docs/agents/TZ_ART_Sprint1_MVP.md` → placeholder asset specs (polycount, atlas)

**Assumptions:**
- Unity 6 LTS + URP уже установлен
- Android Build Support + IL2CPP настроен
- Нет серверной части, весь state локально

---

## 5. Required Output

**Формат:** Unity Project + APK файл
**Структура сцен:**
- `Bootstrap.scene` — инициализация, GameManager
- `MainMenu.scene` — кнопка Play, заглушки
- `GamePlay_Path.scene` — основная игровая сцена (Тропа-режим)

**Конфиг данных (ScriptableObject или JSON):**
```
TowerConfig { 
  type: enum(FIRE, CRYO),
  mergeLevel: int (1..3),
  damage: float,
  attackRate: float,
  range: float,
  spawnCost: int
}

WaveConfig {
  waveNumber: int,
  creepCount: int,
  creepType: enum(SHIP_1, SHIP_2),
  spawnInterval: float,
  spawnDelay: float
}

CreepConfig {
  type: enum(SHIP_1, SHIP_2),
  hp: float,
  speed: float,
  reward: int
}
```

---

## 6. Constraints

**Platform:** Android, minSDK 26
**Unity:** 6 LTS + URP, IL2CPP
**Performance:**
- ≤ 100 draw calls (GPU instancing для крипов обязателен)
- FPS ≥ 30 на Samsung Galaxy A54 (Snapdragon 695 / Exynos 1280)
- RAM ≤ 400 MB total
- Object pooling для крипов и VFX-партиклей

**Analytics events required (Firebase / GameAnalytics — реализовать шину, даже без SDK):**
```
session_start         | { platform, device_model }
wave_started          | { wave_id }
wave_completed        | { wave_id, time_sec, towers_on_field }
tower_spawned         | { tower_type, merge_level, cost, field_slot_id }
tower_merged          | { tower_type, new_merge_level, slot_id }
creep_killed          | { creep_type, wave_id }
creep_escaped         | { creep_type, wave_id }
game_over             | { result: win|lose, waves_survived, total_score }
```

---

## 7. Acceptance Criteria

- [ ] APK собирается и запускается на Android minSDK 26 без краша
- [ ] 10 волн проходимы от начала до конца без freeze/crash
- [ ] Merge работает: 2 башни Level 1 → 1 башня Level 2 (с VFX)
- [ ] Score отображается в реальном времени, растёт при убийстве крипа
- [ ] Lose: крип достигает endpoint → показывается Lose screen
- [ ] Win: все 10 волн пройдены → Win screen
- [ ] FPS ≥ 30 при 20 крипах на сцене одновременно (Galaxy A54)
- [ ] Draw calls ≤ 100 в любой момент матча
- [ ] Analytics-события логируются в Debug.Log (SDK подключим в Sprint 2)
- [ ] Конфигурация волн и башен меняется без перекомпиляции (ScriptableObject/JSON)

---

## 8. Follow-ups
- DEV-S2-001: Волна-режим (bubble-shooter pathfinding)
- DEV-S2-002: Герой игрока (movement, HP, attack)
- DEV-S2-003: 5 типов башен вместо 2
- DEV-S1-005: Highlight-система башен одного типа (по запросу GD)

---

---

# ═══════════════════════════════════════
# АРТЕФАКТ 6Б — ТЗ ДЛЯ ART, Sprint 1
# `docs/agents/TZ_ART_Sprint1_MVP.md`
# ═══════════════════════════════════════

# ART-S1-001 — AiW: Placeholder-контент Sprint 1
[STATUS:DRAFT] | Агент: ART | Sprint 1

---

## 1. Context
Нужен минимальный набор визуального контента для тестового билда. Уровень: «понятно, но не финально». Арт используется для подтверждения gameplay читаемости, не маркетинга.

---

## 2. Goal & Success Criteria
**Goal:** Игрок за 5 сек понимает: где башня, где враг, куда идут враги, где их база.
**KPI:** 0 вопросов «куда мне нажать?» в первых playtest-сессиях.

---

## 3. Scope of Work

**In-scope Sprint 1:**
- Башня Огнемёт — 3 Merge-уровня (Lv1, Lv2, Lv3) = 3 вариации одной модели (цвет/размер/детали)
- Башня Крио-Пушка — 3 Merge-уровня
- Крип Корабль-1 (Common) — базовая форма
- Крип Корабль-2 (Tank) — крупнее, другой силуэт
- Игровое поле: tile-grid (8×12), path tile (подсвеченный), build slot tile
- Start point marker, End point marker (база)
- Particle FX: выстрел башни (fire / cryo), попадание в крипа, смерть крипа (3 системы)
- Score popup prefab (число +N, всплывает вверх)
- Merge VFX: яркая вспышка + частицы (0.5–0.8 сек, читаемо)

**Out-of-scope Sprint 1:**
- Герои, боссы-жуки
- Анимации ходьбы крипов (только lerp движение)
- Скины
- Финальный арт
- UI-арт (это UIUX-задача)

---

## 4. Required Output

**Формат:** Unity Prefabs + Materials (URP Lit/Simple Lit)

**Стиль (обязательно изучить!):**
- Art reference board: https://pin.it/2HReRzicu
- Ключевые черты: sci-fi top-down, яркие цвета (не тёмный) = читаемость, alien aesthetic, cartoon-light (не реализм)
- Цветовой код башен (ОБЯЗАТЕЛЕН для clarity): Огнемёт = красно-оранжевая гамма, Крио = сине-голубая
- Крипы = одна команда → единый стиль (металлик + чужеродные детали)
- ❌ НЕ использовать стилистику Random Dice (не кубики, не dice-visual language)

**Технические ограничения:**
- Polycount башня Lv1: ≤ 400 tri; Lv2 ≤ 600 tri; Lv3 ≤ 800 tri
- Polycount крип: ≤ 300 tri
- Polycount tile: ≤ 50 tri (они × 96 штук)
- Texture atlas: ВСЁ в одном 1024×1024 (башни + крипы + тайлы)
- Shader: URP Simple Lit (без normal maps в Sprint 1)
- VFX: ≤ 100 particles per system, Particle System (не VFX Graph в Sprint 1)
- ❌ Skinned Mesh Renderer для крипов не нужен (просто mesh)

**Силуэты (обязательно):**
- Башня Огнемёт = приземистый, широкий, горизонтальный ствол
- Башня Крио = узкий, вертикальный, с воронкой сверху
- Корабль-1 = маленький, быстрый вид, обтекаемый
- Корабль-2 = широкий, приплюснутый, «бронированный» вид

---

## 5. Acceptance Criteria

- [ ] Башня Lv1 и Lv2 отличаются на 100% (другой размер ИЛИ другая деталь, не только цвет)
- [ ] Корабль-1 и Корабль-2 различаются по силуэту с первого взгляда
- [ ] Огнемёт и Крио-Пушка — разный цвет, разный силуэт (ни один из них нельзя спутать)
- [ ] Всё в одном texture atlas ≤ 1024×1024
- [ ] Polycount соблюдён (проверить в Unity Stats)
- [ ] Merge VFX читается с телефона с расстояния 50 см
- [ ] Путь крипов читается (path tile ≠ build slot tile визуально)

---

## 6. Follow-ups
- ART-S2-001: Герой игрока (3 ориентации для top-down)
- ART-S2-002: Босс Жук-1 (placeholder)
- ART-S3-001: Финальный арт всех 6 башен Tier 1–3

---

---

# АРТЕФАКТ 6В — ТЗ ДЛЯ UIUX, Sprint 1
# `docs/agents/TZ_UIUX_Sprint1_MVP.md`

# UIUX-S1-001 — AiW: Игровые экраны Sprint 1
[STATUS:DRAFT] | Агент: UIUX | Sprint 1

---

## 1. Context
Нужен минимальный набор экранов для тестового билда. Стиль: функциональный, читаемый, mobile-first. Полноценный дизайн — Sprint 2+.

---

## 2. Scope

**Экраны Sprint 1 (5 штук):**

**Экран 1: Главное меню**
- Кнопка «PLAY» (большая, центр)
- Заглушки: Settings, Profile (иконки, не работают)
- Логотип AiW (placeholder — текст)

**Экран 2: Игровой HUD (основной)**
- TOP-LEFT: Score (число, крупно ≥28pt)
- TOP-CENTER: Wave indicator «Волна 3 / 10» 
- TOP-RIGHT: Pause button
- BOTTOM: Spawn Panel:
  - Кнопка «Огнемёт» (иконка башни + стоимость в очках)
  - Кнопка «Крио» (иконка башни + стоимость в очках)
  - Оба кнопки = серые если очков недостаточно (disabled state)
- Highlight одинаковых башен: при нажатии башни на поле — подсветить все того же типа
- Merge prompt: при наведении на подсвеченную башню = drag-target highlight

**Экран 3: Win Screen**
- «ВОЛНА ПРОЙДЕНА!» или «ПОБЕДА!» (если все 10)
- Score итоговый
- Личный рекорд (если побит)
- Две кнопки: «ЕЩЁ РАЗ» + «МЕНЮ»

**Экран 4: Lose Screen**
- «Волна N — крип прорвался» (readable failure!)
- Текущий рекорд
- «ПОПРОБОВАТЬ СНОВА» + «МЕНЮ»

**Экран 5: Pause**
- Затемнённый overlay
- «ПРОДОЛЖИТЬ» + «СДАТЬСЯ»

---

## 3. UX Требования (обязательны)

- **Portrait mode ONLY** во всём Sprint 1
- **Touch target ≥ 48dp** для всех интерактивных элементов
- **Spawn кнопки**: зона — нижняя 1/5 экрана, thumb reach zone
- **Score**: контрастный текст (белый на тёмном или чёрный на светлом), не перекрывает поле
- **Цветовой код типов башен** проходит через HUD: иконка кнопки Spawn = тот же цвет что башня на поле
- **Никаких попапов / реклам / FTUE-экранов в первые 2 минуты** (Sprint 1 = pure gameplay)
- **Readable failure rule:** Lose screen ЯВНО показывает что произошло («Крип пробился на волне 7»), не просто «Проигрыш»

---

## 4. Стиль (ориентир)

- Референс: sci-fi mobile UI (Kingdom Rush, Merge TD подход: чистый, функциональный)
- Шрифт: sans-serif, bold для чисел
- Цвета UI: нейтральный фон (тёмный, не перекрывает яркое поле), акцентные кнопки
- ❌ Без сложных анимаций UI в Sprint 1 (только fade in/out)

---

## 5. Acceptance Criteria

- [ ] Все 5 экранов реализованы в Unity Canvas
- [ ] Score обновляется в реальном времени без lag
- [ ] Spawn кнопки корректно переходят в disabled state при нехватке очков
- [ ] Lose screen показывает номер волны, на которой проиграл
- [ ] Все touch targets ≥ 48dp (проверить в Device Simulator)
- [ ] UI корректно отображается на 5" (1280×720) и 6.5" (2400×1080)

---

**For Agents:**
- **DEV** → Реализовать UIManager, подписаться на события ScoreSystem и WaveManager
- **ART** → Предоставить иконки башен (2 шт) в sprite format для кнопок Spawn

---

---

# ═══════════════════════════════════════
# АРТЕФАКТ 7 — МАТРИЦА СУЩНОСТЕЙ ПУШЕК AiW
# `docs/GDD/sections/AiW_GDD_2.2_Towers_EntityMatrix.md`
# ═══════════════════════════════════════

[ID:TOWERS_MATRIX] [STATUS:DRAFT]

**Принцип:** Механические паттерны адаптированы из реверса Random Dice (35 кубиков). Арт — оригинальный sci-fi (Pinterest ref). Названия — новые.

**Система Merge:** 2 башни Lv N одного типа → 1 башня Lv N+1. Max Lv = 7 (аналог Random Dice pips). Каждый Lv = +15% к базовым статам + разблокировка визуального апгрейда.

**Формулы прогрессии (из RD):**
```
Damage_Lv    = BaseDmg × (1 + 0.15 × (Lv - 1))
DoT_Lv       = BaseDoT × MergeLv + LevelBonus
PassiveBuff_Lv = BaseBonus × MergeLv + LevelBonus
EcoPassive_Lv  = BaseEco × MergeLv + LevelBonus
```

---

## COMMON TOWERS (4 типа, базовые)

### [T-001] INCINERATOR — Огнемёт
**Прообраз:** Fire Die (Огненный кубик)
**Механика:** Атакует первого крипа на пути, наносит базовый урон + урон по области ближайшим.
**Тип урона:** Огонь (AoE)
**Редкость:** Common ⭐
**Merge-эффект:** Каждый уровень merge = +15% базового урона + +10% радиус AoE
**Синергия:** Крио-Пушка рядом = крипы замедлены → Огнемёт атакует дольше = ×1.3 эффективность

| Stat | Lv 1 | Lv 3 | Lv 5 | Lv 7 |
|---|---|---|---|---|
| Damage | 50 | 76 | 101 | 127 |
| AoE Radius | 1.5 | 1.8 | 2.1 | 2.4 |
| Attack Rate | 1.0/sec | 1.0/sec | 1.0/sec | 1.0/sec |
| Spawn Cost | 30 pts | — | — | — |

---

### [T-002] CRYO-CANNON — Крио-Пушка
**Прообраз:** Ice Die (Ледяной кубик)
**Механика:** Атакует первого крипа, накладывает стак замедления. Макс 3 стака. Максимальное замедление 50%.
**Тип урона:** Лёд (CC)
**Редкость:** Common ⭐
**Merge-эффект:** Каждый Lv merge = +5% сила замедления per стак

| Stat | Lv 1 | Lv 3 | Lv 5 | Lv 7 |
|---|---|---|---|---|
| Slow per stack | 15% | 20% | 25% | 30% |
| Max stacks | 3 | 3 | 3 | 3 |
| Max total slow | 45% | 60% | 75% | 90% |
| Attack Rate | 0.8/sec | 0.8/sec | 0.8/sec | 0.8/sec |
| Spawn Cost | 30 pts | — | — | — |

---

### [T-003] ARC-BLASTER — Дуговой Разрядник
**Прообраз:** Electric Die (Электрический кубик)
**Механика:** Атакует первого крипа, цепная молния: второй крип получает 70% урона, третий — 30%.
**Тип урона:** Электро (Chain)
**Редкость:** Common ⭐
**Merge-эффект:** Каждый Lv = +1 цель в цепи (Lv1=3 цели, Lv7=9 целей)

| Stat | Lv 1 | Lv 3 | Lv 5 | Lv 7 |
|---|---|---|---|---|
| Base Damage | 40 | 61 | 81 | 101 |
| Chain targets | 3 | 5 | 7 | 9 |
| Chain falloff | 70%/30% | 70%/30% | 70%/30% | 70%/30% |
| Spawn Cost | 35 pts | — | — | — |

---

### [T-004] SCATTER-BLASTER — Хаотик
**Прообраз:** Glitch Die (Сбоящий кубик)
**Механика:** Атакует случайного крипа. Урон варьируется ±20% от базы (high variance, gambling feel).
**Тип урона:** Хаос
**Редкость:** Common ⭐
**Merge-эффект:** Каждый Lv = сужение variance ±2% AND +урон (парадокс: лучше ≠ предсказуемее)

| Spawn Cost | 25 pts |
|---|---|

---

## UNCOMMON TOWERS (3 типа)

### [T-005] BIO-SPRAYER — Биораспылитель
**Прообраз:** Poison Die (Ядовитый кубик)
**Механика:** Атакует первого крипа без яда → накладывает DoT-яд. Урон от яда × MergeLv каждую секунду.
**Тип урона:** Яд (DoT)
**Редкость:** Uncommon ⭐⭐
**Merge-эффект:** DoT_Lv = 20 × MergeLv + 5 × (Lv-1) — формула прямо из RD
**Синергия:** Крио (замедление) → цели дольше в зоне яда = × DoT тикает больше раз

---

### [T-006] HEAVY-RAILGUN — Рельсотрон
**Прообраз:** Iron Die (Железный кубик)
**Механика:** Атакует СИЛЬНЕЙШЕГО крипа на поле (самый высокий HP). Двойной урон боссам и мини-боссам.
**Тип урона:** Физика (Single, Anti-Boss)
**Редкость:** Uncommon ⭐⭐
**Merge-эффект:** +15% урон per Lv, boss multiplier ×2 → ×3 к Lv 5

---

### [T-007] OVERCLOCK — Адвентурист
**Прообраз:** Adventurer Die (Кубик авантюриста)
**Механика:** Базовый урон + случайный бонус от 1 до критического порога (CritValue). Формула: (Base) + random(1, CritValue).
**Тип урона:** Физика + Крит (RNG)
**Редкость:** Uncommon ⭐⭐
**Merge-эффект:** CritValue растёт с Lv → риск/награда нарастает

---

## RARE TOWERS (4 типа)

### [T-008] BEAM-LANCE — Лазерная Пика
**Прообраз:** Laser Die (Лазерный кубик)
**Механика:** Атакует первого крипа, урон нарастает с каждым выстрелом по одной цели (Lv1=10→20→30...). Смена цели = сброс накопленного урона.
**Тип урона:** Энергия (Ramp-up)
**Редкость:** Rare ⭐⭐⭐
**Merge-эффект:** Ускорение нарастания урона (fewer shots to reach same ramp value)

---

### [T-009] OVERCHARGE-NODE — Узел Перегрузки
**Прообраз:** Light Die (Световой кубик) — PASSIVE
**Механика:** НЕ АТАКУЕТ. Повышает скорость атаки всех соседних башен.
**Тип:** Баф (Passive Support)
**Редкость:** Rare ⭐⭐⭐
**Merge-эффект:** Buff_Lv = 10% × MergeLv + 3% × (Lv-1)
**Синергия:** Лучше всего рядом с Beam-Lance (ускоряет ramp) или Typhoon-Storm

---

### [T-010] AIM-MODULE — Прицельный Модуль
**Прообраз:** Critical Die (Критический кубик) — PASSIVE
**Механика:** НЕ АТАКУЕТ. Повышает шанс критического удара всех соседних башен.
**Тип:** Баф (Passive, Crit%)
**Редкость:** Rare ⭐⭐⭐
**Merge-эффект:** CritChance_Lv = 8% × MergeLv + 2% × (Lv-1)

---

### [T-011] ENERGY-HARVESTER — Энергосборщик
**Прообраз:** Miner Die (Шахтёрский кубик) — PASSIVE
**Механика:** НЕ АТАКУЕТ. Производит очки (soft валюта) каждые несколько секунд.
**Тип:** Экономика (Passive Income)
**Редкость:** Rare ⭐⭐⭐
**Merge-эффект:** Income_Lv = BaseIncome × MergeLv + LevelBonus
**Риск дизайна:** ⚠️ Слот занят под «не-башню» — игрок должен понимать трейдофф. Требует обучения. Можно сделать Uncommon → Rare unlock.

---

## EPIC TOWERS (3 типа)

### [T-012] PHASE-STORM — Штормовая Фаза
**Прообраз:** Typhoon Die (Тайфунный кубик)
**Механика:** Циклично меняет фазы: Фаза 1 (6 сек, обычная атака) → Фаза 2 (4 сек, высокая скорость) → Фаза 3 (1 сек, максимальная скорость + 100% крит).
**Тип урона:** Физика (Phase)
**Редкость:** Epic ⭐⭐⭐⭐
**Merge-эффект:** Сокращение длительности Фазы 1 (-0.5 сек/Lv), удлинение Фазы 3 (+0.2 сек/Lv)

---

### [T-013] SPORE-CANNON — Споровая Пушка
**Прообраз:** Virus Die (Вирусный кубик)
**Механика:** Атакует первого незаражённого крипа. При убийстве заражённого = в точке смерти остаётся ядовитое облако AoE × сек. Урон облака = BaseGas × MergeLv + LevelBonus.
**Тип урона:** Яд (AoE-on-kill)
**Редкость:** Epic ⭐⭐⭐⭐
**Merge-эффект:** Gas_Lv = 30 × MergeLv + 8 × (Lv-1); радиус +0.2/Lv

---

### [T-014] SINGULARITY-CORE — Ядро Сингулярности
**Прообраз:** Nuclear Die (Ядерный кубик)
**Механика:** Базовая атака. При merge с таким же типом = ядерный удар: все обычные крипы на поле уничтожаются мгновенно, боссам наносится 20% × MergeLv от макс HP.
**Тип урона:** Ядерный (Burst, Merge-Trigger)
**Редкость:** Epic ⭐⭐⭐⭐
**Merge-эффект:** Boss nuke % = 20% × MergeLv. Этот тип НЕЛЬЗЯ иметь более 2 на поле — механическое ограничение.

---

## LEGENDARY TOWERS (1 тип)

### [T-015] ADAPTIVE-ARMORY — Адаптивный Арсенал
**Прообраз:** Arsenal Die (Кубик-арсенал) — FLAGSHIP
**Механика:** Атака МЕНЯЕТСЯ в зависимости от текущего MergeLv:
- Lv 1–2: Пистолет → одиночный выстрел, быстрый (1 цель)
- Lv 3–4: Спарка → вдвое быстрее (1 цель)
- Lv 5–6: Дробовик → атакует N крипов одновременно (N = Lv)
- Lv 7: Снайпер → мгновенное убийство обычного крипа, 20% HP боссам
**Тип урона:** Адаптивный (форма меняется с уровнем)
**Редкость:** Legendary ⭐⭐⭐⭐⭐
**Merge-эффект:** Каждый Lv = смена режима атаки → игрок активно стремится к следующему merge

---

## СВОДНАЯ ТАБЛИЦА

| # | Название | Прообраз RD | Тип | Редкость | Sprint |
|---|---|---|---|---|---|
| T-001 | Incinerator | Fire Die | Огонь AoE | Common ⭐ | **Sprint 1** |
| T-002 | Cryo-Cannon | Ice Die | Лёд CC | Common ⭐ | **Sprint 1** |
| T-003 | Arc-Blaster | Electric Die | Электро Chain | Common ⭐ | Sprint 2 |
| T-004 | Scatter-Blaster | Glitch Die | Хаос | Common ⭐ | Sprint 2 |
| T-005 | Bio-Sprayer | Poison Die | Яд DoT | Uncommon ⭐⭐ | Sprint 2 |
| T-006 | Heavy-Railgun | Iron Die | Физика Anti-Boss | Uncommon ⭐⭐ | Sprint 2 |
| T-007 | Overclock | Adventurer Die | Физика + Крит | Uncommon ⭐⭐ | Sprint 2 |
| T-008 | Beam-Lance | Laser Die | Энергия Ramp | Rare ⭐⭐⭐ | Этап 2 |
| T-009 | Overcharge-Node | Light Die | Passive Buff | Rare ⭐⭐⭐ | Этап 2 |
| T-010 | Aim-Module | Critical Die | Passive Crit | Rare ⭐⭐⭐ | Этап 2 |
| T-011 | Energy-Harvester | Miner Die | Passive Eco | Rare ⭐⭐⭐ | Этап 2 |
| T-012 | Phase-Storm | Typhoon Die | Физика Phase | Epic ⭐⭐⭐⭐ | Этап 3 |
| T-013 | Spore-Cannon | Virus Die | Яд AoE-on-kill | Epic ⭐⭐⭐⭐ | Этап 3 |
| T-014 | Singularity-Core | Nuclear Die | Ядерный Burst | Epic ⭐⭐⭐⭐ | Этап 3 |
| T-015 | Adaptive-Armory | Arsenal Die | Адаптивный | Legendary ⭐⭐⭐⭐⭐ | Этап 3 |

---

**For Agents:**
- **GD** → Обновить раздел GDD [2.1] Tower Types с этой матрицей
- **DEV** → Реализовать TowerConfig SO для T-001 и T-002 в Sprint 1; остальные = заготовки config
- **ART** → Силуэты T-001 и T-002 приоритет; T-003 до T-007 = Sprint 2 арт
- **PM** → Гипотеза: Legendary башня T-015 = главный aspiration-item, показывать в магазине с первого дня (но дорого)

---

---

# ═══════════════════════════════════════
# АРТЕФАКТ 8 — FREE ASSET LIST Sprint 1
# `docs/assets/AiW_free_asset_list_Sprint1.md`
# ═══════════════════════════════════════

[STATUS:DRAFT]

**Принцип:** Только для Sprint 1 placeholder. Все ассеты заменяются на оригинальный арт в Sprint 2–3. Attribution фиксируется в CREDITS.md.

---

## Рекомендуемые ассеты

| ID | Название | Тип | Источник | Лицензия | Использование в AiW | Attribution |
|---|---|---|---|---|---|---|
| A-001 | Kenney — Space Shooter Redux | 2D sprites (можно как icon refs) | kenney.nl/assets/space-shooter-redux | CC0 | Иконки для UI кнопок Spawn (temp) | Нет |
| A-002 | Kenney — Sci-Fi RTS Pack | 3D low-poly turrets + units | kenney.nl/assets/sci-fi-rts | CC0 | Placeholder-меши башен T-001, T-002 | Нет |
| A-003 | Kenney — Modular Buildings | 3D building tiles | kenney.nl/assets/modular-buildings | CC0 | Grid tiles для игрового поля | Нет |
| A-004 | Quaternius — Lowpoly Spaceships | 3D low-poly ships | quaternius.com (Unity Asset Store free) | CC0 | Placeholder крипы Корабль-1, Корабль-2 | Нет |
| A-005 | Kenney — Particle Pack | Unity particle presets | kenney.nl/assets/particle-pack | CC0 | Hit VFX, Death VFX placeholder | Нет |
| A-006 | Kenney — Interface Sounds | SFX | kenney.nl/assets/interface-sounds | CC0 | UI click, wave start, score popup | Нет |
| A-007 | Kenney — Digital Audio | SFX | kenney.nl/assets/digital-audio | CC0 | Выстрел башни, merge звук (temp) | Нет |
| A-008 | DOTween Free | Animation tween library | Unity Asset Store (Free) | Free | UI анимации, merge scale pop | Нет |
| A-009 | TextMeshPro | Text rendering | Встроен в Unity | Unity ToS | Все тексты в игре | Нет |

---

## Чеклист перед использованием

- [x] Все ассеты — CC0 (нет требований attribution)
- [x] Совместимы с Unity 6 + URP (Kenney = mesh only, material = наш)
- [x] Размер: Kenney паки ≤ 10 MB каждый
- [x] Стиль: соответствуют sci-fi/top-down aesthetic
- [ ] Добавить A-001..A-009 в `asset_registry.md` с путями после импорта
- [ ] Создать `CREDITS.md` в корне проекта (даже при CC0 = good practice)

---

## Что искать самостоятельно (рекомендации для ART-агента)

Если Kenney Sci-Fi RTS не даёт нужный силуэт — поиск на itch.io по запросам:
- `"tower defense" "3D" "low poly" "free"` → itch.io/game-assets/free
- `"space shooter" "top down" "unity"` → itch.io

Авторы itch.io с хорошим sci-fi low-poly контентом: **Kay Lousberg** (kaylousberg.itch.io), **Quaternius** (quaternius.itch.io).

---

**For Agents:**
- **DEV** → Импортировать A-001..A-009 в Unity Project, настроить URP materials
- **ART** → Использовать как геометрические референсы для понимания poly budget; заменить оригинальным арт в Sprint 2
- **PM** → Создать `asset_registry.md`, зафиксировать все ассеты Sprint 1

---

---

# ═══════════════════════════════════════
# DECISIONS LOG — Sprint 0
# `docs/brain/decisions_log.md`
# ═══════════════════════════════════════

| Date | ID | Решение | Причина | Импакт |
|---|---|---|---|---|
| Sprint 0 | DEC-001 | Sprint 1 = только режим Тропа (НЕ Волна) | 2 pathfinding в спринте = риск срыва | DEV: один NavMesh, ART: одно поле, UIUX: один HUD |
| Sprint 0 | DEC-002 | Sprint 1 = 2 башни (T-001 + T-002) из 15 | Валидировать merge-механику на минимуме | DEV: 2 TowerConfig SO |
| Sprint 0 | DEC-003 | Realtime PvP → async/bot первые 3 этапа | Mobile latency risk, нет сервера в прототипе | DEV: не закладывать realtime networking до Этапа 4 |
| Sprint 0 | DEC-004 | Арт из Random Dice НЕ использовать | IP / стиль конкурента, оригинальная эстетика важна для UA | ART: Pinterest board = единственный visual ref |
| Sprint 0 | DEC-005 | P2W safeguard: matchmaking по tower tier, не IAP | Честная F2P = retention > краткосрочный revenue | PM: заложить bracket-систему в Этапе 3 |

---

# ═══════════════════════════════════════
# SUMMARY — ЧТО ГОТОВО К ДЕПЛОЮ
# ═══════════════════════════════════════

## Пакет документации Sprint 0 → Sprint 1

| Артефакт | Файл | Статус | Получатель |
|---|---|---|---|
| Concept Intake | `docs/intake/AiW_concept_intake.md` | ✅ DRAFT | GD, PM |
| One Page Concept | `docs/concepts/AiW_one_pager_v0.1.md` | ✅ DRAFT | ALL |
| Core Loops | `docs/GDD/sections/AiW_GDD_2.0_CoreLoop.md` | ✅ DRAFT | DEV, PM |
| Mobile Checklist | `docs/tech/AiW_mobile_constraints_v0.1.md` | ✅ DRAFT | DEV |
| Design Heuristics | `docs/GDD/AiW_design_heuristics_audit.md` | ✅ DRAFT | GD, PM |
| TZ DEV Sprint 1 | `docs/agents/TZ_DEV_Sprint1_MVP.md` | ✅ DRAFT | DEV |
| TZ ART Sprint 1 | `docs/agents/TZ_ART_Sprint1_MVP.md` | ✅ DRAFT | ART |
| TZ UIUX Sprint 1 | `docs/agents/TZ_UIUX_Sprint1_MVP.md` | ✅ DRAFT | UIUX |
| Tower Entity Matrix | `docs/GDD/sections/AiW_GDD_2.2_Towers_EntityMatrix.md` | ✅ DRAFT | DEV, ART, PM |
| Free Asset List | `docs/assets/AiW_free_asset_list_Sprint1.md` | ✅ DRAFT | DEV, ART |
| Decisions Log | `docs/brain/decisions_log.md` | ✅ DRAFT | ALL |

## 🟢 КРИТЕРИЙ ГОТОВНОСТИ К ДЕПЛОЮ: ВЫПОЛНЕН

DEV может стартовать Sprint 1 без блокирующих вопросов.  
ART получил visual reference direction + технические ограничения.  
UIUX получил все экраны + UX constraints.  
PM получил roadmap + KPIs + decisions log.
