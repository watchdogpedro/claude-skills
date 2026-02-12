---
name: frontend-development
description: Modern frontend development with React, Next.js, TypeScript, and Tailwind CSS - component scaffolding, performance optimization, and UI best practices
autoInvoke: true
triggers:
  - react
  - next.js
  - nextjs
  - typescript
  - tailwind
  - component
  - frontend
  - shadcn
---

# Modern Frontend Development

Expert-level frontend development using React, Next.js, TypeScript, and Tailwind CSS with focus on performance, accessibility, and maintainable code.

## Stack Overview

- **React 18+** - Component library with Server Components
- **Next.js 14+** - React framework with App Router
- **TypeScript** - Type safety
- **Tailwind CSS** - Utility-first styling
- **shadcn/ui** - Accessible component primitives

## Project Structure (Next.js App Router)

```
app/
├── layout.tsx          # Root layout
├── page.tsx            # Homepage
├── globals.css         # Global styles
├── (auth)/             # Route group
│   ├── login/
│   │   └── page.tsx
│   └── signup/
│       └── page.tsx
└── dashboard/
    ├── layout.tsx      # Nested layout
    └── page.tsx

components/
├── ui/                 # shadcn/ui components
│   ├── button.tsx
│   ├── input.tsx
│   └── card.tsx
├── features/           # Feature-specific components
│   ├── auth/
│   └── dashboard/
└── shared/             # Reusable components
    ├── navbar.tsx
    └── footer.tsx

lib/
├── utils.ts            # Utility functions
├── api.ts              # API client
└── hooks/              # Custom hooks
    ├── use-auth.ts
    └── use-debounce.ts

types/
└── index.ts            # TypeScript types

public/
└── images/

```

## Component Patterns

### Server Component (Default in Next.js App Router)
```typescript
// app/dashboard/page.tsx
import { getUser } from '@/lib/api';

export default async function DashboardPage() {
  // Fetch data directly in Server Component
  const user = await getUser();

  return (
    <div className="container mx-auto py-8">
      <h1 className="text-3xl font-bold">Welcome, {user.name}</h1>
    </div>
  );
}
```

### Client Component (Interactive)
```typescript
// components/counter.tsx
'use client';

import { useState } from 'react';
import { Button } from '@/components/ui/button';

export function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div className="flex items-center gap-4">
      <Button onClick={() => setCount(count - 1)}>-</Button>
      <span className="text-2xl font-mono">{count}</span>
      <Button onClick={() => setCount(count + 1)}>+</Button>
    </div>
  );
}
```

### Reusable Component with Props
```typescript
// components/ui/card.tsx
import { cn } from '@/lib/utils';

interface CardProps {
  title: string;
  description?: string;
  children: React.ReactNode;
  className?: string;
}

export function Card({ title, description, children, className }: CardProps) {
  return (
    <div className={cn('rounded-lg border bg-card p-6 shadow-sm', className)}>
      <h3 className="text-xl font-semibold">{title}</h3>
      {description && (
        <p className="mt-2 text-sm text-muted-foreground">{description}</p>
      )}
      <div className="mt-4">{children}</div>
    </div>
  );
}
```

### Form Component with Validation
```typescript
// components/contact-form.tsx
'use client';

import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';

const formSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Invalid email address'),
  message: z.string().min(10, 'Message must be at least 10 characters'),
});

type FormData = z.infer<typeof formSchema>;

export function ContactForm() {
  const [isSubmitting, setIsSubmitting] = useState(false);

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<FormData>({
    resolver: zodResolver(formSchema),
  });

  const onSubmit = async (data: FormData) => {
    setIsSubmitting(true);
    try {
      const response = await fetch('/api/contact', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      });

      if (!response.ok) throw new Error('Failed to submit');
      alert('Message sent!');
    } catch (error) {
      alert('Failed to send message');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
      <div>
        <Input {...register('name')} placeholder="Your name" />
        {errors.name && (
          <p className="mt-1 text-sm text-red-500">{errors.name.message}</p>
        )}
      </div>

      <div>
        <Input {...register('email')} type="email" placeholder="Your email" />
        {errors.email && (
          <p className="mt-1 text-sm text-red-500">{errors.email.message}</p>
        )}
      </div>

      <div>
        <textarea
          {...register('message')}
          className="w-full rounded-md border px-3 py-2"
          rows={4}
          placeholder="Your message"
        />
        {errors.message && (
          <p className="mt-1 text-sm text-red-500">{errors.message.message}</p>
        )}
      </div>

      <Button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Sending...' : 'Send Message'}
      </Button>
    </form>
  );
}
```

## Custom Hooks

### useDebounce
```typescript
// lib/hooks/use-debounce.ts
import { useEffect, useState } from 'react';

export function useDebounce<T>(value: T, delay: number = 500): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value);

  useEffect(() => {
    const timer = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(timer);
  }, [value, delay]);

  return debouncedValue;
}
```

