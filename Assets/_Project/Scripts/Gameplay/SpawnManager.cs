using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using GAMEDEVGD.Data;
using GAMEDEVGD.Core;

namespace GAMEDEVGD.Gameplay
{
    public class SpawnManager : MonoBehaviour
    {
        public static SpawnManager Instance { get; private set; }

        [Header("Configurations")]
        public GameConfigSO gameConfig;
        public List<WaveConfigSO> waves;
        
        [Header("Prefabs")]
        public GameObject defaultTowerPrefab;
        public GameObject defaultCreepPrefab;

        private int _currentWaveIndex = 0;
        private bool _isSpawningWave = false;

        private void Awake()
        {
            if (Instance == null) Instance = this;
            else Destroy(gameObject);
        }

        public void SpawnTowerRequest(TowerConfigSO towerConfig)
        {
            if (ScoreSystem.Instance.TrySpendScore(towerConfig.spawnCost))
            {
                GridCell freeCell = MergeGrid.Instance.GetFirstEmptyCell();
                if (freeCell != null)
                {
                    GameObject towerObj = Instantiate(towerConfig.prefab != null ? towerConfig.prefab : defaultTowerPrefab);
                    Tower towerComp = towerObj.GetComponent<Tower>();
                    towerComp.InitSequence(towerConfig, freeCell);
                    freeCell.OccupiedTower = towerComp;
                    EventBus.Instance.Publish(new TowerSpawnedEvent { Type = towerConfig.type });
                }
                else
                {
                    // Refund if grid full (for safety)
                    ScoreSystem.Instance.AddScore(towerConfig.spawnCost);
                    Debug.LogWarning("Grid is full, cannot spawn tower.");
                }
            }
        }

        public void UpgradeTower(Tower targetTower, int newLevel)
        {
            // For MVP: we just update the config reference manually or change a visual
            // In full version, this destroys targetTower and instantiates the Lv[newLevel] prefab
            Debug.Log($"Upgraded Tower {targetTower.TowerType} to Level {newLevel}!");
            // Mocking config update
            targetTower.Config = ScriptableObject.CreateInstance<TowerConfigSO>();
            targetTower.Config.mergeLevel = newLevel;
            targetTower.Config.type = targetTower.TowerType;
        }

        public void StartNextWave()
        {
            if (_isSpawningWave || _currentWaveIndex >= waves.Count) return;
            
            StartCoroutine(SpawnWaveRoutine(waves[_currentWaveIndex]));
        }

        private IEnumerator SpawnWaveRoutine(WaveConfigSO wave)
        {
            _isSpawningWave = true;
            EventBus.Instance.Publish(new WaveStartedEvent { WaveNumber = wave.waveNumber });

            for (int i = 0; i < wave.creepCount; i++)
            {
                // Instantiate creep at start pos
                Instantiate(defaultCreepPrefab);
                yield return new WaitForSeconds(wave.spawnInterval);
            }

            _isSpawningWave = false;
            _currentWaveIndex++;
            EventBus.Instance.Publish(new WaveCompletedEvent { WaveNumber = wave.waveNumber });
        }
    }
}
