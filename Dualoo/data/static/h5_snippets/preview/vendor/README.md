# preview vendor — 本地缓存的「原 CDN」资源

离线闭集：Agent 只引用本目录相对路径，**禁止**再写 `https://cdn.tailwindcss.com` / `fonts.googleapis.com`。

| 文件 | 来源 | 说明 |
|------|------|------|
| `tailwind.js` | 官方 Play CDN 快照 | 体积约 400KB；可按需刷新 |
| `fonts.css` | 本仓维护 | `@font-face` + `data-font-pairing` 映射 |
| `fonts/*.woff2` | `@fontsource/*` latin 子集 | 约 15 族 × 400/600/700 |

## 复制到包内

```bash
cp -R data/static/h5_snippets/preview/vendor <App>/_preview/pages/vendor
```

HTML：

```html
<html data-font-pairing="Soft Rounded">  <!-- = task/visual meta fontPairing -->
<head>
  <link rel="stylesheet" href="preview-stage.css" />
  <link rel="stylesheet" href="vendor/fonts.css" />
  <script src="vendor/tailwind.js"></script>
  <link rel="stylesheet" href="../../skill-adapt/design-tokens.css" />
</head>
```

## 刷新（有外网的机器上）

```bash
# Tailwind Play CDN
curl -fsSL -o data/static/h5_snippets/preview/vendor/tailwind.js https://cdn.tailwindcss.com

# 字体：npm pack @fontsource/<family> 后拷 latin-*-normal.woff2 → vendor/fonts/
```

## 注意

- 预览用 Tailwind Play 脚本 ≠ 生产 Vite 构建；正式包仍走 `h5/` 工具链。
- `_shot.sh` 带 `--disable-remote-fonts`，必须用本目录 woff2。
