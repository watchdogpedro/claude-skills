---
name: motion-design
description: Add motion, scroll choreography, and micro-interactions to web interfaces using the right tool for the job — CSS scroll-driven animations, Motion (the React library, formerly Framer Motion), GSAP + ScrollTrigger, and Lenis smooth scroll. Use when building animated heroes, scroll-triggered reveals, parallax, page transitions, kinetic typography, or hover micro-interactions. Motion that means something — never decorative fades for their own sake.
---

# Motion Design — Animation & Scroll Choreography

Motion is communication, not decoration. In 2026, award-winning sites treat every transition, hover, and scroll movement as something with emotional meaning. This skill picks the *right* tool for each effect and implements it with a performance and accessibility budget baked in.

The default failure mode of AI-generated motion is: fade-in everything, scale-on-hover, nothing else. Avoid that. Choreograph deliberately.

---

## STEP 1 — Pick the Right Tool (Decision Matrix)

Do not reach for a JS library by reflex. CSS handles ~80% of UI animation in 2026 at zero bundle cost.

| You need… | Use | Why |
|-----------|-----|-----|
| Hover, focus, simple state transitions | **Plain CSS** (`transition`, `@keyframes`) | Zero JS, GPU-accelerated, native |
| Scroll-linked reveal / parallax, no JS | **CSS scroll-driven animations** (`animation-timeline: scroll()` / `view()`) | Native, runs off main thread, zero bundle |
| React/Next.js component animation, gestures, layout | **Motion** (`motion` package) | ~8KB, React-first, `layout` animations, fastest-growing lib (33M+ weekly downloads) |
| Complex timeline sequencing, SVG morph, scroll choreography with runtime control | **GSAP + ScrollTrigger** | Best-in-class timelines, framework-agnostic, now 100% free |
| Buttery momentum / smooth scrolling | **Lenis** | Smooth scroll without breaking `position: sticky` or scroll-driven CSS |

**Rules of thumb:**
- Start with CSS. Escalate to a library only when CSS can't express it.
- All your sites are Next.js → **Motion** is the default JS choice for component-level work.
- Reach for **GSAP** when you need a *sequenced timeline* or *scroll-scrubbed* choreography (e.g. pin a section and animate through it).
- Add **Lenis** only when you want momentum scrolling — pair it with GSAP ScrollTrigger or CSS scroll timelines.
- Never load two scroll libraries. Never load GSAP just for a fade.

---

## STEP 2 — Patterns by Tool

### A. Plain CSS — micro-interactions (use first)

```css
.btn {
  transition: transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1), background 0.2s ease;
}
.btn:hover { transform: translateY(-2px); }
.btn:active { transform: translateY(0) scale(0.98); }
```

Use a real easing curve (custom `cubic-bezier`), never the default `ease`. Surprise on hover — shift, reveal, color-wash — not just scale.

### B. CSS scroll-driven animations — reveals & parallax, zero JS

Native in all modern browsers. Runs off the main thread, so it never jank-stutters.

```css
/* Reveal each element as it enters the viewport */
@keyframes reveal {
  from { opacity: 0; transform: translateY(40px); }
  to   { opacity: 1; transform: translateY(0); }
}
.reveal {
  animation: reveal linear both;
  animation-timeline: view();          /* tied to element's own viewport crossing */
  animation-range: entry 0% cover 35%; /* start as it enters, finish 35% in */
}

/* Parallax background tied to page scroll */
@keyframes drift { to { transform: translateY(-15%); } }
.parallax-bg {
  animation: drift linear both;
  animation-timeline: scroll(root block);
}
```

Add a fallback for browsers without support:
```css
@supports not (animation-timeline: view()) {
  .reveal { opacity: 1; transform: none; } /* show content, skip the animation */
}
```

### C. Motion (React / Next.js) — the default for components

Install: `npm i motion`. Import from `motion/react`. Client component only (`'use client'`).

```tsx
'use client';
import { motion } from 'motion/react';

// Staggered entrance — deliberate timing, not all-at-once
const container = {
  hidden: {},
  show: { transition: { staggerChildren: 0.08, delayChildren: 0.1 } },
};
const item = {
  hidden: { opacity: 0, y: 24 },
  show:   { opacity: 1, y: 0, transition: { duration: 0.5, ease: [0.22, 1, 0.36, 1] } },
};

export function Reveal({ children }: { children: React.ReactNode }) {
  return (
    <motion.div variants={container} initial="hidden"
      whileInView="show" viewport={{ once: true, margin: '-80px' }}>
      {React.Children.map(children, (c) => <motion.div variants={item}>{c}</motion.div>)}
    </motion.div>
  );
}
```

