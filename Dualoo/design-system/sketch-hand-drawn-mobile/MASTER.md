# Dualoo Design System — MASTER

Slug: `sketch-hand-drawn-mobile` · App: **Dualoo - Crisp & Opposite** · Pack: `h5_swift_shell` (H5 vault, WKWebView shell)
Historical visual authority: `skill-input/visual/` single-row CSVs ONLY (style/colors/typography) + `meta.json` skinMode. No skill search, no cross-package design.

| Locked deck | Value | Source |
|-------------|-------|--------|
| designStyle | **Sketch Hand-Drawn (Mobile)** (Type: Mobile) | `style.csv` row 84 — **shape/motion only** |
| colorPalette | **Restaurant/Food Service** | `colors.csv` row 34 — all color tokens |
| fontPairing | **Soft Rounded** (Varela Round + Nunito Sans) | `typography.csv` row 19 — all fonts |
| skinMode | **浅 (light only)** | `meta.json` — the ONLY light/dark authority |

Cross-read guards (orthogonality): palette is NEVER taken from style.csv; fonts are NEVER taken from style.csv; light/dark is NEVER inferred from the style name. Residual color/font/skin mentions inside the style row (handwriting-font hints, pencil-black, post-it yellow, blue ballpoint) are explicitly non-authoritative and are OUT for this pack: borders use the `Border`/`Foreground` tokens below, accents use `Primary`/`Accent`, fonts use Soft Rounded.

---

## 1. Product scene (from 功能文档 — governs every pattern choice)

Dualoo is an antonym photo-duel drill app for young people who train concepts with a camera: draw an antonym pair (Wind-Up Draw on a 7-day Drill Ring), shoot LEFT/RIGHT opposite frames, rate each side on Dual Rails for a Contrast Score (S/A/B/C), vault Winning Pairs, and export a 4:5 Before–After Strip to Photos. Voice = playful concept coach, English UI, verbs first, honest one-line feedback. Signature surfaces: Drill Ring dial, two-labelled capture slots, dual-rail board, polaroid strip, coin store with dual zones.

---

## 2. Style — Sketch Hand-Drawn (Mobile): shape & motion law

- **Paper canvas:** warm paper tone (Background token) with a subtle repeating paper grain overlay; the canvas stays flat and light — no gradients-as-canvas, no glass, no blur panels.
- **Wobbly corners:** hand-drawn irregular radii per corner. Canonical sets (use via tokens): card `15px 25px 20px 10px / 20px 10px 25px 15px`, button `12px 20px 14px 18px / 18px 14px 20px 12px`, chip `18px 22px 16px 20px / 20px 16px 22px 18px`. Every card/panel uses an irregular radius — perfect rectangles read as wrong-skin.
- **Outlines:** 2–3px strokes; solid for committed objects (cards, rails, rings), **dashed for pending/placeholder/active slot** states (capture slots, empty ring segments). Stroke color = ink Foreground for primary objects, Border token for hairlines and dividers.
- **Hard offset shadow:** zero-blur rear layer offset exactly 4px right / 4px down in ink Foreground (buttons 3px/3px). NEVER a blurred drop shadow on primary cards/buttons.
- **Slight rotation:** cards rotate −1deg or +1deg alternating along a list (content rotates with the card; body copy stays upright only on text-dense legal/store screens for legibility).
- **Scribble overlays:** absolute-positioned SVG decorations — arrows, tape strips, pins/tacks — at ~10–14% opacity ink or Accent gold; maximum 2 per region, never under running text.
- **Press motion:** primary button press translates (4px, 4px) to “cover” its own offset shadow — the signature tactile press.
- **Error motion:** jiggle keyframes −2deg ↔ 2deg, 400ms, ink outline switches to Destructive.
- **Layout motion:** spring curve `cubic-bezier(0.34,1.56,0.64,1)`; 140–220ms for presses/sheets, ≤320ms for card flips and ring segment fills.
- **Haptics-class ticks:** segment ticks on the ring and rail decade crossings pulse via scale 0.96↔1.0 (visual stand-in for native haptics on H5).
- **Targets:** every interactive element ≥48×48 CSS px; mobile-first single-column rhythm.

