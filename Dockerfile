FROM python:3.10.8-slim-buster

# Update and install required packages including ffmpeg
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy application code
COPY . /app/

# Set working directory
WORKDIR /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir --upgrade --requirement requirements.txt

# Run the application
CMD gunicorn app:app & python3 main.py
