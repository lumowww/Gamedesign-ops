using GAMEDEVGD.Data;

namespace GAMEDEVGD.Gameplay
{
    public struct ScoreChangedEvent { public int NewScore; }
    public struct CreepKilledEvent { public CreepHealth Creep; }
    public struct CreepEscapedEvent { public PathFollower Creep; }
    
    public struct WaveStartedEvent { public int WaveNumber; }
    public struct WaveCompletedEvent { public int WaveNumber; }
    
    public struct TowerSpawnedEvent { public TowerType Type; }
    public struct TowerMergedEvent { public int FromLevel; public int ToLevel; }
    
    public struct TowerDragStartedEvent { public Tower DraggedTower; }
    public struct TowerDragEndedEvent { public Tower DraggedTower; }

    // Analytics Events
    public struct SessionStartEvent { }
    public struct SessionEndEvent { public float DurationSec; public int WavesCompleted; }
    public struct GameOverEvent { public bool IsWin; public int WavesCompleted; }
}
