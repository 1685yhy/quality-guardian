# Platform Capture Guides

When Quality Guardian cannot access your product via browser URL (L1), it needs screenshots or recordings of your product running. This directory contains platform-specific guides for capturing those materials.

## Available Guides

| Platform | Guide | Simulation Level |
|----------|-------|-----------------|
| WeChat Mini Program | [mini-program.md](mini-program.md) | L2 screenshots → L3 scripts |
| iOS / Android Native App | [native-app.md](native-app.md) | L2 screenshots → L3 scripts |
| Game (Unity/Unreal/Godot) | [game.md](game.md) | L2 screenshots/recordings → L3 scripts |
| Web Application | (no guide needed) | L1 direct browser access |

## Decision Tree

```
Detected platform type
├── Web (React/Vue/Next/etc.) → L1: Chrome MCP direct browser access
├── WeChat Mini Program → Provide screenshots via WeChat DevTools → L2
├── Native Mobile App → Provide screenshots via Simulator/TestFlight → L2
├── Game → Provide screenshots/recordings via Editor → L2
└── Unknown → Ask user to identify platform → Select appropriate guide
```

## Important

**Never fall back to code review.** If you cannot provide screenshots or recordings, the orchestrator will generate L3 test scripts for human testers instead. Quality Guardian's blind testing only works with real product materials.
