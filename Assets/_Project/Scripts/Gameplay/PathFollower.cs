using UnityEngine;
using GAMEDEVGD.Core;

namespace GAMEDEVGD.Gameplay
{
    public class PathFollower : MonoBehaviour
    {
        public Transform[] waypoints;
        public float speed = 3f;
        
        private int _currentWaypointIndex = 0;

        private void Start()
        {
            // In a real project, waypoints are injected by SpawnManager or read from a global PathManager
            // For MVP, if empty, we try to find a global object named "PathBuilder"
            if (waypoints == null || waypoints.Length == 0)
            {
                var pathObj = GameObject.Find("PathBuilder");
                if (pathObj != null)
                {
                    waypoints = new Transform[pathObj.transform.childCount];
                    for (int i = 0; i < pathObj.transform.childCount; i++)
                    {
                        waypoints[i] = pathObj.transform.GetChild(i);
                    }
                }
            }
            
            if (waypoints != null && waypoints.Length > 0)
            {
                transform.position = waypoints[0].position;
            }
        }

        private void Update()
        {
            if (waypoints == null || waypoints.Length == 0 || _currentWaypointIndex >= waypoints.Length) return;

            Transform target = waypoints[_currentWaypointIndex];
            Vector3 direction = target.position - transform.position;
            
            transform.Translate(direction.normalized * speed * Time.deltaTime, Space.World);

            if (Vector3.Distance(transform.position, target.position) < 0.1f)
            {
                _currentWaypointIndex++;
                if (_currentWaypointIndex >= waypoints.Length)
                {
                    OnReachedEnd();
                }
            }
        }

        private void OnReachedEnd()
        {
            // Creep escaped
            EventBus.Instance.Publish(new CreepEscapedEvent { Creep = this });
            Destroy(gameObject); // Return to pool in final implementation
        }
    }
}
