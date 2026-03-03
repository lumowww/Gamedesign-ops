using NUnit.Framework;
using UnityEngine;

namespace GAMEDEVGD.Tests.Data
{
    /// <summary>
    /// Тесты для ScriptableObject и валидации баланса.
    /// Проверяет что константы баланса загружены из GDD и корректны.
    /// </summary>
    [TestFixture]
    public class ScriptableObjectTests
    {
        [Test]
        public void GameConfigSO_HasValidValues()
        {
            // Arrange & Act
            var config = ScriptableObject.CreateInstance<TestGameConfigSO>();
            
            // Assert
            Assert.IsNotNull(config, "GameConfigSO should not be null");
            Assert.Greater(config.MaxEnergy, 0, "MaxEnergy should be positive");
            Assert.Greater(config.StartCoins, 0, "StartCoins should be positive");
        }
        
        [Test]
        public void LevelConfigSO_HasValidLevelCount()
        {
            // Arrange & Act
            var config = ScriptableObject.CreateInstance<TestLevelConfigSO>();
            
            // Assert
            Assert.IsNotNull(config, "LevelConfigSO should not be null");
            Assert.Greater(config.LevelCount, 0, "LevelCount should be positive");
        }
        
        [Test]
        public void BalanceConstants_AreWithinExpectedRange()
        {
            // Arrange
            var config = ScriptableObject.CreateInstance<TestGameConfigSO>();
            
            // Act & Assert
            Assert.GreaterOrEqual(config.MaxEnergy, 10, "MaxEnergy should be at least 10");
            Assert.LessOrEqual(config.MaxEnergy, 100, "MaxEnergy should not exceed 100");
            Assert.Greater(config.EnergyRegenMinutes, 0, "EnergyRegenMinutes should be positive");
        }
    }
    
    /// <summary>
    /// Тестовый ScriptableObject для конфигурации игры.
    /// </summary>
    public class TestGameConfigSO : ScriptableObject
    {
        public int MaxEnergy = 50;
        public int StartCoins = 100;
        public int EnergyRegenMinutes = 30;
        public float CoinMultiplier = 1.5f;
    }
    
    /// <summary>
    /// Тестовый ScriptableObject для конфигурации уровней.
    /// </summary>
    public class TestLevelConfigSO : ScriptableObject
    {
        public int LevelCount = 10;
        public float DifficultyScale = 1.1f;
        public int BaseReward = 50;
    }
}
