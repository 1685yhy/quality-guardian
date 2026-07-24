# Quality Guardian — 真实案例与验证证据

本目录包含 Quality Guardian 在真实项目上的验收报告。这些不是模拟数据，是框架实际运行的输出。

## 案例列表

### 外部独立验证
| 案例 | 项目 | 类型 | 测试级别 | 关键发现 |
|------|------|------|---------|---------|
| [2026-07-24](external-validation-2026-07-24.md) | HN Premii + Git/NPM | Web + CLI | L2 标准 | 设计系统缺陷、CLI 可用性 |
| [2026-07-22](starlight-tarot-2026-07-22/) | 星光映照塔罗小程序 | 微信小程序 | L2 代码审查 | 4 个 P0: 定价不一致、JWT 默认密钥、无障碍缺失、会员入口不足 |

### 框架自验证
| 案例 | 说明 |
|------|------|
| [本目录](.) | v1.3 E2E 测试报告在 `.quality-guardian/reports/` 中 |

## 验证覆盖矩阵

| 产品类型 | 已验证 | Agent | 发现真实问题 |
|---------|--------|-------|------------|
| 🌐 Web 应用 | ✅ HN Premii | browser-user | ✅ 2 个设计缺陷 |
| 📱 微信小程序 | ✅ 星光映照 | guardians | ✅ 4 个 P0 |
| 💻 CLI 工具 | ✅ Git, NPM | cli-tester | ✅ 路径可用 |
| 🔌 API | 待验证 | api-tester | — |
| 📲 原生 App | 待验证 | native-app-tester | — |
| 🎮 游戏 | 待验证 | game-tester | — |

## 如何贡献案例

如果你用 Quality Guardian 验收了自己的项目，欢迎提交 PR 添加案例！

1. 在你的项目中运行 Quality Guardian
2. 将生成的报告脱敏（移除敏感信息）
3. 在 `case-studies/` 下创建 `项目名-日期/` 目录
4. 提交 PR

每个案例都是框架最好的广告。
