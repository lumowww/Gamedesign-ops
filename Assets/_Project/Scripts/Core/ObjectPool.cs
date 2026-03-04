using System.Collections.Generic;
using UnityEngine;

namespace GAMEDEVGD.Core
{
    /// <summary>
    /// Универсальный пул объектов для оптимизации instantiate/destroy
    /// </summary>
    /// <typeparam name="T">Компонент для пулинга</typeparam>
    public class ObjectPool<T> : MonoBehaviour where T : Component
    {
        [SerializeField] private T _prefab;
        [SerializeField] private int _initialSize = 5;
        [SerializeField] private bool _autoExpand = true;

        private readonly Queue<T> _pool = new();
        private readonly List<T> _active = new();

        public int AvailableCount => _pool.Count;
        public int ActiveCount => _active.Count;

        private void Awake()
        {
            if (_prefab == null)
            {
                Debug.LogError($"[ObjectPool] Prefab not assigned for {typeof(T).Name}");
                return;
            }

            for (int i = 0; i < _initialSize; i++)
                CreateInstance();
        }

        private T CreateInstance()
        {
            var instance = Instantiate(_prefab, transform);
            instance.gameObject.SetActive(false);
            _pool.Enqueue(instance);
            return instance;
        }

        public T Get(Vector3 position, Quaternion rotation)
        {
            if (_pool.Count == 0)
            {
                if (!_autoExpand)
                {
                    Debug.LogWarning($"[ObjectPool] Pool empty for {typeof(T).Name}");
                    return null;
                }
                CreateInstance();
            }

            var instance = _pool.Dequeue();
            instance.transform.SetPositionAndRotation(position, rotation);
            instance.gameObject.SetActive(true);
            _active.Add(instance);
            return instance;
        }

        public T Get() => Get(Vector3.zero, Quaternion.identity);

        public void Return(T instance)
        {
            if (!_active.Contains(instance)) return;

            instance.gameObject.SetActive(false);
            _active.Remove(instance);
            _pool.Enqueue(instance);
        }

        public void ReturnAll()
        {
            foreach (var instance in _active)
                Return(instance);
        }

        private void OnValidate()
        {
            if (_initialSize < 1) _initialSize = 1;
        }
    }
}
