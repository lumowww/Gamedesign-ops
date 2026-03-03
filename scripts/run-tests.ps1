# Unity Test Runner Script for GAMEDEVGD
# Usage: .\scripts\run-tests.ps1 [-Category Runtime|Editor] [-Filter <pattern>] [-OpenRunner]

param(
    [string]$Category = "",
    [string]$Filter = "",
    [switch]$OpenRunner,
    [switch]$Coverage,
    [switch]$Help
)

$PROJECT_ROOT = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$LOG_FILE = Join-Path $PROJECT_ROOT "TestResults\test-results.xml"

function Show-Help {
    Write-Host "Unity Test Runner for GAMEDEVGD"
    Write-Host ""
    Write-Host "Usage:"
    Write-Host "  .\scripts\run-tests.ps1 [parameters]"
    Write-Host ""
    Write-Host "Parameters:"
    Write-Host "  -Category <Runtime|Editor>  Run tests from specified category"
    Write-Host "  -Filter <pattern>           Filter by test name (NUnit filter)"
    Write-Host "  -OpenRunner                 Open Unity Test Runner in editor"
    Write-Host "  -Coverage                   Generate coverage report (requires Unity Coverage)"
    Write-Host "  -Help                       Show this help"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\scripts\run-tests.ps1                          # Run all tests"
    Write-Host "  .\scripts\run-tests.ps1 -Category Runtime        # Runtime tests only"
    Write-Host "  .\scripts\run-tests.ps1 -Filter MCP              # Tests with 'MCP' in name"
    Write-Host "  .\scripts\run-tests.ps1 -OpenRunner              # Open Test Runner UI"
    exit 0
}

function Test-UnityInstalled {
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
    Write-Warning "Unity not found in standard installation paths"
    return $false
}

function Find-UnityEditor {
    $unityPaths = @(
        "C:\Program Files\Unity\Hub\Editor",
        "C:\Program Files (x86)\Unity\Hub\Editor",
        "$env:LOCALAPPDATA\Unity\Hub\Editor"
    )
    foreach ($basePath in $unityPaths) {
        if (Test-Path $basePath) {
            $versions = Get-ChildItem -Path $basePath -Directory | Sort-Object Name -Descending
            if ($versions.Count -gt 0) {
                return Join-Path $basePath "$($versions[0].Name)\Editor\Unity.exe"
            }
        }
    }
    return $null
}

function Run-UnityTests {
    param($UnityExe, $ProjectPath, $TestCategory, $TestFilter, $LogFile)
    
    $testPlatform = if ($TestCategory -eq "Editor") { "EditMode" } else { "PlayMode" }
    
    $testArgs = @(
        "-batchmode"
        "-nographics"
        "-projectPath", $ProjectPath
        "-runTests"
        "-testPlatform", $testPlatform
        "-testResults", $LogFile
        "-logFile", (Join-Path $PROJECT_ROOT "TestResults\unity-test.log")
    )
    
    if ($TestFilter) {
        $testArgs += "-testFilter", $TestFilter
    }
    
    Write-Host "Running Unity tests..."
    Write-Host "Unity: $UnityExe"
    Write-Host "Platform: $testPlatform"
    Write-Host "Results: $LogFile"
    
    $logDir = Split-Path $LogFile -Parent
    if (!(Test-Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
    }
    
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
    $process.WaitForExit()
    
    if ($process.ExitCode -eq 0) {
        Write-Host "Tests completed successfully!" -ForegroundColor Green
        if (Test-Path $LogFile) {
            Get-Content $LogFile | Select-Object -First 20
        }
    }
    else {
        Write-Host "Tests failed with exit code: $($process.ExitCode)" -ForegroundColor Red
    }
    
    return $process.ExitCode
}

function Run-AgentTests {
    $agentTestDir = Join-Path $PROJECT_ROOT ".agent\tests"
    
    if (!(Test-Path $agentTestDir)) {
        Write-Warning "Agent tests directory not found: $agentTestDir"
        return 1
    }
    
    $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    if (!$pythonCmd) {
        Write-Warning "Python not found. Skipping agent tests."
        return 0
    }
    
    $requirementsFile = Join-Path $agentTestDir "requirements.txt"
    if (Test-Path $requirementsFile) {
        Write-Host "Installing Python dependencies..."
        & python -m pip install -r $requirementsFile -q
    }
    
    Write-Host "Running pytest..."
    & python -m pytest $agentTestDir -v --tb=short
    
    return $LASTEXITCODE
}

# Main
if ($Help) { Show-Help }

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GAMEDEVGD Test Runner" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if (!(Test-UnityInstalled)) {
    Write-Warning "Unity not found. Running agent tests only..."
    Run-AgentTests
    exit $LASTEXITCODE
}

$unityExe = Find-UnityEditor
if (!$unityExe) {
    Write-Warning "Unity Editor not found. Running agent tests only..."
    Run-AgentTests
    exit $LASTEXITCODE
}

if ($OpenRunner) {
    Write-Host "Open Unity Editor and go to: Window > General > Test Runner"
    exit 0
}

$exitCode = Run-UnityTests -UnityExe $unityExe -ProjectPath $PROJECT_ROOT -TestCategory $Category -TestFilter $Filter -LogFile $LOG_FILE

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Agent Tests" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$agentExitCode = Run-AgentTests

Write-Host ""
if ($exitCode -eq 0 -and $agentExitCode -eq 0) {
    Write-Host "ALL TESTS PASSED!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "SOME TESTS FAILED" -ForegroundColor Red
    exit 1
}
