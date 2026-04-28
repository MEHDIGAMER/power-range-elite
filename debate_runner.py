"""Parallel debate runner. Sends one prompt to N OpenRouter models concurrently.

Usage:
    python debate_runner.py <out_path> <in_path>

Reads config from (in priority order):
    1. $POWER_RANGE_CONFIG environment variable (path to JSON config)
    2. $OPENROUTER_API_KEY environment variable (key only; uses default model list)
    3. ~/.power-rangers/config.json (created from config.example.json)

Required config fields:
    openrouter_api_key:  your key from openrouter.ai/keys
    debate_models:       list of OpenRouter model IDs to query in parallel
"""
import asyncio
import json
import os
import sys
from pathlib import Path

import aiohttp


def load_config():
    cfg_env = os.environ.get("POWER_RANGE_CONFIG")
    if cfg_env:
        return json.loads(Path(cfg_env).read_text(encoding="utf-8"))

    default_path = Path.home() / ".power-rangers" / "config.json"
    if default_path.exists():
        return json.loads(default_path.read_text(encoding="utf-8"))

    api_key = os.environ.get("OPENROUTER_API_KEY")
    if api_key:
        return {
            "openrouter_api_key": api_key,
            "debate_models": [
                "anthropic/claude-sonnet-4",
                "openai/gpt-4.1",
                "deepseek/deepseek-r1",
                "google/gemini-2.5-pro-preview-05-06",
                "qwen/qwen3-235b-a22b",
            ],
        }

    sys.exit(
        "ERROR: no config found. Set $POWER_RANGE_CONFIG, $OPENROUTER_API_KEY, "
        "or create ~/.power-rangers/config.json from config.example.json"
    )


CFG = load_config()
KEY = CFG["openrouter_api_key"]
MODELS = CFG["debate_models"]

SYS = (
    "You are a senior software engineer in a code debate. Be concrete: name "
    "files, functions, exact tradeoffs. No hedging. Commit to a recommendation. "
    "Keep your response under 600 words. Use this structure:\n"
    "RECOMMENDATION: <2-3 sentences>\n"
    "KEY TRADEOFFS: <bullet list>\n"
    "GOTCHAS: <2-3 things that will bite>\n"
    "EXACT FILES TO TOUCH: <list>"
)


async def ask(session, model, user_msg):
    body = {
        "model": model,
        "messages": [
            {"role": "system", "content": SYS},
            {"role": "user", "content": user_msg},
        ],
        "temperature": 0.6,
        "max_tokens": 1400,
    }
    headers = {
        "Authorization": f"Bearer {KEY}",
        "Content-Type": "application/json",
        "HTTP-Referer": "https://github.com/your-org/power-range",
        "X-Title": "power-range-debate",
    }
    try:
        async with session.post(
            "https://openrouter.ai/api/v1/chat/completions",
            json=body, headers=headers, timeout=aiohttp.ClientTimeout(total=180),
        ) as r:
            data = await r.json()
            if "choices" in data:
                return model, data["choices"][0]["message"]["content"]
            return model, f"ERROR: {json.dumps(data)[:300]}"
    except Exception as e:
        return model, f"ERROR: {type(e).__name__}: {e}"


async def main():
    out_path = Path(sys.argv[1])
    in_path = Path(sys.argv[2]) if len(sys.argv) > 2 else None
    user_msg = in_path.read_text(encoding="utf-8") if in_path else sys.stdin.read()
    timeout = aiohttp.ClientTimeout(total=200)
    async with aiohttp.ClientSession(timeout=timeout) as session:
        results = await asyncio.gather(
            *[ask(session, m, user_msg) for m in MODELS]
        )
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w", encoding="utf-8") as f:
        f.write(f"# DEBATE -- {out_path.stem}\n\n")
        f.write(f"## QUESTION\n\n{user_msg}\n\n---\n\n")
        for model, resp in results:
            f.write(f"## {model}\n\n{resp}\n\n---\n\n")
    print(f"Wrote {out_path}")
    print(f"Models responded: {sum(1 for _, r in results if not r.startswith('ERROR'))}/{len(results)}")


if __name__ == "__main__":
    asyncio.run(main())
