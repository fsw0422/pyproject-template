FROM ubuntu:24.04

# Update package list and install build dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

# Give ubuntu user sudo privileges (ubuntu user already exists in base image)
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Download and install Python 3.13 system-wide
RUN wget https://www.python.org/ftp/python/3.13.0/Python-3.13.0.tgz && \
    tar -xf Python-3.13.0.tgz && \
    cd Python-3.13.0 && \
    ./configure --enable-optimizations --prefix=/usr/local && \
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -rf Python-3.13.0 Python-3.13.0.tgz && \
    /usr/local/bin/python3.13 -m ensurepip --upgrade && \
    /usr/local/bin/python3.13 -m pip install --upgrade pip setuptools wheel && \
    update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.13 2 && \
    update-alternatives --set python3 /usr/local/bin/python3.13 && \
    update-alternatives --install /usr/bin/pip3 pip3 /usr/local/bin/pip3 2 && \
    update-alternatives --set pip3 /usr/local/bin/pip3

# Switch to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu
