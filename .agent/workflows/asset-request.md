# WORKFLOW: /asset-request [тип] [описание]

# Триггер: /asset-request sprite "персонаж 2D cartoon 256px"

# Агент-инициатор: DEV или UIUX

Создать запрос в `.agent/artifacts/asset_request_[timestamp].md`:

```
## ASSET REQUEST — [Дата]
Запросил: DEV / UIUX
Тип: Sprite / Audio / Font / Particle / Prefab
Описание: [точное описание]
Используется в: [сцена / экран / система]
Нужен к: [дата / TASK-ID]
Критичность: P0 / P1 / P2
```

ART читает запрос → ищет ассет → обновляет `asset_registry.md` → сообщает статус.
