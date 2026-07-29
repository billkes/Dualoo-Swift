# 网页 Agent 续跑手册 — Dualoo

> 由流水线 `sync.distilled`（第 8 步）写入。供网页版 Agent 手工续跑剩余 Agent 步骤；**不改变**流水线步骤定义与 `run.sh` 用法。

## 背景

- App: **Dualoo**
- Pack: `h5_swift_shell`
- Runtime: `swift`
- Prefix（代码前缀，≠ Bridge 名）: `dwhkv`
- skinMode: **浅**（壳图槽位 4：logo · launch_light · global_bg_light · retry）
- Generated: `2026-07-29T22:17:44+08:00`
- 流水线脚本步已完成（`prepare.context` → `lock.dimensions` → `sync.distilled`）
- 视觉语料：`skill-input/visual/`（style/colors/typography **各一行**；**无**包内技能克隆）
- 共 **7** 个 Agent 步骤，顺序固定；**网页版须分会话执行**（见下）；总表见 `skill-input/agent-runbook.md`

## 网页时长限制（硬约束）

- 网页 Agent **有执行时长上限**；**禁止**一次会话连续跑多个 `agent.*` 步骤
- **一次会话 = 恰好 1 步**；交付物自检通过后**立即结束**，不得开始下一步
- 下一步须**新开**网页 Agent，粘贴对应「分步启动话术」
- 若单步内超时未完成：下一会话**仍只续跑该步**，禁止跳步

## 工作区

- 根目录 = 本包根（本文件所在目录）
- 只读/写本根下文件；禁止出包
- Preferred index: `skill-input/agent-spec-index.md` · `skill-input/agent-workspace-focus.md`
- 视觉：读 `skill-input/visual/*.csv` 自整理（见 `H5壳ui-ux-pro-max使用规范.md`）

## 执行顺序（严格串行 · 每步一次会话）

