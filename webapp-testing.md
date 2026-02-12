---
name: webapp-testing
description: Test local web applications using Playwright for frontend verification, UI debugging, and screenshot capture
autoInvoke: true
triggers:
  - playwright
  - browser testing
  - e2e test
  - integration test
  - web app test
  - website
  - web app
  - react
  - landing page
  - test website
---

# Web Application Testing with Playwright

Test local and remote web applications using Playwright for verifying frontend functionality, debugging UI behavior, and capturing screenshots.

## Quick Start

### Installation

**Node.js/JavaScript:**
```bash
npm install -D @playwright/test
npx playwright install
```

**Python:**
```bash
pip install playwright
playwright install
```

## Core Testing Patterns

### Pattern 1: Navigate and Verify
```javascript
// JavaScript/TypeScript
import { test, expect } from '@playwright/test';

test('homepage loads correctly', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await expect(page).toHaveTitle(/My App/);
  await expect(page.locator('h1')).toContainText('Welcome');
});
```

```python
# Python
from playwright.sync_api import Page, expect

def test_homepage(page: Page):
    page.goto('http://localhost:3000')
    expect(page).to_have_title(re.compile(r'My App'))
    expect(page.locator('h1')).to_contain_text('Welcome')
```

### Pattern 2: User Interactions
```javascript
test('user can submit form', async ({ page }) => {
  await page.goto('http://localhost:3000/contact');

  // Fill form
  await page.fill('input[name="name"]', 'John Doe');
  await page.fill('input[name="email"]', 'john@example.com');
  await page.fill('textarea[name="message"]', 'Hello!');

  // Submit and wait for navigation
  await page.click('button[type="submit"]');

  // Verify success
  await expect(page.locator('.success-message')).toBeVisible();
});
```

### Pattern 3: Wait for Dynamic Content
```javascript
test('dynamic content loads', async ({ page }) => {
  await page.goto('http://localhost:3000/dashboard');

  // Wait for network to be idle (critical for SPAs)
  await page.waitForLoadState('networkidle');

  // Or wait for specific element
  await page.waitForSelector('.data-loaded');

  // Verify content
  const items = await page.locator('.item').count();
  expect(items).toBeGreaterThan(0);
});
```

## Selector Strategies (Best to Worst)

### 1. User-Facing Attributes (BEST)
```javascript
// By role (accessibility)
page.getByRole('button', { name: 'Submit' });
page.getByRole('textbox', { name: 'Email' });
page.getByRole('heading', { level: 1 });

// By label text
page.getByLabel('Email address');

// By text content
page.getByText('Welcome back');

// By test ID
page.getByTestId('user-profile');
```

### 2. CSS Selectors (OK)
```javascript
page.locator('button.primary');
page.locator('#submit-button');
page.locator('input[type="email"]');
```

### 3. XPath (AVOID - brittle)
```javascript
page.locator('xpath=//button[@class="submit"]');
```

## Testing Different Application Types

### Static HTML Sites
```javascript
test('static site content', async ({ page }) => {
  // Can read directly from file system
  await page.goto('file:///path/to/index.html');
  await expect(page.locator('h1')).toContainText('Hello');
});
```

### Single Page Applications (React, Vue, Svelte)
```javascript
test('SPA navigation', async ({ page }) => {
  await page.goto('http://localhost:3000');

  // CRITICAL: Wait for network idle on SPAs
  await page.waitForLoadState('networkidle');

  // Click link (client-side navigation)
  await page.click('a[href="/about"]');

  // Wait for route change
  await page.waitForURL('**/about');
  await expect(page.locator('h1')).toContainText('About');
});
```

### Server-Rendered Apps (Next.js, Remix, etc.)
```javascript
test('server-rendered page', async ({ page }) => {
  // Content available on first load
  await page.goto('http://localhost:3000/blog/post-1');

  // Can verify immediately (no need for networkidle)
  await expect(page.locator('article h1')).toBeVisible();
});
```

## Screenshot & Debugging

### Capture Screenshots
```javascript
test('capture homepage', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await page.screenshot({ path: 'homepage.png', fullPage: true });
});

// Capture element only
test('capture specific element', async ({ page }) => {
  await page.goto('http://localhost:3000');
  const element = page.locator('.hero-section');
  await element.screenshot({ path: 'hero.png' });
});
```

### Video Recording
```javascript
// In playwright.config.js
export default {
  use: {
    video: 'on-first-retry', // or 'on', 'off', 'retain-on-failure'
  },
};
```

### Browser Console Logs
```javascript
test('capture console logs', async ({ page }) => {
  const logs = [];
  page.on('console', msg => logs.push(msg.text()));

  await page.goto('http://localhost:3000');

  console.log('Browser logs:', logs);
});
```

### Network Inspection
```javascript
test('monitor API calls', async ({ page }) => {
  const apiCalls = [];

  page.on('request', request => {
    if (request.url().includes('/api/')) {
      apiCalls.push(request.url());
    }
  });

  await page.goto('http://localhost:3000/dashboard');
  await page.waitForLoadState('networkidle');

  expect(apiCalls).toContain('http://localhost:3000/api/users');
});
```

## Advanced Patterns

