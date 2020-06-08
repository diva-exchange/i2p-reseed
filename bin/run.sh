#!/usr/bin/env bash
#
# Maintainer: konrad@diva.exchange
#

set -e

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${PROJECT_PATH}/../

# mandatory signer id, like something@somedomain.tld
SIGNER=${1:?Pass signer ID, like something@somedomain.tld}

docker volume create i2preseed
docker run \
  -e "SIGNER=${SIGNER}" \
  -d \
  --mount type=volume,src=i2preseed,dst=/home/i2preseed/ \
  --name i2preseed \
  divax/i2preseed:latest
