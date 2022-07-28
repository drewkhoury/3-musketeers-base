FROM python

RUN apt-get update && apt-get install -y \
    awscli \ 
    pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*