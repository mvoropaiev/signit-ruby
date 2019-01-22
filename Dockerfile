# base image
FROM ruby:2.6-alpine

# install required packages
RUN set -ex \
    && apk add --no-cache \
        su-exec

# set up application group, user and directory
ENV APP_DIR "/usr/src/app"
RUN set -ex \
    && addgroup -g "1000" -S "worker" \
    && adduser -u "1000" -G "worker" -S -s "/bin/false" \
        -h "$APP_DIR" "worker" \
    && mkdir -p "$APP_DIR" \
    && chown -R worker:worker "$APP_DIR"
WORKDIR "/usr/src/app"

# configure bundler 
RUN set -ex \
    && bundle config --global jobs 4 \
    && bundle config --global frozen 1
