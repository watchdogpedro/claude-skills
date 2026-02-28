---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces that are clearly human-crafted. Uses 2025-2026 anti-AI design research — named aesthetics, specific typography, OKLCH color systems, texture techniques, and layout-breaking patterns. Never produces the AI slop fingerprint (purple, Inter, 3 cards, rounded-xl everywhere).
license: Complete terms in LICENSE.txt
---

This skill builds production-grade frontend interfaces that look unmistakably human-designed. It applies documented 2025-2026 anti-AI design research to every decision.

The AI slop problem has a root cause: statistical averaging. When AI generates design, it reproduces the median of every Tailwind tutorial in its training data. That median is purple, Inter font, three rounded cards, and a centered hero. This skill exists to break that pattern at every level.

---

## Before Writing a Single Line of Code

Answer these in sequence. Do not skip.

**1. What aesthetic direction?**
Name it in five words or fewer. Pick from documented movements or invent a hybrid:
- Neo-Brutalism (hard borders, black/white, one accent, stark)
- Editorial/Magazine (serif domination, asymmetric columns, type as visual)
- Analog Anarchy (grain, collage, photocopy texture, zine energy)
- Collage/Scrapbook (stickers, tape, layers, asymmetric, Gen Z)
- Tech Spec/Utilitarian (monospace, strict grid, industrial precision)
- Obsidian (deep black, gloss/matte contrast, restraint)
- Acid Fade (high-chroma prismatic, deliberately loud)
- Retro-Software (terminal, ASCII, monospace, system colors)

**2. What makes it unforgettable?**
Identify the one element a user will remember. It could be the type choice, a layout break, a texture, an animation, or a color. Name it before coding it.

**3. Who is the audience?**
This determines which aesthetic is appropriate — an engineering audience reads Tech Spec as credible, a Gen Z audience reads Collage as authentic. Match the aesthetic to the audience.

---

## The AI Slop Checklist — Hard Stops

**Run this check before shipping anything.** If 5+ apply, rebuild:

- [ ] Primary color is purple or indigo (`#6366f1` vicinity) — FAIL
- [ ] Inter or Roboto is the heading font — FAIL
- [ ] Three equal-width columns with icon + heading + description — FAIL
- [ ] `rounded-xl` or `rounded-2xl` on cards, buttons, and images — FAIL
- [ ] White-only or near-white-only background — FAIL
- [ ] Gradient as the primary visual interest — FAIL
- [ ] Centered hero with one headline, one subhead, one CTA — FAIL
- [ ] Zero texture, grain, or material quality on surfaces — FAIL
- [ ] Animations are only fades and scale-on-hover — FAIL
- [ ] Gradient text on hero headline — FAIL
- [ ] Glassmorphism with no design reason — FAIL
- [ ] Testimonial section with circular avatars and star ratings — FAIL

---

## Typography

**This is the single highest-leverage decision.** Font choice signals human intent faster than any other element.

**Heading/Display fonts — each chosen for character:**

| Font | Character | Best For |
|------|-----------|----------|
| Fraunces | Old Style serif, manneristic, editorial warmth | Magazine, luxury, editorial |
| Bricolage Grotesque | Variable, French-British blend, vintage personality | Modern brand, expressive |
| Syne | Atypical weights, futuristic edge | Creative, design-forward |
| Clash Display | Geometric, strong personality | Bold tech, startup |
| Bebas Neue | Condensed, industrial, impact | Industrial, poster-style |
| Playfair Display | Classic serif, authoritative | Professional, editorial |
| Krona One | Scandinavian retro poster | Brand, distinctive |
| Special Gothic Expanded One | Industrial, near-brutalist | Heavy, impactful |
| DM Serif Display | Quiet distinction, refined | Luxury, understated |

**Body font pairings:**
- Fraunces → DM Sans or Source Sans 3
- Clash Display → Manrope
- Bebas Neue → Lato or Source Sans 3
- Bricolage Grotesque → Inter (Inter acceptable as body, never heading)
- Playfair Display → Source Sans 3 or Nunito Sans

**Typography rules:**
- Type as architectural element — scale contrast between display and body
- Tight tracking on display (`tracking-tight` to `tracking-tighter`)
- Variable font axes: use width and optical size, not just weight
- Oversized headlines that function as visual objects, not just text
- Never Inter as a heading font

