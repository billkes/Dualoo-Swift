# H5 壳 · 视觉整理规范（原 ui-ux-pro-max 使用规范）

> Agent 必读。消费向 **Vue Mobile H5**（WKWebView）。  
> 技术栈锁定：**Vue 3 + Vite + Tailwind + Phosphor**——不换栈。  
> **产包内不再克隆 ui-ux-pro-max**；视觉语料为 `skill-input/visual/` 单行 CSV。

## 1. 职责分工

| 角色 | 职责 |
|------|------|
| **流水线** `prepare.context` | 写 context；按 task 视觉四维从**宿主机**技能 `data/*.csv` **过滤各 1 行**写入 `skill-input/visual/`；**不**克隆技能进包 |
| **`task-fill`** | 抽视觉四维写入 task.csv：`designStyle` · `colorPalette` · `skinMode` · `fontPairing` |
| **`agent.plan.spec`** | **先**写 `功能文档.md` + Legal（定 Screen Inventory） |
| **`agent.design`** | **读包内 visual 单行 CSV** 自行整理 MASTER / tokens / Scene Brief / design-audit（禁止 search.py） |
| **`agent.html`** | Inventory 全量 HTML 视觉契约；skinMode 以 visual meta 为准 |
| **`agent.plan.pack`** | 登记信息 + 视觉锁（对齐已整理设计） |
| **`agent.h5`** | 先忠实移植冻结 HTML → 再按功能文档业务流程 + Vitest |
| **薄 gate（脚本）** | HTML/FLOW 签收仅软警告；plan.gate 仍挡缺 MASTER / SaaS 等硬错 |

**原则：** 技能仓库只作批前牌池与 CSV 投影源，**不进产包**。  
**原则：** Agent 顺序 = **功能文档 → UI（design/html）→ Pack/壳/H5**。  
**原则：** 技术栈仍为 Vue 3 + Vite + Tailwind + Phosphor——不换栈。

## 1.5 视觉单行 CSV（`skill-input/visual/`）

| 文件 | 内容 | 权威职责 |
|------|------|----------|
| `style.csv` | 表头 + **1 行**（Style Category = designStyle） | **仅**形态/动效/层次（投影时剥离色值、字体、深浅列） |
| `colors.csv` | 表头 + **1 行**（Product Type = colorPalette） | 色板 token |
| `typography.csv` | 表头 + **1 行**（Font Pairing Name = fontPairing） | 字体配对 |
| `meta.json` | skinMode + 四维原名 + `authority` | **唯一**决定壳图深浅（浅/深/深浅）与 H5 单皮 |

**`agent.design`：** 读上述文件整理 MASTER / tokens / Scene Brief；**禁止** `search.py`、`--design-system`、行业 BM25 query；禁止用 Style 行推断色/字/深浅。

## 2. 本包栈（禁止误用）

| 用途 | 约定 |
|------|------|
| 架构 | Vue 3 Composition / SFC / router |
| 样式 | Tailwind；mobile-first / touch 44 / safe-area |
| 视觉 | **仅** `skill-input/visual/` 三行 CSV + skinMode |

**禁止：** RN/SwiftUI/Flutter/Nuxt 作 H5 实现源；跨包抄 MASTER；`search.py` / BM25 / 宿主机 skill 路径。

## 3. 视觉锁定（无检索）

视觉由 task 四维 + `skill-input/visual/` 单行 CSV 锁定；`agent.design` **只整理、不检索**。

## 4. 选型硬规则（Agent 自检清单）

对 `design-system/*/MASTER.md` 与 `candidates.json` 逐条核对：

1. **禁 SaaS（消费向默认）**  
   - Style 名含：`SaaS`、`Enterprise SaaS`、`SaaS Mobile`  
   - Category 为：`SaaS (General)`、`Micro SaaS`、无场景依据的 `Productivity Tool`  
   → **不合格**，`design-audit` 记 `REPAIRED` 并改写 MASTER / 相关 brief。

2. **偏 Mobile**  
   - 优先 Style `Type=Mobile` 或明确 Mobile-First / 触控友好的风格  
   - 配色与字体服务手机一屏，而非桌面 dashboard

