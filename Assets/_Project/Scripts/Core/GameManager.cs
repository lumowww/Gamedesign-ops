using GAMEDEVGD.Gameplay;
using GAMEDEVGD.Data;

namespace GAMEDEVGD.Core
{
    /// <summary>
    /// Состояния игрового цикла.
    /// Вынесен на уровень namespace для удобного доступа из любого скрипта.
    /// </summary>
    public enum GameState
    {
        None,
        Menu,
        Playing,
        Paused,
        GameOver
    }

    /// <summary>
    /// Событие изменения состояния игры.
    /// Публикуется через EventBus при каждом переходе.
    /// </summary>
    public struct GameStateChangedEvent
    {
        public GameState OldState;
        public GameState NewState;
    }

    /// <summary>
    /// Менеджер состояния игры и игровой цикл.
    /// Singleton, переживает смену сцен (DontDestroyOnLoad).
    ///
    /// Переходы состояний:
    ///   None → Menu → Playing ⇄ Paused → GameOver → Menu (restart)
    /// </summary>
    public class GameManager : MonoBehaviour
    {
        private static GameManager _instance;

        /// <summary>
        /// Единственный экземпляр GameManager.
        /// </summary>
        public static GameManager Instance => _instance;

        [Header("Config")]
        public GameConfigSO gameConfig;

        [SerializeField] private GameState _currentState = GameState.None;

        /// <summary>Текущее состояние игры.</summary>
        public GameState CurrentState => _currentState;

        /// <summary>Игра в состоянии Playing?</summary>
        public bool IsPlaying => _currentState == GameState.Playing;

        /// <summary>Игра на паузе?</summary>
        public bool IsPaused => _currentState == GameState.Paused;

        private int _escapedCreepsCount = 0;
        private int _wavesCompleted = 0;
        private float _sessionStartTime;

        private void Awake()
        {
            if (_instance != null && _instance != this)
            {
                Destroy(gameObject);
                return;
            }
            _instance = this;
            DontDestroyOnLoad(gameObject);
        }

        private void OnEnable()
        {
            EventBus.Instance.Subscribe<CreepEscapedEvent>(OnCreepEscaped);
            EventBus.Instance.Subscribe<WaveCompletedEvent>(OnWaveCompleted);
        }

        private void OnDisable()
        {
            if (EventBus.Instance != null)
            {
                EventBus.Instance.Unsubscribe<CreepEscapedEvent>(OnCreepEscaped);
                EventBus.Instance.Unsubscribe<WaveCompletedEvent>(OnWaveCompleted);
            }
        }

        private void OnCreepEscaped(CreepEscapedEvent evt)
        {
            if (!IsPlaying || gameConfig == null) return;

            _escapedCreepsCount++;
            if (_escapedCreepsCount >= gameConfig.maxEscapedCreeps)
            {
                Debug.Log($"[GameManager] Defeat! {_escapedCreepsCount} creeps escaped.");
                EndGame(false);
            }
        }

        private void OnWaveCompleted(WaveCompletedEvent evt)
        {
            if (!IsPlaying || gameConfig == null) return;

            _wavesCompleted++;
            if (_wavesCompleted >= gameConfig.totalWavesToWin)
            {
                Debug.Log($"[GameManager] Victory! {_wavesCompleted} waves completed.");
                EndGame(true);
            }
        }

        private void Start()
        {
            ChangeState(GameState.Menu);
        }

        /// <summary>
        /// Изменить состояние игры. Публикует GameStateChangedEvent через EventBus.
        /// </summary>
        /// <param name="newState">Новое состояние</param>
        public void ChangeState(GameState newState)
        {
            if (_currentState == newState) return;

            var oldState = _currentState;
            _currentState = newState;

            Debug.Log($"[GameManager] State: {oldState} -> {newState}");

            EventBus.Instance.Publish(new GameStateChangedEvent
            {
                OldState = oldState,
                NewState = newState
            });

            if (newState == GameState.Playing)
            {
                _sessionStartTime = Time.time;
                _wavesCompleted = 0;
                _escapedCreepsCount = 0;
                EventBus.Instance.Publish(new SessionStartEvent());
            }
        }

        /// <summary>Начать игру (Menu/GameOver → Playing).</summary>
        public void StartGame() => ChangeState(GameState.Playing);

        /// <summary>Поставить на паузу (Playing → Paused).</summary>
        public void PauseGame()
        {
            if (_currentState == GameState.Playing)
                ChangeState(GameState.Paused);
        }

        /// <summary>Снять с паузы (Paused → Playing).</summary>
        public void ResumeGame()
        {
            if (_currentState == GameState.Paused)
                ChangeState(GameState.Playing);
        }

        /// <summary>Завершить игру (Playing → GameOver).</summary>
        public void EndGame(bool isWin)
        {
            ChangeState(GameState.GameOver);
            
            float sessionDuration = Time.time - _sessionStartTime;
            EventBus.Instance.Publish(new GameOverEvent { IsWin = isWin, WavesCompleted = _wavesCompleted });
            EventBus.Instance.Publish(new SessionEndEvent { DurationSec = sessionDuration, WavesCompleted = _wavesCompleted });
        }

        /// <summary>Вернуться в меню (→ Menu).</summary>
        public void ReturnToMenu() => ChangeState(GameState.Menu);

        private void OnDestroy()
        {
            if (_instance == this)
                _instance = null;
        }
    }
}
