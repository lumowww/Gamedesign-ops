using GAMEDEVGD.Core;
using NUnit.Framework;
using UnityEngine;
using UnityEngine.TestTools;

namespace GAMEDEVGD.Tests
{
    public class GameManagerTests
    {
        private GameManager _gameManager;

        [SetUp]
        public void SetUp()
        {
            var go = new GameObject("GameManager");
            _gameManager = go.AddComponent<GameManager>();
        }

        [TearDown]
        public void TearDown()
        {
            Object.DestroyImmediate(_gameManager.gameObject);
        }

        [Test]
        public void InitialState_IsMenu()
        {
            Assert.AreEqual(GameState.Menu, _gameManager.CurrentState);
        }

        [Test]
        public void StartGame_ChangesToPlaying()
        {
            _gameManager.StartGame();
            Assert.AreEqual(GameState.Playing, _gameManager.CurrentState);
        }

        [Test]
        public void PauseGame_WhenPlaying_ChangesToPaused()
        {
            _gameManager.StartGame();
            _gameManager.PauseGame();
            Assert.AreEqual(GameState.Paused, _gameManager.CurrentState);
        }

        [Test]
        public void ResumeGame_WhenPaused_ChangesToPlaying()
        {
            _gameManager.StartGame();
            _gameManager.PauseGame();
            _gameManager.ResumeGame();
            Assert.AreEqual(GameState.Playing, _gameManager.CurrentState);
        }

        [Test]
        public void IsPlaying_WhenPlaying_ReturnsTrue()
        {
            _gameManager.StartGame();
            Assert.IsTrue(_gameManager.IsPlaying);
        }

        [Test]
        public void IsPaused_WhenPaused_ReturnsTrue()
        {
            _gameManager.StartGame();
            _gameManager.PauseGame();
            Assert.IsTrue(_gameManager.IsPaused);
        }
    }
}
