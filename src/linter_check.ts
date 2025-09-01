// sample.ts

// 不要なインポート（eslint で unused-imports などが検知できる）
import fs from "fs";

interface User {
  id: number;
  name: string;
  email?: string;
}

// var の使用（eslint: no-var）
var count = 0;

function greet(user: User): string {
  // eslint の no-console などのチェック対象
  console.log("Hello, " + user.name);

  // テンプレートリテラル推奨ルールで検出される可能性あり
  return "Hi, " + user.name;
}

// any 型を使ってしまう（eslint で @typescript-eslint/no-explicit-any）
function processData(data: any) {
  return data;
}

// 使われない変数
const unusedValue = 42;

const user: User = { id: 1, name: "Alice" };
greet(user);
processData("test");
