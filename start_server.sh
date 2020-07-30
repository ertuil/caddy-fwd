#!/usr/bin/env bash
CADDYFILE=/app/Caddyfile

ROOTDIR="${ROOTDIR:-/app/www}"
HOST="${HOST:-localhost}"

generate_caddyfile() {

    echo "${HOST} {" > ${CADDYFILE}
    echo "  root $ROOTDIR" >> ${CADDYFILE}
    echo "  index index.html index.htm" >> ${CADDYFILE}
    echo '  log / stdout "{remote} - {user} [{when}] \"{method} {host}{uri} {proto}\" {status} {size}"' >> ${CADDYFILE}

    if [[ ! -z ${CERT_FILE} ]]; then
    echo "  tls ${CERT_FILE} ${KEY_FILE}" >> ${CADDYFILE}
    fi
    
    echo "  forwardproxy {" >> ${CADDYFILE}
    if [[ ! -z ${USERNAME} ]]; then
        echo "    basicauth ${USERNAME} ${PASSWORD}" >> ${CADDYFILE}
    fi

    if [[ ! -z ${PROBE_URL} ]]; then
        echo "    probe_resistance ${PROBE_URL}" >> ${CADDYFILE}
    fi

cat << EOF >> ${CADDYFILE}
    ports 21 22 23 80 81 82 8080 8880 2052 2082 2086 2095 443 2053 2083 2087 2096 8443 465 993 996
    response_timeout 10
    dial_timeout 10
    hide_via
    hide_ip
    acl {
        deny 192.168.0.0/16 10.0.0.0/8 100.64.0.0/10 172.16.0.0/12
        allow all
    }
EOF

    echo "  }" >> ${CADDYFILE}

    echo "}" >> ${CADDYFILE}
}

generate_caddyfile
cat ${CADDYFILE}
/app/caddy -conf /app/Caddyfile