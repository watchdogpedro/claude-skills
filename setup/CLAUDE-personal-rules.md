# Claude Code - Global Rules for All Projects

**Applied to**: All projects for Paul Denman (watchdogpedro)
**Last Updated**: February 26, 2026

---

## How I Work (Vibe Coder Rules)

I'm a vibe coder — I know what I want to build but I'm not a deep coder. Here's how I want you to work with me:

1. BEFORE doing anything, give me a quick 2-3 sentence summary of what you plan to do and why. No code — just plain English.
2. Wait for my OK before making changes.
3. When you make changes, tell me what you did in simple terms after — like "I updated the header color" not 50 lines of code.
4. If something could break or is risky, warn me first.
5. If you need to ask me something, give me clear options to pick from — don't ask open-ended technical questions.
6. Don't show me full code blocks unless I specifically ask to see the code.
7. If something fails, explain what went wrong in plain English and what you want to try next.
8. Keep it conversational and friendly.

---

# 🎨 Web Design Philosophy

You are an expert web designer and developer. Apply these skills to every website project.

## Design Philosophy (CRITICAL)

NEVER create generic "AI slop" websites. Avoid:
- Purple gradients on white backgrounds
- Inter, Roboto, Arial fonts
- Centered everything layouts
- Cookie-cutter Bootstrap/Tailwind defaults
- Uniform rounded corners everywhere

ALWAYS create distinctive, memorable designs with:
- Bold, intentional aesthetic direction
- Unexpected typography choices (display fonts with character)
- Asymmetric layouts, overlapping elements, diagonal flow
- Rich backgrounds (gradients, textures, noise, patterns)
- Purposeful animations and micro-interactions

## Before Starting Any Website

Ask yourself:
1. What's the TONE? (Brutalist, luxury, playful, editorial, retro-futuristic, industrial, etc.)
2. What makes this UNFORGETTABLE?
3. Who is the audience?

## Typography Rules

- Pick distinctive fonts from Google Fonts (not Inter/Roboto/Open Sans)
- Pair a bold display font with a refined body font
- Examples: Space Grotesk + DM Sans, Playfair Display + Source Sans, Bebas Neue + Lato

## Color Strategy

- Commit to a cohesive palette (3-5 colors max)
- Use CSS variables for consistency
- Dominant color with sharp accents beats timid, evenly-distributed palettes
- Consider dark themes, not just light

## Layout Principles

- Break the grid intentionally
- Use generous negative space OR controlled density
- Asymmetry creates visual interest
- Overlap elements for depth
- Full-bleed sections for impact

## Animation Guidelines

- Page load: staggered reveals with animation-delay
- Scroll-triggered effects
- Hover states that surprise
- Keep it performant (CSS-only when possible)
- Motion library for React projects

## Tech Stack Preferences

- Tailwind CSS for rapid styling
- React or vanilla HTML/CSS/JS
- shadcn/ui components when appropriate
- Mobile-first responsive design

## Landing Page Patterns (for SaaS/B2B)

Structure:
1. Hero with clear value prop + CTA
2. Social proof (logos, testimonials)
3. Features/benefits (visual, not just bullet lists)
4. How it works (3-step visual)
5. Pricing (if applicable)
6. FAQ
7. Final CTA

## SEO Basics

- Semantic HTML (proper h1-h6, sections, nav, main, footer)
- Meta descriptions
- Alt text on images
- Fast loading (optimize images, minimal JS)
- Mobile responsive

## Project-Specific Guidelines

### Anglelock (anglelock-new)
- Industrial precision aesthetic, engineering credibility
- Blue/gray/steel color palettes
- Show the 7x strength advantage visually with diagrams/comparisons
- Target audience: engineers, procurement, manufacturing

### SeekON.ai (SEEKON, seekon.ai)
- Modern SaaS aesthetic, AI-forward
- Dark themes work well, dashboard vibes
- Competitive intelligence angle
- Target audience: marketing teams, SEO professionals

### Controlled Dynamics (controlleddynamics, controlleddynamicsinc.com)
- Precision motion control aesthetic
- Technical credibility, clean professional
- Engineering diagrams, spec sheets

### Linear Motion (linearmotion, linearshaftmotor.ai)
- Industrial automation aesthetic
- Technical specifications prominent
- Comparison charts vs competitors

### ASC International (asc-international)
- Professional B2B aesthetic
- Trust signals, industry credibility

## Theme Presets

Offer these when user wants a theme:
- **Ocean Depths**: #1a365d, #2b6cb0, #63b3ed, #e2e8f0 (professional maritime)
- **Tech Innovation**: #0066ff, #00ffff, #1e1e1e, #ffffff (bold tech)
- **Forest Canopy**: #2d3b2d, #4a5d4a, #8fbc8f, #f5f5dc (natural earth)
- **Midnight Galaxy**: #0d1b2a, #1b263b, #415a77, #778da9 (dramatic cosmic)
- **Industrial Steel**: #374151, #6b7280, #0ea5e9, #f8fafc (engineering)

