using System;
using System.Collections.Generic;
using UnityEngine;

namespace GAMEDEVGD.Core
{
    /// <summary>
    /// Центральная шина событий для слабой связности систем.
    /// Singleton, переживает смену сцен (DontDestroyOnLoad).
    ///
    /// Использование:
    ///   EventBus.Instance.Subscribe&lt;MyEvent&gt;(OnMyEvent);
    ///   EventBus.Instance.Publish(new MyEvent { ... });
    ///   EventBus.Instance.Unsubscribe&lt;MyEvent&gt;(OnMyEvent);
    /// </summary>
    public class EventBus : MonoBehaviour
    {
        private static EventBus _instance;

        /// <summary>
        /// Единственный экземпляр EventBus. Создаётся автоматически при первом обращении
        /// если не найден на сцене. Для явного контроля — добавьте EventBus
        /// на GameObject в стартовой сцене.
        /// </summary>
        public static EventBus Instance
        {
            get
            {
                if (_instance == null)
                {
                    // Ищем существующий через Object.FindAnyObjectByType (Unity 2023.1+)
                    // Безопасно: вызывается только один раз (lazy singleton)
                    _instance = FindAnyObjectByType<EventBus>();

                    if (_instance == null)
                    {
                        var go = new GameObject("[EventBus]");
                        _instance = go.AddComponent<EventBus>();
                        DontDestroyOnLoad(go);
                    }
                }
                return _instance;
            }
        }

        /// <summary>
        /// Словарь: Type события → список подписок.
        /// Каждая подписка хранит пару (оригинальный Action, wrapper Action&lt;object&gt;)
        /// для корректного Unsubscribe.
        /// </summary>
        private readonly Dictionary<Type, List<Subscription>> _subscriptions = new();

        /// <summary>
        /// Внутренний контейнер подписки: хранит оригинальный делегат и wrapper.
        /// </summary>
        private class Subscription
        {
            public Delegate Original;
            public Action<object> Wrapper;
        }

        /// <summary>
        /// Подписаться на событие типа T.
        /// </summary>
        /// <param name="listener">Метод-обработчик события</param>
        public void Subscribe<T>(Action<T> listener)
        {
            var type = typeof(T);
            if (!_subscriptions.ContainsKey(type))
                _subscriptions[type] = new List<Subscription>();

            var wrapper = new Action<object>(data => listener((T)data));
            _subscriptions[type].Add(new Subscription
            {
                Original = listener,
                Wrapper = wrapper
            });
        }

        /// <summary>
        /// Отписаться от события типа T.
        /// Корректно находит подписку по оригинальному делегату.
        /// </summary>
        /// <param name="listener">Метод-обработчик, ранее переданный в Subscribe</param>
        public void Unsubscribe<T>(Action<T> listener)
        {
            var type = typeof(T);
            if (!_subscriptions.ContainsKey(type)) return;

            var list = _subscriptions[type];
            for (int i = list.Count - 1; i >= 0; i--)
            {
                if (Equals(list[i].Original, listener))
                {
                    list.RemoveAt(i);
                    break;
                }
            }
        }

        /// <summary>
        /// Отправить событие всем подписчикам типа T.
        /// </summary>
        /// <param name="eventData">Данные события</param>
        public void Publish<T>(T eventData)
        {
            var type = typeof(T);
            if (!_subscriptions.ContainsKey(type)) return;

            // Копируем список для защиты от изменений во время итерации
            var listeners = new List<Subscription>(_subscriptions[type]);
            foreach (var sub in listeners)
                sub.Wrapper.Invoke(eventData);
        }

        /// <summary>
        /// Очистить все подписки. Полезно при рестарте игры.
        /// </summary>
        public void ClearAll()
        {
            _subscriptions.Clear();
        }

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

        private void OnDestroy()
        {
            if (_instance == this)
                _instance = null;
        }
    }
}
