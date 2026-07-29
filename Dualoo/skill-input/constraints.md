# Batch Hard Constraints (non-negotiable)

- Fully offline — no login, cloud sync, or external API.
- Respect `.cursor/rules/*.mdc` iron rules.
- H5 shell: vault + Bridge contract; legal kit + deflavor rules apply.
- 功能文档.md MUST meet 《H5壳功能文档深度标准.md》 (businessDepthTier in context.json).
- Interaction topology in context.json — do NOT default to chip→list→detail→export.

Design decisions: organize from `skill-input/visual/` single-row CSVs (style=shape/motion only; colors.csv=palette; typography.csv=fonts; meta.skinMode=浅|深|深浅) into `design-system/` — do not invent a parallel UI canon or re-query the host skill.
