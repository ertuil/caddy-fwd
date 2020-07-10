# Caddy-fwd

Caddy-fwd is a HTTP(s) proxy server powered by [caddy](https://caddyserver.com). It tries to replace `squid` and `nghttpx`.

## Usage

```
docker run -p 8080:8080 \
    -v /cert:/cert:ro \                 # Where you put your HTTPS certificate and private key
    -e USERNAME=username \                # Basic authentication Username
    -e PASSWORD=password \              # Basic Aathentication Password
    -e HOST=0.0.0.0:8080 \              # Listen address
    -e CERT_FILE=/cert/fullchain.cer \  # path to your certificate
    -e KEY_FILE=/cert/private.key \  # path to your private key
    -e PROBE_URL=google.com \           # attempts to hide the fact that the site is a forward proxy
    --name caddy-fwd \
    -d ertuil/caddy-fwd
```