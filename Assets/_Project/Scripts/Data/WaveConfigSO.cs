using UnityEngine;

namespace GAMEDEVGD.Data
{
    public enum CreepType
    {
        SHIP_1,
        SHIP_2
    }

    [CreateAssetMenu(fileName = "NewWaveConfig", menuName = "GAMEDEVGD/Data/Wave Config")]
    public class WaveConfigSO : ScriptableObject
    {
        public int waveNumber = 1;
        public int creepCount = 10;
        public CreepType creepType = CreepType.SHIP_1;
        public float spawnInterval = 1f; // seconds between creeps
    }
}
