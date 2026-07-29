# Page — Drill Ring Hub (`#/ring`, **Tab 1 root**)

Role: the T8_reminder_ring home surface (see 功能文档 Tab Navigation + Interaction Topology). This is the dial-first hub: a rolling 7-day Drill Ring that mediates the daily drill loop, owns the Wind-Up Draw signature interaction (Primary Workflow step 4), and hosts resume/streak state. It is NOT a list home, NOT a dashboard — the ring is the content.

## Regions (canonical)

| Region | Content contract |
|--------|------------------|
| Greeting bar | time-of-day greeting + current streak flame (Accent gold) + best-streak whisper (Muted Foreground) |
| Ring dial hero | hand-drawn SVG dial Ø≈240px centred upper-mid; 7 arc segments D-6…D0 with state grammar (pending=dashed Muted, in-progress=Secondary half-fill, done=Primary solid, missed=broken muted outline); gold vault dot on done+vaulted segments; today segment pulses with Primary ring |
| Wind-Up Draw knob | post-it knob (~96×96) glued at dial centre with detent ticks; press + clockwise drag ≥180° + release = draw (the ONLY draw trigger per 功能文档 signature); idle “wind me” hint arc + chevron scribbles until first draw |
| Today card | white post-it card (−1deg, tape strip) beneath the dial: pending → pair hint + free-draw counter (BR-02 chip “3 free today”); active session → pair labels + status line + Resume affordance (BR-03); done → grade + vault dot + “Make the strip” shortcut |
| Weekly footnote | “4/7 this week · avg 78” style stat line from Metrics; taps nothing (whisper only) |
| TabBar | fixed bottom 4 tabs (Ring active wobbled underlined) |
| Chrome | paper AppBar with wordmark; no back button; `global_bg_light` faint behind the dial |

Empty-skeleton contract (first run / no week data): dial renders as dashed ghost segments + ghost today card with “wind me” scribble; streak shows em dash-flame `—`; greeting still personal-time aware. Never a blank page.

### Scene Brief

- `Primary zone:` **Drill Ring dial (T8 topology-bound)** occupying the upper ~55–60% of the viewport — the rolling 7-segment ring + centre Wind-Up Draw knob; state grammar per MASTER §3 (pending/in-progress/done/missed + gold vault dot + today pulse). **Empty skeleton:** dashed ghost segments + ghost today card with “wind me” hint (no blank hero, no generic “No data”).
- `Greeting:` audience-grounded, rotates with local time — morning “Morning eyes — spot both sides today?”, afternoon “Lunch break duel? Two frames, one word.”, evening “Late light still counts — wind today's ring.”; whisper line references the streak in drill-coach voice (“3-day streak — protect it”), grounded in 喜欢用拍照练概念的年轻人.
- `Entry CTA:` **ring-centre Wind-Up Draw knob = the primary CTA** — press, wind ≥180°, release to open the Primary Workflow draw (PW step 4 / signature interaction); secondary entries: today-card **Resume** chip when an unfinished session exists (BR-03), and “Make the strip” shortcut once done (opens Export flow); Vault tab is one tap away, never a competing hero.
- `Motif + color arc:` dial-centric composition deliberately distinct from Welcome's collage storyboard — circular hero vs paged collage; paper canvas + ink outlines with segment fills carrying the state→color grammar (muted dashes → secondary half-fill → primary solid → gold vault dot), gold reserved for reward marks (streak flame, vault dots); the wobbly post-it today card provides the paper motif that later reappears on capture slots and the strip page.

## Anti-checks

- No tag/chip list, no KPI tiles, no recent-carousel on this home (T8 hard rule + english topology contract).
- Wind-Up Draw knob is discoverable without onboarding text walls: idle hint arc animates until the first draw; target ≥48px; gesture wheel is unrotated so drag math is clean.
- All four state colors present in-story even before visits: ghost/real segments strictly follow the §3 grammar tokens (no invented state colors).
- Today card copy must stay short (no slogan blocks); the resume state names the actual pair from the domain store.