| # | step | prompt | deliverables |
|---|------|--------|--------------|
| 1 | `agent.plan.spec` | `skill-input/agent-prompts/01-agent.plan.spec.md` | 功能文档.md; Dualoo Privacy Agreement.md; Dualoo User Agreement.md |
| 2 | `agent.design` | `skill-input/agent-prompts/02-agent.design.md` | design-system/*/MASTER.md (+ stacks/briefs · Scene Briefs); skill-adapt/* · design-audit.md |
| 3 | `agent.plan.pack` | `skill-input/agent-prompts/03-agent.plan.pack.md` | 本包登记信息.json; 本包视觉锁.json |
| 4 | `agent.assets` | `skill-input/agent-prompts/04-agent.assets.md` | shell rasters (浅): logo · launch_light · global_bg_light · retry; image_prompts.json (replaced) |
| 5 | `agent.html` | `skill-input/agent-prompts/05-agent.html.md` | _preview/pages/*.html（Inventory 全量）; APPROVAL.md（全 PASS）· FREEZE.md · _shots/; vendor/（本地 Tailwind + fonts，随 snippet 复制） |
| 6 | `agent.shell` | `skill-input/agent-prompts/06-agent.shell.md` | native / Flutter shell + Bridge; SHELL-APPROVAL.md（自审限次全 PASS） |
| 7 | `agent.h5` | `skill-input/agent-prompts/07-agent.h5.md` | h5/ 忠实移植冻结 HTML; FLOW-APPROVAL.md（本包功能文档业务流程）; Vitest 快测绿 |

## 每步协议

1. **先读**包 git 根 `.cursor/rules/*.mdc` + `.cursorignore`（网页不自动加载；工作区为 `App/` 时用 `../.cursor/...`）
2. 完整阅读对应 `skill-input/agent-prompts/0N-*.md` 及其 Required Reading
3. **只写**该步 Deliverables；不要提前做下一步
4. 自检通过后输出一行 summary，**本会话结束**（网页勿连跑下一步）
5. 人工验收后，新开会话粘贴下一步话术

## agent.html 网页沙箱截图（已验证路径 · 必读）

网页沙箱通常 **没有** `/Applications/Google Chrome`，且 Playwright 默认下 Chromium 会打 `storage.googleapis.com`（常被墙）。**禁止**因此改用 Pillow/手绘假 PNG。

### 优先级

1. **已有浏览器**：`export CHROME_BIN=<可执行文件>` 后跑 `_preview/pages/_shot.sh <page.html> _preview/pages/_shots/<name>.png`，再 `html_shot_vision.sh`；须有 `*.png.vision.md` 且 `status: PASS`。
2. **无系统 Chrome（网页常用）**：用 **npm 包内自带二进制**（走 npm registry，不走 Google CDN）：
   ```bash
   # 在可写临时目录
   npm pack @sparticuz/chromium
   # 解压包内 chromium.br → 得到 Chromium 可执行文件；
   # 同包 al2023.tar.br 解压出 libnspr4/libnss3/libnssutil3 等 .so
   export CHROME_BIN=/path/to/chromium
   export LD_LIBRARY_PATH=/path/to/extracted-libs:$LD_LIBRARY_PATH
   "$CHROME_BIN" --version   # 须成功
   # 再调用 _shot.sh（脚本会加 --no-sandbox 等）
   ```
   备选：从 **GitHub Releases** 下载与当前 OS/Arch 匹配的 Chromium/Chrome for Testing zip（`github.com` / `codeload.github.com` 常可通），解压后同样 `export CHROME_BIN=...`。
3. **HTML 必须离线**：只用包内 `vendor/tailwind.js` + `vendor/fonts.css`，禁止 `cdn.tailwindcss.com` / Google Fonts，否则 headless 会卡在 TLS。
4. **失败停步**：`--version` 可以但 `--headless`/`--screenshot` 崩溃（常见：Amazon Linux 二进制在 Debian ABI 不兼容）→ **本步未完成**；汇报环境限制；**禁止**写 FREEZE、禁止 APPROVAL 全 PASS、禁止 Pillow/synthetic 假图。 留给有本机 Chrome 的主机补 `_shots/` + vision 后再冻结。

## 硬约束（摘要）

- Bridge 锁定（按 App 名，**禁止**用 prefix 派生）: `dualooBridge` / `dualooBridgeCallback`
- Shell 无业务 UI；业务只在 `h5/`
- **顺序（固定）**：`agent.plan.spec` → `agent.design` → `agent.plan.pack`→ `agent.assets`（真图=1）→ `agent.html` → `agent.shell` → `agent.h5`
- **`agent.design`**：只读 `skill-input/visual/` 单行 CSV + 功能文档；整理 MASTER / tokens / Scene Brief / `design-audit.md`（禁止 search.py / 行业 query）
- **`agent.plan.pack`**：写登记 JSON + `本包视觉锁.json`（在 html 之前，供 assets / 截图引用）
- **`agent.assets`**：仅当 task.csv「真图」=1 时在 **agent.html 之前** GenerateImage 替换 **4** 槽（skinMode=浅：logo · launch_light · global_bg_light · retry）；「真图」=0/空则流水线跳过，html 用 tokens/CSS、不接 PLACEHOLDER PNG
- **`agent.html`**：Screen Inventory **全量** HTML + **真浏览器截图**；无 `_shots`+vision PASS **禁止** FREEZE；截图法见上文「网页沙箱截图」
- **`agent.h5`**：先逐路由抄冻结 HTML → 再按**本包** `功能文档.md` 业务流程逐条实现 + Vitest 快测（禁止默认 Playwright E2E）
- 只认本包 design-system / `_preview` / `h5`（对照范围限于本包根）
- 不编辑 `h5_site/`（部署产物由流水线 `dev.h5.build` 生成）
- 若缺少 `产包计划.md`：跳过该文件，以 `功能文档.md` + 登记 JSON 为准
- H5 用户可见文案：English；浏览器 DEV 须接 `browserMock`

## Agent 全部完成后

- **默认**：7 个 Agent（分 7 次会话）做完即停，交回原流水线续跑 `plan.gate` → `dev.h5.build` → `git.plan` / `git.dev`
- 仅当用户明确说「继续到可 build」时：在 `h5/` 内修到可 `npm run build:deploy`；仍不改流水线代码与步骤

## 分步启动话术（每次只贴一段给一个新网页 Agent）

> 共 **7** 次独立会话；禁止把多段话术合并进同一次对话。

### 步骤 1 · `agent.plan.spec`

```text
请打开并严格遵循 @网页Agent续跑手册.md。
本次会话只做「执行顺序」步骤 1：`agent.plan.spec`。
开工前先读包 git 根（含 `.cursor/` 的 *-Swift|OC|Flutter 目录）下的 `.cursor/rules/*.mdc` 与 `.cursorignore`（网页不自动加载 Cursor 配置，须主动打开；若工作区是 App/ 子目录则路径为 `../.cursor/rules/` 与 `../.cursorignore`）。
完整阅读 @skill-input/agent-prompts/01-agent.plan.spec.md 及其 Required Reading。
写功能文档 + Privacy/User Agreement；只产出本步交付物。
只写本步 Deliverables；自检通过后输出一行 summary 并立即结束。
禁止开始下一步或其他 agent.* 步骤（网页有执行时长限制）。
若本步未做完被中断：下一会话仍只续跑本步，勿跳步。
工作区仅限本包根目录；Bridge 名勿用代码前缀派生。
```

### 步骤 2 · `agent.design`

```text
请打开并严格遵循 @网页Agent续跑手册.md。
本次会话只做「执行顺序」步骤 2：`agent.design`。
开工前先读包 git 根（含 `.cursor/` 的 *-Swift|OC|Flutter 目录）下的 `.cursor/rules/*.mdc` 与 `.cursorignore`（网页不自动加载 Cursor 配置，须主动打开；若工作区是 App/ 子目录则路径为 `../.cursor/rules/` 与 `../.cursorignore`）。
完整阅读 @skill-input/agent-prompts/02-agent.design.md 及其 Required Reading。
读 skill-input/visual/ CSV + 功能文档，整理 MASTER / tokens / Scene Brief / design-audit。
只写本步 Deliverables；自检通过后输出一行 summary 并立即结束。
禁止开始下一步或其他 agent.* 步骤（网页有执行时长限制）。
若本步未做完被中断：下一会话仍只续跑本步，勿跳步。
工作区仅限本包根目录；Bridge 名勿用代码前缀派生。
```

### 步骤 3 · `agent.plan.pack`

```text
请打开并严格遵循 @网页Agent续跑手册.md。
本次会话只做「执行顺序」步骤 3：`agent.plan.pack`。
开工前先读包 git 根（含 `.cursor/` 的 *-Swift|OC|Flutter 目录）下的 `.cursor/rules/*.mdc` 与 `.cursorignore`（网页不自动加载 Cursor 配置，须主动打开；若工作区是 App/ 子目录则路径为 `../.cursor/rules/` 与 `../.cursorignore`）。
完整阅读 @skill-input/agent-prompts/03-agent.plan.pack.md 及其 Required Reading。
写本包登记信息.json + 本包视觉锁.json。
只写本步 Deliverables；自检通过后输出一行 summary 并立即结束。
禁止开始下一步或其他 agent.* 步骤（网页有执行时长限制）。
若本步未做完被中断：下一会话仍只续跑本步，勿跳步。
工作区仅限本包根目录；Bridge 名勿用代码前缀派生。
```

### 步骤 4 · `agent.assets`

```text
请打开并严格遵循 @网页Agent续跑手册.md。
本次会话只做「执行顺序」步骤 4：`agent.assets`。
开工前先读包 git 根（含 `.cursor/` 的 *-Swift|OC|Flutter 目录）下的 `.cursor/rules/*.mdc` 与 `.cursorignore`（网页不自动加载 Cursor 配置，须主动打开；若工作区是 App/ 子目录则路径为 `../.cursor/rules/` 与 `../.cursorignore`）。
完整阅读 @skill-input/agent-prompts/04-agent.assets.md 及其 Required Reading。
真图=1 时 GenerateImage 替换 4 槽（logo · launch_light · global_bg_light · retry）；真图=0/空则确认跳过即可。
只写本步 Deliverables；自检通过后输出一行 summary 并立即结束。
禁止开始下一步或其他 agent.* 步骤（网页有执行时长限制）。
若本步未做完被中断：下一会话仍只续跑本步，勿跳步。
工作区仅限本包根目录；Bridge 名勿用代码前缀派生。
```

### 步骤 5 · `agent.html`

```text
请打开并严格遵循 @网页Agent续跑手册.md。
本次会话只做「执行顺序」步骤 5：`agent.html`。
开工前先读包 git 根（含 `.cursor/` 的 *-Swift|OC|Flutter 目录）下的 `.cursor/rules/*.mdc` 与 `.cursorignore`（网页不自动加载 Cursor 配置，须主动打开；若工作区是 App/ 子目录则路径为 `../.cursor/rules/` 与 `../.cursorignore`）。
完整阅读 @skill-input/agent-prompts/05-agent.html.md 及其 Required Reading。
再读 `data/static/h5_snippets/preview/README.md` 与 `data/static/h5_snippets/preview/vendor/README.md`，确认 vendor 缓存后拷到 `_preview/pages/` 再写 HTML。截图流程见本手册「agent.html 网页沙箱截图」：优先 `CHROME_BIN`/`_shot.sh`；无系统 Chrome 时用 npm `@sparticuz/chromium` （包内二进制，勿拉 storage.googleapis.com）解压后 export CHROME_BIN；HTML 必须离线 vendor（禁 CDN）。headless 崩溃/ABI 不兼容 → **停步汇报**，禁止 Pillow 假图、禁止无真图写 FREEZE。
Inventory 全量 HTML + **真浏览器**截图严审至 APPROVAL 全 PASS，再写 FREEZE.md。无 `_shots/*.png` + vision PASS → 禁止 FREEZE。
只写本步 Deliverables；自检通过后输出一行 summary 并立即结束。
禁止开始下一步或其他 agent.* 步骤（网页有执行时长限制）。
若本步未做完被中断：下一会话仍只续跑本步，勿跳步。
工作区仅限本包根目录；Bridge 名勿用代码前缀派生。
```

### 步骤 6 · `agent.shell`

```text
请打开并严格遵循 @网页Agent续跑手册.md。
本次会话只做「执行顺序」步骤 6：`agent.shell`。
开工前先读包 git 根（含 `.cursor/` 的 *-Swift|OC|Flutter 目录）下的 `.cursor/rules/*.mdc` 与 `.cursorignore`（网页不自动加载 Cursor 配置，须主动打开；若工作区是 App/ 子目录则路径为 `../.cursor/rules/` 与 `../.cursorignore`）。
完整阅读 @skill-input/agent-prompts/06-agent.shell.md 及其 Required Reading。
实现 native / Flutter shell + Bridge；无业务 UI。
只写本步 Deliverables；自检通过后输出一行 summary 并立即结束。
禁止开始下一步或其他 agent.* 步骤（网页有执行时长限制）。
若本步未做完被中断：下一会话仍只续跑本步，勿跳步。
工作区仅限本包根目录；Bridge 名勿用代码前缀派生。
```

### 步骤 7 · `agent.h5`

```text
请打开并严格遵循 @网页Agent续跑手册.md。
本次会话只做「执行顺序」步骤 7：`agent.h5`。
开工前先读包 git 根（含 `.cursor/` 的 *-Swift|OC|Flutter 目录）下的 `.cursor/rules/*.mdc` 与 `.cursorignore`（网页不自动加载 Cursor 配置，须主动打开；若工作区是 App/ 子目录则路径为 `../.cursor/rules/` 与 `../.cursorignore`）。
完整阅读 @skill-input/agent-prompts/07-agent.h5.md 及其 Required Reading。
先抄冻结 HTML，再按本包功能文档业务流程 + Vitest 快测。
只写本步 Deliverables；自检通过后输出一行 summary 并立即结束。
禁止开始下一步或其他 agent.* 步骤（网页有执行时长限制）。
若本步未做完被中断：下一会话仍只续跑本步，勿跳步。
工作区仅限本包根目录；Bridge 名勿用代码前缀派生。
```
