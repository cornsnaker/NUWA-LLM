FROM 5hojib/aeon:latest

# Install build tools required for compiling C extensions (like tgcrypto)
# The rm -rf command cleans up the apt cache to keep your Docker image size small
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN uv venv
COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

COPY . .
CMD ["bash", "start.sh"]
