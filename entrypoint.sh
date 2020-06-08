#!/bin/sh
#
# Author/Maintainer: konrad@diva.exchange
#

# -e  Exit immediately if a simple command exits with a non-zero status
set -e

# DNS-over-TLS, -C path to config
/usr/local/bin/stubby -l -C /home/i2pd/network/stubby.yml &

# see configs: /conf/i2pd.conf
su i2pd -c "/home/i2pd/bin/i2pd --daemon --datadir=/home/i2pd/data --conf=/home/i2pd/conf/i2pd.conf"

# mandatory signer id, like something@somedomain.tld
SIGNER=${SIGNER:?Pass signer ID, like something@somedomain.tld}

# create the keys, if they don't exist
[ -f /home/i2preseed/${SIGNER}.crt ] || /home/i2preseed/bin/i2p-tools keygen --signer=${SIGNER}

# wait for 10 minutes to have the router integrated
sleep 600

while ( true )
do
  /home/i2preseed/bin/i2p-tools reseed \
    --signer=${SIGNER} \
    --netdb=/home/i2pd/data/netDb \
    --port=8443 \
    --ip=127.0.0.1 \
    --trustProxy &
  # sleep for 48 hours, 60 * 60 * 48 secs
  sleep 172800
  # terminate i2p-tools, to restart it again
  pkill i2p-tools
done
