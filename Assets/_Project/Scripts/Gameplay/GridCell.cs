using UnityEngine;

namespace GAMEDEVGD.Gameplay
{
    public class GridCell : MonoBehaviour
    {
        public Tower OccupiedTower { get; set; }

        public bool IsEmpty => OccupiedTower == null;
    }
}
