FROM python:3.11-slim

# Install system dependencies for headless GUI
RUN apt-get update && apt-get install -y \
    xvfb \
    x11-utils \
    libglx-mesa0 libgl1-mesa-dri \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements and install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Run with Xvfb for headless display
CMD ["xvfb-run", "--server-args=-screen 0 1024x768x24", "python", "main.py"]