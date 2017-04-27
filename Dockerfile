FROM debian:jessie-slim

RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' \
  /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list \
  && echo 'Acquire::ForceIPv4 "true";' | tee /etc/apt/apt.conf.d/99force-ipv4

RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    libfontconfig \
    libfreetype6 \
    curl \
    ca-certificates \
    python-pip \
    python-selenium \
    python-pycurl \
    python-joblib \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/man/??_*

RUN /usr/bin/python -m pip install publicsuffix

WORKDIR /root

RUN export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64" && curl -sOL \ 
  https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 \
  && tar xjf $PHANTOM_JS.tar.bz2 \
  && rm $PHANTOM_JS.tar.bz2 \
  && mv $PHANTOM_JS/bin/phantomjs /usr/local/bin \
  && rm -rf $PHANTOM_JS/

COPY insecure_content /usr/local/bin/
RUN chmod +x /usr/local/bin/insecure_content
CMD insecure_content $URL
