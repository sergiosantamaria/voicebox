FROM python:3.11-slim
RUN apt-get update && apt-get install -y ffmpeg git curl sox && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY backend/ ./backend/
RUN pip install --no-cache-dir torch torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir -r backend/requirements.txt
RUN mkdir -p /data
VOLUME ["/data"]
EXPOSE 8000
CMD ["python", "-m", "backend.main", "--host", "0.0.0.0", "--port", "8000", "--data-dir", "/data"]
