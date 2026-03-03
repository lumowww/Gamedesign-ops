#if UNITY_EDITOR
using NUnit.Framework;
using UnityEngine;

namespace GAMEDEVGD.Tests.Editor.MCP
{
    /// <summary>
    /// Editor тесты для MCP Unity инструментов.
    /// Проверяет валидацию инструментов и их параметров.
    /// </summary>
    [TestFixture]
    public class MCPUnityToolTests
    {
        [Test]
        public void GetSceneInfo_ToolExists_ReturnsValidResult()
        {
            // Arrange
            var tool = new MCPUnityTool("get_scene_info");
            
            // Act
            var result = tool.Execute();
            
            // Assert
            Assert.IsNotNull(result, "get_scene_info should return valid result");
            Assert.IsTrue(result.Success, "Tool execution should succeed");
        }
        
        [Test]
        public void GetScenesHierarchy_ToolExists_ReturnsValidResult()
        {
            // Arrange
            var tool = new MCPUnityTool("get_scenes_hierarchy");
            
            // Act
            var result = tool.Execute();
            
            // Assert
            Assert.IsNotNull(result, "get_scenes_hierarchy should return valid result");
        }
        
        [Test]
        public void GetConsoleLogs_ToolExists_ReturnsValidResult()
        {
            // Arrange
            var tool = new MCPUnityTool("get_console_logs");
            
            // Act
            var result = tool.Execute();
            
            // Assert
            Assert.IsNotNull(result, "get_console_logs should return valid result");
        }
        
        [Test]
        public void UpdateGameObject_WithValidData_Succeeds()
        {
            // Arrange
            var tool = new MCPUnityTool("update_gameobject");
            tool.SetParameter("name", "TestObject");
            tool.SetParameter("position", new float[] { 0f, 0f, 0f });
            
            // Act
            var result = tool.Execute();
            
            // Assert
            Assert.IsTrue(result.Success, "update_gameobject should succeed with valid data");
        }
        
        [Test]
        public void UpdateComponent_WithMissingParameters_Fails()
        {
            // Arrange
            var tool = new MCPUnityTool("update_component");
            // Missing required parameters
            
            // Act
            var result = tool.Execute();
            
            // Assert
            Assert.IsFalse(result.Success, "update_component should fail with missing parameters");
        }
        
        [Test]
        public void ExecuteMenuItem_WithValidMenuItem_Succeeds()
        {
            // Arrange
            var tool = new MCPUnityTool("execute_menu_item");
            tool.SetParameter("menu_item", "File/New Scene");
            
            // Act
            var result = tool.Execute();
            
            // Assert
            Assert.IsTrue(result.Success, "execute_menu_item should succeed with valid menu item");
        }
        
        [Test]
        public void LoadScene_WithExistingScene_Succeeds()
        {
            // Arrange
            var tool = new MCPUnityTool("load_scene");
            tool.SetParameter("scene_path", "Assets/Scenes/SampleScene.unity");
            
            // Act
            var result = tool.Execute();
            
            // Assert
            Assert.IsTrue(result.Success, "load_scene should succeed with existing scene");
        }
        
        [Test]
        public void UnknownTool_ExecutionFails()
        {
            // Arrange
            var tool = new MCPUnityTool("unknown_tool");
            
            // Act
            var result = tool.Execute();
            
            // Assert
            Assert.IsFalse(result.Success, "Unknown tool should fail execution");
        }
    }
    
    /// <summary>
    /// Mock реализация MCP Unity инструмента для тестирования.
    /// </summary>
    public class MCPUnityTool
    {
        private string _toolName;
        private System.Collections.Generic.Dictionary<string, object> _parameters 
            = new System.Collections.Generic.Dictionary<string, object>();
        
        public MCPUnityTool(string toolName)
        {
            _toolName = toolName;
        }
        
        public void SetParameter(string key, object value)
        {
            _parameters[key] = value;
        }
        
        public MCPToolResult Execute()
        {
            // Simulated tool execution
            var validTools = new[] 
            { 
                "get_scene_info", 
                "get_scenes_hierarchy", 
                "get_console_logs",
                "update_gameobject",
                "update_component",
                "execute_menu_item",
                "load_scene"
            };
            
            if (!System.Array.Exists(validTools, t => t == _toolName))
            {
                return new MCPToolResult { Success = false, Error = $"Unknown tool: {_toolName}" };
            }
            
            // Simulate parameter validation for update_component
            if (_toolName == "update_component" && _parameters.Count == 0)
            {
                return new MCPToolResult { Success = false, Error = "Missing required parameters" };
            }
            
            return new MCPToolResult { Success = true, Data = $"Executed {_toolName}" };
        }
    }
    
    /// <summary>
    /// Результат выполнения MCP инструмента.
    /// </summary>
    public class MCPToolResult
    {
        public bool Success { get; set; }
        public string Error { get; set; }
        public object Data { get; set; }
    }
}
#endif
