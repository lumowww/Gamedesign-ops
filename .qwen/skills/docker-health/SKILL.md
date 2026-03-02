# SKILL: Docker Health Check

**Описание:** Проверка состояния Docker-контейнеров и сервисов

**Команды:**
```powershell
# Проверка статуса контейнеров
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Проверка health конкретного контейнера
docker inspect --format='{{.State.Health.Status}}' <container_name>

# Проверка портов
docker port <container_name>

# Просмотр логов (последние 50 строк)
docker logs <container_name> --tail 50

# Тест endpoint (curl)
curl -s http://localhost:<port>/health
```

**Критерии здоровья:**
- ✅ Контейнер в статусе `Up`
- ✅ Health check возвращает `healthy`
- ✅ Порты мапятся корректно
- ✅ Логи без ошибок уровня ERROR/FATAL

**Действия при проблемах:**
1. `docker restart <container>` — перезапуск
2. `docker-compose restart <service>` — restart через compose
3. Создать тикет если не помогает (риск: ВЫСОКИЙ)

**RBAC:** DEV (автономно, риск: НИЗКИЙ)
