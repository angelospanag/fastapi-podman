# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

All tasks run via `mise run <task>`. The toolchain (Python 3.14, uv) is pinned in `mise.toml`.

| Task | Command |
|---|---|
| Install dependencies | `mise run install` |
| Dev server | `mise run dev` |
| Production server | `mise run serve` |
| Format | `mise run fmt` |
| Lint | `mise run lint` |
| Type check | `mise run typecheck` |
| Vulnerability audit | `mise run vuln` |
| Run tests | `mise run test` |
| Upgrade dependencies | `mise run deps` |

## Architecture

`app/main.py` owns the FastAPI application. It exposes a single route:

- `GET /` — returns `{"Hello": "World"}`

The `Dockerfile` uses a multi-stage uv-based build: dependencies are installed with `uv sync --frozen --no-dev`, then the app is served via `fastapi run`. The image is intended to be built and run with Podman (or Docker).
