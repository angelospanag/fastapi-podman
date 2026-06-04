FROM python:3.14-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /code

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY ./app /code/app

CMD ["uv", "run", "fastapi", "run", "app/main.py", "--host", "0.0.0.0", "--port", "80"]