3. **贴主题**  
   - Category / 色板 notes / typography mood 能对应本包 `coreScene` / `audience` / `track`  
   - 隐形眼镜 / 染发护色等垂直场景，不得落成通用企业后台皮

4. **栈文件仍在**  
   - 必须保留 `stack-vue.md` + `stack-html-tailwind.md`  
   - 不得改成 RN/SwiftUI 实现说明替代 H5

5. **禁止跨包抄设计**  
   - 不得 `Read` / `find` 其他 App 的 `design-system/**/MASTER.md` 或 `h5/src/styles` 当母版  
   - 视觉锁与 H5 实现只认**本包** `design-system/` + `skill-adapt/` + 本规范

## 5. 何时必须重做设计

出现任一则 **`agent.design` 不得交付**（须按 CSV 重新整理，`design-audit` 记 `REPAIRED`）：

- MASTER Style / Category 命中 §4.1  
- 色板 + 字体 + pattern 与同批兄弟包明显同构（通用灰蓝 Inter + App Store landing）  
- 主题是美妆/健康/亲子等，MASTER 却是企业/Productivity/SaaS 气质  
- `stack-html-tailwind.md` 只有桌面 container/max-width 指引、完全无 touch / mobile-first 条目  

交付前必须齐：

- `design-system/<slug>/MASTER.md`（及 `candidates.json` / 双栈文件）  
- `design-system/<slug>/pages/welcome.md` · `pages/hub.md`（各含 `### Scene Brief`，字段见 `phase_agent_design`）  
- `skill-adapt/design-brief.md` + tokens，与 MASTER 一致  
- `skill-adapt/selected-candidate.json`（`designSystem.style/colors/typography/pattern`，供 plan.gate / skill.pages）  
- `skill-adapt/design-audit.md`（`PASS` / `REPAIRED`，含 `welcomePattern` · `hubPrimaryZone`）  
- 之后由 `agent.plan.pack` 写 `本包视觉锁.json`

## 6. 与后续 Agent 步骤的关系

| 步骤 | 与本规范 |
|------|----------|
| `prepare.context` | 投影 `skill-input/visual/` 单行 CSV（**不**克隆技能） |
| `agent.plan.spec` | 功能文档 + Screen Inventory（先于 design） |
| `agent.design` | **主产**设计系统 + design-audit |
| `agent.plan.pack` | 登记 JSON + `本包视觉锁.json`（含 `assetBrief`；**在 html 之前**） |
| `agent.assets` | task「真图」=1：**在 html 之前** GenerateImage 替换壳图槽；=0 跳过（html 用 tokens/CSS） |
| `agent.html` | Inventory 全量 HTML + 截图严审 + `APPROVAL.md` → `FREEZE.md`（§8.2） |
| `agent.shell` | 原生壳 + Bridge |
| `agent.h5` | 抄冻结 HTML → 本包功能文档业务流程 + Vitest（§8.3） |

## 7. 交付前自检（设计）

- [ ] `skill-adapt/design-audit.md` 已写（`PASS` / `REPAIRED` + `welcomePattern` · `hubPrimaryZone`）  
- [ ] `skill-adapt/selected-candidate.json` 已写（与 MASTER 色板/字体一致）  
- [ ] `pages/welcome.md` · `pages/hub.md` 各有完整 `### Scene Brief`  
- [ ] Category / Style 符合本包主题，非默认 SaaS  
- [ ] Style 偏 Mobile 或明确触控友好  
- [ ] 仅使用 vue + html-tailwind 作为 H5 实现栈  
- [ ] 未引用其他包 design-system / h5 皮肤  
- [ ] `本包视觉锁.json` 色板与 MASTER 一致（由 Pack 落锁）  

## 8. HTML Agent → H5 Agent（全量严审 → 抄写 + 文档业务流程）

H5 栈锁定 **Vue 3 + Tailwind**。**`agent.html`** 用截图循环把 Inventory **每一页**视觉钉死；**`agent.h5`** 再固定 Vue 栈「抄」进工程，并按**本包** `功能文档.md` 业务流程逐条快测——**扩展现有 `_preview/`**，不开第三套预览目录。