### useLocalStorage
```typescript
// lib/hooks/use-local-storage.ts
import { useState, useEffect } from 'react';

export function useLocalStorage<T>(key: string, initialValue: T) {
  const [value, setValue] = useState<T>(() => {
    if (typeof window === 'undefined') return initialValue;

    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch {
      return initialValue;
    }
  });

  useEffect(() => {
    window.localStorage.setItem(key, JSON.stringify(value));
  }, [key, value]);

  return [value, setValue] as const;
}
```

### useMediaQuery
```typescript
// lib/hooks/use-media-query.ts
import { useEffect, useState } from 'react';

export function useMediaQuery(query: string): boolean {
  const [matches, setMatches] = useState(false);

  useEffect(() => {
    const media = window.matchMedia(query);
    setMatches(media.matches);

    const listener = (e: MediaQueryListEvent) => setMatches(e.matches);
    media.addEventListener('change', listener);
    return () => media.removeEventListener('change', listener);
  }, [query]);

  return matches;
}

// Usage:
// const isMobile = useMediaQuery('(max-width: 768px)');
```

## API Routes (Next.js)

### REST API Endpoint
```typescript
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';

const userSchema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
});

export async function GET() {
  const users = await db.user.findMany();
  return NextResponse.json(users);
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const validated = userSchema.parse(body);

    const user = await db.user.create({ data: validated });
    return NextResponse.json(user, { status: 201 });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json({ error: error.errors }, { status: 400 });
    }
    return NextResponse.json({ error: 'Internal error' }, { status: 500 });
  }
}
```

### Dynamic API Route
```typescript
// app/api/users/[id]/route.ts
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  const user = await db.user.findUnique({ where: { id: params.id } });

  if (!user) {
    return NextResponse.json({ error: 'User not found' }, { status: 404 });
  }

  return NextResponse.json(user);
}
```

## Performance Optimization

### Code Splitting with Dynamic Imports
```typescript
// app/page.tsx
import dynamic from 'next/dynamic';

// Component loaded only when needed
const HeavyChart = dynamic(() => import('@/components/heavy-chart'), {
  loading: () => <div>Loading chart...</div>,
  ssr: false, // Skip SSR if not needed
});

export default function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      <HeavyChart data={data} />
    </div>
  );
}
```

### Image Optimization
```typescript
import Image from 'next/image';

export function Hero() {
  return (
    <div className="relative h-96">
      <Image
        src="/hero.jpg"
        alt="Hero image"
        fill
        priority // Load immediately (LCP optimization)
        className="object-cover"
      />
    </div>
  );
}
```

### Suspense and Streaming
```typescript
// app/dashboard/page.tsx
import { Suspense } from 'react';

async function UserData() {
  const user = await getUser(); // Slow API call
  return <div>{user.name}</div>;
}

export default function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      <Suspense fallback={<div>Loading user...</div>}>
        <UserData />
      </Suspense>
    </div>
  );
}
```

### Memoization
```typescript
'use client';

import { useMemo, useCallback } from 'react';

export function ExpensiveComponent({ data }: { data: number[] }) {
  // Memoize expensive calculation
  const sortedData = useMemo(() => {
    return [...data].sort((a, b) => a - b);
  }, [data]);

  // Memoize callback to prevent re-renders
  const handleClick = useCallback(() => {
    console.log('Clicked');
  }, []);

  return <div onClick={handleClick}>{sortedData[0]}</div>;
}
```

## Styling with Tailwind CSS

### Responsive Design
```typescript
<div className="
  grid
  grid-cols-1        // Mobile: 1 column
  md:grid-cols-2     // Tablet: 2 columns
  lg:grid-cols-3     // Desktop: 3 columns
  gap-4              // Gap between items
">
  {items.map(item => <Card key={item.id} {...item} />)}
</div>
```

### Dark Mode
```typescript
// tailwind.config.js
module.exports = {
  darkMode: 'class', // or 'media'
  // ...
};

// Component
<div className="bg-white dark:bg-slate-900 text-black dark:text-white">
  <h1 className="text-2xl">Hello</h1>
</div>
```

### Custom Utilities with @apply
```css
/* app/globals.css */
@layer components {
  .btn-primary {
    @apply rounded-lg bg-blue-600 px-4 py-2 font-semibold text-white transition hover:bg-blue-700;
  }
}
```

### cn() Utility for Conditional Classes
```typescript
// lib/utils.ts
import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

// Usage:
<Button className={cn('base-styles', isActive && 'active-styles')} />
```

## State Management

### Local State (useState)
```typescript
const [count, setCount] = useState(0);
```

### Context API (Global State)
```typescript
// context/auth-context.tsx
'use client';

import { createContext, useContext, useState } from 'react';

interface AuthContextType {
  user: User | null;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);

  const login = async (email: string, password: string) => {
    const response = await fetch('/api/auth/login', {
      method: 'POST',
      body: JSON.stringify({ email, password }),
    });
    const user = await response.json();
    setUser(user);
  };

  const logout = () => setUser(null);

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used within AuthProvider');
  return context;
}
```

