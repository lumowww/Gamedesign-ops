# QWEN.md — GAMEDEVGD Project Context

**Generated:** 2026-03-05  
**Project:** GAMEDEVGD v2.0 — Multi-Agent Unity Game Development System  
**Repository:** https://github.com/lumowww/Gamedesign-ops

---

## 📋 Project Overview

**GAMEDEVGD** is a multi-agent game development system for mobile hypercasual games built on Unity 6 LTS. Six AI agents collaborate through separate Antigravity IDE workspaces, communicating via a file-based "brain" system.

### Team Composition (6 Agents)

| Workspace | Role | Rule File | Entry Point |
|-----------|------|-----------|-------------|
| **PRODUCER** | Game Producer | `.agent/rules/06_PRODUCER.md` | ← **MAIN ENTRY** |
| **PM** | Project Manager | `.agent/rules/01_PM.md` | Sprint coordination |
| **GD** | Game Designer | `.agent/rules/02_GD.md` | GDD ownership |
| **DEV** | Unity Lead Developer | `.agent/rules/03_DEV.md` | Qwen Code role |
| **UIUX** | UI/UX Designer | `.agent/rules/04_UIUX.md` | Interface specs |
| **ART** | Art Director | `.agent/rules/05_ART.md` | Asset direction |

### Technology Stack

| Component | Version/Detail |
|-----------|----------------|
| **Unity** | 6 LTS (6000.3.9f1) + URP |
| **Platforms** | iOS + Android |
| **IDE** | Antigravity (VSCode + Agent Manager) |
| **MCP Server** | `com.gamelovers.mcp-unity@1.2.0` |
| **AI Framework** | Antigravity Multi-Agent System |

---

## 🏗️ Architecture

### Communication Bus (Brain Files)

All agents communicate through `.gemini/antigravity/brain/`:

| File | Owner | Purpose |
|------|-------|---------|
| `project_context.md` | PM | Project status, deadlines |
| `task_board.md` | PM | Task board (TODO/IN_PROGRESS/REVIEW/DONE/BLOCKED) |
| `gdd_summary.md` | GD | GDD summary (Single Source of Truth for design) |
| `art_bible_summary.md` | ART | Art style guide |
| `asset_registry.md` | ART/UIUX | Asset registry with statuses |
| `decisions_log.md` | All | Append-only decision log |

### A2A (Agent-to-Agent) Communication

Artifacts stored in `.agent/artifacts/`:
- `GD_to_DEV_TASK-XXX.md` — Technical specs from GD to DEV
- `GD_to_ART_TASK-XXX.md` — Asset requests from GD to ART
- `GD_to_UIUX_TASK-XXX.md` — UI/UX specifications
- `[ROLE]_to_GD_note_TASK-XXX.md` — Feedback to GD

### Project Structure

```
D:\ASTRA\My project\
├── .agent/                     # Agent configuration
│   ├── rules/                  # Role rules (00_global, 01-06)
│   ├── workflows/              # Workflow protocols (14 files)
│   ├── skills/                 # Agent skills (13 files)
│   └── artifacts/              # A2A communication artifacts
├── .gemini/antigravity/
│   ├── brain/                  # Communication bus (6 files)
│   └── mcp_config.json         # MCP configuration
├── .qwen/                      # Qwen Code (DEV agent)
│   ├── QWEN.md                 # Behavior contract
│   ├── MCP_CLIENT.md           # MCP client documentation
│   ├── mcp-client.js           # MCP Unity client
│   ├── skills/                 # Qwen skills
│   └── tasks/                  # Qwen task tracker
├── Assets/
│   ├── _Project/               # Main project code
│   │   ├── Scripts/
│   │   │   ├── Core/           # Core systems (EventBus, GameManager)
│   │   │   ├── Gameplay/       # Gameplay mechanics
│   │   │   ├── UI/             # UI logic
│   │   │   └── Data/           # Data management
│   │   ├── Prefabs/
│   │   ├── Scenes/
│   │   ├── Art/
│   │   ├── Audio/
│   │   └── UI/
│   └── _ThirdParty/            # Third-party assets
├── docs/
│   ├── GDD/                    # Game Design Documents
│   ├── ArtBible/               # Art bible
│   ├── UISpec/                 # UI specifications
│   ├── PRODUCER_BRIEF.md       # Producer brief (when active)
│   └── PROJECT_PIPELINE.md     # Project pipeline
├── Packages/                   # Unity packages
├── ProjectSettings/            # Unity project settings
├── scripts/                    # Utility scripts
└── package.json                # Node.js dependencies
```

