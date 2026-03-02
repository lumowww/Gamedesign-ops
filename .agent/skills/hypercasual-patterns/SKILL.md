---
name: hypercasual-patterns
description: >
  Паттерны гиперказуальных игр, Unity-шаблоны механик. Активируется при:
  'гиперказуальный', 'hypercasual', 'core loop', 'core mechanic', 'endless runner',
  'stack game', 'crowd game', 'merge game', 'реализуй механику', 'implement mechanic',
  'game prototype', 'прототип игры', 'juicy', 'game feel'.
---

# SKILL: HYPERCASUAL GAME PATTERNS

## Топ механик 2024-2026

### ENDLESS RUNNER

```csharp
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
public class WorldScroller : MonoBehaviour
{
    [SerializeField] private float _speed = 8f;
    void Update() => transform.Translate(Vector3.left * _speed * Time.deltaTime);
}
```

### STACK

```csharp
public class StackBlock : MonoBehaviour
{
    [SerializeField] private float _moveSpeed = 3f;
    private Vector3 _startPos, _endPos;
    private void Update() =>
        transform.position = Vector3.Lerp(_startPos, _endPos,
            Mathf.PingPong(Time.time * _moveSpeed, 1f));
}
```

### GAMEMANAGER + ScriptableObject Architecture

```csharp
public class GameManager : MonoBehaviour
{
    public static GameManager Instance { get; private set; }
    [SerializeField] private GameStateSO _gameState;
    public event Action OnGameStart, OnGameOver, OnLevelComplete;
    private void Awake()
    {
        if (Instance != null) { Destroy(gameObject); return; }
        Instance = this;
    }
}

[CreateAssetMenu(menuName = "Game/GameState")]
public class GameStateSO : ScriptableObject
{
    public int CurrentLevel, Score, HighScore, Coins;
}
```

## Juicy-эффекты (DOTween — обязательно)

```csharp
using DG.Tweening;
public static class JuiceHelper
{
    public static void PunchScale(Transform t) =>
        t.DOPunchScale(Vector3.one * 0.3f, 0.3f, 5, 0.5f);
    public static void ShakeCamera(Camera cam) =>
        cam.DOShakePosition(0.3f, 0.2f, 20, 90f, false);
    public static void BounceIn(RectTransform rt) =>
        rt.DOScale(0, 0).DOScale(1, 0.4f).SetEase(Ease.OutBounce);
}
```

## Мобильная оптимизация (чеклист)

- [ ] Object Pooling для всего спавнящегося
- [ ] Sprite Atlas для UI
- [ ] Camera.main кэшировать в Awake
- [ ] FindObjectOfType только в Awake/Start
- [ ] Тени: OFF в Quality Settings
- [ ] Target FPS: 60 (Application.targetFrameRate = 60)
- [ ] Profiler: GC Alloc в горячих путях

## ScriptableObject минимальный набор

```
Data/
├── LevelConfigSO.cs
├── PlayerConfigSO.cs
├── GameStateSO.cs
└── AudioConfigSO.cs
```
