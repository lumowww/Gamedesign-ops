# SKILL: Environment Healing

**Описание:** Автономное восстановление окружения при типовых проблемах

## Уровень риска: НИЗКИЙ (автономно)

### Виртуальное окружение Python
```powershell
# Проверка venv
Test-Path .venv\Scripts\Activate.ps1

# Активация
.venv\Scripts\Activate.ps1

# Если не существует — создать
python -m venv .venv
```

### Node.js зависимости
```powershell
# Проверка node_modules
Test-Path node_modules

# Установка при отсутствии
npm install

# Очистка кеша (риск: СРЕДНИЙ)
npm cache clean --force
```

### Docker сервисы
```powershell
# Проверка running контейнеров
docker ps

# Перезапуск сервиса
docker-compose restart <service>
```

### Git
```powershell
# Проверка статуса
git status

# Если есть незакоммиченные изменения — предупредить
# Если detached HEAD — предупредить
```

## Уровень риска: СРЕДНИЙ (автономно + лог)

- Очистка `.cache/`, `temp/`, `Logs/old/`
- `docker-compose down && docker-compose up -d`
- Пересоздание `.qwen/` директорий

## Уровень риска: ВЫСОКИЙ (тикет человеку)

- Удаление `.lock` файлов
- Изменение конфигов (кроме `.dev.env`)
- `git reset --hard`

## Уровень риска: ОЧЕНЬ ВЫСОКИЙ (запрещено)

- Изменение `config/prod.*`
- Работа с production данными
- `sudo` / запуск от администратора

**RBAC:** DEV (автономно для НИЗКИЙ/СРЕДНИЙ)
