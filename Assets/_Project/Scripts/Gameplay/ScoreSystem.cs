using GAMEDEVGD.Data;
using GAMEDEVGD.Core;

namespace GAMEDEVGD.Gameplay
{
    public class ScoreSystem : MonoBehaviour
    {
        public static ScoreSystem Instance { get; private set; }

        public GameConfigSO gameConfig;
        
        public int CurrentScore { get; private set; }
        
        private void Awake()
        {
            if (Instance == null) Instance = this;
            else Destroy(gameObject);
        }

        private void Start()
        {
            if (gameConfig != null)
            {
                CurrentScore = gameConfig.startingScore;
            }
            else
            {
                CurrentScore = 100;
            }
            EventBus.Instance.Publish(new ScoreChangedEvent { NewScore = CurrentScore });
        }

        public void AddScore(int amount)
        {
            if (amount <= 0) return;
            CurrentScore += amount;
            EventBus.Instance.Publish(new ScoreChangedEvent { NewScore = CurrentScore });
        }

        public bool TrySpendScore(int amount)
        {
            if (amount <= 0 || CurrentScore < amount) return false;
            
            CurrentScore -= amount;
            EventBus.Instance.Publish(new ScoreChangedEvent { NewScore = CurrentScore });
            return true;
        }
        
        private void OnEnable()
        {
            EventBus.Instance.Subscribe<CreepKilledEvent>(OnCreepKilled);
        }

        private void OnDisable()
        {
            EventBus.Instance.Unsubscribe<CreepKilledEvent>(OnCreepKilled);
        }

        private void OnCreepKilled(CreepKilledEvent evt)
        {
            if (gameConfig != null)
            {
                AddScore(gameConfig.scorePerKill);
            }
        }
    }
}
