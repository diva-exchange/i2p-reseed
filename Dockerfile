FROM divax/i2p:current
ENV GO111MODULE=off

LABEL author="DIVA.EXCHANGE Association <contact@diva.exchange>" \
  maintainer="DIVA.EXCHANGE Association <contact@diva.exchange>" \
  name="exchange.diva.reseed" \
  description="Distributed digital value exchange upholding security, reliability and privacy" \
  url="https://reseed.diva.exchange"

COPY entrypoint-reseed.sh /home/i2preseed/entrypoint-reseed.sh
COPY src /home/i2preseed/src

RUN apk --no-cache --virtual build-dependendencies add \
    binutils \
    git \
    go \
  && export GOPATH=/home/i2preseed/ \
  && cd /home/i2preseed/src/i2p-tools \
  && go install \
  && strip /home/i2preseed/bin/i2p-tools \
  && cd /home/i2preseed/ \
  # remove build dependencies
  && rm -rf /home/i2preseed/src \
  && rm -rf /home/i2preseed/pkg \
  && apk --no-cache --purge del build-dependendencies \
  # set permissions
  && chmod 0700 /home/i2preseed/bin/i2p-tools \
  && chmod +x /home/i2preseed/entrypoint-reseed.sh


# 8443 reseed server
EXPOSE 8443

VOLUME [ "/home/i2preseed/" ]
WORKDIR "/home/i2preseed"
ENTRYPOINT [ "/home/i2preseed/entrypoint-reseed.sh" ]

