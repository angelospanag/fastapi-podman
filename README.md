# fastapi-podman

An example project using [Podman](https://podman.io/) to run a container with [Python/FastAPI](https://fastapi.tiangolo.com/).

## Getting Started

[mise](https://mise.jdx.dev/) manages the pinned toolchain
([Python 3.14](https://www.python.org/), [uv](https://docs.astral.sh/uv/)).

```bash
# macOS / Linux
curl https://mise.run | sh

# Windows
winget install jdx.mise
```

Activate mise in your shell (`~/.zshrc`):

```zsh
eval "$(mise activate zsh)"
```

Then, in the repo:

```bash
mise trust         # one-time
mise install       # downloads Python and uv
mise run install   # installs dependencies into .venv
mise run dev       # starts the dev server on 127.0.0.1:8000
```

| Command            | Description                            |
|--------------------|----------------------------------------|
| `mise run install` | Install dependencies into `.venv`      |
| `mise run dev`     | FastAPI dev server on `127.0.0.1:8000` |
| `mise run serve`   | Production server on `0.0.0.0:8000`   |
| `mise run test`    | Run tests                              |
| `mise run fmt`     | Format code via `ruff format`          |
| `mise run lint`    | Lint code via `ruff check`             |
| `mise run typecheck` | Type check via `ty check`            |
| `mise run vuln`    | Audit deps for known vulnerabilities   |
| `mise run deps`    | Update and sync dependencies           |

## Podman

### Installation

```bash
# macOS
brew install podman

# Ubuntu/WSL
sudo apt install podman
```

### Setup

```bash
podman machine init
podman machine start
```

### Build and run

```bash
# Build image
podman image build -t fastapi-podman .

# Run container (maps local port 8000 → container port 80)
podman container run -d --name fastapi-podman -p 8000:80 --network bridge fastapi-podman

# Check running containers
podman ps

# Hit the endpoint
curl http://localhost:8000
```

Expected output:

```json
{"Hello":"World"}
```
