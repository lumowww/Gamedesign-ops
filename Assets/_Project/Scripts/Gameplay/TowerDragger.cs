using UnityEngine;
using UnityEngine.EventSystems;
using GAMEDEVGD.Core;

namespace GAMEDEVGD.Gameplay
{
    [RequireComponent(typeof(Tower))]
    [RequireComponent(typeof(Collider))]
    public class TowerDragger : MonoBehaviour
    {
        private Tower _tower;
        private Vector3 _startPosition;
        private Camera _mainCamera;
        
        private float _zDistanceToCamera;
        private bool _isDragging = false;

        private void Awake()
        {
            _tower = GetComponent<Tower>();
            _mainCamera = Camera.main;
        }

        private void OnMouseDown()
        {
            _zDistanceToCamera = _mainCamera.WorldToScreenPoint(gameObject.transform.position).z;
            _startPosition = transform.position;
            _isDragging = true;
            
            EventBus.Instance.Publish(new TowerDragStartedEvent { DraggedTower = _tower });
        }

        private void OnMouseDrag()
        {
            if (!_isDragging) return;

            Vector3 screenPosition = new Vector3(Input.mousePosition.x, Input.mousePosition.y, _zDistanceToCamera);
            Vector3 worldPosition = _mainCamera.ScreenToWorldPoint(screenPosition);
            
            // Keep the y slightly elevated while dragging
            worldPosition.y = _startPosition.y + 1.0f; 
            transform.position = worldPosition;
        }

        private void OnMouseUp()
        {
            _isDragging = false;
            EventBus.Instance.Publish(new TowerDragEndedEvent { DraggedTower = _tower });

            // Raycast to find what we dropped on
            Ray ray = _mainCamera.ScreenPointToRay(Input.mousePosition);
            if (Physics.Raycast(ray, out RaycastHit hit, 100f))
            {
                // Attempt to drop on another tower
                Tower targetTower = hit.collider.GetComponent<Tower>();
                if (targetTower != null && targetTower != _tower)
                {
                    if (MergeGrid.Instance.TryMerge(_tower, targetTower))
                    {
                        return; // Successfully merged, this object might be destroyed
                    }
                }
                
                // Attempt to drop on empty grid cell
                GridCell targetCell = hit.collider.GetComponent<GridCell>();
                if (targetCell != null && targetCell.IsEmpty && targetCell != _tower.CurrentCell)
                {
                    MergeGrid.Instance.MoveTower(_tower, targetCell);
                    return;
                }
            }

            // Return to start position if drop failed
            transform.position = _tower.CurrentCell.transform.position;
        }
    }
}