Key Motion features worth using: `whileInView` (scroll reveal), `layout` (auto-animate layout changes), `whileHover`/`whileTap` (gestures), `useScroll` + `useTransform` (scroll-linked values), `AnimatePresence` (exit animations).

Scroll-linked value example:
```tsx
const { scrollYProgress } = useScroll({ target: ref, offset: ['start end', 'end start'] });
const y = useTransform(scrollYProgress, [0, 1], ['0%', '-30%']);
return <motion.div ref={ref} style={{ y }} />;
```

### D. GSAP + ScrollTrigger — timelines & scrubbed choreography

Install: `npm i gsap`. Use for anything CSS/Motion can't sequence cleanly.

```tsx
'use client';
import { useRef, useEffect } from 'react';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
gsap.registerPlugin(ScrollTrigger);

export function PinnedScene() {
  const root = useRef<HTMLDivElement>(null);
  useEffect(() => {
    const ctx = gsap.context(() => {
      const tl = gsap.timeline({
        scrollTrigger: {
          trigger: '.scene', start: 'top top', end: '+=150%',
          scrub: 1, pin: true,           // pin section, scrub timeline to scroll
        },
      });
      tl.from('.headline', { yPercent: 40, opacity: 0 })
        .from('.subline',  { yPercent: 60, opacity: 0 }, '<0.1')
        .to('.art',        { scale: 1.15, rotate: 4 }, 0);
    }, root);
    return () => ctx.revert(); // cleanup on unmount — critical in React
  }, []);
  return <div ref={root}><section className="scene">…</section></div>;
}
```

Always use `gsap.context()` + `ctx.revert()` in React so triggers clean up.

### E. Lenis — smooth momentum scroll

Install: `npm i lenis`. Drive GSAP's ticker so ScrollTrigger stays in sync.

```tsx
'use client';
import { useEffect } from 'react';
import Lenis from 'lenis';

export function SmoothScroll() {
  useEffect(() => {
    const lenis = new Lenis({ lerp: 0.1, smoothWheel: true });
    const raf = (t: number) => { lenis.raf(t); requestAnimationFrame(raf); };
    requestAnimationFrame(raf);
    return () => lenis.destroy();
  }, []);
  return null;
}
```

Don't combine Lenis with `scroll-behavior: smooth` in CSS — they fight.

---

## STEP 3 — Performance Budget (non-negotiable)

Motion is the #1 way to wreck Core Web Vitals. Research flags 3D/WebGL and heavy scroll JS as the biggest offenders.

- **Animate only `transform` and `opacity`.** Never animate `width`, `height`, `top`, `left`, `margin` (they trigger layout/paint every frame).
- Add `will-change: transform` sparingly, only on elements actively animating; remove it after.
- Prefer **CSS scroll-driven animations** over JS scroll listeners — they run off the main thread.
- Lazy-load GSAP/Three.js with dynamic import; never ship them on routes that don't animate.
- Keep hero animations under ~500ms total entrance; scrubbed scenes should feel responsive, not sluggish.
- Test on a throttled mid-tier device, not just your machine. If FPS drops below 60, cut the effect.

---

## STEP 4 — Accessibility (always)

Respect users who get motion sickness. This is required, not optional.

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

In Motion (React), gate animations:
```tsx
import { useReducedMotion } from 'motion/react';
const reduce = useReducedMotion();
<motion.div animate={reduce ? {} : { y: 0, opacity: 1 }} />
```

Never tie essential content visibility *only* to a scroll animation — if it fails or is reduced, the content must still be readable.

---

## STEP 5 — Choreograph, Don't Decorate (anti-slop)

Pairs with the `distinctive-design` / `frontend-design` skills. AI motion is generic; human motion has intent.

- **One choreographed sequence** beats ten scattered micro-fades. Design a single deliberate page-load or scroll moment.
- **Stagger with purpose** — vary `delay` per element so the eye is led, not bombarded.
- **Hover states that change character**, not just scale: reveal a detail, wash a color, shift layout.
- **Kinetic typography** earns its place on the hero only — oversized variable-font headlines that stretch/animate on scroll. Don't animate body text.
- **Deliberate stillness** is a tool. Some elements should not move, as counterpoint.
- Match motion to the named aesthetic: Neo-Brutalism = snappy/instant, Editorial = slow/refined, Acid Fade = bold/elastic.

---

## Self-Review Checklist

- [ ] Used the lightest tool that does the job (CSS before JS)?
- [ ] Only `transform`/`opacity` animated?
- [ ] `prefers-reduced-motion` handled?
- [ ] GSAP/Lenis cleaned up on unmount (no leaks)?
- [ ] Heavy libs dynamically imported, not global?
- [ ] One deliberate choreographed moment, not random fades everywhere?
- [ ] Tested at 60fps on a throttled device?
- [ ] Content still readable if animation is disabled?

If any answer is wrong, fix it before shipping.
