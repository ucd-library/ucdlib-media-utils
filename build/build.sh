#! /bin/bash

set -e

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $ROOT_DIR/..

source ./config.sh

if [[ -f /config/.buildenv ]]; then
  source /config/.buildenv
else
  BUILD_NUM=-1
fi

docker build \
  --cache-from ${IMAGE_TAG} \
  --build-arg BRANCH_NAME=${BRANCH_NAME} \
  --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
  --build-arg BUILD_NUM=${BUILD_NUM} \
  --build-arg SHORT_SHA=${SHORT_SHA} \
  --build-arg TAG_NAME=${TAG_NAME} \
  -t ${IMAGE_TAG} .