# Visual Regression Guide — 视觉回归检测指南

> 当 Quality Guardian 对同一产品执行多次验收时，它应当自动比较不同运行中的截图，检测像素级别的变化，并在报告中标记意外的视觉更改（回归）。

---

## 1. 核心原理

### 1.1 为什么需要视觉回归

- **功能性测试不够**: 按钮仍然"点击有效"，但颜色变浅了、位置偏移了——功能测试不会发现
- **CSS 重构风险**: 改动一个全局样式可能影响数十个页面
- **设计系统不可侵犯性**: 间距、颜色、字体是品质的基石，不能意外改变
- **组件库升级**: 升级依赖可能带来视觉上的微小变化，需要肉眼确认

### 1.2 何时进行视觉回归

| 验收类别 | 是否进行视觉回归 | 说明 |
|---------|----------------|------|
| 开发前标准 (首次) | 否，仅建立基线 | 截图作为 baseline，不比较 |
| 开发中增量 (第 N 次) | 是 | 与上一次截图比较 |
| 开发后盲测 (首次) | 否，仅建立基线 | 最终版 baseline |
| 上线后回溯 | 是 | 与上线前 baseline 比较 |
| 定期巡检 | 是 | 与最近一次 baseline 比较 |

---

## 2. 基线截图 (Baseline Screenshots)

### 2.1 如何建立基线

当验收报告在"与前期对比"章节中引用之前的截图时，以下截图应作为 baseline 保存：

```
quality-guardian/
  screenshots/
    baselines/
      {project-name}/
        {page-name}/
          {viewport}-{stage}-{timestamp}.png
    diffs/
      {project-name}/
        {page-name}/
          {viewport}-{stage}-{baseline-date}-vs-{current-date}.png
    current/
      {project-name}/
        {page-name}/
          {viewport}-{stage}-{timestamp}.png
```

**命名规则**:
```
{页面路径哈希}-{视口宽度}x{视口高度}-{阶段}-{YYYYMMDD}.png

示例:
/supplier/list → supplier-list_1440x900_dev-standard_20260722.png
/supplier/list → supplier-list_375x812_dev-standard_20260722.png
```

### 2.2 基线管理策略

| 策略 | 适用场景 | 做法 |
|------|---------|------|
| 首次即基线 | 新功能首次验收 | 首次截图自动设为 baseline |
| 上次即基线 | 增量验收 | 每次验收覆盖 baseline |
| 版本基线 | 上线前锁定 | L3/L4 验收时，手动锁定 baseline（不自动覆盖） |
| 金版基线 | 设计系统验收 | 经设计团队确认的"完美"截图作为永久的对比基准 |

### 2.3 截图时机

浏览器用户 (Simulator) 应在以下时机截图：

1. **页面完全加载后**（`networkidle` 状态）
2. **关键交互后**（点击/输入/下拉展开等操作的 500ms 后）
3. **滚动到页面底部**（截取长页面全貌 - `fullPage: true`）
4. **特定组件可见时**（Modal/Drawer/Tooltip 展开状态）
5. **空状态/错误状态/加载状态**（每个状态各截一张）

---

## 3. 截图比较方法

### 3.1 像素级对比 (Pixel-Diff)