---

## 🚀 Building and Running

### Prerequisites

- **Unity Editor 6 LTS** (6000.3.9f1)
- **Node.js** (for MCP client)
- **Antigravity IDE** (for multi-agent workspaces)

### Setup

```bash
# 1. Install Node.js dependencies
npm install

# 2. Open project in Unity Editor 6 LTS

# 3. Configure Antigravity MCP Settings
# See: .gemini/antigravity/mcp_config.json

# 4. MCP Unity server auto-starts on port 8090 when Unity is open
```

### MCP Unity Configuration

```json
{
  "mcpServers": {
    "unity": {
      "command": "node",
      "args": ["d:/ASTRA/My project/Library/PackageCache/com.gamelovers.mcp-unity@1.2.0/Server~/build/index.js"]
    }
  }
}
```

**Architecture:**
```
Antigravity (MCP client)
    ↕ STDIO
Node.js index.js (StdioServerTransport)
    ↕ WebSocket :8090
Unity Editor (McpUnityServer)
```

### Available MCP Tools

| Tool | Description |
|------|-------------|
| `get_scene_info` | Current scene information |
| `get_scenes_hierarchy` | Scene object hierarchy |
| `get_gameobject` | GameObject details by ID |
| `get_console_logs` | Unity Console logs |
| `update_gameobject` | Create/update GameObject |
| `update_component` | Add/configure component |
| `execute_menu_item` | Execute Unity menu command |
| `load_scene` / `save_scene` / `create_scene` | Scene management |

### Testing

```bash
# Run Python tests (agent infrastructure)
cd .agent/tests
pytest

# Run Unity C# tests (in Unity Editor)
# Assets/_Project/Tests/
```

---

## 📋 Development Conventions

### Coding Standards (Unity C#)

```csharp
public class PlayerController : MonoBehaviour
{
    [SerializeField] private float _speed = 5f;
    private Rigidbody2D _rb;
    public bool IsAlive { get; private set; } = true;

    private void Awake() => _rb = GetComponent<Rigidbody2D>();
    private void Update() { /* input only */ }
    public void Die() { IsAlive = false; }
}
```

**Naming Conventions:**
- Classes: `PascalCase`
- Variables: `camelCase`, private with `_` prefix
- Constants: `UPPER_SNAKE_CASE`
- ScriptableObjects: `SO` suffix (e.g., `LevelConfigSO`)
- Prefabs: `Pfb` suffix (e.g., `PlayerPfb`)
- Scenes: `snake_case` (e.g., `gameplay_main`)

### Git Conventions (Conventional Commits)

```
feat(gameplay): add double jump mechanic
fix(ui): correct score display overflow
art(sprites): add player idle animation frames
design(gdd): update level progression curve
docs(readme): update setup instructions
```

### Task Lifecycle

```
TODO → IN_PROGRESS → REVIEW → [GD_GATE] → DONE
```

**GD_GATE** is mandatory for tasks tagged: `GAMEPLAY`, `ECONOMY`, `UX`, `FTUE`, `BALANCE`, `LIVEOPS`

### SSOT (Single Source of Truth)

| Domain | SSOT File | Owner |
|--------|-----------|-------|
| Game Design | `.gemini/antigravity/brain/gdd_summary.md` | GD |
| Tasks | `.gemini/antigravity/brain/task_board.md` | PM |
| Assets | `.gemini/antigravity/brain/asset_registry.md` | ART |

---

## ⚡ Slash Commands

