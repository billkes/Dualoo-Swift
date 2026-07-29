# Stack notes — Vue 3 (H5 implementation stack)

Light notes only (known Vue 3 mobile practice; not from any skill search). The pack's H5 implementation stack is **Vue 3 + Vite + Tailwind + Phosphor** — single stack, no substitution.

## App shell
- Vue 3 Composition API, `<script setup>` SFCs; one feature folder per route family mirroring 功能文档 routes (`ring/`, `duel/`, `board/`, `strip/`, `vault/`, `store/`, `settings/`, `legal/`, `welcome/`).
- `vue-router` hash history (matches `#/...` inventory); route meta carries tab vs stack vs overlay lane; overlay routes render `base + overlay` per Overlay 路由规范 (never overwrite the base).
- State: Pinia stores per domain slice (session / ring / vault / wallet / settings / deck) — mirrors the §H5 Architecture slices and `dualoo.*` persistence keys in 功能文档.

## Mobile contracts (from MASTER §2/§6)
- Single-column mobile-first flows; root width = device; `.page` fills `100dvh` with `env(safe-area-inset-*)` padding.
- Every interactive target ≥48×48px (`min-w-12 min-h-12`); buttons use the wobbly-radius utility + press translate(4px,4px).
- AppBar fixed top, TabBar fixed bottom (never scroll away); content scrolls inside the page region only.
- No `v-html` for user content; captions render escaped text via `{{ }}`.
- Images always through the media bridge URL resolver (`dualoo-asset://` via Bridge resolver; browser mock in DEV) — never `file://`, never inline base64 media.
- Lists: virtualize only when the vault exceeds ~200 pairs; keys stable by `pairId`.

## Motion
- CSS keyframes/transitions per MASTER §2 (spring cubic-bezier, jiggle, 140–320ms bands); `useMotion`-style composables discouraged — keep animation declarative in Tailwind/custom CSS so the frozen HTML ports 1:1.
- Respect `prefers-reduced-motion`: swap springs for 120ms fades, disable jiggle.

## Fonts & tokens
- `@font-face` from local vendor woff2 only (Varela Round 400 / Nunito Sans 400·600·700); `<html data-font-pairing="Soft Rounded">`.
- All colors/radii/spacing derive from `skill-adapt/design-tokens.css` custom properties; Tailwind config maps them (no raw hex in components).

## English-only
- All user-visible copy, comments, placeholder text in code = English (`en-US`); time formatting via `Intl.DateTimeFormat('en-US', …)` patterns; CJK is banned in `h5/**` per english-only-business rule.
