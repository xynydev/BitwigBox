FROM scratch AS ctx
COPY / /

FROM quay.io/toolbx/ubuntu-toolbox:24.04

ARG BITWIG_VERSION="6.0"
ARG YABRIDGE_VERSION=5.1.1
ARG WINE_VERSION=10.14~noble-1

# deps
RUN --mount=type=bind,from=ctx,src=/,dst=/ctx \
    bash /ctx/deps.sh

# yabridge
RUN wget https://github.com/robbert-vdh/yabridge/releases/download/${YABRIDGE_VERSION}/yabridge-${YABRIDGE_VERSION}.tar.gz  -O /tmp/yabridge.tar.gz && \
    tar -xvf /tmp/yabridge.tar.gz -C /tmp/ && \
    cp /tmp/yabridge/yabridgectl /usr/bin && \
    cp /tmp/yabridge/yabridge-host* /usr/bin && \
    cp /tmp/yabridge/*.so /usr/lib

# bitwig
RUN wget https://www.bitwig.com/dl/Bitwig%20Studio/${BITWIG_VERSION}/installer_linux/ -O /tmp/bitwig.deb && \
    dpkg -i /tmp/bitwig.deb && \
    rm /tmp/bitwig.deb

CMD ["/opt/bitwig-studio/BitwigStudio"]
