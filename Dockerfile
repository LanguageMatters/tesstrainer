FROM ubuntu:20.04

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get install -y \
	libcairo2-dev \
	libcairo2-dev \
	libicu-dev \
	libicu-dev \
	libjpeg8-dev \
	libjpeg8-dev \
	libpango1.0-dev \
	libpango1.0-dev \
	libtiff5-dev \
	libtiff5-dev \
	libtool \
	pkg-config \
	wget \
	xzgv \
	zlib1g-dev
RUN apt-get install -y \
	autoconf \
	autoconf-archive \
	automake \
	build-essential \
	checkinstall \
	cmake \
	g++ \
	git

# SSH for diagnostic
RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# Directories
ENV BASE_DIR        /tesstrainer
ENV SRC_DIR         ${BASE_DIR}/src
ENV WORKSPACE_DIR   ${BASE_DIR}/workspace
ENV LEP_SRC_URL     https://github.com/DanBloomberg/leptonica/archive/refs/tags/1.82.0.tar.gz
ENV LEP_SRC_DIR     ${SRC_DIR}/leptonica
ENV TES_SRC_URL     https://github.com/tesseract-ocr/tesseract/archive/refs/tags/4.1.3.tar.gz
ENV TES_SRC_DIR     ${SRC_DIR}/tesseract
ENV TESSDATA_PREFIX /usr/local/share/tessdata
ENV LANGDATA_DIR    ${BASE_DIR}/langdata
ENV FONTS_DIR       /usr/local/share/fonts

RUN mkdir -p ${BASE_DIR}
RUN mkdir -p ${SRC_DIR}
RUN mkdir -p ${FONTS_DIR}
RUN mkdir -p ${LANGDATA_DIR}
RUN mkdir -p ${TESSDATA_PREFIX}

COPY ./container-files/fonts     ${FONTS_DIR}/
COPY ./container-files/langdata  ${LANGDATA_DIR}/

# Tessdata Download
# osd: Orientation and script detection | equ: Math / equation detection | eng: English | sin: Sinhala
RUN wget -O ${TESSDATA_PREFIX}/osd.traineddata https://github.com/tesseract-ocr/tessdata/raw/3.04.00/osd.traineddata
RUN wget -O ${TESSDATA_PREFIX}/equ.traineddata https://github.com/tesseract-ocr/tessdata/raw/3.04.00/equ.traineddata
RUN wget -O ${TESSDATA_PREFIX}/eng.traineddata https://github.com/tesseract-ocr/tessdata/raw/4.00/eng.traineddata
RUN wget -O ${TESSDATA_PREFIX}/sin.traineddata https://github.com/tesseract-ocr/tessdata/raw/4.00/sin.traineddata

# Download tesseract source
RUN wget ${TES_SRC_URL} -O ${SRC_DIR}/tesseract-4.1.3.tar.gz
RUN cd ${SRC_DIR} && tar -xf ${SRC_DIR}/tesseract-4.1.3.tar.gz && mv tesseract-4.1.3 ${TES_SRC_DIR}

# Download leptonica source
RUN wget ${LEP_SRC_URL} -O ${SRC_DIR}/leptonica-1.82.0.tar.gz
RUN cd ${SRC_DIR} && tar -xf ${SRC_DIR}/leptonica-1.82.0.tar.gz && mv leptonica-1.82.0 ${LEP_SRC_DIR}

WORKDIR /tesstrainer
