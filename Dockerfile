FROM python:3.9

WORKDIR /app

# Install system dependencies needed to build Python packages
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
