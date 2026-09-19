#!/usr/bin/env bash
# Raw HTTP examples. Handy for debugging: this is exactly what your SDK sends.
# Usage:  BASE_URL=... API_KEY=... MODEL=... ./examples/curl.sh

set -euo pipefail
BASE_URL="${BASE_URL:-https://api.yushou.xyz/v1}"
API_KEY="${API_KEY:-sk-...}"
MODEL="${MODEL:-gpt-4o-mini}"

echo "== 1. non-streaming =="
curl -sS "${BASE_URL}/chat/completions" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"${MODEL}\",\"messages\":[{\"role\":\"user\",\"content\":\"用一句话解释幂等\"}]}" \
  | head -c 600
echo

echo "== 2. streaming (SSE) =="
curl -sS -N "${BASE_URL}/chat/completions" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"${MODEL}\",\"stream\":true,\"messages\":[{\"role\":\"user\",\"content\":\"数到五\"}]}" \
  | head -20

# Common failures:
#   HTTP 404 -> BASE_URL 少了或多了 /v1
#   HTTP 401 -> API_KEY 不对，或该 Key 没有这个模型的权限
#   HTTP 429 -> 并发/速率超限，需要排队或重试
