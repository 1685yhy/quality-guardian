# 测试策略指南

Quality Guardian **不预设你的产品类型**。它通过推理来理解你的产品，然后选择最合适的测试方式。

## 测试方式（按优先级）

| 优先级 | 方式 | 适用场景 |
|--------|------|---------|
| 🔥 L1 自动 | Chrome MCP 浏览器操作 | 任何有 URL 的产品（Web、小程序 Web 版、PWA、WebGL 游戏） |
| 🔥 L1 自动 | curl / CLI 命令 | API 服务、命令行工具、脚本 |
| 📸 L2 分析 | 截图/录屏分析 | 原生 App、无法 URL 访问的程序 |
| 📝 L3 人工 | 测试剧本 | 以上全部不可用时的兜底 |

## 兜底指南（仅当自动化不可用时）

| 场景 | 指南文件 |
|------|---------|
| 小程序（无 Web 版） | [mini-program.md](mini-program.md) — DevTools/真机截图 |
| 原生移动 App | [native-app.md](native-app.md) — Simulator/TestFlight 截图 |
| 游戏（无 WebGL 版） | [game.md](game.md) — Editor Play 模式截图/录屏 |
| 其他 | 询问用户如何运行该产品 |

## 核心原则

**先自动，后人工。先推理，后分类。**
