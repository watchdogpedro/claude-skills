---
name: web-design-expert
description: Expert web designer and developer - automatically applies anti-AI design principles grounded in 2025-2026 research. Named aesthetics, specific fonts, OKLCH color, texture, grid-breaking layouts. Auto-activates on all website work.
autoInvoke: true
triggers:
  - website
  - web design
  - landing page
  - homepage
  - web app
  - frontend
  - UI design
  - tailwind
  - react site
  - component
  - design
  - UI
  - page
  - layout
  - interface
  - build me
  - create a
---

# Web Design Expert Mode — ACTIVE

2026 design research is clear: AI-generated design has a specific, documented visual fingerprint. Your job is to produce work that is unmistakably human-crafted.

---

## The AI Slop Fingerprint — Never Use These

The root cause: Tailwind CSS's demo default (`bg-indigo-500`) trained into every AI system via thousands of GitHub tutorials. The result is always the same website.

**Hard stops — avoid every single one:**
- Purple or indigo as the primary color (`#6366f1` / `bg-indigo-500`)
- Inter or Roboto as the heading font
- Three equal-width feature columns with icon + heading + description
- `rounded-xl` or `rounded-2xl` on every card, button, and image
- White-only background with no texture or depth
- Gradient as the main visual interest
- Centered hero: 1 headline, 1 subhead, 1 CTA — nothing else
- Gradient text on hero headlines
- Glassmorphism (`backdrop-blur`) without purpose
- Testimonials with circular avatars and star ratings
- Zero texture or grain on any surface
- Fade-in animations only

---

## Before Starting ANY Website — 3 Questions

1. **What's the aesthetic?** Name it (see options below)
2. **What's unforgettable?** The one thing they'll remember
3. **Who's the audience?** Match aesthetic to reader

---

## Named Aesthetics — Pick One

These are the documented 2025-2026 anti-AI design movements. Each one is a hard commit, not a suggestion:

| Aesthetic | Character | When to Use |
|-----------|-----------|-------------|
| **Neo-Brutalism** | Hard black borders, offset shadows, stark, honest | Engineering, fintech, direct brands |
| **Editorial** | Serif dominance, asymmetric columns, type-as-visual | Professional, authoritative, B2B |
| **Analog Anarchy** | Grain, photocopy texture, zine, collage | Creative, cultural, Gen Z |
| **Collage/Scrapbook** | Stickers, tape, layers, asymmetric | Youth brand, lifestyle, consumer |
| **Tech Spec** | Monospace, strict grid, industrial precision | Engineering, SaaS, technical |
| **Obsidian** | Deep black, gloss/matte contrast, luxury restraint | Premium, luxury, creative agency |
| **Acid Fade** | High-saturation prismatic, deliberately loud | Youth, music, fashion, bold brand |
| **Retro-Software** | Terminal, ASCII, system colors, monospace | Developer tools, hacker aesthetic |

---

## Typography — Decide First

Font is the fastest signal of human intent. Choose before anything else.

**Approved heading fonts (each has genuine character):**
- `Fraunces` — Editorial serif, manneristic warmth. Not Inter.
- `Bricolage Grotesque` — Variable font, vintage personality, 3-axis flexibility
- `Syne` — Futuristic edge, atypical weight associations
- `Clash Display` — Geometric, strong personality
- `Bebas Neue` — Condensed, industrial, demands attention
- `Playfair Display` — Classic editorial authority
- `Krona One` — Scandinavian retro poster type
- `Special Gothic Expanded One` — Industrial, near-brutalist
- `DM Serif Display` — Quiet distinction, refined

**Pairing examples:**
- Fraunces + DM Sans (editorial warm)
- Clash Display + Manrope (bold modern)
- Bebas Neue + Source Sans 3 (industrial clean)
- Bricolage Grotesque + Inter (variable + neutral body)
- Playfair Display + Lato (classic authority)

**Rules:**
- Inter is acceptable as body text only — never as heading
- Tight tracking on display text (`tracking-tight` to `tracking-tighter`)
- Type at large scale as a visual object, not just words

---

## Color — Build a Custom System

Never rely on Tailwind color defaults. Define tokens first:

```css
:root {
  --color-brand: /* Not indigo. Decide deliberately. */;
  --color-accent: /* One sharp accent. Commit to it. */;
  --surface: /* Not white-only. Could be deep, warm, textured. */;
  --text: /* High contrast against surface. */;
}
```

**Use OKLCH** for perceptually uniform palettes. Tools: oklch.fyi, atmos.style

**Strong directions:**
- Black + white + one electric accent (Neo-Brutalism)
- Deep black + jewel tone (Obsidian)
- Warm mineral/bronze + cream (craft signal)
- High-chroma prismatic (Acid Fade)
- Red + off-white + black (editorial power)

---

## Layout — Break the Expected Grid

AI: Three equal columns. Centered. Uniform spacing.
Human: Asymmetric, overlapping, scale contrast, grid-breaking.

**Techniques:**
- One element dominates 65% of horizontal space — never equal thirds
- Diagonal section breaks: `clip-path: polygon(0 0, 100% 0, 100% 90%, 0 100%)`
- Elements that cross section boundaries or overlap
- Scale contrast: some elements huge, some tiny — no "medium everything"
- One element per page that deliberately ignores the grid

---

## Texture and Depth

AI generates zero texture. Adding it is one of the clearest human signals.

Every project should have at least one:
- Paper grain background or noise overlay
- Hard box shadow with no blur (`box-shadow: 4px 4px 0 #000`)
- Visible structural borders
- Brushstroke, ink-bleed, or collage element
- Film grain on hero imagery

---

## Animation

AI: Subtle fade. Scale on hover. That's it.
Human: Staggered entrance with deliberate timing, hover states that surprise, scroll-triggered shape changes, one choreographed sequence.

---

## Project-Specific Aesthetics

### Anglelock
- **Aesthetic:** Tech Spec / Neo-Brutalism hybrid
- Industrial precision, engineering credibility
- Blue-gray-steel palette (not indigo — go cooler/metallic)
- Show 7x strength advantage with diagrams that feel like specs

### SeekON.ai
- **Aesthetic:** Obsidian or Tech Spec
- Dark first. Dashboard intelligence vibe.
- Avoid the typical SaaS purple — go darker, more editorial

### Controlled Dynamics / Linear Motion
- **Aesthetic:** Tech Spec
- Engineering diagrams, monospace data, precision layouts
- Spec sheet aesthetic — functional beauty

### ASC International
- **Aesthetic:** Editorial
- Trust through authority, not decoration
- Serif headings, professional column layouts

---

## EXECUTION CHECKLIST

For every website project:
- [ ] Named aesthetic chosen (one of the 8 above or named hybrid)
- [ ] AI Slop Fingerprint check — must score zero
- [ ] Heading font chosen from approved list (never Inter as heading)
- [ ] Color tokens defined with CSS variables before any component
- [ ] One grid break planned
- [ ] Texture or grain on at least one surface
- [ ] One animation that surprises
- [ ] Mobile-first responsive
- [ ] Semantic HTML for SEO
- [ ] Self-review: "Would this be mistaken for a Webflow template?" — must be NO

---

## The 2026 Standard

Canva's official 2026 trend report is titled "Imperfect by Design." The design industry has declared this the defining tension of the year: human marks vs. algorithmic smoothness. Fabricio Teixeira (UX Collective, Work & Co): "AI assists but cannot replace human judgment and taste."

The premium for demonstrably human-crafted work is documented at 10-50x over AI-generated alternatives. Design that looks human is increasingly valuable, not just aesthetically — economically.

Make something that could only exist because a person with taste decided it should.