Style avoid-list (bakes into review): enterprise dashboards, high-density tables, fintech precision chrome, medical/legal cold skins, generically centered glossy hero cards.

---

## 3. Color — Restaurant/Food Service tokens (skinMode 浅 → light as-is)

| Token role | Value | Dualoo usage contract |
|------------|-------|------------------------|
| Primary | `#DC2626` | Wind-Up Draw centre, primary buttons, done ring segments, right-pole rail, score emphasis, Store buy row |
| On Primary | `#FFFFFF` | Label on primary |
| Secondary | `#F87171` | Left-pole rail, in-progress ring fill, soft badges, promo tape accents |
| On Secondary | `#0F172A` | Label on secondary |
| Accent | `#A16207` | Gold: vault dots, Winning-Pair medal (S/A), streak flame, coin face, favorite pin |
| On Accent | `#FFFFFF` | Label on accent |
| Background | `#FEF2F2` | Paper canvas, all screens |
| Foreground | `#450A0A` | Ink: outlines, offset shadows, primary text |
| Card | `#FFFFFF` | Post-it cards, polaroids, sheets |
| Card Foreground | `#450A0A` | Card text |
| Muted | `#F0EDF1` | Skeleton shimmer base, inactive slot fill, missed-day haze |
| Muted Foreground | `#64748B` | Hints, timestamps, missed-day outline, disabled labels |
| Border | `#FECACA` | Hairlines, dividers, pending segment dashes, input resting border |
| Destructive | `#DC2626` | Error outlines/jiggle, delete actions |
| On Destructive | `#FFFFFF` | Labels on destructive |
| Ring (focus) | `#DC2626` | Today-segment pulse, input focus outline |

SkinMode 浅 rules: every screen uses the light tokens above — no dark surfaces, no per-screen skin flips; enormous dark overrides (opaque black scrims) are banned: overlays use `Foreground` at ~28% alpha. State→color grammar is fixed: pending=#64748B-dash, in-progress=#F87171 half-fill, done=#DC2626 solid fill, vault-mark=#A16207 gold dot, today-pulse=#DC2626 ring.

---

## 4. Typography — Soft Rounded

- **Heading: Varela Round** (single weight 400). Hierarchy is built with SIZE and the wobbly frame, not weight: H1 28–30px appbars/sheet titles, H2 22–24px section labels, pair labels on cards 20–24px. Never fake-bold Varela (no synthetic stroke bold) — for emphasis, raise size or add an ink underline scribble.
- **Body: Nunito Sans** 400 body (16px), 600 emphasis (buttons, slot labels), 700 numbers (scores, balances). Line-height ~1.45; numerals for scores/rails always Nunito 700 tabular-aligned.
- **Quirks:** greeting/whisper hints in body italic-equivalent are NOT italic-skewed (both fonts stay upright) — playful tone comes from copy + scribbles, not fake italics. All-caps only for the two-pip labels on capture slots (LEFT/RIGHT) and tiny 11–12px section eyebrows.
- **Runtime fonts:** pack-local vendor woff2 (`varela-round-latin-400-normal`, `nunito-sans-latin-{400,600,700}`); `data-font-pairing="Soft Rounded"` on `<html>`; Google Fonts URL is documentation-only, never a runtime call.

## 5. Iconography & assets

- Icons: **Phosphor outlined, regular weight** — camera, images, vault/lock, coin, flame (streak), star (favorite), gear, x (close ≥44×44). Hand-drawn skin keeps icon stroke at 1.5px optical weight.
- Pack rasters (skinMode 浅): brand logo, `launch_light`, `global_bg_light`, retry panel art — referenced per `assetBrief` (registered in 本包视觉锁.json by agent.plan.pack); logo + `global_bg_light` must be VISIBLE in preview screenshots.
- Illustration rule: decorations are SVG scribbles layered over CSS/post-it shapes; photos shown in-app always sit inside polaroid frames (white card, ink outline, caption strip).

