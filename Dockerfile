from ubuntu:bionic-20190612

ENV SQUID_VERSION=3.5.12 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.12.tar.gz \
  && tar -xzvf squid-3.5.12.tar.gz \
  && squid-3.5.12/configure \
  && make -k \
  && make check \
  && make install

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]


