using GAMEDEVGD.Core;
using NUnit.Framework;
using UnityEngine;
using UnityEngine.TestTools;

namespace GAMEDEVGD.Tests
{
    public class EventBusTests
    {
        private EventBus _eventBus;
        private bool _eventReceived;
        private int _eventData;

        [SetUp]
        public void SetUp()
        {
            _eventBus = new GameObject("EventBus").AddComponent<EventBus>();
            _eventReceived = false;
            _eventData = 0;
        }

        [TearDown]
        public void TearDown()
        {
            Object.DestroyImmediate(_eventBus.gameObject);
        }

        [Test]
        public void Singleton_ReturnsSameInstance()
        {
            var instance1 = EventBus.Instance;
            var instance2 = EventBus.Instance;
            Assert.AreSame(instance1, instance2);
        }

        [Test]
        public void Subscribe_AndPublish_EventReceived()
        {
            _eventBus.Subscribe<TestEvent>(data =>
            {
                _eventReceived = true;
                _eventData = data.Value;
            });

            var testData = new TestEvent { Value = 42 };
            _eventBus.Publish(testData);

            Assert.IsTrue(_eventReceived);
            Assert.AreEqual(42, _eventData);
        }

        [Test]
        public void Unsubscribe_AfterUnsubscribe_EventNotReceived()
        {
            Action<TestEvent> handler = data => _eventReceived = true;
            _eventBus.Subscribe(handler);
            _eventBus.Unsubscribe(handler);

            _eventBus.Publish(new TestEvent());

            Assert.IsFalse(_eventReceived);
        }

        [Test]
        public void MultipleSubscribers_AllReceiveEvent()
        {
            int count = 0;
            _eventBus.Subscribe<TestEvent>(data => count++);
            _eventBus.Subscribe<TestEvent>(data => count++);
            _eventBus.Subscribe<TestEvent>(data => count++);

            _eventBus.Publish(new TestEvent());

            Assert.AreEqual(3, count);
        }

        public class TestEvent
        {
            public int Value { get; set; }
        }
    }
}
