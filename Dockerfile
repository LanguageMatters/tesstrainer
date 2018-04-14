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

# Get source files
RUN git clone https://github.com/tesseract-ocr/tesseract.git
RUN git clone https://github.com/tesseract-ocr/langdata.git
RUN git clone https://github.com/DanBloomberg/leptonica.git
RUN wget https://github.com/tesseract-ocr/tessdata/raw/master/sin.traineddata -P tesseract/tessdata/
RUN wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata -P tesseract/tessdata/

# Get Font files
RUN mkdir fonts
RUN wget https://www.np.gov.lk/iskpota.ttf -P fonts/
RUN wget https://github.com/caarlos0-graveyard/msfonts/raw/master/fonts/arial.ttf -P fonts/

