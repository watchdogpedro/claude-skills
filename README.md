# Claude Code Skills

Custom skills for Claude Code by Paul Denman (@watchdogpedro)

## New Machine Setup (One Command)

Install everything — `claude-go`, personal rules, PATH config:

```bash
curl -fsSL https://raw.githubusercontent.com/watchdogpedro/claude-skills/main/setup/install.sh | bash
```

**Prerequisites** (install these first if not present):
- Claude Code CLI: https://claude.ai/code
- GitHub CLI: `brew install gh` then `gh auth login`

That's it. Run `claude-go` and everything loads from GitHub automatically.

---

## How It Works

`claude-go` is a wrapper script that:
1. Pulls every skill file fresh from this GitHub repo
2. Injects them all into `~/.claude/CLAUDE.md`
3. Launches Claude Code with everything loaded

Skills are always up to date — no manual syncing needed.

---

## Skills Included

### Design & Frontend
- **distinctive-design** — Anti-AI interface design. The documented AI slop fingerprint as hard stops. Named aesthetics (Neo-Brutalism, Editorial, Analog Anarchy, Collage, Tech Spec, Obsidian, Acid Fade). Specific fonts, OKLCH color, texture techniques.
- **frontend-design** — Production-grade frontend with 2025-2026 anti-AI research baked in. AI slop checklist, layout-breaking patterns, texture/grain, OKLCH color systems.
- **web-design-expert** — Auto-invokes on all website work. Named aesthetics, approved font list, AI fingerprint checklist, project-specific rules for Anglelock, SeekON, Controlled Dynamics, ASC.
- **frontend-development** — React, Next.js, TypeScript, Tailwind best practices
- **webapp-testing** — Playwright testing patterns

### Development
- **test-driven-development** — TDD workflow (Red-Green-Refactor)

### n8n Workflow Automation
- **n8n-code-javascript** — JavaScript in n8n Code nodes
- **n8n-code-python** — Python in n8n Code nodes
- **n8n-expression-syntax** — n8n expression syntax and fixes
- **n8n-mcp-tools-expert** — Using n8n-mcp MCP tools
- **n8n-node-configuration** — Operation-aware node config
- **n8n-validation-expert** — Validation errors and fixes
- **n8n-workflow-patterns** — Proven workflow architecture patterns

---

## Updating Skills

Edit any `SKILL.md` file, commit and push. Every `claude-go` run picks up changes automatically — no action needed on any machine.

```bash
cd ~/.claude/skills
# edit a skill...
git add .
git commit -m "Update skill"
git push
```

---

## Repository Structure

```
setup/
  install.sh              ← One-command new machine setup
  claude-go               ← The launcher script
  CLAUDE-personal-rules.md ← Personal rules (base for CLAUDE.md)

distinctive-design/SKILL.md
frontend-design/SKILL.md
web-design-expert.md
frontend-development.md
test-driven-development.md
webapp-testing.md
n8n-*/SKILL.md
```

---

**Author**: Paul Denman (@watchdogpedro)
**Last Updated**: February 2026
