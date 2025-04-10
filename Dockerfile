FROM cgr.dev/chainguard/python:latest-dev AS builder
USER root

# # add UV
# RUN apk update
# RUN apk add uv

WORKDIR /app
COPY pyproject.toml .

# same as pip install
RUN uv sync


FROM cgr.dev/chainguard/python:latest

WORKDIR /app

ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY linky.py linky.png ./
COPY --from=builder /app/.venv /venv

ENTRYPOINT [ "python", "/app/linky.py" ]
