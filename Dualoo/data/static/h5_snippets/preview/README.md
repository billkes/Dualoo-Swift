# preview — agent.html 离线截图 + 本地 vendor（原 CDN 缓存）

## 闭集依赖（零外网）

预览页 **禁止** 任何 `http(s)://`。允许：

| 资源 | 路径 |
|------|------|
| 舞台壳 | `preview-stage.css` |
| **Tailwind（原 CDN 缓存）** | `vendor/tailwind.js` |
| **字体（原 Google Fonts 缓存）** | `vendor/fonts.css` + `vendor/fonts/*.woff2` |
| 设计令牌 | `../../skill-adapt/design-tokens.css` |
| 壳图 | `../../assets/...` |
| 截图/审图 | `_shot.sh` · `html_shot_vision.sh` |

详见 [`vendor/README.md`](vendor/README.md)。

## 复制

```bash
SNIP=data/static/h5_snippets/preview
APP=<App>/_preview/pages
cp "$SNIP"/preview-stage.css "$SNIP"/_shot.sh "$SNIP"/html_shot_vision.sh "$APP"/
cp -R "$SNIP"/vendor "$APP"/vendor
chmod +x "$APP"/_shot.sh "$APP"/html_shot_vision.sh
```

## HTML shell

```html
<html lang="en" data-font-pairing="Soft Rounded">
<head>
  <link rel="stylesheet" href="preview-stage.css" />
  <link rel="stylesheet" href="vendor/fonts.css" />
  <script src="vendor/tailwind.js"></script>
  <link rel="stylesheet" href="../../skill-adapt/design-tokens.css" />
</head>
<body>
  <div class="stage">…</div>
</body>
</html>
```

`data-font-pairing` = `skill-input/visual/meta.json` / task **fontPairing** 原名。

## `_shot.sh`

真浏览器；`CHROME_BIN` 或系统 Chrome；禁止 Pillow 假图。

```bash
_preview/pages/_shot.sh _preview/pages/welcome.html _preview/pages/_shots/welcome-b1.png
```

## `html_shot_vision.sh`

真图 → tfLink → Agnes → `*-vision.md`（需 `AGNES_API_KEY`）。
