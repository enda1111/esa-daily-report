FROM ruby:2.4.2-alpine

RUN apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime &&
    apk del tzdata && \
    rm -rf /var/cache/apk/*
