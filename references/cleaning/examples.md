# 改写示例

> 源自开源 skill [shuorenhua](https://github.com/MrGeDiao/shuorenhua)（MIT © MrGeDiao），本文件在其基础上有增删；2026-07-06 按信息守恒原则重修。

> 每个示例展示同一段内容的 AI 版和人话版。**信息守恒**：人话版的每个事实都来自该示例的"原始素材"行——改写只能重组和删减信息，不能新增。原文零信息时，正确输出是指出缺事实、回去要数据（见示例 4 和英文示例 3），不是编出具体数字。

## 中文示例

### 示例 1：项目介绍

**原始素材**：项目把语音识别和自动翻译接到一起，用户说中文直接出英文字幕；上线两周日活 1200，翻译准确率 94%。

**AI 版：**
> 该项目是一个创新性的解决方案，旨在通过深度整合多种前沿技术，为用户提供全方位、一站式的智能化体验。它不仅能够显著提升工作效率，还能有效降低运营成本，实现真正的降本增效。

**人话版：**
> 这个项目把语音识别和自动翻译接到一起，用户说中文就能直接出英文字幕。上线两周日活 1200，翻译准确率 94%。

**改了什么：**
- 删掉"创新性""前沿技术""全方位""一站式""智能化"——全是空词
- 删掉"不仅…还能…"的二元结构
- 功能描述和数据全部来自原始素材——AI 版把它们丢了换成空词，人话版是找回来，不是编出来

---

### 示例 2：技术总结

**原始素材**：本轮重构后 API 响应时间从 800ms 降到 120ms；修复 3 个 SQL 注入漏洞；6000 行的 God Class 拆成 12 个模块。

**AI 版：**
> 综上所述，通过对系统架构的全面优化和持续迭代，我们在性能、安全性和可维护性等方面均取得了显著提升。这一成果充分体现了团队在技术创新方面的不懈追求和卓越实力。

**人话版：**
> 这轮改完之后：API 响应时间从 800ms 降到 120ms，修了 3 个 SQL 注入漏洞，把 6000 行的 God Class 拆成了 12 个模块。

**改了什么：**
- 删掉"综上所述"和整个总结式开头
- "显著提升"换成具体数据
- 删掉"充分体现""不懈追求""卓越实力"——自吹自擂
- 用具体改动代替抽象描述

---

### 示例 3：消息回复

**原始素材**：同事问头像改了为什么不生效。排查结论：CDN 缓存未失效，TTL 设了 7 天，改成 1 小时可解决。

**AI 版：**
> 好问题！这确实是一个值得深入探讨的话题。让我来为你详细解释一下。首先，我们需要了解的是，这个问题的本质在于……

**人话版：**
> 核心原因是缓存没失效。用户改了头像但 CDN 还在用旧的，TTL 设了 7 天太长了。改成 1 小时就行。

**改了什么：**
- 删掉全部谄媚和铺垫
- 直接给原因和解决方案

---

### 示例 4：新闻摘要（零信息原文的正确处理）

**AI 版：**
> 在当今快速发展的人工智能领域，OpenAI 近日发布了其最新的大语言模型，引发了业界的广泛关注和热烈讨论。该模型在多个关键指标上实现了显著突破，标志着人工智能技术迈入了一个全新的发展阶段。

**正确输出（不是改写，是要素材）：**
> 这段没有可保留的事实：型号、指标、数字、价格全缺，删掉废话之后剩不下任何内容。摘要无从改写——先回去拿发布原文，至少要模型名、1-2 个关键指标数字和价格变化，才能写出"X 发布了 Y：指标 A 到多少、价格如何"式的摘要。

**为什么不直接改写：**
- 原文的问题不是措辞是空心：删掉"在当今""广泛关注""显著突破"后是零信息
- 此时往里填具体数字（跑分、上下文窗口、价格）只能靠编——比空话更糟，空话读者顶多不获得信息，编造的数字会被当真
- 零信息原文的唯一正确动作：指出缺什么素材、去要，而不是替作者虚构

---

### 示例 5：工程师腔 / 调试腔

**原始素材**：排查发现原因是配置写死不能直接改；排查范围已缩小到两个可能的位置，与此前报错信息吻合；先记录结论，后续改一版。

**AI 版：**
> 我先拆开看了一下，发现根因偏硬，不太好直接打掉。目前已经把差异收窄了，和刚抓到的现象也对上了。接下来稳稳兜住，落盘之后就能收口。

**人话版：**
> 查了一下，原因是配置写死了，不能直接改。我把排查范围缩小到两个可能的地方，和之前的报错信息对得上。先把结论记下来，回头改一版就行。

**改了什么：**
- "拆开看"→"查了一下"，"根因偏硬"→"原因是配置写死了"
- "打掉"→"改"，"收窄"→"缩小"，"抓到的现象"→"报错信息"
- "兜住"→删掉，"落盘"→"记下来"，"收口"→"就行"
- 整段从 postmortem 腔调改成正常同事对话

---

### 示例 6：小红书 AI 腔

**原始素材**：推荐 Raycast，免费版够用；作者从 Alfred 切换过来，每天约省十几分钟，主要省在切窗口和查文档；优点是启动快、插件多。

**AI 版：**
> 姐妹们！今天给大家拆解一个保姆级避坑攻略！这个工具真的绝绝子，狠狠提升了效率！建议收藏！划重点：免费！

**人话版：**
> 推荐个工具：Raycast，免费版就够用。我从 Alfred 切过来一个月，每天大概省十几分钟，主要省在切窗口和查文档上。启动快、插件多，用过的应该懂。

**改了什么：**
- "拆解""保姆级""避坑""绝绝子""狠狠""建议收藏""划重点"全删——删的是流水线 slop 词，不是平台语域
- 保持小红书的轻口语人设（"推荐个""应该懂"），只去 AI 味不换语域——改成书面语才是过度矫正
- 工具名、省时数据全部来自原始素材

---

### 示例 7：语域混搭

**原始素材**：bug 涉及三个服务之间的调用顺序，不好修；先把支付服务超时从 3 秒调到 10 秒，观察一周。

**AI 版：**
> 诚然，这个 bug 的修复确实存在一定的技术复杂度。不过说白了就是绝绝子的体验！我们需要进一步深入探讨其底层逻辑，稳稳把核心链路兜住。综上所述，未来可期。

**人话版：**
> 这个 bug 不好修，涉及到三个服务之间的调用顺序。我先把支付服务的超时时间从 3 秒调到 10 秒，观察一周再说。

**改了什么：**
- 原文混搭了 5 种语域（学术/网络/商业/工程/鸡汤），统一成技术口语
- 把空泛描述换成具体方案

---

## English Examples

### Example 1: Product description

**Source facts**: the platform auto-assigns tickets based on who fixed similar bugs before; teams using it close issues 2 days faster on average.

**AI version:**
> Our groundbreaking platform serves as a testament to the transformative potential of AI, empowering teams to navigate complex challenges and unlock unprecedented levels of productivity. Nestled at the intersection of innovation and practicality, it showcases how cutting-edge technology can foster meaningful collaboration.

**Human version:**
> The platform auto-assigns tickets based on who fixed similar bugs before. Teams using it close issues 2 days faster on average.

**What changed:**
- Removed "groundbreaking", "testament", "empowering", "navigate", "unprecedented", "nestled", "showcases", "cutting-edge", "foster"
- Replaced vague claims with specific functionality and data

---

### Example 2: Technical update

**Source facts**: cold start time down 60%; fixes the SQL injection found in last month's security audit; config reduced from 200 lines to 40; upgrade guide in the changelog.

**AI version:**
> We're excited to announce a comprehensive update that significantly enhances performance, bolsters security, and streamlines the developer experience. This pivotal release underscores our commitment to delivering robust, scalable solutions.

**Human version:**
> This release cuts cold start time by 60%, fixes the SQL injection found in last month's security audit, and drops the config from 200 lines to 40. Upgrade guide is in the changelog.

**What changed:**
- "Comprehensive update" → specific changes
- "Significantly enhances" → "cuts by 60%"
- "Bolsters security" → the actual vulnerability fixed (never invent a CVE number — cite the real one or describe the fix)
- "Streamlines developer experience" → specific config reduction
- Deleted "pivotal", "underscores", "commitment", "robust", "scalable"

---

### Example 3: Analysis (two-pass demo — and the no-fabrication line)

**AI version:**
> The landscape of remote work has undergone a profound transformation. It's not just about working from home — it's about reimagining the very fabric of how we collaborate. Companies that fail to navigate this paradigm shift risk being left behind in an increasingly competitive ecosystem.

**First pass:**
> More companies went remote after 2020. Some did it well, some didn't. The ones that kept async communication and cut meetings kept their engineers longer.

**Audit — what still feels off?**
- "Some did it well, some didn't" is vague
- "Kept their engineers longer" is a factual claim with no source — and the rewriter has none to offer

**Final:**
> More companies went remote after 2020. Anecdotally, the ones that kept async communication and cut recurring meetings seem to retain engineers better — but that's an impression, not data. [To publish this claim, cite an actual retention study here.]

**What changed in second pass:**
- The vague claim is now labeled as what it is: an impression, not a finding
- The missing source is exposed as a placeholder, not papered over — inventing a survey name and a percentage here would be the worst possible "fix"
- Rule demonstrated: when the source facts run out, the rewrite stops adding specifics. De-slopping never licenses fabrication

---

## 标注模式示例 | Annotation Mode Examples

> 下面这几组展示同一段文本在 `annotation mode` 和默认改写模式下的区别。

### 示例 A：公开文案里的无源引用

**原文：**
> 研究表明，采用 AI 协作开发的团队交付效率显著提升。业内人士认为，这一趋势将在未来十年持续加速。

**Annotation mode：**
- `问题族`：无源引用
- `触发点`：`研究表明`、`业内人士认为`
- `建议动作`：补具体来源；如果没有来源，删掉权威铺垫
- `是否建议改写`：是

**默认改写：**
> 用 AI 协作开发的团队，交付速度可能会更快，但这段话没有给出具体来源。要么补研究出处，要么直接把结论改写得更克制。

### 示例 B：status 场景里的保守处理

**原文：**
> 数据显示，这次改版显著提升了留存率。业内人士认为，这个方向已经验证可行。

**Annotation mode：**
- `问题族`：无源引用
- `触发点`：`数据显示`、`业内人士认为`
- `建议动作`：在 `status` 场景优先补数据来源和归属，不要改写成像已证实的事实
- `是否建议改写`：是

**默认改写：**
> 这段缺数据来源和观点归属。作为 status，同步时应补具体报表、时间范围或负责人；在补齐之前，不建议把它写成已经证实的结论。

### 示例 C：技术文档里的不改案例

**原文：**
> 网关在请求超时后返回 504。缓存服务每 5 分钟刷新一次热点 key。负载均衡器将流量按权重分配到三个后端节点。

**Annotation mode：**
- `问题族`：无明显问题
- `触发点`：系统主语和技术术语都属于正常文档写法
- `建议动作`：保持不动
- `是否建议改写`：否

**默认改写：**
> 网关在请求超时后返回 504。缓存服务每 5 分钟刷新一次热点 key。负载均衡器将流量按权重分配到三个后端节点。
