# insecure_content

nagios check for insecure content on a webpage

either you need python-selenium from jessie-backports and
node install -g phantomjs:

    ./insecure_content https://www.abcnyheter.no/

or we wrap it in a huge docker image:

    docker build -t insecure_content .
    docker run -e "URL=https://www.abcnyheter.no" -it insecure_content

