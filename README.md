# Quality Guardian 🛡️

> AI 驱动的全维度品质保障框架 — 像一支专业 QA 团队 + 一群真实用户，丢进任何项目就能用。

## 这是什么

Quality Guardian 是一套 Claude Code 的 Agent 定义文件。把它放进你的项目，它会自动：

1. **识别你的项目类型** — Web/小程序/App/游戏/...不用你告诉它
2. **生成验收标准** — 从 6 个维度（可达性/可理解性/可靠性/响应性/愉悦性/包容性）推理出该检查什么
3. **盲测验收** — 以"完全不知道实现细节"的视角独立验收
4. **真实用户模拟** — 用不同用户画像（新手/专家/暴躁/佛系...）真实使用你的产品
5. **输出迭代建议** — 按优先级排序的改进清单

## 快速开始

```bash
# 进入你的项目
cd your-project

# 克隆 Quality Guardian
git clone https://github.com/1685yhy/quality-guardian.git .claude/quality-guardian

# 在 Claude Code 中运行
/quality-guardian
```

## 命令

| 命令 | 说明 |
|------|------|
| `/quality-guardian` | 自动检测项目，运行完整流程 |
| `/quality-guardian pre` | 仅开发前：生成验收标准 |
| `/quality-guardian check` | 仅开发中：增量检查 |
| `/quality-guardian accept` | 仅开发后：盲测验收 |
| `/quality-guardian review` | 仅上线后：体验回溯 |

## 原理

Quality Guardian 不靠穷举清单（"Web 应用检查 50 项""游戏检查 80 项"...），而是教 Agent **怎么思考**：

1. 读取项目 → 理解"这是什么产品"
2. 套用通用品质框架（6 维度） → 推理"这个产品应该检查什么"
3. 生成匹配的用户画像 → "谁会用它"
4. 选择匹配的模拟方式 → "怎么用它"

## 项目结构

```
├── orchestrator.md        ← 主调度 Agent
├── framework/             ← 通用品质框架
├── guardians/             ← 验收 Agent 团队（6 维度）
├── simulators/            ← 用户模拟 Agent 团队
├── templates/             ← 输出模板
└── examples/              ← 使用示例
```

## 适用场景

- ✅ Web 应用 / SaaS 平台
- ✅ 微信小程序 / 支付宝小程序
- ✅ 移动 App (iOS / Android)
- ✅ 游戏 (Unity / Unreal / 小程序游戏)
- ✅ API 服务 / 管理后台
- ✅ 任何有用户界面的软件项目

## License

MIT