### Zustand (Lightweight State Management)
```typescript
// lib/store.ts
import { create } from 'zustand';

interface CartState {
  items: CartItem[];
  addItem: (item: CartItem) => void;
  removeItem: (id: string) => void;
  clearCart: () => void;
}

export const useCartStore = create<CartState>((set) => ({
  items: [],
  addItem: (item) => set((state) => ({ items: [...state.items, item] })),
  removeItem: (id) => set((state) => ({
    items: state.items.filter((item) => item.id !== id),
  })),
  clearCart: () => set({ items: [] }),
}));
```

## TypeScript Best Practices

### Type-Safe Props
```typescript
interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
}

export function Button({ variant = 'primary', size = 'md', ...props }: ButtonProps) {
  return <button {...props} className={getButtonClasses(variant, size)} />;
}
```

### Generic Components
```typescript
interface ListProps<T> {
  items: T[];
  renderItem: (item: T) => React.ReactNode;
}

export function List<T>({ items, renderItem }: ListProps<T>) {
  return <ul>{items.map(renderItem)}</ul>;
}

// Usage:
<List items={users} renderItem={(user) => <li>{user.name}</li>} />
```

### Type Inference
```typescript
// Instead of:
const users: User[] = await fetchUsers();

// Let TypeScript infer:
const users = await fetchUsers(); // TypeScript infers User[]
```

## Accessibility

### Semantic HTML
```typescript
<nav aria-label="Main navigation">
  <ul>
    <li><a href="/">Home</a></li>
  </ul>
</nav>

<main>
  <h1>Page Title</h1>
  <article>...</article>
</main>
```

### ARIA Attributes
```typescript
<button
  aria-label="Close dialog"
  aria-expanded={isOpen}
  onClick={handleClose}
>
  <XIcon />
</button>
```

### Focus Management
```typescript
'use client';

import { useEffect, useRef } from 'react';

export function Modal({ isOpen, onClose }: ModalProps) {
  const closeButtonRef = useRef<HTMLButtonElement>(null);

  useEffect(() => {
    if (isOpen) {
      closeButtonRef.current?.focus();
    }
  }, [isOpen]);

  return (
    <dialog open={isOpen}>
      <button ref={closeButtonRef} onClick={onClose}>Close</button>
      {/* content */}
    </dialog>
  );
}
```

## Testing

### Component Test (React Testing Library)
```typescript
import { render, screen, fireEvent } from '@testing-library/react';
import { Counter } from './counter';

describe('Counter', () => {
  it('increments count when button clicked', () => {
    render(<Counter />);

    const button = screen.getByRole('button', { name: /increment/i });
    fireEvent.click(button);

    expect(screen.getByText('1')).toBeInTheDocument();
  });
});
```

## Environment Variables

```typescript
// .env.local
NEXT_PUBLIC_API_URL=https://api.example.com
DATABASE_URL=postgres://...

// Usage:
const apiUrl = process.env.NEXT_PUBLIC_API_URL; // Client-side
const dbUrl = process.env.DATABASE_URL; // Server-side only
```

## Deployment Checklist

- [ ] TypeScript types are valid (`npm run type-check`)
- [ ] No console errors or warnings
- [ ] Build succeeds (`npm run build`)
- [ ] Environment variables configured
- [ ] Images optimized
- [ ] Meta tags and SEO configured
- [ ] Accessibility tested (keyboard navigation, screen reader)
- [ ] Mobile responsive
- [ ] Performance: Core Web Vitals passing
- [ ] Error boundaries implemented
- [ ] Loading states for async operations

## Common Patterns

### Error Boundary
```typescript
// components/error-boundary.tsx
'use client';

import { useEffect } from 'react';

export default function Error({
  error,
  reset,
}: {
  error: Error;
  reset: () => void;
}) {
  useEffect(() => {
    console.error(error);
  }, [error]);

  return (
    <div className="flex min-h-screen flex-col items-center justify-center">
      <h2 className="text-2xl font-bold">Something went wrong!</h2>
      <button onClick={reset} className="mt-4 btn-primary">
        Try again
      </button>
    </div>
  );
}
```

### Loading State
```typescript
// app/dashboard/loading.tsx
export default function Loading() {
  return (
    <div className="flex items-center justify-center min-h-screen">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600" />
    </div>
  );
}
```

## Resources

- **Next.js Docs**: https://nextjs.org/docs
- **React Docs**: https://react.dev
- **Tailwind CSS**: https://tailwindcss.com
- **shadcn/ui**: https://ui.shadcn.com
- **TypeScript**: https://www.typescriptlang.org

---

**Remember**: Server Components by default, Client Components only when needed (interactivity, hooks, browser APIs).
