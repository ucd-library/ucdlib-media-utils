#! /bin/bash

set -e

# Directories

BASE_DIR=/home/workspace
LEP_REPO_URL=https://github.com/DanBloomberg/leptonica.git
LEP_SRC_DIR=${BASE_DIR}/leptonica
TES_REPO_URL=https://github.com/tesseract-ocr/tesseract.git
TES_SRC_DIR=${BASE_DIR}/tesseract
TESSDATA_PREFIX=/usr/local/share/tessdata


# Downloading training data

echo "Downloading training data..."

mkdir -p ${TESSDATA_PREFIX}
# osd	Orientation and script detection
wget -O ${TESSDATA_PREFIX}/osd.traineddata https://github.com/tesseract-ocr/tessdata/raw/3.04.00/osd.traineddata
# equ	Math / equation detection
wget -O ${TESSDATA_PREFIX}/equ.traineddata https://github.com/tesseract-ocr/tessdata/raw/3.04.00/equ.traineddata
# eng English
wget -O ${TESSDATA_PREFIX}/eng.traineddata https://github.com/tesseract-ocr/tessdata/raw/4.00/eng.traineddata
# other languages: https://github.com/tesseract-ocr/tesseract/wiki/Data-Files

echo "Downloading source code..."


# Downloading source code

# Leptonica
git clone --depth 1 ${LEP_REPO_URL} ${LEP_SRC_DIR}

# Tesseract
git clone --depth 1 ${TES_REPO_URL} ${TES_SRC_DIR}



# Build

# Leptonica
cd ${LEP_SRC_DIR}
autoreconf -vi && ./autogen.sh && ./configure
make && make install

# Tesseract
cd ${TES_SRC_DIR}
./autogen.sh && ./configure
LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make
make
make install && ldconfig
make training && make training-install

