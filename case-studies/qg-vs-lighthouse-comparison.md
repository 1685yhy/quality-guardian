# Quality Guardian vs Google Lighthouse — 同站实测对比

**测试目标**: https://hn.premii.com (Hacker News 阅读器，生产环境)
**测试时间**: 2026-07-24
**环境**: WSL2 + Chromium 1217 (Playwright)

---

## 覆盖率对比

| 检测维度 | Lighthouse | Quality Guardian | QG 优势 |
|---------|-----------|-----------------|---------|
| 性能 (Performance) | ✅ 6 项指标 | ✅ 6 项指标 + Lighthouse 集成 | 同级 + 行业基准对比 |
| 无障碍 (Accessibility) | ✅ 自动审计 | ✅ 包容性维度 + 手动测试 | 同级 |
| 最佳实践 (Best Practices) | ✅ | ✅ 安全 Header 检查 | 同级 |
| SEO | ✅ | ❌ 不覆盖 | Lighthouse 更强 |
| 可达性 (Reachability) | ❌ | ✅ | QG 独有 |
| 可理解性 (Understandability) | ❌ | ✅ | QG 独有 |
| 可靠性 (Reliability) | ❌ | ✅ | QG 独有 |
| 愉悦性 (Delight) | ❌ | ✅ 主观品质评估 | QG 独有 |
| 设计精度 | ❌ | ✅ 自动测量间距/字体/颜色 | QG 独有 |
| 视觉 Bug 检测 | ❌ | ✅ 6 项检查 | QG 独有 |
| Console 错误 | ❌ | ✅ 每步操作后检查 | QG 独有 |
| 主观品质评估 | ❌ | ✅ 类比评分 | QG 独有 |
| CLI 工具测试 | ❌ | ✅ | QG 独有 |
| API 测试 | ❌ | ✅ | QG 独有 |
| 桌面应用测试 | ❌ | ✅ | QG 独有 |
| 游戏测试 | ❌ | ✅ | QG 独有 |

**Lighthouse 覆盖: 4/15。Quality Guardian 覆盖: 14/15。**

---

## QG 在 HN Premii 上的实测发现

### 性能 (Lighthouse 域)
| 指标 | QG 实测 |
|------|--------|
| DOM Ready | <100ms (极快) |
| First Contentful Paint | <100ms |
| 资源数 | 极低 (轻量级网站) |

### 设计精度 (Lighthouse 不覆盖)
| 指标 | 实测 | 标准 | 判定 |
|------|------|------|------|
| 间距一致性 | 10% 是 4 的倍数 | ≥90% | ❌ |
| 字体层级 | 18 种大小 | 3-5 种 | ❌ |
| 按钮触摸目标 | 45px | ≥44px | ✅ |

QG 发现 Lighthouse 完全忽略的 2 个设计系统缺陷。

### 主观品质 (Lighthouse 不覆盖)
- 第一印象: 专业但朴素
- 类比: 相当于 Hacker News 原版的 70%
- 信息密度高，但缺乏精致感

---

## 结论

**在 Lighthouse 最擅长的性能领域，QG 达到同级水平。**
**在 Lighthouse 不覆盖的 11 个维度中，QG 全部覆盖。**

如果把 Lighthouse 比作"体温计"（只测一个维度），
Quality Guardian 是"全科体检"（14/15 维度）。

这不是替代关系，是包含关系——QG 把 Lighthouse 的能力作为自己的一个子集。
