#!/usr/bin/env bash
# PostToolUse(Write|Edit) hook：.md 文稿改动后跑 sharp-writing L0 黑名单检查
# stdin: hook JSON；命中时输出 additionalContext JSON 提示模型修复（不阻断）
# 跳过：非 .md、.claude 目录（词表/skill 自身）、memory 目录、node_modules
set -uo pipefail

f=$(jq -r '.tool_input.file_path // .tool_response.filePath // empty')
case "$f" in
  *.md) ;;
  *) exit 0 ;;
esac
case "$f" in
  */.claude/*|*/memory/*|*node_modules*) exit 0 ;;
esac

out=$("$(dirname "$0")/lint-lexicon.sh" "$f" 2>/dev/null)
rc=$?
if [ "$rc" -eq 1 ]; then
  printf '%s\n' "$out" | jq -Rs '{hookSpecificOutput:{hookEventName:"PostToolUse",additionalContext:("sharp-writing L0 黑名单命中（正式文稿必须修复；引用用户原话可保留）:\n"+.)}}'
fi
exit 0
