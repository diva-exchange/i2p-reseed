#!/bin/sh
#
# Author/Maintainer: DIVA.EXCHANGE Association, https://diva.exchange
#

# -e  Exit immediately if a simple command exits with a non-zero status
set -e

# start i2pd - in the context of the container this points to the top-level entrypoint, which belongs to i2pd
BANDWIDTH=${BANDWIDTH:-P}
BANDWIDTH=${BANDWIDTH} /entrypoint.sh >/dev/null 2>&1 &

IP_CONTAINER=`ip route get 1 | awk '{ print $NF; exit; }'`

# mandatory signer id, like something@somedomain.tld
SIGNER=${SIGNER:?Pass signer ID, like something@somedomain.tld}

# create the keys, if they don't exist
[ -f /home/i2preseed/${SIGNER}.lock ] || /home/i2preseed/bin/i2p-tools keygen --signer=${SIGNER}
touch /home/i2preseed/${SIGNER}.lock

# wait for some minutes to have the router integrated
sleep 600

while ( true )
do
  /home/i2preseed/bin/i2p-tools reseed \
    --signer=${SIGNER} \
    --netdb=/home/i2pd/data/netDb \
    --port=8443 \
    --ip=${IP_CONTAINER} \
    --trustProxy &
  # sleep for 48 - 60 hours
  sleep $(( (RANDOM*60*60*12/32768) + (60*60*48) ))
  # terminate i2p-tools, to restart it again
  pkill i2p-tools
done
