# insecure_content

nagios check for insecure content on a webpage

either you need python-selenium from jessie-backport and
node install -g phantomjs:

    ./check_http_insecure_content https://www.abcnyheter.no/

or we wrap it in a huge docker image:

    docker build -t check .
    docker run -e "URL=https://www.abcnyheter.no" -it check

