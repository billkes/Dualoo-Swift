# Design Brief — Dualoo

Organized from `skill-input/visual/` single-row CSVs + `meta.json` (no skill search, no cross-package reference). Full law lives in `design-system/sketch-hand-drawn-mobile/MASTER.md`; this brief is the forward handoff for `agent.plan.pack` (本包视觉锁) and `agent.html` (preview contracts).

## Locked four + one
- designStyle: **Sketch Hand-Drawn (Mobile)** — shape/motion only
- colorPalette: **Restaurant/Food Service** — tokens below
- fontPairing: **Soft Rounded** — Varela Round (heading, 400) + Nunito Sans (body, 400/600/700)
- skinMode: **浅 (light only)** — single light skin for the whole pack
- Iconography: Phosphor outlined regular; rasters per assetBrief (logo · launch_light · global_bg_light · retry)

## Voice
Playful concept coach for young camera-drillers. English-only UI; verbs first; one idea per surface; honest one-line state copy (no slogan walls, no lorem). Product nouns fixed by 功能文档 glossary: Antonym Pair, Duel, Left/Right Frame, Dual Rails, Contrast Score, Grade, Winning Pair, Opposites Vault, Drill Ring, Wind-Up Draw, Before–After Strip.

## Token summary (CSS source: `design-tokens.css`)
- Canvas paper `#FEF2F2` · ink `#450A0A` · card `#FFFFFF` · primary `#DC2626` · secondary `#F87171` · accent gold `#A16207` · border `#FECACA` · muted `#F0EDF1` / `#64748B` · focus ring `#DC2626`
- Wobbly radii (card/button/chip sets) · 2–3px solid-or-dashed outlines · hard offset shadow 4px/4px ink · ±1deg card rotation · spring `cubic-bezier(0.34,1.56,0.64,1)` 140–320ms · jiggle-on-error · 48px targets · safe-area env vars

## State → color grammar (fixed)
pending=muted dashed · in-progress=secondary half-fill · done=primary solid · vault-mark=accent gold dot · today=primary pulse · destructive/error=primary-red jiggle.

## Scene anchors (pages/*)
- `pages/welcome.md` — carousel, 3 beats ending in consent row (bundled legal overlay).
- `pages/hub.md` — T8 Drill Ring dial hero + Wind-Up Draw knob (only draw trigger) + today card + greeting; dashed ghost empty skeleton.

## Screen map for preview (from 功能文档 Screen Inventory)
12 H5 routes: `#/splash` `#/welcome` `#/ring`(Tab1) `#/duel` `#/duel/board` `#/strip/:pairId` `#/vault`(Tab2) `#/pair/:pairId` `#/store`(Tab3) `#/settings`(Tab4) `#/legal`(overlay) `#/plaza`(hidden). Every route gets its own 390×844 stage; chrome + tabbar contracts per MASTER §6.

## Non-negotiables for later steps
1. Palette/fonts/深浅 only from this brief's locked sources — never restyled per page.
2. skinMode 浅: light everywhere; scrims = ink at 28% alpha; no glass/blur panels.
3. Polaroid+scribble motif carries capture slots, vault cards and the strip; the strip preview IS the export tree (fidelity contract).
4. Legal overlay: mask-fade scroll hint only, close ≥44×44, bundled text.
5. No SaaS chrome; no tag/chip list home; no invented state colors; English-only copy.
