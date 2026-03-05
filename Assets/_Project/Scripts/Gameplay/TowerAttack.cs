using UnityEngine;

namespace GAMEDEVGD.Gameplay
{
    [RequireComponent(typeof(Tower))]
    public class TowerAttack : MonoBehaviour
    {
        private Tower _tower;
        private float _lastAttackTime;

        private void Awake()
        {
            _tower = GetComponent<Tower>();
        }

        private void Update()
        {
            if (_tower.Config == null || _tower.CurrentCell == null) return;

            if (Time.time - _lastAttackTime >= 1f / _tower.Config.attackRate)
            {
                AttackNearest();
            }
        }

        private void AttackNearest()
        {
            Collider[] hits = Physics.OverlapSphere(transform.position, _tower.Config.range);
            foreach (var hit in hits)
            {
                var creepHealth = hit.GetComponent<CreepHealth>();
                if (creepHealth != null && !creepHealth.IsDead)
                {
                    creepHealth.TakeDamage(_tower.Config.damage);
                    _lastAttackTime = Time.time;
                    
                    // TODO: trigger specific VFX or Projectile logic here
                    break; 
                }
            }
        }
        
        private void OnDrawGizmosSelected()
        {
            if (_tower != null && _tower.Config != null)
            {
                Gizmos.color = Color.red;
                Gizmos.DrawWireSphere(transform.position, _tower.Config.range);
            }
        }
    }
}
