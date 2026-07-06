---
name: sharp-writing
description: 中文职场书面表达一体化协议：构建（结构/判断/数字/概念命名）+ 清理（去 AI 味/词表/语域）+ 自检。适用于写汇报、评价、总结、PPT 文案、对外文章等正式书面产出，以及"去 AI 味""说人话""自然一点"的改写需求。
metadata:
  short-description: 简练有力的中文职场写作协议（构建 + 清理一体）
---

# Sharp Writing

把书面产出从"写出来再改"变成"先想清楚再写，写完再洗一遍"。本 skill 一体化覆盖**构建**（结构、判断、数字、概念）与**清理**（去 AI 味、词表、语域），所有机制自包含，不依赖其他 skill。

两个分支，方向相反：**构建分支**（写新内容 / 缩写提炼）正向生成好概括，核心机制在 [condense](./references/condense.md)；**审读分支**（review 已有文字 / 去 AI 味）反向拦截坏概括，核心机制在 [cleaning](./references/cleaning.md)。归纳是发动机，三查是刹车，构建产物最终仍过审读。

## When to use

- 写任何正式书面产出：向上汇报（周报/月报/半年总结）、人员评价、规划总结、PPT 文案、对外文章 → 构建分支，走五步全流程
- 缩写 / 提炼已有长文（"压成一页""帮我概括""写个短版"）→ 构建分支，重点走第 3 步的 [condense](./references/condense.md) 详简三问
- 用户说"按标准写""写得简练有力""帮我把这段写好" → 构建分支
- 纯审读需求（"去 AI 味""说人话""别像模板"、review 已有稿）：跳过第 1-3 步，直接从第 4 步进入，按 [cleaning](./references/cleaning.md) 完整协议执行

## 执行流程（固定五步，不跳步）

### 1. 判体裁，读分册

| 体裁 | 分册 | 典型产出 |
|---|---|---|
| 向上汇报 | [scene-report](./references/scene-report.md) | 周报、月报、季度/半年总结、述职 |
| 人员评价 | [scene-review](./references/scene-review.md) | 候选人评价、晋升评语、同事评价 |
| 总结/规划 | [scene-summary](./references/scene-summary.md) | 项目总结、年度规划、复盘 |
| PPT 文案 | [scene-slides](./references/scene-slides.md) | 讨论稿、汇报稿的页标题与页内文案 |
| 对外文章 | [principles](./references/principles.md) 全文 + [cases](./references/cases.md) | 公众号、博客、演讲稿 |

跨体裁产出以主体裁为准，其余只借规则不换语域。

### 2. PLAN：动笔前三行（缺一不动笔）

1. **靶子行**：给谁看 / 他已知什么 / 看完要他做什么决策（"射箭要看靶子"；Amazon PRFAQ 式倒推——先写读者读完后的动作，再倒推正文）
2. **主要矛盾行**：本篇最重要的一件事是什么，一句话（先列全再挑主，不平均看待；"捉住了主要矛盾，一切问题就迎刃而解"）
3. **数字锚点行**：支撑核心判断的 2-3 个数字及其基线（vs 目标 / vs 上期 / vs 对照；"没有数量也就没有质量"）

### 3. EXECUTE：先详后简（概括生成协议见 [condense](./references/condense.md)）

先写信息饱和的详细版（完整逻辑链，不省 so what 和背景），再压缩到目标篇幅。详细版落成稿同目录的 `<文件名>-detail.md`，作为信息池保留，正式交付只交简版。两个关键动作都在 condense 分册：

- **写新**：四步归纳（铺开事实 → 按共同原因重新归组，不沿用 KR/部门现成框架 → 每组归纳跳跃出判断句 → 顶层收口中心判断）+ 第一性遮盖检验（遮掉旧框架，中心判断还成立吗）
- **压缩**：详简三问（一句话判断是什么 / 留哪 2 个数字可验证 / 改变读者哪个决策），压缩 = 换层级重写，不是删字

概括的唯一合法产物是新判断句，不是分类标签。写作中随时对照 [principles](./references/principles.md) 六原则。

### 4. 清理（内置协议，见 [cleaning.md](./references/cleaning.md)）

对成稿执行清理协议：

1. **L0 词表硬闸**：跑 `scripts/lint-lexicon.sh <文件>`（脚本路径相对本 skill 目录），按 [个人词表](./references/cleaning/personal-lexicon.md) 黑名单命中必改，白名单禁止误杀；正式文稿必须 PASS
2. **结构反模式扫描**：跑 `scripts/check-structure.sh <文件>`（二元对比骨架 / 总结式收尾 / 无源断言 / 对仗密度）。命中处人工复核——引用原话、规则讲解、反例展示可豁免，正文命中必改
3. **判场景与档位**：汇报/总结 = `status`，评价/操作文档 = `docs`，对外文章 = `public-writing`；然后先判 Tier（问题命中强度）、再定档位（改写力度）——两者是独立维度，规则见 cleaning.md
4. **概括句三查**：抽象状态词可反推、对仗金句全篇 ≤1 处、定性词带基线
5. 完整规则（禁改项、无源引用三模式、结构反模式、误杀防护）见 [cleaning.md](./references/cleaning.md) 及其子文件

### 5. REVIEW：分册自检表 + 两条终检

每个分册末尾有自己的检查表，逐项过。之后加两条通用终检：

- **不在场测试**：假设你没机会口头补充，任何需要口头解释的地方就是没写完的地方
- **转发测试**：读者拿这段给他的上级看，需要二次翻译吗？需要就重写

## Reference navigation

- 六原则总纲 + 概念命名规范：[principles.md](./references/principles.md)
- 构建与缩写（四步归纳 / 遮盖检验 / 详简三问）：[condense.md](./references/condense.md)
- 标题学（文章/PPT/文档三套规则）：[titles.md](./references/titles.md)
- 范本案例库（可引用片段 + 判断句模式）：[cases.md](./references/cases.md)
- 各体裁分册：见上表
- 清理层协议：[cleaning.md](./references/cleaning.md)，子文件在 [cleaning/](./references/cleaning/)（词表、中英短语表、结构反模式、严重度、误杀防护、场景禁改、微操作手册、边界案例）
- 词表 lint：`scripts/lint-lexicon.sh <文件>`（黑名单命中退出码 1）
- 结构反模式扫描：`scripts/check-structure.sh <文件>`（二元骨架/总结收尾/无源断言/对仗密度，命中退出码 1，需人工复核豁免项）

## 源与演化

规则源自作者的私有知识库（表达实践 thesis + 12 条已审定范本的提炼），新反馈先进源头、验证后同步到本 skill——源是 master，skill 是 release。
