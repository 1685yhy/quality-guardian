# Quality Guardian — 60-Second Demo Video Script

> **Format**: Terminal recording (asciinema or terminalizer) with voiceover
> **Style**: Clean, fast-paced, no fluff. Show the commands, show the output.
> **Target audience**: Developers who want to see exactly how it works in 60 seconds.

---

## Scene 1: Setup (0:00 - 0:10)

**Screen**: Terminal, fresh project directory

```
~/projects/my-app$
```

**Voiceover**:
> "Quality Guardian. Clone it into any project, run one command."

**Action**: Type and execute:

```bash
git clone https://github.com/1685yhy/quality-guardian.git .claude/quality-guardian
```

**Result**: Files clone quickly (repo is small, just Markdown + shell scripts).

**Lower third text**: "git clone → ready in 3 seconds"

---

## Scene 2: Running Acceptance (0:10 - 0:25)

**Screen**: Back to terminal, project still visible

**Voiceover**:
> "Now run `accept` in Claude Code. It auto-detects your project type."

**Action**: Type:

```bash
/quality-guardian accept --quick
```

**Visual effect**: Terminal shows the orchestrator starting, scanning ports:

```
🔍 Quality Guardian v1.0 — 品质保障框架
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 阶段: 开发后盲测验收 (--quick)
🔎 检测项目类型: Web Application (package.json + vite.config detected)
🌐 扫描端口: 3000 ✓ | 5173 ✓ | 8080 ✗
🚀 连接 Dev Server: http://localhost:5173
🖥️ 启动 Chrome...
```

**Lower third text**: "Auto-detects project type + dev server"

---

## Scene 3: Guardian + Simulator Dispatch (0:25 - 0:45)

**Screen**: Terminal shows agents being dispatched in parallel

**Voiceover**:
> "Six Guardians and four Simulators start testing in parallel. Guardians check structure. Simulators act like real users."

**Action**: Animated terminal output showing each agent starting:

```
═══════════════════════════════════════
 派发 Guardian 团队 (6 维度)
═══════════════════════════════════════
✅ Reachability Guardian — 已启动 (检查: 可发现性)
  → 正在探索导航结构...
✅ Understandability Guardian — 已启动 (检查: 可理解性)
  → 正在分析界面文案...
✅ Reliability Guardian — 已启动 (检查: 可靠性)
  → 正在测试边界条件...
✅ Responsiveness Guardian — 已启动 (检查: 响应性)
✅ Delight Guardian — 已启动 (检查: 愉悦性)
✅ Inclusivity Guardian — 已启动 (检查: 包容性)

═══════════════════════════════════════
 派发 Simulator 团队 (4 画像)
═══════════════════════════════════════
👤 新手小白「小雨」— 第一次使用，直觉操作
👤 暴躁用户「阿杰」— 耐心有限，随时想走
👤 效率专家「Luna」— 高频使用，最快路径
👤 完美主义「Vivian」— 像素级审视

═══════════════════════════════════════
 进度: ████████░░ 80%  |  ⏱ 已跑 35s
```

**Visual effect**: Show the progress bar filling up, agents completing one by one.

**Voiceover** (continuing):
> "In quick mode, this takes 5 minutes. Deep mode runs for hours with full coverage."

**Lower third text**: "L1 Quick: ~5 min | L3 Deep: ~1-3 hr | L4 Exhaustive: ~4-8 hr"

---

## Scene 4: Acceptance Report (0:45 - 0:55)

**Screen**: The completed report appears

**Voiceover**:
> "Here's the acceptance report. Structured scores, prioritized issues, and real simulator feedback — all from blind testing."

**Action**: Show a highlight reel of the report scrolling:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 📊 总体评分: 74/100
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 可达性   Reachability   82 ⚠️
 可理解性 Understand.    71 ⚠️
 可靠性   Reliability    65 ❌
 响应性   Responsiveness 88 ✅
 愉悦性   Delight        92 ✅
 包容性   Inclusivity    46 ❌

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 🚨 P0 — 紧急修复
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1. 定价一致性: 前端¥19.9 ≠ 后端¥29.9
 2. JWT密钥: change-me-in-production

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 💬 用户模拟反馈
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 [暴躁用户] "默认模式改为快速，别拿所有用户
              的时间赌转化率"
 [新手] "'牌阵'是什么？没有解释，只能猜"
```

**Zoom in** on the P0 findings. **Highlight** the Simulator quotes.

**Lower third text**: "Blind testing. No source code access."

---

## Scene 5: CI/CD + CTA (0:55 - 1:00)

**Screen**: Shows the CI/CD integration in a split view:
- Left: The YAML file (`.github/workflows/quality-check.yml`)
- Right: A PR comment with the quality check results

**Voiceover**:
> "Add it to CI. Every PR gets an automated quality gate. Star it, clone it, try it on your next project."

**Action**: The screen transitions to a simple call-to-action card:

```
┌──────────────────────────────────────┐
│  🛡️ Quality Guardian                │
│  github.com/1685yhy/quality-guardian │
│                                      │
│  Open Source · MIT · Claude Code     │
└──────────────────────────────────────┘
```

**Lower third text**: "github.com/1685yhy/quality-guardian"

---

## Production Notes

### Recording Setup

| Element | Recommendation |
|---------|---------------|
| **Recording tool** | asciinema (terminal) or terminalizer (customizable GIF) |
| **Terminal theme** | Dark theme (Dracula, Monokai, or Nord) |
| **Font** | Fira Code, JetBrains Mono, or Cascadia Code |
| **Font size** | 14-16pt (readable on mobile) |
| **Window size** | 80x24 characters minimum, 100x30 ideal |
| **Frame rate** | Safari/Chrome can record at 60fps for smooth cursor |
| **Audio** | Clean voiceover, no background music |
| **Voiceover tone** | Calm, slightly energetic, developer-to-developer |

### Scene Timing Notes

- The 60-second constraint means **every second matters**
- Scenes 1-2 (setup) should be fast — devs already know how `git clone` works
- Scene 3 (agent dispatch) is the "wow" moment — show the parallel execution visually
- Scene 4 (report) needs the most screen time — this is the core value proposition
- Scene 5 (CTA) should be crisp and memorable

### Alternative: Silent Version

If voiceover isn't possible, add text overlays:

1. **0-10s**: "Clone into any project →"
2. **10-25s**: "Run `/quality-guardian accept` — auto-detects project type"
3. **25-45s**: "6 Guardians + 4 Simulators test in parallel (blind, no source code access)"
4. **45-55s**: "Full acceptance report: scores + P0/P1/P2 findings + simulator feedback"
5. **55-60s**: "github.com/1685yhy/quality-guardian — open source, MIT"

### Screenshot B-Roll (for GIF version)

If creating a GIF instead of a video, capture these stills:

1. **Still 1**: Before/after — the command vs. the running output
2. **Still 2**: Agent dispatch screen (all 10 agents starting)
3. **Still 3**: Acceptance report score table (the 6-dimension grid)
4. **Still 4**: P0 findings closeup
5. **Still 5**: Simulator quote
6. **Still 6**: CI/CD comment on a PR

### Suggested Tools

| Tool | Purpose | Cost |
|------|---------|------|
| [asciinema](https://asciinema.org/) | Terminal recording | Free |
| [terminalizer](https://github.com/faressoft/terminalizer) | Customizable terminal GIFs | Free |
| [Screen Studio](https://screenstudio.xyz/) | Mac screen recording with auto-cursor | Paid |
| [OBS Studio](https://obsproject.com/) | Free screen recording | Free |
| [Kap](https://getkap.co/) | Mac GIF recording | Free |
