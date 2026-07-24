# 为什么需要 Quality Guardian

## 这个项目解决什么问题

**现状**：要全面测试一个产品，你需要：

| 要测什么 | 需要什么工具 | 适用产品 |
|---------|------------|---------|
| Web 性能 | Lighthouse | 仅 Web |
| Web 功能 | Cypress / Playwright / Selenium | 仅 Web |
| 视觉回归 | Applitools / Percy | 仅 Web |
| 小程序测试 | 微信开发者工具手动 | 仅小程序 |
| API 测试 | Postman / curl 脚本 | 仅 API |
| 桌面应用测试 | 手动 | 桌面 |
| 游戏测试 | 手动 + Unity Test Framework | 游戏 |
| 无障碍审计 | axe / WAVE | 仅 Web |
| 安全 Header | SecurityHeaders.com | 仅 Web |
| 设计评审 | 设计师人工 | 全部 |

**你需要 8+ 个工具，覆盖 4 种产品类型。大部分是付费的。全部需要配置。**

---

## Quality Guardian 的做法

**一个框架，覆盖所有**：

| QG 的能力 | 替代的工具 |
|----------|----------|
| 6 维度品质评估 | Lighthouse + axe + SecurityHeaders + 设计评审 |
| 8 种产品类型 | Cypress + Postman + Unity Test Framework + 手动测试 |
| 4 级深度 (5分钟→6小时) | 冒烟测试 + 完整测试 + 压力测试 |
| 9 条强制规则 | 人工 QA checklist |
| CI/CD 集成 | 各工具分别配置 |
| 回归测试 | 人工追溯 |

**不替代专业工具，而是减少你需要配置的工具数量。从 8 个降到 1 个。**

---

## QG 不强的地方（诚实说明）

| 场景 | QG | 专业工具 | 差距 |
|------|-----|---------|------|
| Web 性能深挖 | 达标级 | Lighthouse 更专业 | Lighthouse 有多年行业基准数据积累 |
| 大规模 E2E 测试 | 能跑 | Cypress 更稳定 | Cypress 重跑 1000 次的稳定性 QG 没验证过 |
| 像素级视觉对比 | 支持 | Applitools 更成熟 | Applitools 有 AI 智能忽略动态内容 |
| 安全渗透测试 | 基础 Header 检查 | Burp Suite 等专业工具 | QG 不做真正的渗透测试 |

**QG 的定位不是"最好的 X 工具"，而是"覆盖最广的品质工具"。**

---

## 类比

| 工具 | 类比 |
|------|------|
| Lighthouse | 体温计 — 测一个指标，极准 |
| Cypress | 手术刀 — 精确控制，功能强大 |
| Quality Guardian | 体检中心 — 一小时内查完全身，发现异常再找专科 |

**QG 的优势不是替代专科医生，而是让你不用自己预约 8 个科室。**

---

## 谁应该用 QG

- ✅ 小团队，没有专职 QA
- ✅ 多产品线（Web + 小程序 + API 都有）
- ✅ 用 AI 写代码的团队（需要验证 AI 代码质量）
- ✅ 想在上线前做一次全面体检

## 谁不应该用 QG

- ❌ 只需要 Web 性能测试 → 用 Lighthouse
- ❌ 需要大规模 CI 稳定测试 → 用 Cypress
- ❌ 需要像素级视觉对比 → 用 Applitools
- ❌ 需要安全渗透测试 → 找安全公司
