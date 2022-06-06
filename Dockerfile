FROM python:3.8-slim
ENV PYTHONUNBUFFERED 1
ARG PUID=${PUID:-1000}
ARG PGID=${PGID:-1000}
ENV APP_DIR="/app"
ENV HOME="/home/python"
ENV PYTHON_ENV="/venv"
ENV PATH="${HOME}/.poetry/bin:${PYTHON_ENV}/bin:${APP_DIR}:${PATH}"
ENV PYTHONUNBUFFERED 1

# # create user/group
RUN set -ex \
  && addgroup --gid $PGID python \
  && useradd -u $PUID -g $PGID python \
  && mkdir -p $PYTHON_ENV $HOME $APP_DIR

# # create and activate our virtual env
RUN set -ex \
  && python3 -m venv $PYTHON_ENV \
  && echo source $PYTHON_ENV/bin/activate > $HOME/.bashrc \
  && chown -R python.python $PYTHON_ENV $HOME $APP_DIR

RUN \
    apt-get -y update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    autoconf \
    automake \
    build-essential \
    build-essential \
    curl \
    gettext \
    git \
    libcairo2 \
    libffi-dev \
    libgdk-pixbuf2.0-0 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libpq-dev \
    libssl-dev \
    libtool \
    openssh-client \
    pkg-config \
    python3 \
    python3-cffi \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python-is-python3 \
    shared-mime-info \
    vim \
    wget \
    && DEBIAN_FRONTEND="noninteractive" apt-get upgrade -y \
    && apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN \
    apt-get -y update && \
    apt-get install -y nodejs && \
    apt-get clean

WORKDIR $APP_DIR
