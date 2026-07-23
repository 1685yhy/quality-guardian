# Quality Guardian 🛡️

> AI 驱动的全维度品质保障框架 — 像一支专业 QA 团队 + 一群真实用户，丢进任何项目就能用。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-skill-blue)](https://claude.ai/code)

## 这是什么

Quality Guardian 是一套 Claude Code 的 Agent 定义文件。放进你的项目，它会自动：

1. **识别项目类型** — Web/小程序/App/游戏/API...不用你告诉它
2. **生成验收标准** — 从 6 个维度推理出该检查什么
3. **盲测验收** — 以"完全不知道实现细节"的视角独立验收
4. **真实用户模拟** — 用不同用户画像（新手/专家/暴躁/佛系...）真实使用你的产品
5. **自动操作浏览器** — Chrome MCP 自动打开你的产品，点击、输入、浏览，像真人一样
6. **回归测试** — 每次验收自动对比上次发现的所有问题，验证旧 Bug 是否真的修好了
7. **渐进学习** — 积累项目的品质历史，越用越精准。知道这个项目的"老毛病"在哪里
8. **4 级深度** — `--quick` 5 分钟快速扫 / `--deep` 2 小时深度测 / `--exhaustive` 穷尽测试

## 快速开始

```bash
# 进入你的项目
cd your-project

# 克隆 Quality Guardian
git clone https://github.com/1685yhy/quality-guardian.git .claude/quality-guardian

# 在 Claude Code 中告诉 Claude：
# "读取 .claude/quality-guardian/orchestrator.md，对我的项目做验收"
```

Quality Guardian 会自动：
1. 检测你的项目类型（Web/小程序/App/游戏）
2. 扫描 localhost 端口找到正在运行的 dev server
3. 启动 Chrome（需要 Chrome/Chromium 已安装）自动操作你的产品
4. 派出 6 个 Guardian + 4 个 Simulator Agent 并行验收
5. 生成完整的验收报告

### CI/CD 自动运行

在 PR 时自动跑 Quality Guardian。将 `.github/workflows/quality-check.yml` 复制到你的项目即可。

每次 PR 自动:
- ✅ 启动 Chromium
- ✅ 检查页面可访问性
- ✅ 检测 Console 错误
- ✅ 测量 Core Web Vitals (LCP/FCP/CLS)
- ✅ 检查安全 Header
- ✅ 结果自动贴到 PR Comment

**如果没有 Chrome**：框架会自动降级到 L2（截图分析）或 L3（测试剧本），并给出精确的浏览器安装命令。

## 命令

在 Claude Code 中告诉 Claude 使用对应的阶段：

| 阶段 | 说明 | 产出 |
|------|------|------|
| **开发前** (`pre`) | 生成验收标准和用户画像 | 验收标准清单 + 场景矩阵 |
| **开发中** (`check`) | 增量快速检查 | 即时问题清单 |
| **开发后** (`accept`) | 盲测验收（最重要） | 完整验收报告（含分数、Simulator 反馈、P0/P1/P2 建议） |
| **上线后** (`review`) | 体验回溯与校准 | 校准报告（Simulator 准确率/误报率） |

## 原理

Quality Guardian 不靠穷举清单，而是教 Agent **怎么思考**：

1. 读取项目 → 理解"这是什么产品"
2. 套用通用品质框架（6 维度）→ 推理"这个产品应该检查什么"
3. 生成匹配的用户画像 → "谁会用它"
4. 优先自动操作产品 → "怎么用它"（Chrome MCP / WebFetch / 截图分析）
5. 并行调度验收团队 → 6 Guardian + 4 Simulator + 反馈编译器

## 项目结构

```
quality-guardian/
├── orchestrator.md           ← 主调度 Agent（入口）
├── framework/                ← 通用品质框架
│   ├── quality-dimensions.md ← 6 维度定义 + 推理规则 + 评分锚定
│   └── persona-system.md     ← 8 类基础用户画像
├── guardians/                ← 验收 Agent 团队（6 维度）
│   ├── reachability.md       ← 可达性
│   ├── understandability.md  ← 可理解性
│   ├── reliability.md        ← 可靠性
│   ├── responsiveness.md     ← 响应性
│   ├── delight.md            ← 愉悦性
│   └── inclusivity.md        ← 包容性
├── simulators/               ← 用户模拟 Agent 团队（8 个）
│   ├── persona-generator.md  ← 画像生成器
│   ├── browser-user.md       ← L1: Web 浏览器操作
│   ├── miniapp-user.md       ← L1: 小程序 DevTools 操作
│   ├── cli-tester.md         ← L1: CLI 命令行测试
│   ├── api-tester.md         ← L1: API 端点测试
│   ├── desktop-tester.md     ← L1: 桌面应用测试
│   ├── visual-user.md        ← L2: 截图/录屏分析
│   ├── scenario-player.md    ← L3: 测试剧本
│   └── feedback-compiler.md  ← 反馈编译器（冲突裁决）
├── templates/                ← 输出模板
│   ├── acceptance-report.md  ← 验收报告
│   ├── user-experience-log.md← 用户体验日志
│   ├── iteration-backlog.md  ← 迭代建议清单
│   ├── calibration-report.md ← 校准报告
│   └── history.json          ← 分数趋势记录
├── platforms/                ← 平台素材采集指南（L2 兜底用）
├── scripts/
│   └── start-chrome.sh       ← Chrome 自动启动脚本
├── examples/                 ← 使用示例（Web/小程序/App/游戏）
└── case-studies/             ← 真实项目验收案例
```

## 适用场景（全部 ⭐⭐⭐⭐⭐ L1 自动化）

| 场景 | Agent | 自动化方式 |
|------|-------|----------|
| 🌐 Web 应用 / SaaS | `browser-user.md` | Chrome MCP |
| 📱 微信小程序 | `miniapp-user.md` | DevTools MCP |
| 💻 命令行工具 / CLI | `cli-tester.md` | 命令测试 |
| 🔌 API / 后端服务 | `api-tester.md` | curl 测试 |
| 📲 原生 App (iOS/Android) | `native-app-tester.md` | adb + xcrun |
| 🎮 游戏 (Unity/Unreal/Godot) | `game-tester.md` | WebGL→引擎→截图 |
| 🖥️ 桌面应用 (Electron/Qt/.NET) | `desktop-tester.md` | Web版→CLI→UIA |
| 📸 无自动化条件 | `visual-user.md` + `scenario-player.md` | 截图 + 测试剧本 |

## 贡献

欢迎提 Issue 和 PR。详见[增长策略](docs/growth-strategy.md)。

## License

MIT © 2026 Yan Haiyang
