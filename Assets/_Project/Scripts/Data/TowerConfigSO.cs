using UnityEngine;

namespace GAMEDEVGD.Data
{
    public enum TowerType
    {
        FIRE,
        CRYO
    }

    [CreateAssetMenu(fileName = "NewTowerConfig", menuName = "GAMEDEVGD/Data/Tower Config")]
    public class TowerConfigSO : ScriptableObject
    {
        [Header("Identity")]
        public TowerType type;
        [Range(1, 3)]
        public int mergeLevel = 1;

        [Header("Combat Stats")]
        public float damage = 10f;
        public float attackRate = 1f; // shots per second
        public float range = 5f;

        [Header("Economy")]
        public int spawnCost = 10;
        
        [Header("Visuals (Optional for DEV MVP)")]
        public GameObject prefab;
    }
}
