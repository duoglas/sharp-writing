# sharp-writing

中文职场书面表达的 Claude Code skill：**构建**（写新内容 / 缩写提炼时怎么产生高度概括）+ **清理**（去 AI 味、词表、语域）一体化。

现有中文写作类 skill 几乎都集中在"去 AI 痕迹"这一段——文本写完了，往回删套路。sharp-writing 的重心在上游：概括是归纳的产物，不是压缩的技巧。它把"怎么写出简练有力的判断句"做成了可执行的流程（归纳跳跃、四步归纳、详简三问），清理层只是最后一道闸。

## 它解决什么问题

写月报、总结、评价、PPT 文案时最常见的三种失败：

1. 概括句是分类标签不是判断——"三个积极信号""研发效能情况"，读者获得零信息
2. 压缩靠删字——so what 和数据基线被砍掉，句子电报化，读起来像模板
3. 判断句带 AI 骨架——"不是 X 而是 Y""不在 X 在 Y"，推理过程誊写进了结论

## 方法 demo：从事实到中心判断（四步归纳）

以一组虚构的月度事实为例：

**第 1 步 · 铺开**（全部事实带数字，禁止判断）

- H1 目标 2000 万，6 月底完成 1240 万（62%）
- 6 月新签 3 单共 380 万，最大一单 260 万来自老客户增购
- 新产品首月接入 4 个客户，2 个付费
- 按期交付率 91%（上月 78%），新增了每周交付例会
- 售前只有 2 人，3 个商机因排不开档期流失，预估 300 万

**第 2 步 · 归组**（按隐藏的共同原因重新归组，不沿用"业绩 / 产品 / 交付"现成框架）

- 收入组：1240 万里增量主要靠老客户；新产品刚开始变现（2/4 付费）
- 产能组：交付率 91% 已修复，瓶颈换到了售前——300 万流失和 2 人档期是同一件事

**第 3 步 · 组内跳跃**（每组逼出一个判断句，不是组名）

- "新增长引擎已点火但未到量：新产品首月 2 单付费，收入大盘仍靠老客户增购撑着"
- "瓶颈已从交付移到售前：交付率 91% 修复完成，售前 2 人档期挡住约 300 万商机"

**第 4 步 · 顶层收口**（中心判断，就是全文第一句）

> 完成 62% 落后于时间进度，缺口集中在售前产能：6 月因档期排不开流失约 300 万商机，接近当月新签的 380 万——需求侧仍有单可接。

注意这句的形态：正面陈述 + 冒号 + 数字证据。对比由"300 万 vs 380 万"的并置承载，而没有写成"问题不在需求，而在产能"——那种二元对比骨架正是本 skill 清理层的必删项。

## 安装

推荐用 [skills CLI](https://github.com/vercel-labs/skills)，一条命令，兼容 Claude Code / OpenClaw / Cursor / Codex 等 70+ 个 agent 工具：

```bash
npx skills add duoglas/sharp-writing
```

Claude Code 用户也可手动 clone 到用户级目录：

```bash
git clone https://github.com/duoglas/sharp-writing.git ~/.claude/skills/sharp-writing
```

装好后直接说"写一份月报""把这篇压成一页""帮我去掉 AI 味"，skill 会自动匹配；Claude Code 里也可显式 `/sharp-writing`。

可选：把词表检查挂成 hook，任何 .md 文稿一经 Write/Edit 就自动过黑名单（`~/.claude/settings.json`；hook 依赖 `jq`）：

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{ "type": "command", "command": "bash ~/.claude/skills/sharp-writing/scripts/hook-lint.sh" }]
    }]
  }
}
```

## 流程与结构

SKILL.md 是自足的执行协议：读个人层 → PLAN 三行（靶子 / 主要矛盾 / 数字锚点）→ 四步归纳写详细版 → 详简三问压缩 → 清理（脚本反馈循环跑到全绿 + 概括句三查）→ 逐句五关终检。常规产出走 SKILL.md 一个文件即可，references/ 是深水区，按需一跳直达。

```
SKILL.md                      自足执行协议（五步全内联 + 深水区导航）
personal/
  lexicon.md                  个人词表（黑白名单，自进化落点一）
  rules.md                    个人规则增补（自进化落点二，优先级最高）
references/
  condense.md                 构建分册完整版：归纳跳跃 / 四步归纳 / 遮盖检验 / 详简三问
  principles.md               六原则总纲 + 概念命名规范
  titles.md                   标题学（文章 / PPT / 文档三套规则）
  scene-report.md             汇报分册（dashboard、vs 基线、敏感词清单）
  scene-review.md             人员评价分册
  scene-summary.md            总结 / 规划分册
  scene-slides.md             PPT 分册（讨论型 / 汇报型）
  cases.md                    范本案例库（张一鸣 / 黄峥 / 王慧文 / 周枫 / Bezos 等）
  cleaning.md + cleaning/     清理协议完整版（Tier 细则、短语表、误杀防护）
scripts/
  check.sh                    机械检查合一入口（词表 + 结构 + 敏感词）
  lint-lexicon.sh             L0 词表硬闸
  check-structure.sh          结构反模式扫描（二元骨架 / 总结收尾 / 无源断言 / 对仗密度）
  hook-lint.sh                PostToolUse hook 版词表检查
```

脚本可独立使用，不依赖 Claude：

```bash
bash scripts/check.sh 你的文稿.md          # 一条命令跑完，修复后重跑至全绿
bash scripts/check.sh 你的文稿.md report   # 汇报场景追加敏感词扫描
```

## 定制

所有你个人的东西集中在 `personal/` 目录，两个文件：`lexicon.md` 是词表（黑名单 = 你点名讨厌的词，白名单 = 你所在团队的正常用语，防"去 AI 味"误杀），`rules.md` 是你的个人规则增补，优先级高于全部通用规则。入表标准写在文件里：词条必须有你的点名或历史语料证据，不收"行业常用"印象词。

skill 支持有边界的自进化，两个通道。显式：你点名一个词或明说一条规则，agent 当场写入并即刻生效。隐式：你批评或亲手改写产出后，agent 从你的修改里提炼表达偏好候选（改掉的词、换上的词、改写后的句式），当轮收尾时列出来（最多 3 条，附改前改后证据）问你要不要存——确认哪条写哪条。每条记录必带日期和你的原话或改动对照，可追溯；进化只允许写 personal/ 两个文件，核心规则要改必须人工动手，所以它学得会你的偏好，也不会悄悄改掉方法论。

## 来源与致谢

规则提炼自作者的真实汇报 / 评价 / PPT 实战反馈（每条规则带正例反例），范本取自公开出版物与公开信（张一鸣、黄峥、王慧文、曾鸣、周枫、Bezos、毛泽东《反对党八股》、鲁迅、余光中等）。内部来源样本已全部匿名化，示例数字为虚构。

清理层（`references/cleaning/`）以 [MrGeDiao/shuorenhua](https://github.com/MrGeDiao/shuorenhua)（说人话，MIT）为底本——场景判定、Tier 分级、误杀防护、中英短语表的体系都来自它，是中文去 AI 味方向做得最扎实的开源 skill，在此致谢。本仓库在其基础上加了个人词表硬闸、概括句三查和结构反模式脚本；构建分支（condense / titles / principles / scene-* 各分册）为本仓库原创。

## License

MIT
