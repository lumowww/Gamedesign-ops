# Unity Test Runner Script for GAMEDEVGD
# Запускает тесты Unity Test Framework через командную строку
# Использование: .\scripts\run-tests.ps1 [-Category Runtime|Editor] [-Filter <pattern>] [-OpenRunner]

param(
    [string]$Category = "",
    [string]$Filter = "",
    [switch]$OpenRunner,
    [switch]$Coverage,
    [switch]$Help
)

$PROJECT_ROOT = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$UNITY_PROJECT_PATH = $PROJECT_ROOT
$LOG_FILE = Join-Path $PROJECT_ROOT "TestResults\test-results.xml"

function Show-Help {
    Write-Host @"
Unity Test Runner для GAMEDEVGD

Использование:
  .\scripts\run-tests.ps1 [параметры]

Параметры:
  -Category <Runtime|Editor>  Запустить только тесты указанной категории
  -Filter <pattern>           Фильтр по имени теста (NUnit filter)
  -OpenRunner                 Открыть Unity Test Runner в редакторе
  -Coverage                   Сгенерировать отчёт о покрытии (требует Unity Coverage)
  -Help                       Показать эту справку

Примеры:
  .\scripts\run-tests.ps1                          # Запустить все тесты
  .\scripts\run-tests.ps1 -Category Runtime        # Только Runtime тесты
  .\scripts\run-tests.ps1 -Filter MCP              # Тесты с 'MCP' в имени
  .\scripts\run-tests.ps1 -OpenRunner              # Открыть Test Runner UI

"@
    exit 0
}

function Test-UnityInstalled {
    # Проверка наличия Unity в системе
    $unityPaths = @(
        "C:\Program Files\Unity\Hub\Editor",
        "C:\Program Files (x86)\Unity\Hub\Editor",
        "$env:LOCALAPPDATA\Unity\Hub\Editor"
    )
    
    foreach ($path in $unityPaths) {
        if (Test-Path $path) {
            return $true
        }
    }
    
    Write-Warning "Unity не найден в стандартных путях установки"
    return $false
}

function Find-UnityEditor {
    # Поиск последней версии Unity Editor
    $unityPaths = @(
        "C:\Program Files\Unity\Hub\Editor",
        "C:\Program Files (x86)\Unity\Hub\Editor",
        "$env:LOCALAPPAPPDATA\Unity\Hub\Editor"
    )
    
    $latestVersion = $null
    $latestPath = $null
    
    foreach ($basePath in $unityPaths) {
        if (Test-Path $basePath) {
            $versions = Get-ChildItem -Path $basePath -Directory | Sort-Object Name -Descending
            if ($versions.Count -gt 0) {
                $latestVersion = $versions[0].Name
                $latestPath = Join-Path $basePath $latestVersion
                break
            }
        }
    }
    
    if ($latestPath) {
        return Join-Path $latestPath "Editor\Unity.exe"
    }
    
    return $null
}