## 6. Pattern notes — surface contracts

- **TabBar (bottom hub, 4 tabs):** fixed bottom paper bar with ink top hairline; active tab gets a wobbly ink underline scribble + primary tint; labels Ring / Vault / Store / Settings in Nunito 600 with Phosphor icons.
- **AppBar/style pages:** paper bar, Varela Round title, handwritten back-arrow scribble; fixed, never scrolls away.
- **Cards / list rows:** white post-it card, 2.5px ink outline, alternating ±1deg rotation, 4px offset shadow; first-class content is captioned polaroids.
- **Buttons:** primary = Primary bg + On-Primary label + 3px offset shadow; press = translate(4,4) shadow-cover. Secondary = white + ink ghost outline. Destructive = ghost with Destructive outline + jiggle on invalid.
- **Chips/filters:** dashed outline resting → solid ink + soft fill active; checkboxes keep native appearance (no `appearance:none`) styled inside a hand-drawn square outline.
- **Inputs:** Nunito 400, 2.5px Border resting → Primary ring on focus; never full-width bare underline.
- **Sheets/modals:** bottom sheet = post-it card pulling up over 28% ink scrim; tap-outside dismiss; drag handle is a short ink scribble.
- **Snackbars/toasts:** post-it slip, bottom, −1deg, 2.4s, ink outline, icon + one-line English copy.
- **Legal reader (paper overlay):** white sheet, Varela title, scroll region with bottom mask fade only (per legal UI rules), close button ≥44×44.
- **Empty states:** never blank “No data” — a dashed-outline motif of the surface's hero (ring dial / polaroid / coin) + one coaching line + one CTA.

### Surface signatures (design anchors for pages/*)

- **Drill Ring (Tab1 hero):** hand-drawn dial Ø≈240px; 7 arc segments rolling D-6…D0; state grammar from §3; centre post-it knob = Wind-Up Draw handle with tick detents every ~30°; gold vault dot sub-mark on scored+vaulted days; today segment pulses.
- **Duel capture slots:** two stacked polaroid slots labelled LEFT / RIGHT with each concept; dashed 3px outline when empty, solid ink + photo when filled; camera FAB per slot.
- **Dual Rail Board:** two horizontal rails with scribble handles; left rail Secondary, right rail Primary; live score readout in an ink-stamped circle; “Score it” primary button.
- **Strip composer:** fixed 4:5 portrait composition — two polaroids over paper, dashed divider, score stamp circle, date strip; preview IS the export (same tree, same ratio).
- **Vault grid:** 2-col polaroid grid, each with caption strip + score badge; gold pin for favorites; filter chips row opens dashed filter sheet.
- **Coin Store:** coin face = gold circle w/ ink inner ring; Standard zone = post-it tier cards alternating tilt; Limited Promo zone = dashed “today only” tape badges with struck original price.
- **Welcome gate:** collage storyboard, two-polaroid motif, progress scribbles; final beat carries the consent row (checkbox + two legal links + Agree & Start).

## 7. Stack note

H5 栈锁定 **Vue 3 + Vite + Tailwind + Phosphor** —— 单一实现栈；RN/SwiftUI/Flutter 不作本包 H5 实现源。详见 `stack-vue.md` 与 `stack-html-tailwind.md`。

## 8. Review checklist (owner: agent.design / agent.html)

1. Style name == Sketch Hand-Drawn (Mobile); CSS/JS never imports another design's tokens.
2. Every color resolves to a colors.csv token; every font-family resolves to Soft Rounded pair.
3. skinMode 浅 single light skin everywhere (Background #FEF2F2 base).
4. Wobbly radius + ink outline + offset shadow on all first-class surfaces; blurred shadows absent; 48px targets.
5. Pages stay within their section 6 contracts; two side-by-side pages are never “same layout, different title”.
