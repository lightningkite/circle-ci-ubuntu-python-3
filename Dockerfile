FROM ubuntu:18.04
ENV PYTHONUNBUFFERED 1

RUN \
    apt-get -y update && \
    apt-get install -y \
    gettext \
    git \
    openssh-client \
    curl \
    build-essential \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-cffi \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libffi-dev \
    shared-mime-info \
    python3-dev \
    && apt-get upgrade -y \
    && apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN \
    apt-get -y update && \
    apt-get install -y nodejs && \
    apt-get clean
