using UnityEngine;
using System.Collections.Generic;
using GAMEDEVGD.Core;

namespace GAMEDEVGD.Gameplay
{
    public class MergeGrid : MonoBehaviour
    {
        public static MergeGrid Instance { get; private set; }

        public List<GridCell> allCells = new List<GridCell>();

        private void Awake()
        {
            if (Instance == null) Instance = this;
            else Destroy(gameObject);
        }

        public bool TryMerge(Tower draggedTower, Tower targetTower)
        {
            // Max merge level is 3 for Sprint 1 MVPP
            if (draggedTower.TowerType == targetTower.TowerType && 
                draggedTower.CurrentMergeLevel == targetTower.CurrentMergeLevel &&
                draggedTower.CurrentMergeLevel < 3)
            {
                // Successful Merge
                int newLevel = draggedTower.CurrentMergeLevel + 1;
                
                // Clear dragged tower cell
                draggedTower.CurrentCell.OccupiedTower = null;
                
                // Destroy old towers (visuals drop, logic removes)
                // In actual implementation, we might upgrade targetTower instead of destroying both
                Destroy(draggedTower.gameObject);

                // Here we ask SpawnManager to upgrade the target tower 
                // Currently just setting a mock upgrade event
                SpawnManager.Instance.UpgradeTower(targetTower, newLevel);
                
                EventBus.Instance.Publish(new TowerMergedEvent { FromLevel = newLevel - 1, ToLevel = newLevel });
                return true;
            }

            return false;
        }

        public void MoveTower(Tower tower, GridCell targetCell)
        {
            // Clear old cell
            if (tower.CurrentCell != null)
                tower.CurrentCell.OccupiedTower = null;

            // Occupy new cell
            tower.CurrentCell = targetCell;
            targetCell.OccupiedTower = tower;

            // Snap position
            tower.transform.position = targetCell.transform.position;
        }

        public GridCell GetFirstEmptyCell()
        {
            foreach (var cell in allCells)
            {
                if (cell.IsEmpty) return cell;
            }
            return null;
        }
    }
}
