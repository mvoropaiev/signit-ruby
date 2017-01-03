# base image
FROM ruby:2.4

# set up required group, user and directory
ENV APP_DIR /usr/src/app
RUN set -ex \
    && groupadd --gid 118 --system worker \
    && useradd --uid 118 --gid 118 --shell /bin/false --home-dir /nonexistent \
               --system worker \
    && mkdir --parents /usr/src/app \
    && chown --recursive worker:worker /usr/src/app
WORKDIR /usr/src/app

# install gosu
ENV GOSU_VERSION 1.10
ENV GOSU_GPG_KEY B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN set -ex \
    && wget -O /usr/local/bin/gosu \
        "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" \
    && wget -O /usr/local/bin/gosu.asc \
        "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GOSU_GPG_KEY" \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

# set the number of parallel jobs
RUN set -ex \
    && bundle config --global jobs 4 \
    && bundle config --global frozen 1
