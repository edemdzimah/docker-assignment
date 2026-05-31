# ── STAGE 1: Builder ──────────────────────────────────────
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --target=/app/packages


# ── STAGE 2: Runner ───────────────────────────────────────
FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /app/packages /app/packages

COPY . .

EXPOSE 5000

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

ENV PYTHONPATH=/app/packages

CMD ["python", "app.py"]