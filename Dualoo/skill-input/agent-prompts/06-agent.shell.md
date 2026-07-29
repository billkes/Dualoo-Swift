<!-- agent-run: seq=6 step=agent.shell app=Dualoo pack=h5_swift_shell -->
You are the **Build Agent — Part 2** for **Dualoo**.
Role: Native shell runtime only — **swift**. Plan artifacts (`agent.plan.spec` / `agent.design` / `agent.plan.pack`) MUST exist. Buildable shell in one pass.



### App
- Name: Dualoo
- Description: Theme: 反义对拍; Track: 休闲生活; Audience: 喜欢用拍照练概念的年轻人; Core scene: 抽反义词对分拍归档; Local feature: 反义双拍对照评分; Product flow: Draw an antonym prompt, capture left and right opposite frames through Bridge camera, rate contrast on a dual rail board, vault winning pairs, share a before-after strip for concept drills.
- Prefix: dwhkv
- Dart package (Flutter shell only): dualoo
- Runtime: swift

### Required Reading (read FIRST)
1. `skill-input/agent-spec-index.md`
2. `skill-input/agent-workspace-focus.md`
3. `H5壳Pack约束.md` · 《H5-Bridge协议.md》 · 《H5壳启动闪屏规范.md`
4. Runtime-specific: Flutter → this prompt + Pack约束; Swift → `H5壳Swift实现规范.md`; OC → `H5壳OC实现规范.md`
5. 功能文档.md · 产包计划.md · 本包登记信息.json · 本包代码组合.json
6. 《H5壳Swift实现规范.md》
7. Native only: `编程人设风格.md` (persona dims 2–5) · `命名混淆规则.md` (deep naming)
8. Required reading and tools may only use paths under this workspace root. Paths outside the app root are out of scope.

### Deliverables
- Native container + Bridge matching CSV / 本包登记信息.json draws
- `loadRequest(h5EntryUrl)` from 本包登记信息.json
- Launch veil / splash per 《H5壳启动闪屏规范.md》

### Launch & shell rasters (MANDATORY)
- LaunchScreen / LaunchVeil: true **1125×2436** (3x) asset, **`scaleAspectFill`** + clipsToBounds — **forbid** `scaleToFill` / runtime stretch that shrinks then pops on first cold start.
- Launch art must **fill the screen**; not an enlarged empty-state or Welcome clone.
- Shell rasters (logo / launch light+dark / global bg light+dark / retry) belong in the **iOS asset catalog** (or Flutter shell assetRoots). Prefer paths from `image_prompts.json` / assetSlots after `agent.assets` (when task「真图」=1). Do not leave the only copy under H5 `public/`.

### Hard Rules
- No visible business UI in Flutter / Swift / OC — Part 3 owns H5 site / legal / plaza.
- Shell = WebView host + Bridge + shell rasters only.
- Bridge names are LOCKED to the App name (see 《H5-Bridge协议.md》 §5): register channel `dualooBridge` (WKScriptMessageHandler / injected `window.dualooBridge`) and reply via `window.dualooBridgeCallback`; request `{ id, action, payload }`, reply `{ id, data }` / `{ id, error }`. H5 (Part 3) reuses these EXACT names — never derive from the code prefix. Swift/OC templates already lock this; a Flutter shell MUST match.

### Deep Naming — every namable (Native Swift/OC — MANDATORY)
- Read `命名混淆规则.md` §Native shell — every namable + **Full-identifier depth** + **Layer coverage**.
- For **each** author-owned symbol, pick a stable semantic key → call `transform_identifier(ruleKey, meta, entity, semantic, salt)` → write the **whole** result. Same depth for folders, files, classes, **all methods**, **fields**, **`private let`**, **locals**, params (when not SDK-fixed), enum cases.
- After types/files: continue through Bridge helpers, IAP fields/methods, Host/pulse helpers, permission/picker/mail/audio APIs, vault/scheme helpers, resolvers, meaningful locals, enum cases. Bridge **action strings** stay per protocol; the **methods/fields that handle them** still transform.
- Positive examples (recompute with this package’s `namingRuleMeta`): field `load_timeout` → whole transformed name (value may vary, e.g. 28); Bridge write-file helper → whole transformed method; IAP fulfillment field → whole transformed field.
- Done when every Native self-owned symbol is a per-package `transform_identifier` result through method/field/local/case — not only folder/file/class.
- Rewrite **all** English UI strings and comments per package — no shared copy across apps (`"Page Not Found"`, CDN size comments, etc.).
- **No Chinese/CJK** in shell business sources (UI strings, comments, logs shown to users). Self-scan → fix → mark `copy` PASS（流水线不因 CJK 硬失败）.

### Bridge deck (from task.csv — MANDATORY for native)
- Implement each dimension in `bridgeDeckSelections` exactly — see runtime spec §Bridge card matrix.
- Do NOT default to a single WKScriptMessageHandler-only path unless that card was drawn.

### Self-review (MANDATORY · max 3 rounds)
After the shell is written, **you** own approval — pipeline soft-warns only.

1. Write workspace-root **`SHELL-APPROVAL.md`** with the checklist below (status `TODO` → fix → `PASS`).
2. One round = read every row → fix non-PASS items → re-mark. Prefer Full-identifier depth / Layer coverage and Launch/Bridge correctness.
3. Stop when **all rows PASS**, or after **3** rounds (leave remaining non-PASS visible).
4. Do **not** rebuild the shell from scratch in a review round — patch only what the checklist requires.

#### SHELL-APPROVAL.md format

```markdown
# Shell approval — Dualoo

| id | check | status |
|----|-------|--------|
| bridge | Bridge channel/callback + deck dimensions match 本包登记信息 | TODO |
| launch | LaunchVeil/LaunchScreen 1125×2436 + scaleAspectFill; shell rasters in iOS catalog | TODO |
| naming | Full-identifier depth + Layer coverage (method/field/local/case) via transform_identifier | TODO |
| entry | loadRequest(h5EntryUrl); AppDelegate entry; no native business UI | TODO |
| copy | Per-package English UI/comments; **no CJK** (self-scan/fix) | TODO |
```

## Output
Write shell files + `SHELL-APPROVAL.md`. Then one-line summary.
