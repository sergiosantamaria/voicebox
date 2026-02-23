 FROM python:3.11-slim

  # Dependencias del sistema
  RUN apt-get update && apt-get install -y \
      ffmpeg \
      git \
      curl \
      && rm -rf /var/lib/apt/lists/*

  WORKDIR /app

  # Copiar backend
  COPY backend/ ./backend/

  # Instalar PyTorch CPU (evita descargar versión CUDA de ~2GB)
  RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu

  # Instalar resto de dependencias
  RUN pip install --no-cache-dir -r backend/requirements.txt

  # Directorio persistente para modelos y datos
  RUN mkdir -p /data
  VOLUME ["/data"]

  EXPOSE 8000

  CMD ["python", "-m", "backend.main", "--host", "0.0.0.0", "--port", "8000", "--data-dir", "/data"]
