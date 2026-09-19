"""Minimal examples: OpenAI-compatible endpoint, non-streaming + streaming.

Swap BASE_URL / API_KEY / MODEL for your own and run it.
"""

from openai import OpenAI

BASE_URL = "https://api.yushou.xyz/v1"
API_KEY = "sk-..."  # noqa: S105 (example only)
MODEL = "gpt-4o-mini"

client = OpenAI(api_key=API_KEY, base_url=BASE_URL)


def simple():
    resp = client.chat.completions.create(
        model=MODEL,
        messages=[{"role": "user", "content": "用一句话解释幂等性"}],
    )
    print(resp.choices[0].message.content)


def streaming():
    """Coding agents (Claude Code, Codex CLI, Cursor...) depend on this path."""
    stream = client.chat.completions.create(
        model=MODEL,
        messages=[{"role": "user", "content": "列出三种 API 鉴权方式"}],
        stream=True,
    )
    for chunk in stream:
        delta = chunk.choices[0].delta.content or ""
        print(delta, end="", flush=True)
    print()


if __name__ == "__main__":
    simple()
    print("-" * 40)
    streaming()
