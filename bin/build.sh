#!/usr/bin/env bash
#
# Author/Maintainer: DIVA.EXCHANGE Association, https://diva.exchange
#

set -e

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/../
cd "${PROJECT_PATH}"
PROJECT_PATH=$( pwd )

sudo rm -rf ${PROJECT_PATH}/src/i2p-tools/bin/i2p-tools
sudo rm -rf ${PROJECT_PATH}/src/i2p-tools/pkg
export GOPATH=${PROJECT_PATH}/src/i2p-tools/
cd "${PROJECT_PATH}/src/i2p-tools"
go install
cd "${PROJECT_PATH}"
strip ${PROJECT_PATH}/src/i2p-tools/bin/i2p-tools

# docker image
sudo docker build --no-cache -t divax/i2p-reseed:current .
