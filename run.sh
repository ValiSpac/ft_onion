#!/bin/bash
runuser -u debian-tor -- tor -f /etc/tor/torrc &

while [ ! -f /var/lib/tor/hidden_service/hostname ]; do
    sleep 1
done

TOR_HOSTNAME=$(cat /var/lib/tor/hidden_service/hostname)
echo "TOR link: $TOR_HOSTNAME"

sed -i "s/server_name _;/server_name $TOR_HOSTNAME;/" /etc/nginx/sites-available/default

nginx

sleep infinity
