docker-redis
============

This Dockerfile builds a redis on top of a Debian.

It downloads the latest stable source availabe at this time: 2.8.5

You can then run it as server or as client.

# Run the server
When you stop the container do not forget to delete, or you will have a name conflict (used for links).
```
sudo docker rm 3b577fa
```

## Using the cli inside this docker
If you will use the cli from this docker, you do not need to expose the port.

```
sudo docker run -d -m 2g -name redis-server jeremyclerc/docker-redis
```

## Using your own cli
If you want to use a client that is on your machine, or in your scripts, you need to expose the port.

```
sudo docker run -d -p 6379:6379 -name redis-server jeremyclerc/docker-redis
```

# Run the client
```
sudo docker run -i -t --rm --link redis-server:redis -name redis-client jeremyclerc/docker-redis /root/start_cli.sh
```

/root/start_cli.sh just calls redis-cli with right IP and PORT from env because I have not been able to do something like docker run ... -h $REDIS_PORT_6379_TCP_ADDR
