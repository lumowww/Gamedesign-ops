using UnityEngine;

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

        [SerializeField] private GameState _currentState = GameState.None;

        /// <summary>Текущее состояние игры.</summary>
        public GameState CurrentState => _currentState;

        /// <summary>Игра в состоянии Playing?</summary>
        public bool IsPlaying => _currentState == GameState.Playing;

        /// <summary>Игра на паузе?</summary>
        public bool IsPaused => _currentState == GameState.Paused;

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
        public void EndGame() => ChangeState(GameState.GameOver);

        /// <summary>Вернуться в меню (→ Menu).</summary>
        public void ReturnToMenu() => ChangeState(GameState.Menu);

        private void OnDestroy()
        {
            if (_instance == this)
                _instance = null;
        }
    }
}