function Run-UnityTests {
    param(
        [string]$UnityExe,
        [string]$ProjectPath,
        [string]$TestCategory,
        [string]$TestFilter,
        [string]$LogFile
    )
    
    $testArgs = @(
        "-batchmode"
        "-nographics"
        "-projectPath", $ProjectPath
        "-runTests"
        "-testPlatform", "PlayMode"
        "-testResults", $LogFile
        "-logFile", (Join-Path $PROJECT_ROOT "TestResults\unity-test.log")
    )
    
    if ($TestCategory -eq "Editor") {
        $testArgs[5] = "EditMode"
    }
    
    if ($TestFilter) {
        $testArgs += "-testFilter", $TestFilter
    }
    
    Write-Host "Запуск Unity тестов..."
    Write-Host "Unity: $UnityExe"
    Write-Host "Проект: $ProjectPath"
    Write-Host "Категория: $TestCategory"
    Write-Host "Фильтр: $TestFilter"
    Write-Host "Результаты: $LogFile"
    Write-Host ""
    
    # Создание директории для результатов
    $logDir = Split-Path $LogFile -Parent
    if (!(Test-Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
    }
    
    # Запуск Unity
    $processInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processInfo.FileName = $UnityExe
    $processInfo.Arguments = $testArgs -join " "
    $processInfo.RedirectStandardOutput = $true
    $processInfo.RedirectStandardError = $true
    $processInfo.UseShellExecute = $false
    $processInfo.CreateNoWindow = $true
    
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $processInfo
    $process.Start() | Out-Null
    
    $output = $process.StandardOutput.ReadToEnd()
    $errorOutput = $process.StandardError.ReadToEnd()
    
    $process.WaitForExit()
    
    if ($process.ExitCode -eq 0) {
        Write-Host "✓ Тесты завершены успешно!" -ForegroundColor Green
        Write-Host "Результаты: $LogFile"
        
        if (Test-Path $LogFile) {
            Write-Host ""
            Write-Host "Результаты тестов:"
            Get-Content $LogFile | Select-Object -First 50
        }
    }
    else {
        Write-Host "✗ Тесты провалились с кодом: $($process.ExitCode)" -ForegroundColor Red
        if ($errorOutput) {
            Write-Host "Ошибки:"
            Write-Host $errorOutput -ForegroundColor Red
        }
    }
    
    return $process.ExitCode
}

function Open-TestRunner {
    Write-Host "Открытие Unity Test Runner..."
    Write-Host "В Unity Editor перейдите: Window > General > Test Runner"
    Write-Host ""
    Write-Host "Или используйте меню: Tests > Run All Tests"
}

function Run-AgentTests {
    Write-Host "Запуск тестов агентских workflows..."
    
    $agentTestDir = Join-Path $PROJECT_ROOT ".agent\tests"
    
    if (!(Test-Path $agentTestDir)) {
        Write-Warning "Директория агентских тестов не найдена: $agentTestDir"
        return 1
    }
    
    # Проверка наличия Python и pytest
    $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    if (!$pythonCmd) {
        Write-Warning "Python не найден. Пропускаем агентские тесты."
        return 0
    }
    
    # Установка зависимостей
    $requirementsFile = Join-Path $agentTestDir "requirements.txt"
    if (Test-Path $requirementsFile) {
        Write-Host "Установка зависимостей Python..."
        & python -m pip install -r $requirementsFile -q
    }
    
    # Запуск pytest
    Write-Host "Запуск pytest..."
    $pytestResult = & python -m pytest $agentTestDir -v --tb=short
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Агентские тесты пройдены!" -ForegroundColor Green
    }
    else {
        Write-Host "✗ Агентские тесты провалились" -ForegroundColor Red
    }
    
    return $LASTEXITCODE
}

# Main script
if ($Help) {
    Show-Help
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GAMEDEVGD Test Runner" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Проверка Unity
if (!(Test-UnityInstalled)) {
    Write-Warning "Unity не найден. Запускаем только агентские тесты."
    Run-AgentTests
    exit 0
}

# Поиск Unity Editor
$unityExe = Find-UnityEditor
if (!$unityExe) {
    Write-Warning "Unity Editor не найден. Запускаем только агентские тесты."
    Run-AgentTests
    exit 0
}

# Открытие Test Runner
if ($OpenRunner) {
    Open-TestRunner
    exit 0
}

# Запуск Unity тестов
$exitCode = Run-UnityTests `
    -UnityExe $unityExe `
    -ProjectPath $UNITY_PROJECT_PATH `
    -TestCategory $Category `
    -TestFilter $Filter `
    -LogFile $LOG_FILE

# Запуск агентских тестов
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Agent Tests" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$agentExitCode = Run-AgentTests

# Итоговый результат
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Итоговые результаты" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($exitCode -eq 0 -and $agentExitCode -eq 0) {
    Write-Host "✓ ВСЕ ТЕСТЫ ПРОЙДЕНЫ!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "✗ НЕКОТОРЫЕ ТЕСТЫ ПРОВАЛИЛИСЬ" -ForegroundColor Red
    exit 1
}
