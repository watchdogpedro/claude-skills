# Claude Code Skills

Custom skills for Claude Code by Paul Denman (@watchdogpedro)

## What This Is

This repository contains my custom Claude Code skills that extend Claude's capabilities with specialized prompts and workflows.

## Skills Included

### Design & Frontend
- **distinctive-design** - Expert UI/UX designer creating human-crafted, anti-AI interfaces with neo-brutalist aesthetics. Avoids purple gradients and generic AI startup looks.
- **frontend-design** - Create distinctive, production-grade frontend interfaces with high design quality.
- **web-design-expert.md** - Web design expertise and patterns
- **frontend-development.md** - Frontend development best practices

### Development & Testing
- **test-driven-development.md** - TDD workflows and best practices
- **webapp-testing.md** - Web application testing strategies

### n8n Workflow Automation
- **n8n-code-javascript** - Write JavaScript code in n8n Code nodes
- **n8n-code-python** - Write Python code in n8n Code nodes
- **n8n-expression-syntax** - Validate n8n expression syntax
- **n8n-mcp-tools-expert** - Expert guide for using n8n-mcp MCP tools
- **n8n-node-configuration** - Operation-aware node configuration guidance
- **n8n-validation-expert** - Interpret validation errors and guide fixing
- **n8n-workflow-patterns** - Proven workflow architectural patterns

## Installation

### First Time Setup
```bash
# Clone this repo to your Claude skills directory
git clone https://github.com/watchdogpedro/claude-skills.git ~/.claude/skills
```

### Updating Skills on Other Machines
```bash
# Pull latest skills
cd ~/.claude/skills
git pull
```

### Adding Your Own Skills
```bash
# Create new skill directory
mkdir -p ~/.claude/skills/my-skill

# Create SKILL.md file
cat > ~/.claude/skills/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: What this skill does
---

[Your skill content here]
EOF

# Commit and push
cd ~/.claude/skills
git add .
git commit -m "Add my-skill"
git push
```

## Usage

Skills can be invoked in Claude Code with:
```
/skill-name
```

Examples:
- `/distinctive-design` - Start anti-AI design session
- `/frontend-design` - Create production-grade UI
- `/n8n-workflow-patterns` - Get n8n workflow guidance

## Syncing Across Machines

When you make changes on one machine:
```bash
cd ~/.claude/skills
git add .
git commit -m "Update skills"
git push
```

On other machines:
```bash
cd ~/.claude/skills
git pull
```

## Structure

Skills are either:
1. **Directory-based**: `skill-name/SKILL.md` with YAML frontmatter
2. **Standalone**: `skill-name.md` markdown files

Both formats work with Claude Code.

---

**Last Updated**: February 11, 2026
**Author**: Paul Denman
**Repository**: https://github.com/watchdogpedro/claude-skills
