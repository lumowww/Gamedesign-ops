# SKILL: PowerShell Fix

**Описание:** Диагностика и исправление проблем PowerShell окружения

**Диагностика:**
```powershell
# Проверка версии PowerShell
$PSVersionTable.PSVersion

# Проверка execution policy
Get-ExecutionPolicy -List

# Проверка переменных окружения
Get-ChildItem Env:

# Проверка текущего пути
Get-Location

# Проверка доступных команд
Get-Command <command_name>
```

**Исправление проблем:**
```powershell
# Если execution policy блокирует скрипты
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

# Если путь не существует
Test-Path <path>

# Если команда не найдена
Get-Module -ListAvailable | Select-String <command>

# Очистка кеша PowerShell
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\PSModuleAnalysisCacheReport.dat" -Force -ErrorAction SilentlyContinue
```

**Совместимость:**
- PowerShell: `$var`, `Get-ChildItem`, `Select-String`, `Out-File`
- cmd.exe: `%var%`, `dir`, `findstr`, `echo >`

**RBAC:** DEV (автономно, риск: НИЗКИЙ)
