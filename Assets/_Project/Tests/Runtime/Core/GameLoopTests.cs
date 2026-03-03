using NUnit.Framework;
using UnityEngine;

namespace GAMEDEVGD.Tests.Core
{
    /// <summary>
    /// Тесты для Game Loop механик.
    /// Проверяет состояния игры и переходы между ними.
    /// </summary>
    [TestFixture]
    public class GameLoopTests
    {
        private TestGameManager _gameManager;
        
        [SetUp]
        public void Setup()
        {
            _gameManager = new TestGameManager();
        }
        
        [TearDown]
        public void TearDown()
        {
            _gameManager.Reset();
        }
        
        [Test]
        public void StartGame_InitialState_IsPlaying()
        {
            // Act
            _gameManager.StartGame();
            
            // Assert
            Assert.AreEqual(GameState.Playing, _gameManager.CurrentState, 
                "Game state should be Playing after StartGame");
        }
        
        [Test]
        public void EndGame_WhenPlaying_TransitionsToGameOver()
        {
            // Arrange
            _gameManager.StartGame();
            
            // Act
            _gameManager.EndGame(true); // victory = true
            
            // Assert
            Assert.AreEqual(GameState.GameOver, _gameManager.CurrentState, 
                "Game state should be GameOver after EndGame");
            Assert.IsTrue(_gameManager.IsVictory, "IsVictory should be true");
        }
        
        [Test]
        public void RestartGame_AfterGameOver_ResetsState()
        {
            // Arrange
            _gameManager.StartGame();
            _gameManager.EndGame(false);
            
            // Act
            _gameManager.RestartGame();
            
            // Assert
            Assert.AreEqual(GameState.Playing, _gameManager.CurrentState, 
                "Game state should be Playing after RestartGame");
        }
        
        [Test]
        public void PauseGame_WhenPlaying_PausesGame()
        {
            // Arrange
            _gameManager.StartGame();
            
            // Act
            _gameManager.PauseGame();
            
            // Assert
            Assert.AreEqual(GameState.Paused, _gameManager.CurrentState, 
                "Game state should be Paused after PauseGame");
        }
        
        [Test]
        public void ResumeGame_WhenPaused_ResumesGame()
        {
            // Arrange
            _gameManager.StartGame();
            _gameManager.PauseGame();
            
            // Act
            _gameManager.ResumeGame();
            
            // Assert
            Assert.AreEqual(GameState.Playing, _gameManager.CurrentState, 
                "Game state should be Playing after ResumeGame");
        }
        
        [Test]
        public void PauseGame_WhenNotPlaying_DoesNotPause()
        {
            // Act
            _gameManager.PauseGame();
            
            // Assert
            Assert.AreNotEqual(GameState.Paused, _gameManager.CurrentState, 
                "Game should not pause when not in Playing state");
        }
    }
    
    public enum GameState
    {
        None,
        Playing,
        Paused,
        GameOver
    }
    
    public class TestGameManager
    {
        public GameState CurrentState { get; private set; } = GameState.None;
        public bool IsVictory { get; private set; }
        
        public void StartGame()
        {
            CurrentState = GameState.Playing;
            IsVictory = false;
        }
        
        public void EndGame(bool victory)
        {
            if (CurrentState == GameState.Playing)
            {
                CurrentState = GameState.GameOver;
                IsVictory = victory;
            }
        }
        
        public void RestartGame()
        {
            CurrentState = GameState.Playing;
            IsVictory = false;
        }
        
        public void PauseGame()
        {
            if (CurrentState == GameState.Playing)
            {
                CurrentState = GameState.Paused;
            }
        }
        
        public void ResumeGame()
        {
            if (CurrentState == GameState.Paused)
            {
                CurrentState = GameState.Playing;
            }
        }
        
        public void Reset()
        {
            CurrentState = GameState.None;
            IsVictory = false;
        }
    }
}
