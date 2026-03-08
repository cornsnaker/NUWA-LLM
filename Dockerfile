FROM 5hojib/aeon:latest

# Install build tools required for compiling C extensions
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Set up environment and install dependencies
RUN uv venv
COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

# Copy all files into the container
COPY . .

# IMPORTANT: Run the chmod AFTER copying the files.
# The -R makes it recursive, granting write access to all subfolders.
# We also proactively create 'sessions' and 'data' folders just in case your code expects them.
RUN mkdir -p sessions data && chmod -R 777 /usr/src/app

CMD ["bash", "start.sh"]
