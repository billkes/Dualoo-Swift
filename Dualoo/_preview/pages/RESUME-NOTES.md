# agent.html — RESUME NOTES (environment findings, 2026-07-29)

**Why step 5 stopped:** the web sandbox has **no working Chrome/Chromium**, so no real screenshots (`_shots/`) or vision reviews can be produced here. Per 《网页Agent续跑手册》「agent.html 网页沙箱截图 → 失败停步」: **do not** write FREEZE, **do not** mark APPROVAL PASS, **no Pillow/synthetic images**. This step therefore delivered infrastructure + INDEX only; page HTML is NOT authored yet (batch-drafting without the shot loop is banned by the step flow).

## What was tried (all failed — do not re-try blindly)

1. `@sparticuz/chromium@149.0.0` (npm–fetched, botli-extracted): `--version` OK (Chromium 149), but `--headless=new --screenshot` hangs; zygote/socket-prematurely-closed + network-service crash loop.
2. `@sparticuz/chromium@131.0.1` (old headless still present): `--headless=old` hangs identically; `VizNullHypothesis` stall at viz init; single-process mode FATALs or stalls; swiftshader (`libEGL/libGLESv2/libvulkan/libvk_swiftshader`) staged next to the binary + `--use-gl=angle --use-angle=swiftshader|vulkan` — still hangs.
3. al2023 libs staged at `/tmp/al2023/lib` + `FONTCONFIG_FILE` from bundled `fonts.tar` — version OK, raster still hangs.
4. Alternate binary sources checked and **network-blocked** in this sandbox: `storage.googleapis.com`, `cdn.playwright.dev`, `registry.npmmirror.com`, `raw.githubusercontent.com`, `objects.githubusercontent.com`, `release-assets.githubusercontent.com` (GitHub release .deb `chromium-browser-stable_128...amd64.deb` exists but host blocked), gh-proxy mirrors, apt (no sources, non-root).
5. System browsers: none under `/usr/bin` or `/Applications` (Linux container, Debian 12, x86_64, 2 vCPU).

Conclusion: Amazon-Linux (AL2/AL2023) Chromium binaries cannot raster in this Debian sandbox (viz/zygote instability). Working mirrors for a Debian-native binary are not reachable from here.

## What IS ready on disk now

- `_preview/pages/preview-stage.css` · `_shot.sh` (chmod +x) · `html_shot_vision.sh` (chmod +x) · `vendor/` (Tailwind Play snapshot + fonts.css + woff2 incl. `varela-round` + `nunito-sans`) · `_shots/`
- `_preview/pages/INDEX.md` — full 12-route inventory (all DRAFT), skinMode=浅, source-contract pointers.
- Assets (real rasters), 功能文档, design-system, visual lock, registry — all steps 1–4 done and committed.

## How to resume (host with real Chrome — macOS Chrome or Linux Debian chromium)

1. `export CHROME_BIN=<your Chrome/Chromium binary>` (macOS: `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`). Verify: `"$CHROME_BIN" --headless=new --version` and a smoke `--screenshot`.
2. Author pages ONE at a time from `_preview/pages/INDEX.md` order (route list is authoritative):
   - shell: `lang="en"`, `data-font-pairing="Soft Rounded"`, `preview-stage.css` + `vendor/fonts.css` + `vendor/tailwind.js` + `../../skill-adapt/design-tokens.css`; zero remote URLs; English copy only.
   - wire rasters visibly per step-5 rules: `../../assets/jxfs_media_raster_ke/dwhkv_brand_logo.png` (brand surfaces) + `dwhkv_global_bg_light.png` (stage ambient) + `dwhkv_launch_light.png` (splash) + `dwhkv_panel_retry_offline.png` (store/IAP error states etc.).
3. Per page/state:
   ```bash
   _preview/pages/_shot.sh _preview/pages/<file>.html _preview/pages/_shots/<name>.png
   _preview/pages/html_shot_vision.sh _shots/<name>.png <file>.html light [beat]
   ```
   Read `_shots/<name>.png.vision.md`; `status: FAIL` → fix THIS page only → re-shot until PASS; then append the page row to `_preview/pages/APPROVAL.md` (format per 05-agent prompt).
4. `html_shot_vision.sh` needs `${REPO}/scripts/batch/html_shot_vision.py` (pipeline repo) + `AGNES_API_KEY` in `config/config.env` + tflink reachability — this packaging has none of those; run it from the pipeline host. If Agnes is unavailable but the shot is real, the resuming agent performs the visual review by reading the PNG via Cursor vision and records a matching `*-vision.md` — that judgement call belongs to the host operator (pipeline-level gate stays soft-warn per 手册).
5. After 12/12 PASS: write `_preview/pages/FREEZE.md` (skinMode=浅 + one attestation row per page).
