#!/bin/sh
#
# Author/Maintainer: konrad@diva.exchange
#

# -e  Exit immediately if a simple command exits with a non-zero status
set -e

IP_CONTAINER=`ip route get 1 | awk '{ print $NF; exit; }'`

sed 's/\$IP_CONTAINER/'"${IP_CONTAINER}"'/g' /home/i2pd/conf/i2pd.org.conf >/home/i2pd/conf/i2pd.conf

# overwrite resolv.conf - forces the container to use stubby as a resolver
cat </home/i2pd/network/resolv.conf >/etc/resolv.conf

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
    --ip=${CONTAINER_IP} \
    --trustProxy &
  # sleep for 48 - 60 hours
  sleep $(( (RANDOM*60*60*12/32768) + (60*60*48) ))
  # terminate i2p-tools, to restart it again
  pkill i2p-tools
done
