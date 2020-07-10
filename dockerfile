FROM golang:alpine as builder
WORKDIR /app
RUN apk add git
RUN git clone https://github.com/caddyserver/forwardproxy
WORKDIR /app/forwardproxy
RUN GO111MODULE=on go install -i github.com/caddyserver/forwardproxy/cmd/caddy

FROM alpine
WORKDIR /app
EXPOSE 80 443
COPY --from=builder /go/bin/caddy /app/caddy
COPY Caddyfile start.sh /app/
RUN apk add bash && chmod +x /app/start.sh
ENTRYPOINT ["bash","-c","/app/start.sh"]