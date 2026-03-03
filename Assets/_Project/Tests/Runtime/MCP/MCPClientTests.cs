using NUnit.Framework;
using UnityEngine;

namespace GAMEDEVGD.Tests.MCP
{
    /// <summary>
    /// Тесты для MCP Unity клиента.
    /// Проверяет конфигурацию подключения и базовую функциональность.
    /// </summary>
    [TestFixture]
    public class MCPClientTests
    {
        private MCPClientConfig _config;
        
        [SetUp]
        public void Setup()
        {
            _config = new MCPClientConfig
            {
                Port = 8090,
                AutoStartServer = true,
                AllowRemoteConnections = false,
                RequestTimeoutSeconds = 10
            };
        }
        
        [Test]
        public void Config_DefaultPort_Is8090()
        {
            // Assert
            Assert.AreEqual(8090, _config.Port, "Default MCP port should be 8090");
        }
        
        [Test]
        public void Config_Validate_WithValidConfig_ReturnsTrue()
        {
            // Act
            bool isValid = _config.Validate();
            
            // Assert
            Assert.IsTrue(isValid, "Valid config should pass validation");
        }
        
        [Test]
        public void Config_Validate_WithInvalidPort_ReturnsFalse()
        {
            // Arrange
            _config.Port = -1;
            
            // Act
            bool isValid = _config.Validate();
            
            // Assert
            Assert.IsFalse(isValid, "Invalid port should fail validation");
        }
        
        [Test]
        public void Config_Validate_WithZeroTimeout_ReturnsFalse()
        {
            // Arrange
            _config.RequestTimeoutSeconds = 0;
            
            // Act
            bool isValid = _config.Validate();
            
            // Assert
            Assert.IsFalse(isValid, "Zero timeout should fail validation");
        }
        
        [Test]
        public void ConnectionState_InitialState_IsDisconnected()
        {
            // Arrange
            var client = new TestMCPClient(_config);
            
            // Assert
            Assert.IsFalse(client.IsConnected, "Initial connection state should be disconnected");
        }
        
        [Test]
        public void Connect_WithValidConfig_ChangesState()
        {
            // Arrange
            var client = new TestMCPClient(_config);
            
            // Act
            client.Connect();
            
            // Assert
            Assert.IsTrue(client.IsConnected, "Connection state should change after Connect");
        }
        
        [Test]
        public void Disconnect_ChangesStateToDisconnected()
        {
            // Arrange
            var client = new TestMCPClient(_config);
            client.Connect();
            
            // Act
            client.Disconnect();
            
            // Assert
            Assert.IsFalse(client.IsConnected, "Connection state should be disconnected after Disconnect");
        }
    }
    
    /// <summary>
    /// Конфигурация MCP клиента.
    /// </summary>
    public class MCPClientConfig
    {
        public int Port { get; set; } = 8090;
        public bool AutoStartServer { get; set; } = true;
        public bool AllowRemoteConnections { get; set; } = false;
        public int RequestTimeoutSeconds { get; set; } = 10;
        
        public string WebSocketUrl => $"ws://localhost:{Port}";
        
        public bool Validate()
        {
            return Port > 0 && Port <= 65535 && RequestTimeoutSeconds > 0;
        }
    }
    
    /// <summary>
    /// Тестовая реализация MCP клиента.
    /// </summary>
    public class TestMCPClient
    {
        private MCPClientConfig _config;
        public bool IsConnected { get; private set; }
        
        public TestMCPClient(MCPClientConfig config)
        {
            _config = config;
            IsConnected = false;
        }
        
        public void Connect()
        {
            // Simulated connection
            IsConnected = true;
        }
        
        public void Disconnect()
        {
            IsConnected = false;
        }
    }
}
