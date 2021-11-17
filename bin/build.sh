#!/usr/bin/env bash
#
# Maintainer: konrad@diva.exchange
#

set -e

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${PROJECT_PATH}/../

# docker image
sudo docker build --no-cache -t divax/i2p-reseed:latest .