### Mocking API Responses
```javascript
test('mock API response', async ({ page }) => {
  // Intercept and mock API call
  await page.route('**/api/users', route => {
    route.fulfill({
      status: 200,
      body: JSON.stringify([
        { id: 1, name: 'John' },
        { id: 2, name: 'Jane' }
      ])
    });
  });

  await page.goto('http://localhost:3000/users');
  await expect(page.locator('.user-item')).toHaveCount(2);
});
```

### Authentication Testing
```javascript
test.describe('authenticated tests', () => {
  test.beforeEach(async ({ page }) => {
    // Login before each test
    await page.goto('http://localhost:3000/login');
    await page.fill('input[name="email"]', 'test@example.com');
    await page.fill('input[name="password"]', 'password123');
    await page.click('button[type="submit"]');
    await page.waitForURL('**/dashboard');
  });

  test('user can view dashboard', async ({ page }) => {
    await expect(page.locator('.dashboard')).toBeVisible();
  });
});

// Or use storage state to skip repeated logins
test.use({ storageState: 'auth.json' });
```

### Testing Mobile Viewports
```javascript
test('mobile view', async ({ page }) => {
  // Set mobile viewport
  await page.setViewportSize({ width: 375, height: 667 });
  await page.goto('http://localhost:3000');

  // Verify mobile menu
  await expect(page.locator('.mobile-menu')).toBeVisible();
});

// Or use device emulation
import { devices } from '@playwright/test';

test.use(devices['iPhone 13']);
```

### Parallel Testing
```javascript
// playwright.config.js
export default {
  workers: 4, // Run 4 tests in parallel
  fullyParallel: true,
};
```

### Testing Accessibility
```javascript
import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test('should not have accessibility violations', async ({ page }) => {
  await page.goto('http://localhost:3000');

  const accessibilityScanResults = await new AxeBuilder({ page })
    .analyze();

  expect(accessibilityScanResults.violations).toEqual([]);
});
```

## Configuration Best Practices

### playwright.config.js
```javascript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI, // Fail if test.only in CI
  retries: process.env.CI ? 2 : 0, // Retry on CI
  workers: process.env.CI ? 1 : undefined,

  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry', // Collect trace on retry
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },

  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'webkit', use: { ...devices['Desktop Safari'] } },
    { name: 'mobile', use: { ...devices['iPhone 13'] } },
  ],

  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

## Common Testing Workflows

### Testing Form Validation
```javascript
test('form validation', async ({ page }) => {
  await page.goto('http://localhost:3000/signup');

  // Try to submit empty form
  await page.click('button[type="submit"]');

  // Verify error messages
  await expect(page.locator('.error-email')).toContainText('Email is required');
  await expect(page.locator('.error-password')).toContainText('Password is required');

  // Fill with invalid email
  await page.fill('input[name="email"]', 'invalid-email');
  await page.click('button[type="submit"]');
  await expect(page.locator('.error-email')).toContainText('Invalid email');
});
```

### Testing File Uploads
```javascript
test('file upload', async ({ page }) => {
  await page.goto('http://localhost:3000/upload');

  // Upload file
  const fileInput = page.locator('input[type="file"]');
  await fileInput.setInputFiles('path/to/test-file.pdf');

  await page.click('button[type="submit"]');
  await expect(page.locator('.success')).toContainText('File uploaded');
});
```

### Testing Infinite Scroll
```javascript
test('infinite scroll', async ({ page }) => {
  await page.goto('http://localhost:3000/feed');

  const initialItems = await page.locator('.item').count();

  // Scroll to bottom
  await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));

  // Wait for new items to load
  await page.waitForFunction(
    count => document.querySelectorAll('.item').length > count,
    initialItems
  );

  const newItems = await page.locator('.item').count();
  expect(newItems).toBeGreaterThan(initialItems);
});
```

## Debugging Tips

### Run with UI Mode
```bash
npx playwright test --ui
```

### Debug Specific Test
```bash
npx playwright test --debug
```

### Slow Down Execution
```javascript
test('slow motion', async ({ page }) => {
  await page.goto('http://localhost:3000', { waitUntil: 'networkidle' });
  // In config: use: { launchOptions: { slowMo: 1000 } }
});
```

### Pause Execution
```javascript
test('debug at specific point', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await page.pause(); // Opens inspector
  await page.click('button');
});
```

## Test Organization

```
tests/
├── e2e/
│   ├── auth.spec.js         # Authentication flows
│   ├── checkout.spec.js     # Checkout process
│   └── navigation.spec.js   # Navigation tests
├── integration/
│   ├── forms.spec.js        # Form interactions
│   └── api.spec.js          # API integration
└── visual/
    └── screenshots.spec.js  # Visual regression
```

## Checklist for Web App Testing

- [ ] Test on multiple browsers (Chrome, Firefox, Safari)
- [ ] Test mobile viewports
- [ ] Wait for `networkidle` on dynamic apps
- [ ] Use user-facing selectors (role, label, text)
- [ ] Mock external APIs for consistent tests
- [ ] Capture screenshots on failure
- [ ] Test authentication flows
- [ ] Test form validation
- [ ] Test error states
- [ ] Check accessibility
- [ ] Monitor console errors
- [ ] Test loading states

## Resources

- **Docs**: https://playwright.dev
- **Best Practices**: https://playwright.dev/docs/best-practices
- **Selectors**: https://playwright.dev/docs/locators
- **Debugging**: https://playwright.dev/docs/debug

---

**Remember**: Always wait for `networkidle` on dynamic content before inspecting the DOM.
