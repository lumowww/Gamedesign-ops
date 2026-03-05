using UnityEngine;

namespace GAMEDEVGD.Gameplay
{
    /// <summary>
    /// Placeholder for the Tower component. Will hold logic for attack and configuration.
    /// </summary>
    public class Tower : MonoBehaviour
    {
        public Data.TowerConfigSO Config;
        public GridCell CurrentCell { get; set; }
        
        public int CurrentMergeLevel => Config != null ? Config.mergeLevel : 1;
        public Data.TowerType TowerType => Config != null ? Config.type : Data.TowerType.FIRE;

        // Visuals can be updated here based on level
        public void InitSequence(Data.TowerConfigSO config, GridCell cell)
        {
            Config = config;
            CurrentCell = cell;
            transform.position = cell.transform.position;
        }
    }
}
