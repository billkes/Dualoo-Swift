# Page — Welcome Gate (`#/welcome`, stack route)

Role: first-run-only gate (see 功能文档 Screen Inventory #2). Three carousel beats introduce the duel loop, then the consent beat gates the app behind both bundled agreements + one checkbox + Agree & Start. Skipped on later runs once `legalAcceptedAt` is set. Never reachable again from tabs — Settings re-opens legal via `#/legal` overlay instead.

## Slots (canonical)

| Slot | Region | Content contract |
|------|--------|------------------|
| App mark | top-safe bar | brand logo (light raster), small; no wordmark duplication in the same band |
| Progress scribbles | under app mark | 3 hand-drawn dashes/dots; active = solid ink, pending = dashed Border |
| Collage stage | upper 55% | two-polaroid collage + scribble arrows/tape; per-beat art swap (Beats below) |
| Headline block | mid | Varela Round 26–28px headline + 1–2 line Nunito support copy |
| Beat controls | lower | “Next” ghost button (beats 1–2); beat 3 replaces controls with the consent row |
| Consent row | final beat | native-appearance checkbox (checked state = Primary), two inline legal links opening `#/legal` overlay (bundled full text, scroll-to-end tracked), Agree & Start primary button disabled until: both docs scrolled to end AND checkbox ticked |
| Chrome | none | no AppBar back, no TabBar; paper canvas + `global_bg_light` visible in-collage |

Copy owner: beats copy aligns with 功能文档 voice (verbs first, drill loop in one breath). Legal checkbox label: “I agree to the User Agreement and the Privacy Agreement”.

### Scene Brief

- `Pattern:` **carousel** — three paged beats (page-scrub horizontal swipe + progress scribbles), final beat is the consent gate (not a fourth marketing slide).
- `Beats:` **B1 “Two Frames, One Word”** — collage of two taped polaroids (a giant pumpkin vs a tiny pumpkin style montage, LEFT/RIGHT labels), headline “Shoot both sides of a word”, support: “Dualoo deals you an antonym pair — you prove each side with a photo.” · **B2 “Wind the Drill Ring”** — ring dial sketch with one filled segment + knob, headline “One draw, two frames, one minute”, support: “Wind the ring every day; fill all seven segments to keep your streak.” · **B3 consent “Rate the Opposites”** — dual-rail sketch with gold medal + consent row, headline “Score the contrast, keep the wins”, consent controls per Slots table; Continue is the only forward exit.
- `Hero craft:` **SVG/illustration** (hand-drawn scribble arrows, tape strips, polaroid outlines, ring dial sketch — inline SVG per beat) + **motion** (beat change = paper-flip spring; knob idle “wind me” wobble hint on B2; medal bob on B3) + **domain motif** (two-halves polaroid pair, the product's signature visual).
- `Headline voice:` playful concept-coach for young people who drill concepts with a camera — short verb-led English lines (“Shoot both sides of a word”), grounded in coreScene 抽反义词对分拍归档; zero slogan walls, zero marketing adjectives, one idea per beat.
- `Motif + color arc:` paper canvas `#FEF2F2` + ink `#450A0A` outlines throughout; arc runs ink-on-paper (B1 collage) → Primary red `#DC2626` energy (B2 ring + knob) → Accent gold `#A16207` reward cue on B3 medal, with the Agree & Start button in Primary. Polaroid motif and the 7-dot ring glyph carry over into #/ring and #/strip pages later.

## Anti-checks

- No slogan wall; every beat has a visible, discoverable control (swipe scrubs, Next works, consent checkbox toggles visibly).
- Consent row never hidden below fold at 390×844 — it is the final beat's content.
- Legal links open the bundled overlay (`#/legal` stacked over welcome) — never a new tab, never main-WebView navigation.
- 48px targets including the two legal link hit areas; checkbox keeps native appearance inside its hand-drawn square outline.
