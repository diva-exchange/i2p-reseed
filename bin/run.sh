#!/usr/bin/env bash
#
# Maintainer: konrad@diva.exchange
#

set -e

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/../
cd "${PROJECT_PATH}"
PROJECT_PATH=$( pwd )

# mandatory signer id, like something@somedomain.tld
SIGNER=${1:?Pass signer ID, like something@somedomain.tld}

sudo docker volume create i2preseed
sudo docker run \
  -e "SIGNER=${SIGNER}" \
  -d \
  -p 8443:8443 \
  --mount type=volume,src=i2preseed,dst=/home/i2preseed/ \
  --name i2preseed \
  divax/i2p-reseed:current
