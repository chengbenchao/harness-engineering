# Harness Engineering 快速入门

## 🚀 第一天：设置基础知识系统

### 步骤 1：重构你的 AGENTS.md
```bash
# 从模板创建新的 AGENTS.md
cp skills/harness-engineering/AGENTS.md.template ./AGENTS.md
# 编辑并填写你的项目特定信息
```
**目标：** 将 AGENTS.md 缩减到约 100 行，只保留地图和链接。

### 步骤 2：创建 docs/ 目录结构
```bash
mkdir -p docs/{architecture,principles,patterns,execution-plans,style-guide,taste}
```

### 步骤 3：迁移现有知识
- 将架构决策放入 `docs/architecture/`
- 将代码风格放入 `docs/style-guide/`
- 将团队约定放入 `docs/principles/`

---

## 📅 第一周：实现架构约束

### 创建第一个自定义 Linter
目标：强制执行分层架构
1. 定义允许的依赖关系
2. 创建 linter 检查代码
3. 将 linter 集成到 CI

### 定义品味不变量
1. 创建 `docs/taste/golden-rules.md`
2. 列出至少 3 条黄金原则
3. 尽可能将原则编码为 lint 规则

---

## 🔄 第一个月：构建反馈循环

### 建立垃圾回收系统
1. 创建代码质量扫描脚本
2. 设置定期运行的后台任务
3. 自动创建重构 PR

### 实现端到端自主能力
从简单开始：
1. ✅ 自动修复 lint 错误
2. ✅ 自动更新依赖
3. ✅ 自动修复简单的测试失败

---

## 📊 衡量成功的指标

| 指标 | 目标 |
|------|------|
| 智能体 PR 吞吐量 | > 3 PR/天/人 |
| 人工代码审查率 | < 20% 的 PR |
| 自动化重构数量 | > 5 个/周 |
| 文档新鲜度 | > 90% 文档 < 30 天 |

---

## 💡 记住

> **人类的品味一旦被捕捉，就会持续应用于每一行代码。**

不要追求完美。从简单开始，持续迭代。重要的是建立反馈循环，让系统随着时间推移变得更好。
