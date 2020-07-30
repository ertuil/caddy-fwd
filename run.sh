docker build -t ertuil/caddy-fwd .
docker run -p 80:80 \
    -e USERNAME=caddy \
    -e PASSWORD=caddy \
    -e HOST=127.0.0.1:8080 \
    -e PROBE_URL=www.baidu.com \
    -it --rm caddy-fwd