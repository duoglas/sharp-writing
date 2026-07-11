#!/usr/bin/env bash
# UserPromptSubmit hook：检测用户 prompt 中的书面产出意图，
# 命中时注入一条提醒，让模型先调用 sharp-writing skill 再动笔。
# 不命中时静默退出，零干扰。
# 注意：hook 输入 JSON 来自 stdin，而 python 脚本经 heredoc 也走 stdin，
# 因此先用 cat 收下输入、经环境变量传给 python。
HOOK_INPUT="$(cat)"
export HOOK_INPUT
python3 - <<'PY'
import json, os, re, sys

try:
    data = json.loads(os.environ.get("HOOK_INPUT") or "{}")
except Exception:
    sys.exit(0)

prompt = data.get("prompt") or ""

# 三类触发词：文档体裁 / 清理意图 / 压缩提炼意图
DOC = r"周报|月报|季报|年报|半年总结|述职|汇报|报告|总结|复盘|规划|评价|评语|演讲|讲稿|发言稿|文章|博客|公众号|文案|通稿|通告|介绍稿|发布稿|股东信|PPT"
CLEAN = r"去\s*ai\s*味|ai\s*味|说人话|自然一点|润色|太\s*ai|人味"
CONDENSE = r"压成一页|压缩成|写个?短版|提炼成|概括成"

pattern = re.compile(f"({DOC})|({CLEAN})|({CONDENSE})", re.IGNORECASE)

if pattern.search(prompt):
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "UserPromptSubmit",
            "additionalContext": (
                "[sharp-writing 触发提醒] 本条请求包含书面产出关键词。"
                "若本次任务确属正式书面产出（汇报/评价/总结/规划/PPT 文案/对外文章）"
                "或改写、去 AI 味、压缩提炼需求，必须先调用 Skill(sharp-writing) "
                "按其协议构建或清理，再产出文字；不要只凭项目规则直接写。"
                "若与书面产出无关（如查阅、代码、日程），忽略本提醒。"
            ),
        }
    }, ensure_ascii=False))
PY
exit 0