**推荐工具**: [pixelmatch](https://github.com/mapbox/pixelmatch)（Node.js, 轻量, 精确）

```typescript
import pixelmatch from 'pixelmatch';
import { PNG } from 'pngjs';
import fs from 'fs';

function compareScreenshots(baselinePath: string, currentPath: string, diffPath: string, threshold: number = 0.1) {
  const baseline = PNG.sync.read(fs.readFileSync(baselinePath));
  const current = PNG.sync.read(fs.readFileSync(currentPath));

  // 确保尺寸一致
  if (baseline.width !== current.width || baseline.height !== current.height) {
    throw new Error(`Dimension mismatch: baseline(${baseline.width}x${baseline.height}) vs current(${current.width}x${current.height})`);
  }

  const { width, height } = baseline;
  const diff = new PNG({ width, height });
  const mismatchedPixels = pixelmatch(baseline.data, current.data, diff.data, width, height, {
    threshold,          // 0-1, 颜色差异敏感度 (0.1 为默认, 越小越敏感)
    alpha: 0.3,         // diff 图像高亮不透明度
    includeAA: false,   // 是否忽略抗锯齿差异
  });

  // 写入差异图
  fs.writeFileSync(diffPath, PNG.sync.write(diff));

  const totalPixels = width * height;
  const diffRatio = mismatchedPixels / totalPixels;

  return {
    mismatchedPixels,
    totalPixels,
    diffRatio,            // 差异像素比例
    passed: diffRatio <= 0.005,  // 默认阈值 0.5%
  };
}
```

### 3.2 结构相似性 (SSIM)

**适用场景**: 内容不变但位置可能变化的布局（如动态列表、广告位）

```typescript
// PSNR / SSIM 计算（简化版）
function calculateSSIM(baseline: PNG, current: PNG): number {
  // 实际使用时推荐使用 ssim.js 库
  // npm install ssim.js
  // 相比 pixelmatch，SSIM 更接近人类视觉感知
  // score > 0.98 = 无明显差异
  // score 0.95-0.98 = 可能有细微差异
  // score < 0.95 = 明显视觉差异
}
```

### 3.3 文本内容对比 (OCR-based)

**适用场景**: 检测文案变化（文本内容是否意外更改、字体渲染是否正确）

```typescript
// 通过提取文本层进行比较
// 使用 playwright 的 textContent 提取 + 字符串 diff
async function comparePageContent(baselinePage: string, currentPage: string): boolean {
  const baselineTexts = extractAllVisibleText(baselinePage);
  const currentTexts = extractAllVisibleText(currentPage);
  return deepEqual(baselineTexts, currentTexts);
}

function extractAllVisibleText(html: string): string[] {
  // 提取所有可见元素的 text content
  // 忽略 script/style 标签
  // 只保留 display !== 'none' 和 visibility !== 'hidden' 的元素
}
```

---

## 4. 敏感度配置 (Sensitivity Thresholds)

### 4.1 全局配置

```json
{
  "visualRegression": {
    "enabled": true,
    "tools": ["pixelmatch", "ssim"],
    "defaults": {
      "threshold": 0.1,
      "maxDiffRatio": 0.005,
      "ignoreAntialiasing": true,
      "fullPageCapture": true
    },
    "tagging": {
      "minorChange": 0.005,      // < 0.5% 差异 → "微调"
      "notableChange": 0.05,     // 0.5%-5% 差异 → "视觉变更"
      "majorChange": 0.05        // > 5% 差异 → "重大视觉变更"
    }
  }
}
```

### 4.2 逐维度敏感度

| 差异比例 | 标签 | 行为 |
|---------|------|------|
| < 0.5% | "微调" | 在报告中注明，不标记为问题 |
| 0.5% - 5% | "视觉变更" | 标记为 P2，在"与前期对比"章节显示 |
| > 5% | "重大视觉变更" | 标记为 P1，要求人工审查 |
| > 20% | "结构变更" | 标记为 P0，很可能布局错乱或页面崩溃 |

### 4.3 动态内容忽略策略

某些页面元素会自然变化（实时数据、动态广告、当前时间），这些不应触发视觉回归：

```typescript
const ignoreSelectors = [
  '[data-visual-ignore]',     // 开发者手动标记
  '.dynamic-content',          // 动态内容容器
  '.ad-container',             // 广告位
  '.current-time',             // 时间显示
  '.live-counter',             // 计数器
  '[class*="avatar"]',         // 用户头像（因用户而异）
];

// 在比较前遮盖这些区域
function maskIgnoredRegions(page: Page, image: PNG): PNG {
  // 通过坐标计算将这些区域填充为中性色
  // 避免这些区域的差异影响整体差异比例
}
```

---

## 5. 视觉回归报告格式

当反馈编译器 (Feedback Compiler) 检测到视觉变化时，在验收报告的"与前期对比"章节中包含以下内容：

```markdown
## 视觉回归检测

### 变更概览
| 页面 | 差异比例 | 严重程度 | 截图证据 |
|------|---------|---------|---------|
| /supplier/list | 3.2% | 视觉变更 (P2) | ![diff](./diffs/supplier-list-diff.png) |
| /supplier/detail?id=1 | 12.8% | 重大变更 (P1) | ![diff](./diffs/supplier-detail-diff.png) |

### 详细差异
#### /supplier/list — 差异 3.2%

| Baseline (前次) | Current (本次) | Diff (差异) |
|----------------|---------------|-------------|
| ![baseline](./baselines/supplier-list-20260722.png) | ![current](./currents/supplier-list-20260724.png) | ![diff](./diffs/supplier-list-diff.png) |

**变更检测**:
- **主页按钮颜色从 #1890FF 变为 #1677FF** — 可能是设计系统更新
- **间距：卡片内边距从 24px 变为 20px** — 影响 12 个卡片
- **其他区域无感知差异** ✅

**判定**: 视觉变更，但方向统一，推测为有意的设计更新。建议人工确认。

---

#### /supplier/detail?id=1 — 差异 12.8%

| Baseline (前次) | Current (本次) | Diff (差异) |
|----------------|---------------|-------------|
| ... | ... | ... |

**变更检测**:
- **表单提交按钮消失了** — 按钮从 DOM 中完全移除
- **页面底部空白区域增大 200px**
- **控制台无报错**

**判定**: 重大视觉变更 — 按钮丢失影响核心功能。自动标记为 P1，需人工审查。
```

---

## 6. 与验收工作流的集成

### 6.1 Feedback Compiler 中的视觉回归步骤

在反馈编译器的工作流程中，**"与前期对比"** 步骤增强为：

```
Phase 4: 与前期对比 (增强版)

Step 4.1: 功能对比
  - 对比本次和上次的问题清单
  - 哪些问题已修复/未修复/新增

Step 4.2: 视觉回归检测 (新增)
  - 检查本次验收和上次验收是否都有截图
  - 如果有 → 逐页运行 pixelmatch 对比
  - 如果没有截图 → 跳过视觉回归，只进行功能对比
  
Step 4.3: 视觉变更判定
  - 差异 < 0.5% → 记录为"微调"，不标记问题
  - 差异 0.5%-5% → 标记为"视觉变更" (P2)
  - 差异 > 5% → 标记为"重大视觉变更，需人工审查" (P1)
  
Step 4.4: 生成差异报告
  - 包含 baseline/current/diff 三图对比
  - 标注差异位置和比例
  - 合并到验收报告
```

### 6.2 Simulator 的截图职责

Browser User Simulator 在每次验收时负责：

1. 按 `框架规定的截图时机`（详见本文第 2.3 节）进行截图
2. 截图文件命名遵循 `命名约定`
3. 截图保存到 `screenshots/current/{项目名}/{页面名}/` 目录
4. 在体验日志中记录截图路径，供 Feedback Compiler 后续使用

### 6.3 CLI 集成示例

```bash
# 运行视觉回归检测
quality-guardian visual-regression \
  --baseline ./screenshots/baselines/my-app/ \
  --current ./screenshots/current/my-app/ \
  --output ./screenshots/diffs/my-app/ \
  --threshold 0.1 \
  --max-diff 0.005

# 输出:
# ✓ /supplier/list: 0.03% diff (微调)
# ✗ /supplier/detail: 3.2% diff (视觉变更)
# ✗ /dashboard: 12.8% diff (重大变更)
# Summary: 2/12 pages failed visual regression
```

---

## 7. 最佳实践

### 7.1 截图质量原则

1. **一致的视口尺寸**: 每次验收使用相同的 viewport（默认 1440×900 桌面、375×812 移动端）
2. **一致的网络条件**: 使用 `networkidle` 确保所有资源加载完毕
3. **一致的浏览器**: 同一项目固定使用 Chromium，避免跨浏览器渲染差异
4. **排除动态内容**: 使用 `[data-visual-ignore]` 属性标记无需比较的区域
5. **固定时间**: 如果页面有时间相关元素，需 Mock 时间戳
6. **相同的认证状态**: 登录/未登录状态不一致会导致大量误报

### 7.2 避免误报的策略

| 误报原因 | 解决方案 |
|---------|---------|
| 字体渲染差异 | 同一操作系统/同一浏览器执行 |
| 动态数据 | Mock API 返回固定数据 |
| A/B 测试 | 固定实验组/对照组 |
| 动画进行中 | 截图前等待所有动画完成（`waitForLoadState('networkidle')` + 500ms） |
| 第三方组件 | 将被测页面与第三方内容隔离 |
| 系统字体/抗锯齿 | 固定操作系统环境（Docker/CI） |

### 7.3 推荐的图像比较工具

| 工具 | 语言 | 优势 | 适合场景 |
|------|------|------|---------|
| [pixelmatch](https://github.com/mapbox/pixelmatch) | Node.js | 轻量、精确、无依赖 | 像素级精确对比 |
| [ssim.js](https://github.com/obartra/ssim) | Node.js | 符合人类视觉感知 | 内容布局结构比较 |
| [Resemble.js](https://github.com/rsmbl/Resemble.js) | Node.js | 可忽略指定区域 | 需要区域忽略的场景 |
| [ImageMagick compare](https://imagemagick.org/script/compare.php) | CLI | 强大、灵活、可脚本化 | CI 环境/批量处理 |
| [Playwright Visual Comparisons](https://playwright.dev/docs/test-snapshots) | Node.js | 内置于 Playwright | Playwright 用户首选 |

### 7.4 ImageMagick CLI 示例

```bash
# 像素级对比
compare -metric AE baseline.png current.png diff.png

# 容忍度设定 -fuzz 5%
compare -metric AE -fuzz 5% baseline.png current.png diff.png

# 生成高亮差异图（红色标记差异区域）
compare -highlight-color red baseline.png current.png diff.png
```