### 8.1 目录（扩展 `_preview/`，勿另起体系）

与流水线 `preview.tabs`（`{slug}-tabs-preview.html` · `preview-canonical.md`）并存：

```text
_preview/
├── preview-canonical.md          # 已有：Tab / 色 / 字（流水线）
├── {slug}-tabs-preview.html      # 已有：Tab 明暗总览（流水线）
└── pages/                        # agent.html：逐屏 HTML 视觉契约
    ├── INDEX.md                  # 路由 → 文件 + skinMode
    ├── APPROVAL.md               # 每页 status=PASS + 截图路径（全量）
    ├── _shot.sh                  # 自 data/static/h5_snippets/preview/ 复制；390×844
    ├── preview-stage.css         # 视口=.stage 零外圈边距（同目录 snippets）
    ├── vendor/                   # 本地缓存 Tailwind + 字体（原 CDN）
    ├── html_shot_vision.sh       # Agnes vision（同目录 snippets）
    ├── _shots/                   # 截图（与 .stage 同框，禁止加宽裁切）
    ├── FREEZE.md                 # APPROVAL 全 PASS 后冻结
    ├── welcome.html
    ├── hub.html                  # 或 Inventory 路由名如 fit.html
    └── ….html                    # Inventory 每一页，同等质量
```

文件名：hash 路由去 `#/`，`/` → `-`（如 `#/day/detail` → `day-detail.html`）。

### 8.2 `agent.html` — 全量同等严审（无优先级简化）

**皮肤（整包只选一种）**

1. 读 `本包视觉锁.json` + MASTER，选定 **`skinMode=浅|深|深浅`**（H5 整包 UI 仍只选 **一种** 亮/暗皮；深浅 表示壳图两套资源都产）。  
2. 全 Inventory 统一该模式（色板 / 字色 / chrome）；禁止 Tab 一页亮、Plaza 整屏暗这种「两套 App」。  
3. `INDEX.md` / `FREEZE.md` 写明 `skinMode`。

**固定舞台 + 截图（离线 vendor）**

- 每页 HTML：全部 UI 在 **`.stage` = 390×844、`overflow:hidden`** 内（与截图窗口一致）。  
- **视口 = `.stage` = 截图框**：`html` / `body` / `.stage` **禁止**外圈 `margin` / `padding`（含 `margin: 0 auto`）；间距只写在 stage **内部**。  
- 复制 `preview-stage.css` + **`vendor/`**（`tailwind.js` + `fonts.css` + woff2）→ `_preview/pages/`；**禁止**外网 CDN URL（用本地 vendor 代替原 Tailwind/Google Fonts CDN）。`<html data-font-pairing="…">` 对齐 visual fontPairing。  
- 截图：复制 `_shot.sh`；系统 Chrome 或 `CHROME_BIN`；`--window-size=390,844` + `--disable-remote-fonts`；**禁止**加宽裁切；**禁止** Pillow 假图。  
- 截图出现左右裁切 / 左偏空半屏 / 外圈 gutter → **改 HTML 壳**，不要靠裁图「修」。

**资源（有图必用）**

- `assetBrief` 下 logo + **所选 mode** 的 `global_bg_*`（及 splash 时的 `launch_*`）须在截图中**可见**。  
- 本 skinMode 对应槽位文件存在时禁止纯渐变壳；task.csv **「真图」=1** 时更不得用 CSS 顶替 logo/bg。  
- `skinMode=浅` → 仅 `launch_light` / `global_bg_light`；`深` → 仅 dark 槽；`深浅` → 四套 light+dark 都有（logo + retry 始终保留）。

**顺序（一页一过）**

