# Capturing Game Materials

Use this guide when Quality Guardian needs to evaluate a game (any engine).

## Unity

### Editor Play Mode (Recommended)
1. Open your project in Unity Editor
2. Press Play to enter Game view
3. For screenshots: Use the Game view's built-in capture or OS screenshot
4. For recordings: Window → General → Recorder → capture Game view at runtime
5. Navigate through key moments in your game

### Build (PC/Mac/Linux)
1. Build a development build
2. Use OBS Studio or OS screen recording to capture gameplay

## Unreal Engine

### Editor PIE Mode (Recommended)
1. Open your project in Unreal Editor
2. Click Play → Selected Viewport (or New Editor Window)
3. Use `HighResolutionScreenshot` console command for screenshots
4. Use built-in sequencer recorder or OS screen recording for video

## Godot

### Editor Play Mode
1. Open your project and click "Play" or "Play Scene"
2. Use OS screenshot tools or Godot's debug menu for captures
3. Use OS screen recording for video

## What to Capture

### Essential Screens
- Main menu / title screen
- Core gameplay (at least 3-5 distinct moments)
- UI/HUD overlay
- Settings/options screen
- Pause menu
- Loading screens

### Core Loops (Record 30-60 seconds each)
1. First-time player experience / tutorial
2. Primary gameplay loop (one full cycle)
3. Menu → Settings → Back to game flow
4. Win/lose/death state and restart flow

### Game-Specific
- Combat feedback (hit sparks, damage numbers, screen shake)
- Inventory/equipment UI
- Shop/trading UI
- Quest/mission log
- Multiplayer lobby/matchmaking (if applicable)

## What NOT to Do
- Do NOT send C# / C++ / GDScript source code
- Do NOT send prefab/scene descriptions
- Do NOT send game design documents — show the running game
- Do NOT describe what a mechanic "does in code" — show the player experience
