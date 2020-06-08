FROM divax/i2p:latest

LABEL author="Konrad Baechler <konrad@diva.exchange>" \
  maintainer="Konrad Baechler <konrad@diva.exchange>" \
  name="exchange.diva.reseed" \
  description="Distributed digital value exchange upholding security, reliability and privacy" \
  url="https://reseed.diva.exchange"

COPY entrypoint.sh /home/i2preseed/
COPY src /home/i2preseed/src

RUN apk --no-cache --virtual build-dependendencies add \
    binutils \
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
  # add user/group
  && addgroup -g 2000 i2preseed \
  && adduser -u 2000 -G i2preseed -s /bin/sh -h "/home/i2preseed" -D i2preseed \
  && chown -R i2preseed:i2preseed /home/i2preseed \
  && chmod 0700 /home/i2preseed/bin/i2p-tools \
  && chmod +x /home/i2preseed/entrypoint.sh


# 8443 reseed server
EXPOSE 8443

VOLUME [ "/home/i2preseed/" ]
WORKDIR "/home/i2preseed"
ENTRYPOINT [ "/home/i2preseed/entrypoint.sh" ]

