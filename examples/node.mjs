#!/usr/bin/env node
// Node 18+ example: no SDK, built-in fetch only.
// Run:  node examples/node.mjs

const BASE_URL = process.env.BASE_URL ?? "https://api.yushou.xyz/v1";
const API_KEY = process.env.API_KEY ?? "sk-...";
const MODEL = process.env.MODEL ?? "gpt-4o-mini";

const res = await fetch(`${BASE_URL}/chat/completions`, {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    Authorization: `Bearer ${API_KEY}`,
  },
  body: JSON.stringify({
    model: MODEL,
    messages: [{ role: "user", content: "用一句话解释什么是 HTTP 幂等" }],
  }),
});

if (!res.ok) {
  // 401 -> key problem / wrong endpoint prefix. 404 -> base_url missing /v1.
  console.error(`HTTP ${res.status}:`, await res.text());
  process.exit(1);
}

const data = await res.json();
console.log(data.choices[0].message.content);