---

## Color — Build From Scratch

**Never use Tailwind color defaults without overriding the entire system.**

System to follow:
```css
/* Define tokens first, before any component */
:root {
  --color-brand: oklch(45% 0.2 250);   /* Not indigo */
  --color-accent: oklch(65% 0.3 60);   /* Sharp, not safe */
  --surface: oklch(15% 0.02 250);      /* Deep, not white */
  --surface-alt: oklch(20% 0.02 250);
  --text: oklch(95% 0.01 250);
}
```

**OKLCH advantages over hex/HSL:**
- Perceptually uniform (equal lightness steps look equal)
- Better palette generation (use oklch.fyi or atmos.style)
- Accessible contrast easier to calculate

**Strong palette directions:**
- `#000` + `#fff` + one electric accent (neo-brutalism)
- Deep black + single jewel tone (Obsidian)
- High-saturation prismatic — push the chroma (Acid Fade)
- Warm mineral/bronze + cream (craft signal, anti-digital)
- Red + off-white + black (editorial power)

**Avoid:**
- Any indigo/purple as primary
- Muted "tech startup blue" secondaries
- Four evenly distributed safe colors that express nothing

---

## Layout — Break the Expected Structure

AI defaults to: three equal columns, centered hero, uniform section spacing, predictable order.

**Techniques that signal human judgment:**

**Asymmetric dominance:** One element takes 65-70% of horizontal space, the rest share the remainder. Never equal splits.

**Diagonal cuts:** `clip-path: polygon(0 0, 100% 0, 100% 90%, 0 100%)` between sections. Breaks the horizontal line.

**Overlap:** Hero image bleeds into the next section. Cards overlap their container. Type sits on top of imagery.

**Scale contrast:** Some elements deliberately huge, others deliberately small. Not everything at medium.

**Scrapbook composition:** Elements at slight rotations (`transform: rotate(-1.5deg)`), layered, sticker-style components, asymmetric placement.

**Grid-breaking:** One element per page that ignores the grid entirely — bleeds to edge, overlaps columns, ignores alignment.

---

## Texture and Depth

AI generates zero texture. This is one of the clearest human signals.

**Implementation techniques:**

CSS grain overlay:
```css
.grain {
  position: relative;
}
.grain::after {
  content: '';
  position: absolute;
  inset: 0;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.4'/%3E%3C/svg%3E");
  opacity: 0.08;
  pointer-events: none;
}
```

Other texture approaches:
- `background-blend-mode: multiply` on paper texture images
- SVG `feTurbulence` filter for organic noise
- Hard box shadows with no blur (`box-shadow: 4px 4px 0 #000`)
- Visible borders as structural elements, not decoration
- Rough/torn edge effects on image containers

---

## Animation

**AI defaults:** Fade in. Scale on hover. Predictable.

**Human signals:**
- Staggered entrance with deliberate `animation-delay` per element
- Hover states that change the character of an element, not just its scale
- Scroll-triggered position or shape changes
- One choreographed page load sequence — not scattered micro-interactions
- Deliberate stillness on some elements as counterpoint
- Cursor-reactive elements (where appropriate)

**Motion library for React:** Use `framer-motion` for complex sequences. CSS-only for simple effects.

---

## Implementation

Write working code that:
- Has a clear aesthetic direction evident in the first glance
- Uses design tokens (CSS variables) before any component
- Applies typography choices consistently throughout
- Has at least one texture or material quality element
- Breaks the grid in at least one intentional place
- Has interactions that surprise at least once

Match implementation complexity to aesthetic vision. Neo-brutalism is deceptively simple in code but requires nerve in choices. Maximalism needs elaborate CSS. Restraint (Obsidian, Tech Spec) needs precision in spacing.

---

## Self-Review Before Delivering

1. Run the AI Slop Checklist — must score 0 failures
2. Can you state the aesthetic direction in five words?
3. Is there a font choice that required a deliberate decision?
4. Does something break the expected grid?
5. Is there texture, grain, or depth on any surface?
6. Would this be at home on Awwwards?
7. Is there one element only a human with taste would have chosen?

If any answer is wrong, do not deliver. Go bolder.
