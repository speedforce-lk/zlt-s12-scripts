#!/bin/sh

# to change IMEI run the file and IMEI number as argument see example below
# ./changeImei.sh 356256873546712

# verifiying if IMEI is valid
echo "${1}" | grep -q '[^0-9]'
if [ $? = 1 ] && [ ${#1} -eq 15 ]; then
        at_sender -e at+spimei=0,\"$1\" >/dev/null
        eth_mac s imei $1
fi
