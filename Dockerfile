ARG FIXBUF_VERSION=2
FROM cmusei/fixbuf:${FIXBUF_VERSION} AS build
LABEL maintainer="maheckathorn@cert.org"

ARG SUPER_VERSION=1.11.0

# Pre-reqs:
# curl for downloading
# build-essentials for build tools
# ca-certs to download https
# 
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        build-essential \
        pkg-config \
        ca-certificates \
        libglib2.0-dev \
        libssl-dev \
        zlib1g-dev \
        && apt-get clean && \
        rm -rf /var/lib/apt/lists/*

WORKDIR /netsa

RUN curl https://tools.netsa.cert.org/releases/super_mediator-$SUPER_VERSION.tar.gz | \
        tar -xz && cd super_mediator-* && \
        ./configure --prefix=/netsa \
        --with-libfixbuf=/netsa/lib/pkgconfig \
        --with-openssl \
        --with-mysql=no && \
        make && \
        make install && \
        cd ../ && rm -rf super_mediator-$SUPER_VERSION

FROM debian:11-slim
LABEL maintainer="maheckathorn@cert.org"

RUN apt-get update && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        zlib1g \
        libssl1.1 \
        && apt-get clean && \
        rm -rf /var/lib/apt/lists/*

COPY --from=build /netsa/ /netsa/

COPY super_mediator.conf /usr/local/etc/

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]