# Install redis from source
# Actual stable version is 2.8.5
# docker run -p 6379 jeremyclerc/redis-stable

FROM debian:wheezy

MAINTAINER Jeremy Clerc <jeremy@clerc.io>

RUN apt-get update && apt-get -y install wget build-essential

RUN wget -O- http://download.redis.io/releases/redis-2.8.5.tar.gz | tar xz

RUN cd redis-2.8.5/ && make && make install

ADD ./redis.conf /etc/redis.conf



