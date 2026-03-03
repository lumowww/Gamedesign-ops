# GAMEDEVGD Testing Guide

**Версия:** 1.0  
**Дата:** 2026-03-03

---

## 📋 Обзор

Проект GAMEDEVGD использует многоуровневую систему тестирования:

| Уровень | Тип | Фреймворк | Расположение |
|---------|-----|-----------|--------------|
| **Unity Runtime** | Unit/Integration | Unity Test Framework | `Assets/_Project/Tests/Runtime/` |
| **Unity Editor** | Editor Tests | Unity Test Framework | `Assets/_Project/Tests/Editor/` |
| **Agent Workflows** | Validation | pytest | `.agent/tests/` |

---

## 🚀 Быстрый старт

### Запуск всех тестов

```powershell
# Из корня проекта
.\scripts\run-tests.ps1
```

### Запуск конкретных тестов

```powershell
# Только Runtime тесты
.\scripts\run-tests.ps1 -Category Runtime

# Только Editor тесты
.\scripts\run-tests.ps1 -Category Editor

# Тесты по фильтру (NUnit filter)
.\scripts\run-tests.ps1 -Filter MCP

# Открыть Unity Test Runner UI
.\scripts\run-tests.ps1 -OpenRunner
```

### Запуск агентских тестов (Python)

```powershell
# Автоматически запускается вместе с Unity тестами
.\scripts\run-tests.ps1

# Или напрямую через pytest
cd .agent\tests
pytest -v
```

---

## 📁 Структура тестов

```
D:\ASTRA\My project\
├── Assets/
│   └── _Project/
│       └── Tests/
│           ├── Tests.asmdef              ← Assembly Definition для тестов
│           ├── Runtime/
│           │   ├── Core/
│           │   │   ├── EventBusTests.cs       # Тесты EventBus
│           │   │   └── GameLoopTests.cs       # Тесты Game Loop
│           │   ├── MCP/
│           │   │   └── MCPClientTests.cs      # Тесты MCP клиента
│           │   └── Data/
│           │       ├── ScriptableObjectTests.cs    # Тесты SO
│           │       └── BalanceValidationTests.cs   # Валидация баланса
│           └── Editor/
│               └── MCP/
│                   └── MCPUnityToolTests.cs # Editor тесты MCP
│
├── .agent/
│   └── tests/
│       ├── workflows/
│       │   └── workflow_validation_tests.py  # Валидация workflows
│       ├── rules/
│       │   └── rule_validation_tests.py      # Валидация rules
│       ├── brain/
│       │   └── brain_schema_tests.py         # Валидация brain-файлов
│       └── requirements.txt                  # Python зависимости
│
└── scripts/
    └── run-tests.ps1                         # Главный скрипт запуска
```

---

## 🧪 Unity Test Framework

### Требования

- **Unity 6 LTS** (6000.3.9f1 или новее)
- **Unity Test Framework** пакет (уже установлен в проекте)
- **NSubstitute** (опционально, для моков)

### Добавление новых тестов

1. Создайте `.cs` файл в соответствующей папке:
   - `Runtime/` — для тестов игрового кода
   - `Editor/` — для тестов редактора (требуют `#if UNITY_EDITOR`)

2. Используйте атрибуты NUnit:

```csharp
using NUnit.Framework;
using UnityEngine;

namespace GAMEDEVGD.Tests.Core
{
    [TestFixture]
    public class MyTests
    {
        [SetUp]
        public void Setup()
        {
            // Подготовка перед каждым тестом
        }
        
        [TearDown]
        public void TearDown()
        {
            // Очистка после каждого теста
        }
        
        [Test]
        public void MyTest_ShouldPass()
        {
            // Arrange
            var value = 42;
            
            // Act
            var result = value * 2;
            
            // Assert
            Assert.AreEqual(84, result);
        }
    }
}
```

3. Unity автоматически обнаружит тесты в Test Runner

### Запуск из Unity Editor

1. Откройте **Window > General > Test Runner**
2. Выберите **PlayMode** или **EditMode**
3. Нажмите **Run All** или выберите конкретный тест

---

## 🐍 Agent Tests (Python)

### Требования

- **Python 3.8+**
- **pytest**

### Установка

```powershell
cd .agent\tests
pip install -r requirements.txt
```

### Запуск

```powershell
# Все тесты
pytest -v

# С отчётом о покрытии
pytest -v --cov=.

# Конкретный файл
pytest workflows/workflow_validation_tests.py -v
```

### Что тестируется

| Файл | Проверяет |
|------|-----------|
| `workflow_validation_tests.py` | Валидность markdown workflows |
| `rule_validation_tests.py` | Структура rule-файлов агентов |
| `brain_schema_tests.py` | Schema brain-файлов коммуникации |

---

## 📊 Покрытие кода

### Unity Coverage (требует пакет)

```powershell
# Запуск с покрытием
.\scripts\run-tests.ps1 -Coverage

# Результаты в TestResults/coverage/
```

### Python Coverage

```powershell
cd .agent\tests
pytest --cov=. --cov-report=html
# Отчёт в htmlcov/
```

---

## ✅ Best Practices

### Для Unity тестов

1. **Изоляция:** Каждый тест должен быть независимым
2. **Arrange-Act-Assert:** Используйте AAA паттерн
3. **Одно утверждение на тест:** Один тест = одна проверка
4. **Чистые имена:** `MethodName_State_ExpectedResult`
5. **Mock внешних зависимостей:** Не тестируйте Unity API напрямую

### Для Agent тестов

1. **Валидация структуры:** Проверяйте наличие обязательных секций
2. **Markdown lint:** Без trailing whitespace, используйте пробелы
3. **Семантическая проверка:** Проверяйте смысл, а не только синтаксис

---

## 🔧 CI/CD Интеграция

### GitHub Actions (пример)

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: windows-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install Agent Test Dependencies
      run: |
        pip install -r .agent/tests/requirements.txt
    
    - name: Run Agent Tests
      run: |
        cd .agent/tests
        pytest -v
    
    - name: Run Unity Tests
      run: |
        .\scripts\run-tests.ps1 -Category Runtime
```

---

## 🐛 Troubleshooting

### Тесты не обнаруживаются

1. Проверьте что `Tests.asmdef` ссылается на Assembly-CSharp
2. Убедитесь что тестовые классы `public`
3. Проверьте атрибут `[TestFixture]`

### Unity не запускается в batch mode

```powershell
# Проверьте путь к Unity
Get-ChildItem "C:\Program Files\Unity\Hub\Editor" -Recurse -Filter "Unity.exe"
```

### Python тесты падают с ImportError

```powershell
# Переустановите зависимости
pip install -r .agent/tests/requirements.txt --force-reinstall
```

---

## 📚 Ресурсы

- [Unity Test Framework Documentation](https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/manual/index.html)
- [NUnit Documentation](https://docs.nunit.org/)
- [pytest Documentation](https://docs.pytest.org/)

---

**GAMEDEVGD Team © 2026**
