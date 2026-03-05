using UnityEngine;

namespace GAMEDEVGD.Data
{
    [CreateAssetMenu(fileName = "GameConfig", menuName = "GAMEDEVGD/Data/Game Config")]
    public class GameConfigSO : ScriptableObject
    {
        public string gameName = "Alien in Waders";
        public string version = "0.1.0";
        public int targetFPS = 60;
        
        [Header("Economy Settings")]
        public int startingScore = 100;
        public int scorePerKill = 5;
        
        [Header("Game Rules")]
        public int totalWavesToWin = 10;
        public int maxEscapedCreeps = 10;
    }
}
