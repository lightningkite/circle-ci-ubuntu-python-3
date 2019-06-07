FROM ubuntu:16.04
ENV PYTHONUNBUFFERED 1

RUN \
    apt-get -y update && \
    apt-get install -y \
    gettext \
    wget \
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
    libpq-dev \
    && apt-get upgrade -y \
    && apt-get clean

# install xvfb
RUN apt-get install -yqq xvfb

# Install postgis stuff
RUN apt-get install -y --reinstall software-properties-common
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq postgis postgresql-11-postgis-scripts

# Install GEOS library
RUN apt-get install -yqq binutils libproj-dev gdal-bin
RUN wget http://download.osgeo.org/geos/geos-3.7.2.tar.bz2
RUN tar xjf geos-3.7.2.tar.bz2; cd geos-3.7.2; ./configure; make; make install
ENV LD_LIBRARY_PATH /usr/local/lib

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN \
    apt-get -y update && \
    apt-get install -y nodejs && \
    apt-get clean