#!/usr/bin/env bash
# sharp-writing L0 层：个人黑名单确定性检查
# 用法: lint-lexicon.sh <文件1> [文件2 ...]
# 输出: 文件:行号:【命中词】该行内容；无命中输出 PASS
# 退出码: 0 无命中 / 1 有命中 / 2 用法或词表配置错误
# 注意: macOS awk 在 UTF-8 locale 下对 CJK 字符串比较有 bug，词表解析必须用 LC_ALL=C
set -uo pipefail

[ $# -ge 1 ] || { echo "用法: lint-lexicon.sh <文件1> [文件2 ...]" >&2; exit 2; }

LEXICON="$(cd "$(dirname "$0")/.." && pwd)/personal/lexicon.md"
[ -f "$LEXICON" ] || { echo "找不到词表: $LEXICON" >&2; exit 2; }

WORDS=$(awk '/## 黑名单/,/## 白名单/' "$LEXICON" \
  | LC_ALL=C awk -F'|' '/^\|/ {gsub(/ /,"",$2); if ($2!="" && $2!="词" && $2 !~ /^-+$/) print $2}')

[ -n "$WORDS" ] || { echo "词表解析为空，检查 personal/lexicon.md 格式" >&2; exit 2; }

HIT=0
for f in "$@"; do
  [ -f "$f" ] || { echo "找不到文件: $f" >&2; exit 2; }
  while IFS= read -r w; do
    [ -z "$w" ] && continue
    # -F 固定串匹配：词表词条含 [ . * 等字符时不能被当作正则解释
    matches=$(grep -nF "$w" "$f" || true)
    if [ -n "$matches" ]; then
      HIT=1
      while IFS= read -r line; do
        echo "$f:${line%%:*}:【${w}】${line#*:}"
      done <<< "$matches"
    fi
  done <<< "$WORDS"
done

if [ "$HIT" -eq 0 ]; then
  echo "PASS: 无黑名单词命中（词表 $(echo "$WORDS" | wc -l | tr -d ' ') 词）"
  exit 0
else
  exit 1
fi
