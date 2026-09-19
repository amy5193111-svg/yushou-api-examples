"""Anthropic native format example (what Claude Code uses).

Key difference from the OpenAI-compatible path:
  - ANTHROPIC_BASE_URL must NOT include the /v1 suffix
  - auth header is x-api-key (or ANTHROPIC_AUTH_TOKEN for Claude Code)
  - request/response shape is Anthropic's Messages API
"""

import json
import os
import urllib.request

BASE_URL = os.environ.get("ANTHROPIC_BASE_URL", "https://api.yushou.xyz")
API_KEY = os.environ.get("ANTHROPIC_AUTH_TOKEN", "sk-...")

req = urllib.request.Request(
    f"{BASE_URL}/v1/messages",
    data=json.dumps({
        "model": "claude-sonnet-4-5",
        "max_tokens": 256,
        "messages": [{"role": "user", "content": "用一句话说明 base_url 的作用"}],
    }).encode(),
    headers={
        "x-api-key": API_KEY,
        "anthropic-version": "2023-06-01",
        "content-type": "application/json",
    },
)

with urllib.request.urlopen(req, timeout=60) as r:
    data = json.load(r)

print(data["content"][0]["text"])