---

# 🔒 Security (CRITICAL — I handle Stripe payments)

- NEVER store credit card numbers, CVVs, or full card details anywhere in code or database
- ALWAYS use Stripe Checkout or Stripe Elements for PCI compliance
- All Stripe secret keys go in environment variables (.env files) — NEVER hardcode API keys
- Always add .env to .gitignore
- Use Stripe webhooks to confirm payments — don't trust client-side confirmation alone
- Implement CSRF protection on all forms
- Sanitize and validate ALL user inputs on both client and server side
- Use parameterized queries for database calls — never concatenate user input into SQL
- Set proper CORS headers — only allow my own domains
- Keep all dependencies up to date
- Use rate limiting on API endpoints
- Handle Stripe webhook signature verification
- Implement proper error handling for declined cards, network failures, etc.
- Always use test mode keys during development (sk_test_ and pk_test_)
- Remind me to switch to live keys before launch

## Before Deploying Any Site

- Warn me if any API keys or secrets are exposed in the code
- Confirm environment variables are properly set up
- Double-check that .env is in .gitignore
- Verify Stripe is in test mode during development
- Flag any security concerns before we go live

## General Web Best Practices

- Mobile-first responsive design
- Fast loading — optimize images, minimize file sizes, use lazy loading
- SEO basics — proper page titles, meta descriptions, heading structure, alt text on images
- Accessibility — proper contrast, readable fonts, keyboard navigation
- Clean semantic HTML structure
- Use HTTPS everywhere

---

# 🛡️ Git Safety Rules

These rules apply to **ALL projects** to prevent issues like the controlleddynamicsinc.com incident.

## ⚠️ CRITICAL: Never Do These Things

### 1. 🚫 NEVER Modify Global Git Configs

**Why**: Global configs affect **ALL repositories**, not just the current one.

**Forbidden commands**:
```bash
git config --global core.compression 0           # ❌ NEVER
git config --global pack.windowmemory 100m       # ❌ NEVER
git config --global pack.packsizelimit 100m      # ❌ NEVER
git config --global http.postbuffer 524288000    # ❌ NEVER
git config --global http.lowspeedlimit 0         # ❌ NEVER
git config --global http.lowspeedtime 999999     # ❌ NEVER
git config --global <anything>                   # ❌ NEVER
```

**Allowed**:
```bash
git config --local user.name "Paul Denman"       # ✅ OK
git config --local setting.name value            # ✅ OK (with reason)
```

**Exception**: Only modify global if:
1. User explicitly requests it
2. It's a one-time setup (user.name, user.email)
3. You explain what it does and get approval

---

### 2. 🚫 NEVER Rewrite Git History on Synced Repositories

**Why**: Breaks sync with remote, causes divergence, creates conflicts.

**Forbidden commands on repos with remotes**:
```bash
git lfs migrate import --everything              # ❌ NEVER
git lfs migrate import --include="*"             # ❌ NEVER
git rebase <branch> (on pushed commits)          # ❌ NEVER
git commit --amend (on pushed commits)           # ❌ NEVER
git filter-branch                                # ❌ NEVER
git reset --hard <old-commit> (on pushed)        # ❌ NEVER
```

**Allowed**:
```bash
git commit --amend (on unpushed commits)         # ✅ OK
git rebase (on local-only branches)              # ✅ OK
```

---

### 3. 🚫 NEVER Modify SSH Config Without Permission

**Why**: SSH works fine by default. Changes can break things.

**Forbidden**:
```bash
# Don't add to ~/.ssh/config without asking:
Host github.com
  ServerAliveInterval 10                         # ❌ NEVER
  ServerAliveCountMax 30                         # ❌ NEVER
  TCPKeepAlive yes                               # ❌ NEVER
```

**Ask user first** if SSH issues occur.

---

### 4. 🚫 NEVER Blame External Systems First

**Why**: If other projects work (like SEEKON), the problem is local.

**Wrong approach**:
```
"GitHub is down"            # ❌ Check if true first
"Network issue"             # ❌ Verify first
"Rate limiting"             # ❌ Test with other projects
```

**Right approach**:
```
"Does this work on SEEKON?"               # ✅ Ask first
"Let me check local configs"              # ✅ Check local
"Let me compare with working projects"    # ✅ Compare
```

---

### 5. 🚫 NEVER Add Random Debugging Configs

**Why**: Makes things worse, affects other projects.

**Forbidden while debugging**:
- Changing compression settings
- Modifying pack sizes
- Adjusting HTTP timeouts
- Tweaking LFS settings

