# Quality Guardian GitHub 增长运营策略

## 核心定位

Quality Guardian 不是又一个"测试工具"或"QA 框架"——它是 **AI 时代的第一道品质防线**。在 AI 辅助编程爆发的当下，这是每一个用 AI 写代码的团队都需要的。

## 第一阶段: 冷启动（0→100 stars）

### 1. 自己先用，产出案例
- 在你自己所有的项目（供应商系统、易理明灯、星光映照、地球Online）上运行 Quality Guardian
- 把真实的验收报告脱敏后放到 `examples/` 目录
- **真实案例比任何宣传都有说服力**

### 2. 产品猎人 (Product Hunt) 发布
- 准备好英文标题和简介
- 截一张 Quality Guardian 运行时的终端截图作为封面
- 发布时间选周二/周三（PH 流量最高）
- 提前在 PH 上联系 5-10 个活跃用户做 launch day 支持

### 3. 内容传播三件套

**A. 一篇"我们怎么用 AI 给自己的 AI 代码做验收"的博客**
- 发在掘金/思否/知乎/Medium
- 核心故事: 自己做的项目自己验收总漏问题 → 做了这个 → 效果惊人
- 附真实数据: 发现了多少问题、评分提升了多少

**B. 一段 60 秒演示视频**
- 展示: clone → /quality-guardian → 自动识别 → 并行 Agent 跑 → 出报告
- 发在 B 站/YouTube/Twitter
- 核心卖点: "丢进去就能用，零配置"

**C. 对比图**
- Before: 人工验收清单（漏了 80% 的体验问题）
- After: Quality Guardian 验收报告（6 维度全覆盖）
- 一张图顶一万字

### 4. 社区钩子

在 README 中放一个 "Submit your acceptance report" 的入口：
- 用户跑完验收后，可以把报告（脱敏）提交到 `community-reports/` 目录
- 这就是天然的 UGC 案例库
- 每个提交的用户都会帮你传播

## 第二阶段: 社区增长（100→1000 stars）

### 5. Claude Code 生态对接
- 联系 Anthropic 的 DevRel，看能不能进 Claude Code 官方 skill 推荐列表
- 在 Claude Code Discord/论坛 中活跃，回答品质保障相关问题时自然提到 Quality Guardian

### 6. 和 AI 编程工具集成
- 写一个 GitHub Action: 代码 push 后自动跑 Quality Guardian
- 支持 Cursor/Windsurf/Copilot 等 AI IDE 的一键集成
- "AI 帮你写代码，Quality Guardian 帮你检查 AI 写的代码"

### 7. 行业场景模板
- 开源贡献者可以提交特定行业的验收模板: 电商/金融/教育/医疗/游戏
- 形成"模板市场"效应

## 第三阶段: 破圈（1000→5000 stars）

### 8. 做"AI 代码品质报告"
- 定期发布"XX 个 AI 生成项目的品质分析报告"（匿名化）
- 这会成为行业参考数据，媒体会引用

### 9. 企业版/托管版
- 开源的继续开源（MIT）
- 可以做一个 Web 托管版（按项目收费），给不想自己跑命令行的非技术 PM 用
- 这就是 v2.0 的 Web 平台

## 关键原则

1. **真实优于精美** — 真实的验收报告 > 精美的营销文案
2. **案例驱动** — 每一个 star 背后都应该是一个"这个真的有用"的故事
3. **社区参与** — 让用户成为参与者（提交报告/贡献模板），而不是消费者
4. **持续更新** — GitHub 绿点不能断，每周至少一次提交
