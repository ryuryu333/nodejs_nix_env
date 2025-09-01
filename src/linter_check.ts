// linter_check.ts

interface User {
  id: number;
  name: string;
  email?: string;
}

// Use of var (eslint: no-var)
var count = 0;

function greet(user: User): string {
  // Subject to ESLint rules such as no-console
  console.log("Hello, " + user.name);

  // May be flagged by a "prefer template literals" rule
  return "Hi, " + user.name;
}

// Using any type (ESLint: @typescript-eslint/no-explicit-any)
function processData(data: any) {
  return data;
}

// Unused variable
const unusedValue = 42;

const user: User = { id: 1, name: "Alice" };
greet(user);
processData("test");
