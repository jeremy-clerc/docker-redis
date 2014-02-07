# Install redis from source
# Actual stable version is 2.8.5
# To run the server
#    sudo docker run -d -m 2g -name redis-server jeremyclerc/docker-redis
# If you want to use client not from a docker, expose the ports 
#    sudo docker run -d -p 6379:6379 -name redis-server jeremyclerc/docker-redis
# If you stop it do not forget to rm the container, or you will have 
#  a name conflict
#
# Then a run a client by issuing
# sudo docker run -i -t --rm --link redis-server:redis -name redis-client jeremyclerc/docker-redis /root/start_cli.sh
#
# /root/start_cli.sh just calls redis-cli with right IP and PORT from env 
# because I have not been able to do something like docker run ... -h $REDIS_PORT_6379_TCP_ADDR
#
#

FROM debian:wheezy

MAINTAINER Jeremy Clerc <jeremy@clerc.io>

RUN apt-get update && apt-get -y install wget build-essential && apt-get clean

RUN wget -O- http://download.redis.io/releases/redis-2.8.5.tar.gz | tar xz

RUN cd redis-2.8.5/ && make && make install

# Custom config, with only memory use
# Max memory of 2G
ADD ./redis.conf /etc/redis.conf

# Startup script for client
ADD ./start_cli.sh /root/start_cli.sh

# Exposing default redis port
EXPOSE 6379

# If no argument, run Redis Server
CMD ["/redis-2.8.5/src/redis-server", "/etc/redis.conf"]
