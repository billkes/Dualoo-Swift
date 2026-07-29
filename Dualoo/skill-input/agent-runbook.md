# Agent runbook

- App: **Dualoo**
- Pack: `h5_swift_shell`
- Generated: `2026-07-29T22:17:44+08:00`

Review snapshots filled after lock.dimensions. Runtime Agent steps re-fill prompts before each call.

| # | step | prompt | prerequisites | deliverables |
|---|------|--------|---------------|--------------|
| 1 | `agent.plan.spec` | `skill-input/agent-prompts/01-agent.plan.spec.md` | prepare.context done; lock.dimensions done; sync.distilled done; skill-input/visual/*.csv（单行） | 功能文档.md; Dualoo Privacy Agreement.md; Dualoo User Agreement.md |
| 2 | `agent.design` | `skill-input/agent-prompts/02-agent.design.md` | agent.plan.spec done; 功能文档.md; skill-input/visual/style.csv · colors.csv · typography.csv · meta.json | design-system/*/MASTER.md (+ stacks/briefs · Scene Briefs); skill-adapt/* · design-audit.md |
| 3 | `agent.plan.pack` | `skill-input/agent-prompts/03-agent.plan.pack.md` | agent.design done; 功能文档.md; skill-adapt/design-audit.md | 本包登记信息.json; 本包视觉锁.json |
| 4 | `agent.assets` | `skill-input/agent-prompts/04-agent.assets.md` | agent.plan.pack done; 本包视觉锁.json; image_prompts.json（流水线写入；真图=1 时 GenerateImage 替换） | shell rasters (浅): logo · launch_light · global_bg_light · retry; image_prompts.json (replaced) |
| 5 | `agent.html` | `skill-input/agent-prompts/05-agent.html.md` | agent.assets done（真图=0 时流水线跳过，用 tokens/CSS）; agent.design done; 功能文档.md Screen Inventory; design-system · skill-adapt · 本包视觉锁.json | _preview/pages/*.html（Inventory 全量）; APPROVAL.md（全 PASS）· FREEZE.md · _shots/; vendor/（本地 Tailwind + fonts，随 snippet 复制） |
| 6 | `agent.shell` | `skill-input/agent-prompts/06-agent.shell.md` | agent.html done; 本包登记信息.json; 本包视觉锁.json | native / Flutter shell + Bridge; SHELL-APPROVAL.md（自审限次全 PASS） |
| 7 | `agent.h5` | `skill-input/agent-prompts/07-agent.h5.md` | agent.html done（流水线不硬验 APPROVAL；以 Agent 自审为准）; agent.shell done | h5/ 忠实移植冻结 HTML; FLOW-APPROVAL.md（本包功能文档业务流程）; Vitest 快测绿 |

## Files

- `skill-input/agent-runbook.json` — machine-readable order
- `skill-input/agent-prompts/0N-<step>.md` — filled prompts (exactly 7)
- `网页Agent续跑手册.md` — web Agent resume (written at sync.distilled)
