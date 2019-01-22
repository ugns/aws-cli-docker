FROM buildpack-deps:stable-curl

LABEL maintainer="Jeremy T. Bouse <Jeremy.Bouse@UnderGrid.net"

RUN apt-get update -qqy \
    && apt-get install -qqy --no-install-recommends python python-pip python-setuptools python-all-dev groff less mime-support\
    && pip install --upgrade awscli s3cmd python-magic \
    && apt-get purge -qqy python-pip python-all-dev \
    && curl -fsSLO "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" \
    && dpkg -i session-manager-plugin.deb \
    && rm session-manager-plugin.deb \
    && apt-get autoremove -qqy \
    && rm -rf /var/lib/apt/lists/*

VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
