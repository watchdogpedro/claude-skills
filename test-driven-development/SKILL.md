---
name: test-driven-development
description: Test-Driven Development (TDD) workflow - write tests first, then implementation
autoInvoke: true
triggers:
  - TDD
  - test first
  - write test
  - unit test
  - website
  - web app
  - react
  - component
  - feature
  - bug fix
---

# Test-Driven Development (TDD) Skill

## Core Principle: RED-GREEN-REFACTOR

Always follow this cycle:
1. **RED** - Write a failing test first
2. **GREEN** - Write minimal code to make it pass
3. **REFACTOR** - Clean up while keeping tests green

## TDD Workflow

### Step 1: Write a Failing Test (RED)
```
Before writing any implementation:
- Write a test that describes the desired behavior
- Run the test and verify it FAILS
- The failure confirms the test is valid
```

### Step 2: Make It Pass (GREEN)
```
Write the simplest code that makes the test pass:
- Don't over-engineer
- Don't add features not covered by tests
- Just make the test green
```

### Step 3: Refactor
```
Clean up the code while keeping tests green:
- Remove duplication
- Improve naming
- Optimize structure
- Run tests after each change
```

### Step 4: Commit
```
Commit when tests are green and code is clean
```

## Testing Anti-Patterns to AVOID

❌ **Writing tests after implementation**
- Tests become confirmations, not specifications
- You're testing what you wrote, not what you need

❌ **Writing multiple tests before implementation**
- Breaks the tight feedback loop
- Harder to debug failures

❌ **Skipping the "see it fail" step**
- You might have a false positive (test passes for wrong reasons)

❌ **Testing implementation details**
- Tests should test behavior, not internals
- Brittle tests that break on refactoring

❌ **Writing complex tests first**
- Start with simplest case
- Add complexity incrementally

❌ **Not refactoring**
- Technical debt accumulates
- Code becomes harder to test

## When to Use TDD

✅ **New features** - Define behavior through tests
✅ **Bug fixes** - Write a test that reproduces the bug first
✅ **Refactoring** - Tests ensure behavior doesn't change
✅ **API design** - Tests show how the API will be used
✅ **Complex logic** - Tests document edge cases

## Testing Framework Quick Reference

### JavaScript/TypeScript
```javascript
// Jest / Vitest
describe('Calculator', () => {
  it('should add two numbers', () => {
    expect(add(2, 3)).toBe(5);
  });
});

// React Testing Library
render(<Button onClick={handleClick}>Click me</Button>);
fireEvent.click(screen.getByText('Click me'));
expect(handleClick).toHaveBeenCalled();
```

### Python
```python
# pytest
def test_add():
    assert add(2, 3) == 5

# unittest
class TestCalculator(unittest.TestCase):
    def test_add(self):
        self.assertEqual(add(2, 3), 5)
```

### Go
```go
func TestAdd(t *testing.T) {
    result := Add(2, 3)
    if result != 5 {
        t.Errorf("Expected 5, got %d", result)
    }
}
```

## Test Pyramid

Aim for this distribution:
```
    /\
   /E2E\    <- Few (slow, brittle)
  /─────\
 /Integration\ <- Some (medium speed)
/─────────────\
/  Unit Tests  \ <- Many (fast, focused)
```

**Unit Tests (70%)**: Fast, isolated, test single functions/components
**Integration Tests (20%)**: Test components working together
**E2E Tests (10%)**: Test complete user workflows

## Best Practices

### Good Test Characteristics (F.I.R.S.T.)
- **Fast**: Tests should run quickly
- **Independent**: Tests shouldn't depend on each other
- **Repeatable**: Same result every time
- **Self-Validating**: Pass or fail, no manual checking
- **Timely**: Written at the right time (before implementation)

### Test Naming Convention
```
test_[method]_[scenario]_[expected_result]

Examples:
- test_add_positiveNumbers_returnsSum
- test_login_invalidPassword_throwsError
- test_render_emptyList_showsEmptyState
```

### Arrange-Act-Assert (AAA) Pattern
```javascript
test('user can add item to cart', () => {
  // Arrange - Set up test data and conditions
  const cart = new ShoppingCart();
  const item = { id: 1, name: 'Widget', price: 10 };

  // Act - Execute the behavior being tested
  cart.addItem(item);

  // Assert - Verify the outcome
  expect(cart.items).toContain(item);
  expect(cart.total).toBe(10);
});
```

## TDD for Frontend (React/Vue/Svelte)

### Component Testing Workflow
1. Write test describing component behavior
2. See it fail
3. Create/update component to pass
4. Refactor

### Example: Building a Counter Component (TDD Style)

**Test 1: Render initial count**
```javascript
test('displays initial count of 0', () => {
  render(<Counter />);
  expect(screen.getByText('0')).toBeInTheDocument();
});
```

**Implementation 1**:
```javascript
function Counter() {
  return <div>0</div>;
}
```

**Test 2: Increment button**
```javascript
test('increments count when button clicked', () => {
  render(<Counter />);
  fireEvent.click(screen.getByText('Increment'));
  expect(screen.getByText('1')).toBeInTheDocument();
});
```

**Implementation 2**:
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <div>{count}</div>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

## TDD for Backend/API

### API Endpoint Testing Workflow
1. Write test for endpoint behavior
2. See it fail (404, 500, etc.)
3. Implement endpoint
4. See it pass
5. Refactor

### Example: Building a User API (TDD Style)

**Test 1: GET /users returns user list**
```javascript
test('GET /users returns 200 and user array', async () => {
  const response = await request(app).get('/users');
  expect(response.status).toBe(200);
  expect(Array.isArray(response.body)).toBe(true);
});
```

**Test 2: POST /users creates new user**
```javascript
test('POST /users creates user and returns 201', async () => {
  const newUser = { name: 'John', email: 'john@example.com' };
  const response = await request(app)
    .post('/users')
    .send(newUser);
  expect(response.status).toBe(201);
  expect(response.body).toMatchObject(newUser);
});
```

## Mocking & Stubbing

Use mocks for external dependencies:

### JavaScript (Jest)
```javascript
// Mock API calls
jest.mock('./api');
api.fetchUser.mockResolvedValue({ id: 1, name: 'John' });

// Mock timers
jest.useFakeTimers();
jest.advanceTimersByTime(1000);
```

### Python (pytest)
```python
# Mock external service
def test_get_weather(mocker):
    mock_api = mocker.patch('weather.api.fetch')
    mock_api.return_value = {'temp': 72}
    result = get_weather('NYC')
    assert result['temp'] == 72
```

## Coverage Goals

- **Aim for 80%+ code coverage** (but coverage ≠ quality)
- **100% coverage of critical paths** (auth, payment, data loss scenarios)
- **Don't sacrifice test quality for coverage numbers**

## TDD Checklist

Before writing implementation, ask:
- [ ] Have I written a test for this feature/fix?
- [ ] Did I see the test fail?
- [ ] Am I writing the simplest code to pass?
- [ ] Are my tests independent?
- [ ] Am I testing behavior, not implementation?
- [ ] Have I refactored with green tests?

## Resources

- **Books**: "Test Driven Development" by Kent Beck
- **Frontend**: React Testing Library, Vitest, Playwright
- **Backend**: Jest, pytest, Go testing package
- **E2E**: Playwright, Cypress, Selenium

---

**Remember**: Tests are documentation. Write tests that communicate intent clearly.
