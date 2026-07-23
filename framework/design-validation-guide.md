# Design Validation Guide — 设计规范验证

UI 精度问题（按钮尺寸偏差、间距不一致、字体大小错误）无法通过 Console 报错发现。需要系统性地测量和比较。

## 核心原则

**功能正确 ≠ 设计正确。** 代码无 Bug 但 UI 丑陋的产品是失败的。

## 自动测量规则

### 规则 1: 间距一致性

使用 JS 测量页面中所有间距，标记异常值：

```js
// 收集所有 margin 和 padding
const spacings = [];
document.querySelectorAll('*').forEach(el => {
  const style = getComputedStyle(el);
  ['marginTop','marginBottom','marginLeft','marginRight',
   'paddingTop','paddingBottom','paddingLeft','paddingRight'].forEach(prop => {
    const val = parseFloat(style[prop]);
    if (val > 0) spacings.push({el: el.tagName, prop, val});
  });
});
// 分析间距模式——大多数间距应该是 4 或 8 的倍数
const nonStandard = spacings.filter(s => s.val % 4 !== 0);
if (nonStandard.length > spacings.length * 0.2) {
  console.log('DESIGN_WARNING: 超过20%的间距不是4的倍数，设计系统可能不一致');
}
```

### 规则 2: 字体大小层级

```js
// 收集所有字体大小
const fontSizes = new Set();
document.querySelectorAll('*').forEach(el => {
  const style = getComputedStyle(el);
  if (el.textContent?.trim()) fontSizes.add(parseFloat(style.fontSize));
});
const sizes = [...fontSizes].sort((a,b)=>a-b);
// 好的设计通常有 3-5 个字体层级
if (sizes.length > 8) console.log('DESIGN_WARNING: 字体大小超过8种，缺乏层级系统');
if (sizes.length < 3) console.log('DESIGN_INFO: 字体层级少于3种，可能过于单调');
```

### 规则 3: 按钮尺寸一致性

```js
// 检查所有按钮的尺寸
const buttons = [];
document.querySelectorAll('button, [role="button"], .btn, a.Button').forEach(el => {
  const rect = el.getBoundingClientRect();
  buttons.push({el, w: rect.width, h: rect.height, text: el.textContent?.trim()});
});
// 分析按钮尺寸模式
const heights = [...new Set(buttons.map(b => Math.round(b.h)))];
if (heights.length > 4) {
  console.log('DESIGN_WARNING: 按钮高度种类过多(>4)，缺乏统一的按钮尺寸系统');
  console.log('实测高度:', heights.join(', '));
}
// 检查触摸目标最小值
const tooSmall = buttons.filter(b => b.h < 44 || b.w < 44);
if (tooSmall.length > 0) {
  console.log('ACCESSIBILITY: 以下按钮小于最小触摸目标44px:', 
    tooSmall.map(b => `${b.text}(${Math.round(b.w)}x${Math.round(b.h)})`).join(', '));
}
```

### 规则 4: 颜色一致性

```js
// 收集所有使用的颜色
const colors = {bg:[], text:[], border:[], button:[]};
document.querySelectorAll('*').forEach(el => {
  const s = getComputedStyle(el);
  colors.bg.push(s.backgroundColor);
  colors.text.push(s.color);
  colors.border.push(s.borderColor);
  if (el.tagName === 'BUTTON') colors.button.push(s.backgroundColor);
});
// 检查每个类别中不同颜色的数量
Object.entries(colors).forEach(([key, vals]) => {
  const unique = [...new Set(vals)].filter(c => c !== 'rgba(0, 0, 0, 0)' && c !== 'transparent');
  if (unique.length > 5) {
    console.log(`DESIGN_WARNING: ${key} 使用了${unique.length}种不同颜色，可能缺乏色彩系统`);
  }
});
```

### 规则 5: 对齐检查

```js
// 检查是否有元素偏离页面主体对齐
const bodyWidth = document.body.getBoundingClientRect().width;
const centerX = bodyWidth / 2;
document.querySelectorAll('header, main, section, footer, .container').forEach(el => {
  const rect = el.getBoundingClientRect();
  const elCenter = rect.left + rect.width / 2;
  if (Math.abs(elCenter - centerX) > 10 && rect.width < bodyWidth * 0.9) {
    console.log(`DESIGN_WARNING: ${el.tagName} 偏离中心 ${Math.round(elCenter - centerX)}px`);
  }
});
```

## 设计规范对比（如果有 Figma/设计稿）

如果项目中有设计规范文件（design-tokens.json、figma.json、CSS 变量文件），执行精确对比：

```js
// 假设设计规范定义了主色调
const SPEC = {
  primaryColor: '#7c3aed',
  bodyFont: '16px',
  headingFont: '24px',
  buttonHeight: '48px',
  spacing: '8px'
};
// 对比实际值
const actual = {
  primaryColor: getComputedStyle(document.querySelector('.btn-primary'))?.backgroundColor,
  bodyFont: getComputedStyle(document.body).fontSize,
  buttonHeight: document.querySelector('button')?.getBoundingClientRect().height
};
```

## 主观品质评估

以上规则只能检测"不一致"。对于"好不好看"、"合不合理"，需要主观评估。

### 评估方法 1: 第一印象评分

在页面加载后的前 5 秒内，记录：
1. 整体感觉：专业/业余/精致/粗糙/现代/过时
2. 配色和谐度：和谐/一般/冲突
3. 信息密度：拥挤/舒适/稀疏
4. 品牌感：强/弱/无

### 评估方法 2: 渐进式细节评估

```
5 秒: 整体印象（上述）
15 秒: 导航和布局评价
30 秒: 细节发现（间距、字体、颜色）
60 秒: 交互体验（hover、过渡、动画）
```

### 评估方法 3: 类比评估

"这个产品的设计水平相当于______（知名产品的名字）的______%。"
让 Simulator 给出一个诚实的类比分数，这比抽象评分更直观。

## 输出格式

在体验日志中新增「设计精度报告」章节：

```markdown
## 设计精度报告

### 量化测量
- 间距一致性: [通过/需改进] (X% 的间距是 4 的倍数)
- 字体层级: [X 种] (建议 3-5 种)
- 按钮尺寸: [X 种高度] (建议 ≤4 种)
- 颜色使用: [背景 X 种 / 文字 Y 种 / 按钮 Z 种]

### 已知设计偏差（与设计规范对比）
| 元素 | 规范值 | 实测值 | 偏差 |
|------|--------|--------|------|
| 主按钮高度 | 48px | 44px | -4px |

### 主观品质评分
- 第一印象: [专业/业余/精致/粗糙/现代/过时]
- 配色: [和谐/一般/冲突]
- 类比: 相当于 [知名产品] 的 [X]%
```
