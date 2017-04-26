FROM python:2.7-slim

RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' \
  /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list \
  && echo 'Acquire::ForceIPv4 "true";' | tee /etc/apt/apt.conf.d/99force-ipv4

RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    libfontconfig \
    libfreetype6 \
    curl \
    python-pip \
    python-selenium \
    python-pycurl

RUN /usr/bin/python -m pip install publicsuffix 

WORKDIR /root

RUN export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64" && curl -sOL \ 
  https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 \
  && tar xjf $PHANTOM_JS.tar.bz2 \
  && rm $PHANTOM_JS.tar.bz2 \
  && mv $PHANTOM_JS /usr/local/share \
  && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin \
  && phantomjs --version

COPY insecure_content /usr/local/bin/
RUN chmod +x /usr/local/bin/insecure_content
CMD insecure_content $URL
