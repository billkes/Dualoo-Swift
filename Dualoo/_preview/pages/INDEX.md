# Preview INDEX — Dualoo

skinMode: **浅 (light)** — H5 UI single light chrome; rasters wired: `logo`, `global_bg_light`, `launch_light`, `retry` (真图=1, agent.assets done).

> **STATUS: DRAFT — NOT FROZEN.** No page HTML has been authored yet and **no APPROVAL / FREEZE exists**. This environment has no working Chrome/Chromium (see RESUME-NOTES.md). Resume with the per-page loop: author one page → `_shot.sh` → `html_shot_vision.sh` → PASS → `APPROVAL.md` row → next page. Do not freezen or batch-approve.

| # | Route (from 功能文档 Screen Inventory) | File (draft name) | Status |
|---|------|------|--------|
| 1 | `#/splash` | `splash.html` | DRAFT — pending page + shot + vision |
| 2 | `#/welcome` | `welcome.html` (beats 1–3, final = consent row) | DRAFT — pending page + shot + vision |
| 3 | `#/ring` (Tab 1) | `ring.html` | DRAFT — pending page + shot + vision |
| 4 | `#/duel` | `duel.html` | DRAFT — pending page + shot + vision |
| 5 | `#/duel/board` | `duel-board.html` | DRAFT — pending page + shot + vision |
| 6 | `#/strip/:pairId` | `strip.html` (param page; export = preview contract) | DRAFT — pending page + shot + vision |
| 7 | `#/vault` (Tab 2) | `vault.html` | DRAFT — pending page + shot + vision |
| 8 | `#/pair/:pairId` | `pair-detail.html` (param page) | DRAFT — pending page + shot + vision |
| 9 | `#/store` (Tab 3) | `store.html` (standard 9 + promo 6 zones) | DRAFT — pending page + shot + vision |
| 10 | `#/settings` (Tab 4) | `settings.html` | DRAFT — pending page + shot + vision |
| 11 | `#/legal` (overlay) | `legal.html` (bundled text, mask-fade scroll) | DRAFT — pending page + shot + vision |
| 12 | `#/plaza` (hidden) | `plaza.html` | DRAFT — pending page + shot + vision |

## Page source contracts (must open before authoring)

- Screen Inventory / Tab Navigation / State & Empty Matrix: `功能文档.md`
- MASTER + tokens: `design-system/sketch-hand-drawn-mobile/MASTER.md` · `skill-adapt/design-tokens.css`
- Scene Briefs: `design-system/sketch-hand-drawn-mobile/pages/welcome.md` · `pages/hub.md`
- Visual lock + component selection + assetBrief: `本包视觉锁.json`
- Rasters (agent.assets, real): `assets/jxfs_media_raster_ke/dwhkv_brand_logo.png` · `dwhkv_launch_light.png` · `dwhkv_global_bg_light.png` · `dwhkv_panel_retry_offline.png` — referenced from pages as `../../assets/...`

## Stage shell (per page)

390×844 `.stage`, `overflow:hidden`, zero outer margin/padding; `lang="en"`; `data-font-pairing="Soft Rounded"`; local `preview-stage.css` + `vendor/tailwind.js` + `vendor/fonts.css` + `../../skill-adapt/design-tokens.css`. Zero remote URLs. Copy = English only (no CJK).
