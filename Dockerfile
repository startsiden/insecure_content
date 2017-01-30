FROM node:6-slim

RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    libfontconfig \
    python-selenium

RUN npm install -g phantomjs-prebuilt
COPY check_http_insecure_content /root/
CMD /root/check_http_insecure_content $URL
