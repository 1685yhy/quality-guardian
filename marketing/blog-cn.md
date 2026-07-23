# 我写了一个 AI Agent，让它自动给我的项目做验收，结果发现了 4 个致命 Bug

## 一个习惯性忽略的事实

作为开发者，我们都经历过这种时刻：

项目上线前，自己"验收"了一遍——点了几个页面，走了几条主流程，觉得没什么问题。然后上线第二天，用户反馈来了：

- "为什么支付价格和页面显示的不一样？"
- "这个按钮点不了啊"
- "这个功能我根本找不到在哪"

你开始检查代码。然后发现，自己确实写了个逻辑漏洞，但"测试"的时候根本没走到那条分支。

问题出在哪？**人无法客观测试自己的作品。**

你的大脑会自动补全：知道这个功能在哪，所以觉得"入口很明显"；知道这个按钮会跳转，所以觉得"反馈很清晰"；知道价格是从数据库取的，所以不会专门去验证前端写死的是不是和后端一致。

这不是疏忽，这是认知偏见。每个开发者都带着这种偏见写代码、做验收。

## 转机：让 AI Agent 代替我做验收

去年我在做[星光映照](https://github.com/1685yhy/starlight-tarot)（一款塔罗占卜微信小程序）时，想试试能不能用 Claude Code 的 Agent 能力，做一个"完全不读源码、完全不知道实现细节"的验收工具。

思路很简单：**像人一样盲测。**

- 不给它看代码
- 不给它看 API 文档
- 不给它看数据库 schema
- 只告诉它"这是个什么产品"，然后让它自己上去用

结果很惊人——它发现了 4 个 P0（致命级）Bug：

1. **定价欺诈风险（P0）**：前端显示"会员月卡 19.9 元/年卡 168 元/学生 9.9 元"，后端实际扣款 29.9 元/年卡 198 元/学生不存在。前后端硬编码不一致，上线就是消费者权益问题。

2. **JWT 密钥默认值（P0）**：`JWT_SECRET = "change-me-in-production"` 在生产环境没改。攻击者可伪造任意用户 Token，全站数据裸奔。

3. **无障碍属性缺失（P0）**：整个项目只有 1 处 aria-label，78 张塔罗牌全部没有 alt 文本，盲人用户完全无法使用。

4. **会员入口缺失（P0）**：首页完全没有会员升级入口，用户免费额度用完后只有弹窗拦截，没有引导。

最终验收报告给了 **63/100 分**——响应性和愉悦性超过 90 分，但可靠性和包容性双双不及格。

那个报告让我在发布前修复了 2 个可能毁掉产品的致命问题。我意识到，这个"AI 验收工具"本身值得做成一个通用项目。

## Quality Guardian 的诞生

于是我把这个思路做成了 **Quality Guardian**——一个 Claude Code 的 Agent 技能框架。任何一个项目，把它克隆进去，告诉 Claude "做验收"，它就会自动做下面这件事：

### 架构：6 个 Guardian + 4 个 Simulator 并行工作

它不是单个 Agent，而是一个**平行团队**。

**6 个 Guardian（品质卫士）：**
- **可达性** — 核心功能入口是否明显？找到需要几步？
- **可理解性** — 用户能看懂吗？需要思考吗？
- **可靠性** — 出错了怎么办？数据安全吗？
- **响应性** — 操作有反馈吗？快不快？
- **愉悦性** — 用着开心吗？有惊喜吗？
- **包容性** — 不同人群和环境下能用吗？

**4 个 Simulator（模拟用户）：**
- **新手小白** — 第一次用，靠直觉操作
- **效率专家** — 高频使用，追求最快路径
- **暴躁用户** — 耐心极有限，随时想放弃
- **完美主义** — 关注每个像素和每个字

6 个 Guardian 从结构化维度评分，4 个 Simulator 以第一人称"使用产品"。然后一个 **Feedback Compiler** 汇总双方结果，进行冲突裁决。

裁决规则很简单但有效：
- Simulator 发现问题但 Guardian 没发现 → **Simulator 胜**，标记 "Guardian 漏检"
- Guardian 说通过但 Simulator 卡住了 → **Simulator 胜**，真实用户永远是对的
- Guardian 说有问题但 Simulator 没遇到 → **Guardian 胜**，标记 "理论风险" 降级处理
- 双方一致 → **最高置信度**，直接入报告

### 4 级测试深度

| 深度 | 时间 | 检查项/维度 | Simulator 数量 | 场景覆盖 |
|------|------|------------|---------------|---------|
| L1 快速 `--quick` | 5-10 分钟 | 3-5 条 | 1 个 | 主流程 |
| L2 标准（默认） | 20-40 分钟 | 8-12 条 | 3-4 个 | 快乐+异常路径 |
| L3 深度 `--deep` | 1-3 小时 | 15-25 条 | 4-5 个 | 系统边界探索 |
| L4 穷尽 `--exhaustive` | 4-8 小时 | 全覆盖 | 全部 | 安全+无障碍审计 |

快速验收？`--quick`，5 分钟跑一轮，适合日常开发中增量检查。上线前大检查？`--deep` 或 `--exhaustive`，让 AI 团队花几个小时穷尽你的产品。

### 支持所有产品类型

Quality Guardian 能自动识别并适配测试方式：

| 产品类型 | 测试方式 |
|---------|---------|
| Web 应用 / SaaS | Chrome MCP 浏览器操作 |
| 微信小程序 | DevTools MCP 操作 |
| CLI 命令行工具 | 命令执行测试 |
| API / 后端服务 | curl 端点测试 |
| 原生 App (iOS/Android) | adb + xcrun 自动化 |
| 游戏 (Unity/Unreal/Godot) | 引擎检测 + 截图分析 |
| 桌面应用 | Web 版 -> CLI -> 截图 |
| 没有自动化条件 | 截图 + 测试剧本降级 |

## 一段真实的 Simulator 反馈

这是验收星光映照时，暴躁用户"阿杰"的反馈（节选）：

> "默认模式从'沉浸'改成'快速'，想体验仪式感的人自己去开。不要拿所有用户的时间去赌转化率。"
>
> "点会员牌阵弹窗时——第 3 次想关，并且骂了一句'有病'。"

而新手小白"小雨"说：

> "'牌阵'这个词一开始完全不懂。'恋人三角'是干嘛的？'凯尔特十字'又是什么？没有解释。"

这些反馈不是分析的结论，而是**模拟用户的第一人称感受**。读到这些时，你会觉得团队里有 4 个真实用户在同时试用你的产品。这正是 Quality Guardian 的核心价值——**不是数据分析，而是体验模拟**。

## CI/CD 集成

你只需要在 PR 时自动触发：

```yaml
name: Quality Guardian Check
on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Clone Quality Guardian
        run: git clone https://github.com/1685yhy/quality-guardian.git /tmp/quality-guardian
      - name: Run Quick Check
        run: |
          bash /tmp/quality-guardian/scripts/start-chrome.sh 9222
          # ... 验收自动执行
      - name: Post results
        uses: actions/github-script@v7
        with:
          script: |
            // 自动在 PR 上贴验收结果
```

每次 PR 自动检查：页面访问性、Console 错误、Core Web Vitals、安全 Header，结果直接贴在 PR Comment 上。

## 快速上手

```bash
cd your-project
git clone https://github.com/1685yhy/quality-guardian.git .claude/quality-guardian
```

然后在 Claude Code 中说：

```
/quality-guardian accept --quick
```

就这样。它会自动扫描你项目的端口、启动 Chrome、派出 Guardian 团队和 Simulator 团队并行验收。

---

这就是 Quality Guardian 的故事。它源自一次真实的痛苦经历，现在已经开源。如果你和我一样，受够了上线后才发现自己漏掉的 Bug，试试它。

总有一天，每个 PR 都会自动跑 AI 验收，就像现在自动跑 CI 一样。这一天不会太远。

**GitHub**: https://github.com/1685yhy/quality-guardian

**Star 它，Clone 它，给你的下一个项目跑一轮验收。**
