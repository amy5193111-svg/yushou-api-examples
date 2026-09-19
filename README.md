# yushou-api-examples

用 OpenAI 兼容接口调用多家大模型的最小示例（Python / Node / curl）。

A minimal set of examples for calling multiple LLM providers through a single OpenAI-compatible endpoint — one `base_url`, one API key.

## What this shows

The point of an OpenAI-compatible gateway is that **you change exactly two things**: `base_url` and `model`. Everything else — request headers, request body, response shape, streaming, function calling — stays the same as the official SDK.

```python
from openai import OpenAI

client = OpenAI(
    api_key="sk-...",
    base_url="https://api.yushou.xyz/v1",
)

resp = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": "hello"}],
)
print(resp.choices[0].message.content)
```

## Files

| File | What it does |
| --- | --- |
| `examples/python_openai_sdk.py` | OpenAI Python SDK, non-streaming + streaming |
| `examples/node.mjs` | Node 18+ (built-in fetch), no SDK required |
| `examples/curl.sh` | Raw HTTP, useful when debugging 401/404 |
| `examples/anthropic_native.py` | Anthropic native format (no `/v1` suffix) for Claude Code style clients |

## Notes worth knowing

- **OpenAI-compatible endpoints use the `/v1` suffix**; the Anthropic native format does not. Mixing these up is the most common cause of a 404 that looks like an auth problem.
- Streaming is what most coding agents rely on — always test `stream=True` before wiring a client into an automated pipeline.
- Test with a short prompt first, then a very long context, to check whether the gateway truncates or silently downgrades the model.

## Links

- Getting started (Base URL setup): https://api.yushou.xyz/guide/
- Live per-model pricing: https://api.yushou.xyz/pricing
- Usage rankings (real token volume): https://api.yushou.xyz/rankings
- Guides: https://blog.yushou.xyz/

## License

MIT
