FROM ubuntu
MAINTAINER Sumedhe Dissanayake <sumedhedissanayake@gmail.com>

WORKDIR /tesstrainer
RUN apt-get update

# Install Dependancies
RUN apt-get install -y \
    cmake \
    curl \
    git \
    wget \
    unzip
RUN apt-get install -y g++  \
    autoconf automake libtool \
    autoconf-archive \
    pkg-config \
    libpng-dev \
    libjpeg8-dev \
    libtiff5-dev \
    libicu-dev \
    libpango1.0-dev \
    libcairo2-dev \
    zlib1g-dev

# Copy resources
COPY langdata /tesstrainer/langdata
COPY fonts /tesstrainer/fonts

# Get sources
RUN git clone https://github.com/tesseract-ocr/tesseract.git
RUN git clone https://github.com/DanBloomberg/leptonica.git
RUN wget https://github.com/tesseract-ocr/tessdata/raw/master/sin.traineddata -P tesseract/tessdata/
RUN wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata -P tesseract/tessdata/

