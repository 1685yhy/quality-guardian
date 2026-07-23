# Platform Automation Guides

Quality Guardian **优先尝试自动操作你的产品**，而不是一上来就要素材。这里的指南文件是**兜底方案**——只在自动化全部失败时才用。

## 自动化优先级

```
每个平台的尝试顺序:
1. 🔥 自动操作（框架自己来）
2. 📸 截图/录屏（请用户提供）
3. 📝 测试剧本（真人测试）  ← 最后的兜底
```

## 各平台自动化能力

| 平台 | 自动操作方案 | 成功率 | 兜底指南 |
|------|------------|--------|---------|
| Web 应用 | Chrome MCP 直接打开、点击、输入 | 极高 | 几乎不需要 |
| 微信小程序 | ①找 H5/Web 版 → Chrome MCP ②DevTools CLI 自动化 | 中高 | [mini-program.md](mini-program.md) |
| 原生 App | ①找 Web/PWA 版 → Chrome MCP ②Simulator CLI | 中 | [native-app.md](native-app.md) |
| 游戏 | ①找 WebGL 版 → Chrome MCP ②Editor 自动化 | 中低 | [game.md](game.md) |
| API / Backend Service | (curl automation) | L1 API auto-testing |

## 兜底指南（仅当自动化失败时使用）

| 平台 | 指南 | 说明 |
|------|------|------|
| 微信小程序 | [mini-program.md](mini-program.md) | DevTools/真机截图步骤 |
| iOS / Android | [native-app.md](native-app.md) | Simulator/TestFlight 截图 |
| 游戏 | [game.md](game.md) | Editor Play 模式截图/录屏 |

## 核心原则

**框架先自己动手。实在做不到才问你要。**
