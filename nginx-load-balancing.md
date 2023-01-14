# Nginx load balancing

Based on [nginx doc](http://nginx.org/en/docs/http/load_balancing.html)

## LB

Dockerfile:

```

FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf

```

nginx configuration:

```
events {
    worker_connections  1024;
}

http {
    upstream myapp1 {
        server host.docker.internal:8080;
        server host.docker.internal:8081;
        server host.docker.internal:8082;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://myapp1;
        }
    }
}


```

I will expose ports of my backed so that I can access it from my docker machine. To simplify minimal configuration `host.docker.internal` is being used for balancing (with port). Read further [here](https://docs.docker.com/desktop/networking/#i-want-to-connect-from-a-container-to-a-service-on-the-host).

```

docker build . -t nlb 
docker run -p 80:80 nlb

# LB in on `localhost` (port 80)

```

## Backends

Reuse configuration files from [sandbox](sandbox/nginx-load-balancer/backend) and build 3 image passing different argument each time:

```

# build backend images
docker build . -t backend1 --build-arg FILE="index1.html"
docker build . -t backend2 --build-arg FILE="index2.html"
docker build . -t backend3 --build-arg FILE="index3.html"

# run backend containers
docker run -p 8081:80 backend1  
docker run -p 8082:80 backend2  
docker run -p 8083:80 backend3

```

## Test

Ensure all is up.

```

docker ps                   

CONTAINER ID   IMAGE      COMMAND                  CREATED              STATUS              PORTS                  NAMES
9827edc854a9   backend3   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8083->80/tcp   silly_ishizaka
c84a90864ce8   nlb        "/docker-entrypoint.…"   8 minutes ago        Up 8 minutes        0.0.0.0:80->80/tcp     bold_ganguly
42bab3a61448   backend2   "/docker-entrypoint.…"   12 minutes ago       Up 12 minutes       0.0.0.0:8082->80/tcp   serene_jackson
3ff323782bc8   backend1   "/docker-entrypoint.…"   12 minutes ago       Up 12 minutes       0.0.0.0:8081->80/tcp   pedantic_kapitsa

curl localhost

# When the load balancing method is not specifically configured, it defaults to round-robin. So each refresh should give a new next node in list (1..2..3). 

```

That's it!