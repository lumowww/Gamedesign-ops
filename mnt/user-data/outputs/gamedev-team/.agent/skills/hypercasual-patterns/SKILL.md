---
name: hypercasual-patterns
description: >
  Паттерны гиперказуальных игр, Unity-шаблоны механик, реверс-инжиниринг.
  Активируется при: 'гиперказуальный', 'hypercasual', 'hyper casual', 'casual game',
  'core loop', 'core mechanic', 'game mechanic', 'endless runner', 'idle', 'merge game',
  'stack game', 'crowd game', 'реализуй механику', 'implement mechanic',
  'как сделать', 'how to make', 'game prototype', 'прототип игры'.
---

# SKILL: HYPERCASUAL GAME PATTERNS

## Топ механик гиперказуальных игр 2024-2026

### 1. STACK / STACK-AND-MERGE
**Core Mechanic:** Игрок тапает → блок падает → нужно попасть в стек
**Unity Implementation:**
```csharp
// StackBlock.cs — основа механики
public class StackBlock : MonoBehaviour
{
    [SerializeField] private float _moveSpeed = 3f;
    private bool _isMoving = true;
    private Vector3 _startPos, _endPos;
    
    private void Update()
    {
        if (!_isMoving) return;
        transform.position = Vector3.Lerp(_startPos, _endPos, 
            Mathf.PingPong(Time.time * _moveSpeed, 1f));
    }
    
    public float Drop(float previousBlockSize, float previousBlockPos)
    {
        // Возвращает размер оставшейся части
        float overlap = ...; // вычислить пересечение
        // Обрезать блок, уничтожить лишнее
        return overlap;
    }
}
```

### 2. ENDLESS RUNNER
**Core Mechanic:** Автоматическое движение + прыжки/уклонение
```csharp
// PlayerRunner.cs
public class PlayerRunner : MonoBehaviour
{
    [SerializeField] private float _jumpForce = 12f;
    private Rigidbody2D _rb;
    private bool _isGrounded;
    
    private void Update()
    {
        if (Input.GetMouseButtonDown(0) && _isGrounded)
            _rb.AddForce(Vector2.up * _jumpForce, ForceMode2D.Impulse);
    }
}
// WorldScroller.cs — двигает мир, а не игрока
public class WorldScroller : MonoBehaviour
{
    [SerializeField] private float _speed = 8f;
    void Update() => transform.Translate(Vector3.left * _speed * Time.deltaTime);
}
```

### 3. CROWD / ARMY RUNNER
**Core Mechanic:** Сбор единиц → финальная битва
**Ключевые системы:** Unit pooling, Formation system, Flocking behavior

### 4. MERGE GAME
**Core Mechanic:** Drag and drop → merge same items → higher tier item
**Ключевые системы:** Grid система, ScriptableObject для items chain

### 5. IDLE / CLICKER
**Core Mechanic:** Tapping → resource → upgrade → automation

## Unity Architecture Template для прототипа

```csharp
// GameManager.cs — сервис-локатор / центральный менеджер
public class GameManager : MonoBehaviour
{
    public static GameManager Instance { get; private set; }
    
    [SerializeField] private GameStateSO _gameState;
    
    public event Action OnGameStart;
    public event Action OnGameOver;
    public event Action OnLevelComplete;
    
    private void Awake()
    {
        if (Instance != null) { Destroy(gameObject); return; }
        Instance = this;
    }
    
    public void StartGame() { OnGameStart?.Invoke(); }
    public void GameOver() { OnGameOver?.Invoke(); }
    public void LevelComplete() { OnLevelComplete?.Invoke(); }
}

// GameStateSO.cs
[CreateAssetMenu(fileName = "GameState", menuName = "Game/GameState")]
public class GameStateSO : ScriptableObject
{
    public int CurrentLevel;
    public int Score;
    public int HighScore;
    public int Coins;
}
```

## Juicy-эффекты (обязательны для гиперказуальных)

```csharp
// JuiceHelper.cs — быстрые эффекты через DOTween
using DG.Tweening;

public static class JuiceHelper
{
    // Пульсация при сборе
    public static void PunchScale(Transform t) =>
        t.DOPunchScale(Vector3.one * 0.3f, 0.3f, 5, 0.5f);
    
    // Тряска камеры
    public static void ShakeCamera(Camera cam) =>
        cam.DOShakePosition(0.3f, 0.2f, 20, 90f, false);
    
    // Bounce при появлении UI
    public static void BounceIn(RectTransform rt) =>
        rt.DOScale(0, 0).DOScale(1, 0.4f).SetEase(Ease.OutBounce);
    
    // Плавающие числа (score popup)
    public static void FloatingScore(TextMeshPro tmp, int score)
    {
        tmp.text = $"+{score}";
        tmp.transform.DOMove(tmp.transform.position + Vector3.up * 2f, 1f);
        tmp.DOFade(0, 1f).OnComplete(() => Destroy(tmp.gameObject));
    }
}
```

## Мобильная оптимизация (чеклист)

- [ ] Object Pooling для всего спавнящегося (враги, монеты, эффекты)
- [ ] Sprite Atlas для всех UI-спрайтов
- [ ] Camera.main убрать из Update (кэшировать в Awake)
- [ ] FindObjectOfType только в Awake/Start
- [ ] Отключить тени (Project Settings → Quality)
- [ ] Target FPS: 60 для iOS, 60 для Android (SetTargetFrameRate)
- [ ] Profiler: проверить GC Alloc в горячих путях

## ScriptableObject Architecture — минимальный набор

```
Data/
├── LevelConfig_SO.cs    // параметры каждого уровня
├── PlayerConfig_SO.cs   // скорость, силы, жизни
├── GameState_SO.cs      // текущий прогресс
└── AudioConfig_SO.cs    // AudioClips, volumes
```
