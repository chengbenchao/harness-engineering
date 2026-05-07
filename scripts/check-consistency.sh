#!/bin/bash
# check-consistency.sh - 一致性检查脚本
# 守护文档新鲜度，防止文档腐烂
# 用法：bash scripts/check-consistency.sh

set -e
cd "$(dirname "$0")/.."

ERRORS=0
WARNINGS=0

echo "🔍 天工引擎一致性检查"
echo "========================"

# C1: 检查行动清单的 TODO 数量与声明一致
TODO_COUNT=$(grep -c '^\- \[ \]' SKILL.md 2>/dev/null || echo "0")
DONE_COUNT=$(grep -c '^\- \[x\]' SKILL.md 2>/dev/null || echo "0")
TOTAL=$((TODO_COUNT + DONE_COUNT))

echo ""
echo "📋 行动清单: 已完成 $DONE_COUNT / 总计 $TOTAL"

if [ "$TOTAL" -eq 0 ]; then
    echo "  ⚠️  警告：没有找到行动清单"
    WARNINGS=$((WARNINGS + 1))
fi

# C2: 检查核心章节是否存在
echo ""
echo "📖 检查核心章节..."
REQUIRED_SECTIONS=(
    "核心理念"
    "四层架构模型"
    "各层设计要点"
    "OpenClaw 落地实践"
    "核心架构原则"
    "熵与垃圾回收系统"
    "行动清单"
    "参考资源"
)

for section in "${REQUIRED_SECTIONS[@]}"; do
    if grep -q "$section" SKILL.md 2>/dev/null; then
        echo "  ✅ $section"
    else
        echo "  ❌ 缺少章节: $section"
        ERRORS=$((ERRORS + 1))
    fi
done

# C3: 检查元数据一致性
echo ""
echo "📝 检查元数据..."
if [ -f "_meta.json" ]; then
    META_NAME=$(python3 -c "import json; print(json.load(open('_meta.json'))['name'])" 2>/dev/null || echo "")
    if [ -n "$META_NAME" ]; then
        if grep -qi "$META_NAME" SKILL.md 2>/dev/null; then
            echo "  ✅ 名称一致: $META_NAME"
        else
            echo "  ⚠️  _meta.json 名称 '$META_NAME' 未在 SKILL.md 中出现"
            WARNINGS=$((WARNINGS + 1))
        fi
    fi
else
    echo "  ❌ 缺少 _meta.json"
    ERRORS=$((ERRORS + 1))
fi

# C4: 检查文档新鲜度（超过 30 天警告）
echo ""
echo "⏰ 检查文档新鲜度..."
MOD_DATE=$(stat -c %Y SKILL.md 2>/dev/null || echo "0")
NOW=$(date +%s)
AGE_DAYS=$(( (NOW - MOD_DATE) / 86400 ))

if [ "$AGE_DAYS" -gt 30 ]; then
    echo "  ⚠️  SKILL.md 已 $AGE_DAYS 天未更新，建议审查"
    WARNINGS=$((WARNINGS + 1))
else
    echo "  ✅ 文档新鲜：$AGE_DAYS 天前更新"
fi

# 总结
echo ""
echo "========================"
if [ "$ERRORS" -eq 0 ] && [ "$WARNINGS" -eq 0 ]; then
    echo "✅ 检查通过，一切正常"
    exit 0
elif [ "$ERRORS" -eq 0 ]; then
    echo "⚠️  检查完成，有 $WARNINGS 个警告"
    exit 0
else
    echo "❌ 检查失败，$ERRORS 个错误，$WARNINGS 个警告"
    exit 1
fi
