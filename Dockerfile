ARG NODE_VERSION
FROM node:${NODE_VERSION}

RUN apt-get update && apt-get install -y \
	autoconf \
	autoconf-archive \
	automake \
	build-essential \
	checkinstall \
	cmake \
  curl \
  gcc \
	g++ \
	git \
  ghostscript \
  imagemagick \
	libcairo2-dev \
	libicu-dev \
	libjpeg-dev \
	libpango1.0-dev \
	libgif-dev \
	libwebp-dev \
	libopenjp2-7-dev \
	libpng-dev \
	libtiff-dev \
	libtool \
  make \
	pkg-config \
  poppler-utils \
  unzip \
	wget \
	xzgv \
  xz-utils \
	zlib1g-dev \
  zip

RUN mkdir /install
WORKDIR /install

# Tesseract
COPY install/tesseract.sh tesseract.sh
RUN ./tesseract.sh

# FFMPEG
COPY install/ffmpeg.sh ffmpeg.sh
RUN ./ffmpeg.sh

# ImageMagick
COPY im-policy.xml /etc/ImageMagick-6/policy.xml

WORKDIR /

# TAGS
ARG BRANCH_NAME
ENV BRANCH_NAME=${BRANCH_NAME}
ARG BUILD_DATE
ENV BUILD_DATE=${BUILD_DATE}
ARG BUILD_NUM
ENV BUILD_NUM=${BUILD_NUM}
ARG SHORT_SHA
ENV SHORT_SHA=${SHORT_SHA}
ARG TAG_NAME
ENV TAG_NAME=${TAG_NAME}

CMD ["node", "/server/index.js"]