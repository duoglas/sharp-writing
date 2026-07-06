#!/usr/bin/env bash
# PostToolUse(Write|Edit) hook：.md 文稿改动后跑 sharp-writing L0 黑名单检查
# stdin: hook JSON；命中时输出 additionalContext JSON 提示模型修复（不阻断）
# 依赖: jq
# 跳过：非 .md、本 skill 目录（词表/规则文档必然含黑名单词）、.claude 目录、memory 目录、node_modules
set -uo pipefail

command -v jq >/dev/null 2>&1 || { echo "hook-lint: 缺少 jq（brew install jq），词表检查未执行" >&2; exit 0; }

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
f=$(jq -r '.tool_input.file_path // .tool_response.filePath // empty')
case "$f" in
  "$SKILL_DIR"/*|*/.claude/*|*/memory/*|*node_modules*) exit 0 ;;
  *.md) ;;
  *) exit 0 ;;
esac

out=$("$(dirname "$0")/lint-lexicon.sh" "$f" 2>&1)
rc=$?
if [ "$rc" -eq 1 ]; then
  printf '%s\n' "$out" | jq -Rs '{hookSpecificOutput:{hookEventName:"PostToolUse",additionalContext:("sharp-writing L0 黑名单命中（正式文稿必须修复；引用用户原话可保留）:\n"+.)}}'
elif [ "$rc" -ge 2 ]; then
  printf '%s\n' "$out" | jq -Rs '{hookSpecificOutput:{hookEventName:"PostToolUse",additionalContext:("sharp-writing L0 词表检查无法执行（词表配置损坏，需先修复）:\n"+.)}}'
fi
exit 0
