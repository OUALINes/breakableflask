FROM python:3.12-alpine

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

# Dépendances système nécessaires
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    openssl-dev \
    curl \
    libaio

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

COPY . /app

RUN adduser -D appuser \
 && chown -R appuser /app
USER appuser

EXPOSE 4000

CMD ["python", "main.py"]
