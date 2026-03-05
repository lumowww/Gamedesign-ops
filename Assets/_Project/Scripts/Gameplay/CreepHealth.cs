using UnityEngine;
using GAMEDEVGD.Core;

namespace GAMEDEVGD.Gameplay
{
    public class CreepHealth : MonoBehaviour
    {
        public float maxHealth = 50f;
        private float _currentHealth;
        
        public bool IsDead { get; private set; }

        private void Start()
        {
            _currentHealth = maxHealth;
            IsDead = false;
        }

        public void TakeDamage(float amount)
        {
            if (IsDead) return;

            _currentHealth -= amount;
            if (_currentHealth <= 0)
            {
                Die();
            }
        }

        private void Die()
        {
            IsDead = true;
            EventBus.Instance.Publish(new CreepKilledEvent { Creep = this });
            Destroy(gameObject); // ObjectPool integration later
        }
    }
}
