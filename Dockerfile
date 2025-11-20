FROM ubuntu:24.04

# Update package list and install build dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    curl \
    build-essential

# Give ubuntu user sudo privileges (ubuntu user already exists in base image)
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu
ENV PATH="/home/ubuntu/.local/bin:$PATH"

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Python 3.13 using uv
RUN uv python install 3.13