| Command | Who | Description |
|---------|-----|-------------|
| `/concept [text]` | User → PRODUCER | Start new project |
| `/new-project` | PM | Initialize project |
| `/feature-spec [name]` | GD | Write feature spec + tasks |
| `/balance-review` | GD | Economy audit |
| `/design-review [TASK-ID]` | GD | Review implementation |
| `/liveops-plan [type]` | GD | Design LiveOps event |
| `/sync` | PM | Daily sync summary |
| `/done TASK-ID` | All | Mark task complete |
| `/handoff` / `/resume` | All | Context transfer/recovery |
| `/asset-request [type] [desc]` | All | Request asset from ART |
| `/qwen-autonomous [TASK-ID]` | Qwen Code | Autonomous DEV mode |

---

## 🔐 RBAC (Role-Based Access Control)

### DEV Agent (Qwen Code) Permissions

| Path/File | Access |
|-----------|--------|
| `Assets/_Project/Scripts/` | R/W (owner) |
| `Assets/_Project/Prefabs/` | R/W |
| `Assets/_Project/Scenes/` | R/W |
| `docs/GDD/` | Read-only (GD owner) |
| `brain/gdd_summary.md` | Read-only (GD owner) |
| `brain/task_board.md` | Read-only (PM owner) |
| `brain/decisions_log.md` | Append-only |
| `.agent/artifacts/GD_to_DEV_*.md` | Read |
| `.agent/artifacts/DEV_to_GD_*.md` | R/W (creates DEV) |

### Human-in-the-Loop (Requires Confirmation)

Request permission before:
- Deleting files/directories
- `git push --force` or working with `main` branch
- Production deployment
- Changing `config/prod.*` files
- Commands with elevated privileges

---

## 📊 Current Project Status

| Parameter | Value |
|-----------|-------|
| **Version** | 2.0.0 |
| **Status** | 🟢 READY FOR WORK |
| **MCP Unity** | ✅ CONNECTED (port 8090) |
| **GD-Workspace** | ✅ DEPLOYED |
| **Active Sprint** | Sprint 0 — COMPLETED |
| **Next Step** | Run `/concept` in PRODUCER-Workspace |

### Completed (Sprint 0)

- ✅ Core infrastructure scripts (`EventBus.cs`, `GameManager.cs`, `ObjectPool.cs`)
- ✅ MCP Unity integration (port 8090, AutoStartServer=true)
- ✅ Qwen Code integration as DEV agent
- ✅ Full documentation (AGENTS.md, WIKI.md, MCP_CLIENT.md)
- ✅ 14 workflow files, 13 skill files, 7 rule files
- ✅ Python + Unity C# test infrastructure

---

## 🆘 Escalation Path

| Situation | Action |
|-----------|--------|
| **Blocker** | Escalate to PM via `task_board.md` (status BLOCKED) |
| **Architectural conflict** | `decisions_log.md` + notify PM + PRODUCER |
| **Concept pivot** | PRODUCER makes decision |
| **Critical bug in prototype** | DEV → PM → PRODUCER (if affects deadlines) |

---

## 📚 Key Documentation Files

| File | Description |
|------|-------------|
| [README.md](README.md) | Main project documentation |
| [AGENTS.md](AGENTS.md) | Team rules (READ FIRST for agents) |
| [VERSION_HISTORY.md](VERSION_HISTORY.md) | Version history |
| [docs/WIKI.md](docs/WIKI.md) | Complete team guide |
| [.qwen/QWEN.md](.qwen/QWEN.md) | Qwen Code behavior contract |
| [.qwen/MCP_CLIENT.md](.qwen/MCP_CLIENT.md) | MCP Unity client docs |
| [.agent/rules/00_global.md](.agent/rules/00_global.md) | Global team rules |
| [.agent/rules/03_DEV.md](.agent/rules/03_DEV.md) | DEV agent specific rules |

---

## 🔗 External Links

- **Repository:** https://github.com/lumowww/Gamedesign-ops
- **Unity:** https://unity.com/
- **MCP Unity:** https://github.com/CoderGamester/mcp-unity
- **Antigravity:** https://antigravity.dev/

---

**GAMEDEVGD Team © 2026 | MIT License**
