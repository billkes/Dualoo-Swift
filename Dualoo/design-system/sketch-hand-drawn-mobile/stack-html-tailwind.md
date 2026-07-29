# Stack notes — HTML + Tailwind (preview contract stack)

Light notes for `_preview/pages/*.html` visual contracts (agent.html consumes this). Everything here is mobile-first; desktop container/max-width guidance does NOT apply to this pack.

## Stage
- Preview stage is exactly **390×844 CSS px**, `overflow:hidden`, zero outer margin/padding on `html/body/.stage`; all spacing lives inside the stage (screenshot window == stage).
- `<html lang="en" data-font-pairing="Soft Rounded">`; pages reference only local `preview-stage.css`, `vendor/tailwind.js`, `vendor/fonts.css` and `skill-adapt/design-tokens.css` — no CDN URL, no remote font.
- Relative asset paths `../../assets/…`; the pack's light-mode rasters (`logo`, `global_bg_light`, plus `launch_light` on splash pages) must be visible in-frame.

## Tailwind usage
- Mobile-first single column; spacing scale 4px (p-3 = 12px, p-4 = 16px …); dense regions drop to p-2.5 minimum.
- Fixed chrome: `.appbar { position: fixed; inset-inline: 0; top: env(safe-area-inset-top); }`, tabbar mirrors at bottom; scroll container owns overscroll.
- Touch: `h-12 w-12` (48px) minimum on buttons, chips, icon cells; active states use `active:translate-x-1 active:translate-y-1` to cover the offset shadow per MASTER.
- Wobbly radius comes from token utilities (arbitrary values mirroring the radius sets: `rounded-[15px_25px_20px_10px/20px_10px_25px_15px]`), never generic `rounded-lg` on first-class surfaces.
- Offset shadow util: `shadow-[4px_4px_0_#450A0A]` class pattern (tokenized) — never Tailwind's blurred `shadow-md/lg` on cards/buttons.
- Rotation: alternate `-rotate-1` / `rotate-1` on cards; interactive drag regions (ring, rails) stay unrotated so gesture math stays clean.

## Component shape (for previews)
- Cards = white post-it: `bg-white border-[2.5px] border-[#450A0A] rounded-[…] shadow-[4px_4px_0_#450A0A]`.
- Primary buttons: `bg-[#DC2626] text-white` + wobbly radius + offset shadow + press translate.
- Rails: track `h-3 rounded-full` with scribble handle `h-12 w-12 rounded-full border-[2.5px]`; LEFT rail `bg-[#F87171]`, RIGHT rail `bg-[#DC2626]`.
- Ring dial: inline SVG arcs (hand-drawn dash pattern for pending segments), centre knob 96×96 with detent ticks.
- Legal scroll region: bottom mask `mask-image: linear-gradient(to bottom, #000 85%, transparent)`, `scrollbar-width: none`, `::-webkit-scrollbar{display:none}` per legal UI rules.
- Checkbox rows keep native `appearance` (welcome consent stays visibly checkable).

## What NOT to ship in previews
- No system `<select>`, `<input type=file/color/date>`, no `alert/confirm/prompt`; native-appearance text inputs are styled with kit outlines.
- No remote URLs of any kind (fonts, css, images); no placeholder lorems; copy comes from 功能文档 voice (short English strings).
