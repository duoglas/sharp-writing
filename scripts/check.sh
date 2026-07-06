#!/usr/bin/env bash
# check.sh — sharp-writing 机械检查合一入口。反馈循环：跑 → 修 → 重跑，直到全绿
# 用法: check.sh <文件.md> [report]    第二参数 report = 汇报场景，追加敏感词扫描
# 退出码: 0 全绿 / 1 有命中需处理 / 2 用法错误
# 命中不等于必改：引用原话、规则讲解、反例展示可豁免（人工复核）；正文命中必改
set -uo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
f="${1:-}"
[ -f "$f" ] || { echo "用法: check.sh <文件.md> [report]" >&2; exit 2; }
scene="${2:-}"

fail=0
echo "== 1/3 词表 L0（个人黑名单）=="
bash "$DIR/lint-lexicon.sh" "$f" || fail=1
echo "== 2/3 结构反模式（二元骨架/总结收尾/无源断言/对仗密度）=="
bash "$DIR/check-structure.sh" "$f" || fail=1
if [ "$scene" = "report" ]; then
  echo "== 3/3 敏感词（汇报场景专用，命中需人工复核语境）=="
  hit=0
  for w in 裁员 淘汰 末位 跟不上 尾部 退出 降级处理 大力度启用 直接转进 没有历史负担; do
    m=$(grep -n "$w" "$f" || true)
    if [ -n "$m" ]; then hit=1; echo "【${w}】"; echo "$m"; fi
  done
  if [ "$hit" -eq 0 ]; then echo "PASS: 敏感词零命中"; else echo "敏感词命中，按 scene-report.md 敏感措辞规则重写"; fail=1; fi
else
  echo "== 3/3 敏感词: 跳过（汇报场景加第二参数 report 启用）=="
fi
echo
if [ "$fail" -eq 0 ]; then echo "CHECK: 全绿"; else echo "CHECK: 有命中 —— 修复或确认豁免后重跑本脚本"; fi
exit $fail
