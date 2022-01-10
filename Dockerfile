FROM python:3.10

WORKDIR /app

# Copy dependency management files
COPY poetry.lock pyproject.toml /app/

# Install Poetry (Python dependency management tool)
RUN pip install poetry

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction

# Copy application files
COPY ./main.py /app/

# Run server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
