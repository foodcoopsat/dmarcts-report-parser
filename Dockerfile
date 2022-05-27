FROM debian:bullseye-slim

RUN set -ex; \
  apt-get update; \
  apt-get install -y \
  libclass-dbi-mysql-perl \
  libfile-mimeinfo-perl \
  libio-socket-inet6-perl \
  libio-socket-ip-perl \
  libmail-imapclient-perl \
  libmail-mbox-messageparser-perl \
  libmime-tools-perl \
  libperlio-gzip-perl \
  libxml-simple-perl \
  unzip; \
  rm -rf /var/lib/apt/lists/*

ENV DMARCPARSER_VERSION 2af80e6a0ccc57bfe4e6bc8ae11c15b435c3d919
ENV DMARCPARSER_SHA256 27401ba15b1f97a962b9f8bf0fb0943cf0d005784e5fab850ea604500b751cd5

RUN set -ex; \
  apt-get update; \
  apt-get install -y curl; \
  cd /usr/local/bin; \
  curl -o dmarcts-report-parser.pl -fSL https://github.com/techsneeze/dmarcts-report-parser/raw/${DMARCPARSER_VERSION}/dmarcts-report-parser.pl; \
  echo "$DMARCPARSER_SHA256 dmarcts-report-parser.pl" | sha256sum -c -; \
  chmod +x dmarcts-report-parser.pl; \
  rm -rf /var/lib/apt/lists/*

COPY run.sh /

CMD ["/run.sh"]