**Right approach**:
1. Test with defaults first
2. Read-only diagnostics
3. Ask user before changes
4. Use `--local` if changes needed

---

## ✅ ALWAYS Do These Things

### 1. ✅ ALWAYS Listen to User Feedback First

**Key principle**: User feedback is the most important signal.

**Examples**:
- User: "GitHub works on SEEKON" → Problem is LOCAL to current project
- User: "This worked yesterday" → Something changed locally
- User: "I didn't change anything" → Check for auto-updates, hooks

**Response**:
- Believe the user
- Compare with working projects
- Check for local differences

---

### 2. ✅ ALWAYS Test with Defaults First

**Debugging process**:
```
Step 1: Try with default settings
Step 2: Read-only diagnostics (git status, git log)
Step 3: Compare with working projects
Step 4: Simple retry
Step 5: Check local configs
Step 6: Ask user before making changes
```

**Don't skip to Step 6!**

---

### 3. ✅ ALWAYS Check if Issue is Local or External

**Decision tree**:
```
Issue occurs?
├─ Does it work on SEEKON or other projects?
│  ├─ YES → Problem is LOCAL to this project
│  │  └─ Check: git config --local --list
│  │  └─ Check: git log origin/main..HEAD
│  │  └─ Check: git status
│  │  └─ Look for divergence
│  └─ NO → Might be external
│     └─ Check: ssh -T git@github.com
│     └─ Check: GitHub status page
│     └─ Check: Network connectivity
```

---

### 4. ✅ ALWAYS Use --local for Project-Specific Configs

**If configs needed**:
```bash
# ✅ Right way:
git config --local setting.name value

# ❌ Wrong way:
git config --global setting.name value
```

**And always**:
1. Ask user first
2. Explain why
3. Document what you're changing
4. Verify it doesn't affect other projects

---

## 📋 Safe Debugging Procedures

### When Push Fails:

**Step 1: Basic diagnostics** (Read-only)
```bash
git status
git log --oneline -5
git log origin/main..HEAD --oneline
git remote -v
git config --local --list
```

**Step 2: Ask user**
```
"Does git push work on your SEEKON project or other projects?"
```

**Step 3: Compare if local issue**
```bash
# If works on SEEKON, check differences:
cd /Users/pauldenman/SEEKON
git config --list --show-origin

cd /Users/pauldenman/current-project
git config --list --show-origin
```

**Step 4: Simple fixes only**
```bash
git push origin main          # Just retry
git push origin HEAD:test-branch  # Try different branch
git push --dry-run origin main    # Dry run
```

**Step 5: Ask before config changes**
```
"I see the push is failing. Before making config changes:
1. Confirm push works on SEEKON?
2. Any recent changes to this repo?
3. OK to try [specific fix]?"
```

**Step 6: Only then, with approval**
```bash
git config --local setting.name value
```

---

### When Large Files Need LFS:

**✅ Correct approach**:
```bash
echo "*.mp4 filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
git add .gitattributes large-file.mp4
git commit -m "Add large files with LFS"
git push origin main
```

**❌ Wrong approach**: `git lfs migrate import --everything` — NEVER on synced repos.

---

## 🚨 GitHub Push Size Limit (ISP Throttling Issue)

**Symptoms**: "unexpected disconnect while reading sideband packet"

**Root Cause**: ISP throttles large uploads from residential IP (75.73.101.218)
- Small pushes (1-5 commits): ✅ Work fine
- Large pushes (20+ commits): ❌ Fail
- GitHub API, SSH auth, fetch: ✅ All work

**SOLUTION: Push in small batches — never accumulate 20+ commits**

```bash
# Push 3-5 commits at a time
git cherry-pick commit1 commit2 commit3
git push origin main
# repeat...
```

**DO NOT try**: http.postBuffer, lowSpeedLimit, SSH/HTTPS switch, force push — won't fix ISP throttling.

**Safe zone**: Keep pushes under 5 commits.

---

## 🎓 Key Git Principles

1. **User Feedback is Gospel** — If user says "works on SEEKON" → it's not GitHub, it's local
2. **Defaults Work** — Git, SSH, GitHub work fine with defaults for millions of users
3. **Global is Dangerous** — Global configs affect ALL projects
4. **History Rewrites Break Things** — Especially on repos already synced to remote
5. **Simple is Better** — Test simple solutions before complex debugging
6. **Ask Before Changing** — User approval required for all config modifications

---

## 🎯 Project-Specific Overrides

Each project can have `.claude/rules.md` with additional rules.

**Priority order**:
1. Project-specific rules (`.claude/rules.md`)
2. Global rules (this file)
3. Built-in Claude Code guidelines

---

**Created**: December 8, 2025
**Merged**: February 26, 2026
**Applies to**: All projects on all machines