1. 页面清单 = **功能文档 Screen Inventory 全部 H5 路由**（无 P0/P1/P2；splash/legal/plaza 同标准）。  
2. 打开对应 Scene Brief / MASTER / **视觉锁** / `assetBrief`。  
3. 写该页 HTML → **`_shot.sh` 截图** → **读图打磨** → `APPROVAL` 记 PASS → 下一页。  
4. 全页 PASS 后写 `FREEZE.md`（每页一行证明）。  
5. 之后若改视觉：先改 HTML + APPROVAL/FREEZE，再让 `agent.h5` 重抄。

**范围**

- 每页独立 HTML：固定舞台 390×844、**离线** `preview-stage.css` + `vendor/tailwind.js` + `vendor/fonts.css` + design-tokens；相对路径 `../../assets/`。
- HTML 钉视觉与信息架构；Bridge / IAP / router / 持久化在 `agent.h5`。

**完成标准（每一页）**

| 要求 | 说明 |
|------|------|
| 舞台 | 390×844 `.stage` 铺满视口（无外圈 gutter）；截图无裁切、无左右偏框 |
| 构图 | 首屏一个构图；品牌/主 CTA/主区清晰；触控≥44；安全区 |
| 皮肤 | 与整包 `skinMode` + 视觉锁一致 |
| 差异 | 与邻页主结构可区分（非改标题克隆） |
| 资源 | logo + 所选 mode 的 global_bg 在截图可见 |
| Welcome | ≥2 差异化 beat；末拍同意+协议+Continue |
| Hub | 问候 + 主区 + 进主工作流 CTA |
| 签收 | `APPROVAL.md` 该行 `PASS` + `_shots/` |

### 8.3 `agent.h5` — 先抄 HTML，再按功能文档业务流程

1. 自建完整 Vite 工程（《H5壳Vite工程规范.md》）；HTML 契约靠 Agent 自审（流水线对 APPROVAL/FREEZE 仅软警告）。  
2. **逐路由**对照冻结 HTML：结构与 Tailwind class **优先原样迁移**；Port 快测 PASS 后再下一页。  
3. 从**本包** `功能文档.md` 解析业务流程 → `h5/FLOW-APPROVAL.md`（**非**固定 F1–F8 模板）。  
4. **逐条**实现 flow + Vitest（happy-dom）快测至 PASS；禁止默认 Playwright/Cypress 慢测作门禁。  
5. 可构建交付物只有 `h5/` → `h5_site/`。

### 8.4 协作约定

| 主题 | 约定 |
|------|------|
| **视觉真源** | FREEZE 前：HTML；FREEZE 后改视觉须回 HTML Agent / 重签 APPROVAL |
| **业务真源** | 本包 `功能文档.md` 流程清单 → FLOW-APPROVAL |
| **快测** | Vitest；整包 `vitest run` ≪ 30s |
| **与 tabs 预览** | canonical / tabs 管 Tab IA 与色板；`pages/*.html` 管单屏密度 |
| **本包设计** | 只认本包 design-system / Scene Brief / tokens |
| **RESUME** | HTML：从首个非 PASS 页继续；H5：从首个非 PASS Port/Flow 继续 |

### 8.5 阶段自检

**agent.html**

- [ ] Inventory **每一页** HTML + 截图严审 PASS（无简化档）  
- [ ] 整包单一 `skinMode`；舞台 390×844 + `preview-stage.css` + `vendor/`（零外网 CDN）；`_shot.sh` 无加宽裁切
- [ ] `APPROVAL.md` 全 PASS；`FREEZE.md` 每页一行  
- [ ] logo + 所选 mode global_bg 在截图可见（真图=1 必用）  
- [ ] 任意两页并排时主结构可区分  

**agent.h5**

- [ ] 每个 Inventory HTML 有对应 Vue，class/层级可追溯（先 Port）  
- [ ] `FLOW-APPROVAL.md` 流程来自本包功能文档，全部 PASS  
- [ ] `vitest run` 绿（无默认 E2E 慢测）  
- [ ] Bridge / Legal 分支可走通；交付从 `h5/` 构建  

## 导航

- 上级：`H5壳Vite工程规范.md` · `H5壳Pack约束.md` · `H5壳H5实现检查清单.md`  
- 视觉语料：`skill-input/visual/`（`prepare.context` 投影单行 CSV）
