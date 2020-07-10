if [ -z $CERT_FILE -o -z $KEY_FILE ]; then
    sed -i '/tls_var/d' /app/Caddyfile
else
    sed -i "s#tls_var#tls $CERT_FILE $KEY_FILE#g" /app/Caddyfile
fi

if [ -z $USERNAME -o -z $PASSWORD ]; then
    sed -i '/auth_var/d' /app/Caddyfile
else
    sed -i "s#auth_var#basicauth $USERNAME $PASSWORD#g" /app/Caddyfile
fi

if [ -z $PROBE_URL ]; then
    sed -i '/probe_var/d' /app/Caddyfile
    sed -i '/rewrite_var/d' /app/Caddyfile
else
    sed -i "s#probe_var#probe_resistance $PROBE_URL#g" /app/Caddyfile
    sed -i "s#rewrite_var#rewrite / {\n if \"{method}\" not_has \"CONNECT\"\nto $PROBE_URL\n }#g" /app/Caddyfile
fi

if [ -z $HOST ]; then
    echo "no address to listen"
    exit -1
else
    sed -i "s#host_var#$HOST#g" /app/Caddyfile
fi

cd /app
cat /app/Caddyfile
/app/caddy -conf /app/Caddyfile




