# Skill 项目硬化 Playbook

适用场景：
- OpenClaw / AgentSkills 仓库
- 已有 `SKILL.md`，但缺少模板、检查、发布流程

## 第一轮硬化清单
1. 校验 `SKILL.md` 是否存在逻辑自相矛盾
2. 校验 `_meta.json` 是否与 `SKILL.md` 一致
3. 补标准模板：
   - `AGENTS.md.template`
   - `execution-plan.template.md`
4. 补一致性脚本：
   - `scripts/check-consistency.sh`
5. 如果要公开分享：补 `README.md`
6. 推送前做敏感信息扫描

## 关键原则
- Skill 不是只讲概念，必须带可复用资产
- 优先沉淀模板、脚本、失败模式，而不是继续写大段口号
- 真实项目改造经验要反哺 Skill 仓库

## 最小交付标准
- `SKILL.md`
- `_meta.json`
- `scripts/check-consistency.sh`
- 至少一个模板
- 至少一个生产实践参考文档
