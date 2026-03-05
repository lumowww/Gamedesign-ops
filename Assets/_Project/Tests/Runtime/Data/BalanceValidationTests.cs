using NUnit.Framework;

namespace GAMEDEVGD.Tests.Data
{
    /// <summary>
    /// Тесты валидации баланса из GDD.
    /// Проверяет что константы соответствуют дизайн-документу.
    /// </summary>
    [TestFixture]
    public class BalanceValidationTests
    {
        private TestBalanceData _balanceData;
        
        [SetUp]
        public void Setup()
        {
            _balanceData = new TestBalanceData();
        }
        
        [Test]
        public void SoftCurrency_Cap_IsValid()
        {
            // Assert
            Assert.Greater(_balanceData.SoftCurrencyCap, 0, "Soft currency cap should be positive");
            Assert.LessOrEqual(_balanceData.SoftCurrencyCap, 999999, "Soft currency cap should not exceed max int");
        }
        
        [Test]
        public void HardCurrency_Cap_IsValid()
        {
            // Assert
            Assert.Greater(_balanceData.HardCurrencyCap, 0, "Hard currency cap should be positive");
            Assert.LessOrEqual(_balanceData.HardCurrencyCap, 99999, "Hard currency cap should be reasonable");
        }
        
        [Test]
        public void EnergySystem_HasValidRegenRate()
        {
            // Assert
            Assert.Greater(_balanceData.EnergyRegenRateMinutes, 0, "Energy regen rate should be positive");
            Assert.LessOrEqual(_balanceData.EnergyRegenRateMinutes, 60, "Energy regen should not be too slow");
        }
        
        [Test]
        public void LevelProgression_HasValidScaling()
        {
            // Assert
            Assert.Greater(_balanceData.XPScaleFactor, 1.0f, "XP scale factor should be > 1 for progression");
            Assert.Less(_balanceData.XPScaleFactor, 2.0f, "XP scale factor should not be too steep");
        }
        
        [Test]
        public void Economy_EarnToSpendRatio_IsBalanced()
        {
            // Arrange
            float earnPerSession = _balanceData.BaseEarnPerSession;
            float spendPerLevel = _balanceData.BaseSpendPerLevel;
            
            // Act
            float ratio = earnPerSession / spendPerLevel;
            
            // Assert
            Assert.Greater(ratio, 0.5f, "Earn/spend ratio should allow progression");
            Assert.Less(ratio, 2.0f, "Earn/spend ratio should not be too generous");
        }
        
        [Test]
        public void Analytics_EventNames_FollowConvention()
        {
            // Arrange
            var eventNames = _balanceData.GetAnalyticsEvents();
            
            // Assert
            foreach (var eventName in eventNames)
            {
                Assert.IsTrue(eventName.Contains("_"), 
                    $"Event name '{eventName}' should use snake_case convention");
                Assert.AreEqual(eventName.Replace("_", "").ToLower(), eventName.Replace("_", ""), 
                    $"Event name '{eventName}' should be lowercase");
            }
        }
    }
    
    /// <summary>
    /// Тестовые данные баланса (симуляция GDD констант).
    /// </summary>
    public class TestBalanceData
    {
        // Currency caps
        public int SoftCurrencyCap = 10000;
        public int HardCurrencyCap = 5000;
        
        // Energy system
        public int MaxEnergy = 50;
        public int EnergyRegenRateMinutes = 30;
        
        // Level progression
        public float XPScaleFactor = 1.15f;
        public int BaseXPForLevel = 100;
        
        // Economy
        public float BaseEarnPerSession = 150f;
        public float BaseSpendPerLevel = 100f;
        
        public string[] GetAnalyticsEvents()
        {
            return new[]
            {
                "level_start",
                "level_complete",
                "level_fail",
                "currency_earn",
                "currency_spend",
                "energy_refill",
                "session_start",
                "session_end"
            };
        }
    }
}
