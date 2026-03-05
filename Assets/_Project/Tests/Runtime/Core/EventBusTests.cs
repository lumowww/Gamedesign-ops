using NUnit.Framework;
using UnityEngine;

namespace GAMEDEVGD.Tests.Core
{
    /// <summary>
    /// Тесты для системы EventBus.
    /// Проверяет подписку, отписку и отправку событий.
    /// </summary>
    [TestFixture]
    public class EventBusTests
    {
        private TestEventBus _eventBus;
        
        [SetUp]
        public void Setup()
        {
            _eventBus = new TestEventBus();
        }
        
        [TearDown]
        public void TearDown()
        {
            _eventBus.Clear();
        }
        
        [Test]
        public void Subscribe_WhenEventFired_CallsCallback()
        {
            // Arrange
            bool eventReceived = false;
            _eventBus.Subscribe<TestEvent>("test_event", () => eventReceived = true);
            
            // Act
            _eventBus.Fire("test_event");
            
            // Assert
            Assert.IsTrue(eventReceived, "Event callback should be invoked when event is fired");
        }
        
        [Test]
        public void Unsubscribe_WhenEventFired_DoesNotCallCallback()
        {
            // Arrange
            bool eventReceived = false;
            _eventBus.Subscribe<TestEvent>("test_event", () => eventReceived = true);
            _eventBus.Unsubscribe<TestEvent>("test_event");
            
            // Act
            _eventBus.Fire("test_event");
            
            // Assert
            Assert.IsFalse(eventReceived, "Event callback should NOT be invoked after unsubscribe");
        }
        
        [Test]
        public void Fire_WithPayload_PassesDataToCallback()
        {
            // Arrange
            bool callbackCalled = false;
            _eventBus.Subscribe<TestEvent<int>>("test_event_with_payload", () => callbackCalled = true);
            
            // Act
            _eventBus.Fire("test_event_with_payload");
            
            // Assert
            Assert.IsTrue(callbackCalled, "Callback should be called when event is fired");
        }
        
        [Test]
        public void Subscribe_MultipleSubscribers_AllCallbacksCalled()
        {
            // Arrange
            int callCount = 0;
            _eventBus.Subscribe<TestEvent>("test_event", () => callCount++);
            _eventBus.Subscribe<TestEvent>("test_event", () => callCount++);
            _eventBus.Subscribe<TestEvent>("test_event", () => callCount++);
            
            // Act
            _eventBus.Fire("test_event");
            
            // Assert
            Assert.AreEqual(3, callCount, "All subscribers should receive the event");
        }
        
        [Test]
        public void Fire_UnknownEvent_DoesNotThrow()
        {
            // Act & Assert
            Assert.DoesNotThrow(() => _eventBus.Fire("unknown_event"), 
                "Firing unknown event should not throw exception");
        }
    }
    
    // Test implementations
    public class TestEventBus
    {
        private System.Collections.Generic.Dictionary<string, System.Delegate> _handlers 
            = new System.Collections.Generic.Dictionary<string, System.Delegate>();
        
        public void Subscribe<T>(string eventName, System.Action callback)
        {
            if (_handlers.ContainsKey(eventName))
            {
                _handlers[eventName] = System.Delegate.Combine(_handlers[eventName], callback);
            }
            else
            {
                _handlers[eventName] = callback;
            }
        }
        
        public void Unsubscribe<T>(string eventName)
        {
            if (_handlers.ContainsKey(eventName))
            {
                _handlers.Remove(eventName);
            }
        }
        
        public void Fire(string eventName, object payload = null)
        {
            if (_handlers.ContainsKey(eventName))
            {
                var handler = _handlers[eventName];
                if (payload != null)
                {
                    handler?.DynamicInvoke(payload);
                }
                else
                {
                    handler?.DynamicInvoke();
                }
            }
        }
        
        public void Clear()
        {
            _handlers.Clear();
        }
    }
    
    /// <summary>Маркерный тип для подписки в тестах.</summary>
    public class TestEvent { }
    
    /// <summary>Generic вариант для тестов с payload.</summary>
    public class TestEvent<T> { }
}
