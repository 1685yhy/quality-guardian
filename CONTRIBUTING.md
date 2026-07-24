# 贡献指南

Quality Guardian 欢迎所有人贡献——无论是代码、文档、案例还是反馈。

## 快速开始

```bash
git clone https://github.com/1685yhy/quality-guardian.git
cd quality-guardian
bash scripts/self-test.sh  # 验证框架完整性
```

## 贡献方式

### 提交真实案例（最有价值的贡献）

在你的项目上运行 Quality Guardian，把验收报告脱敏后提交：

1. 运行验收：在 Claude Code 中告诉 Claude 使用 `.claude/quality-guardian/orchestrator.md`
2. 脱敏：移除公司名、敏感数据、内部 URL
3. 提交：在 `case-studies/` 下创建 `项目名-日期/` 目录，放入报告
4. 更新 `case-studies/README.md` 的案例列表

### 改进 Agent 定义

1. 找到要改进的文件（`guardians/`, `simulators/`, `framework/`）
2. 修改后运行 `bash scripts/self-test.sh` 确保一致性
3. 提交 PR

### 添加新平台支持

1. 在 `platforms/` 下创建新指南文件
2. 在 `platforms/README.md` 更新索引
3. 如果需要新 Agent，在 `simulators/` 下创建
4. 在 `orchestrator.md` 的策略表中添加路由

### 报告 Bug

1. 描述你做了什么、期望发生什么、实际发生什么
2. 附上相关的验收报告（脱敏后）
3. 说明环境：OS、Chrome 版本、Claude Code 版本

## 开发规范

- Agent 定义文件使用 Markdown 格式
- 评分统一使用 0-3 四级量表
- 所有 Guardian 必须包含盲测原则
- 所有 Simulator 使用第一人称"I"做反馈
- 提交前运行 `bash scripts/self-test.sh`

## 项目结构

参照 [README.md](README.md) 中的完整结构图。

## License

MIT — 你的贡献也以 MIT 协议发布。
