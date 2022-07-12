#!/bin/sh
# This will generate random IMEI and change IMEI
# It needs the changeImei.sh file and should be in the same directory


IMEI=35672811
#Generating random 6 digit
randomNumber=$(($(hexdump -n 4 -e '"%u"' </dev/urandom) % 10 ))
for i in 1 2 3 4 5
do
    RAND=$(($(hexdump -n 4 -e '"%u"' </dev/urandom) % 10 ))
    randomNumber="${randomNumber}${RAND}"
done
IMEI="${IMEI}${randomNumber}"

# calculating the last check digit
MUL=2
SUM=0
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14
do
    if [[ $MUL -eq 1 ]]
    then
        MUL=2
    else
        MUL=1
    fi

    CURRENT=${IMEI:$i-1:1} 
    TMP=$((CURRENT*MUL))
    if [[ $TMP -gt 9 ]]
    then
          TMP=$((${TMP:0:1} + ${TMP:1:1}))
    fi
    SUM=$(($SUM + $TMP))
done
C=$(((10 - ($SUM % 10)) % 10))
IMEI="${IMEI}${C}"

# Changing the IMEI
script_name=$0
script_full_path=$(dirname "$0")
program="/changeImei.sh"
changeimei="${script_full_path}${program}"
$changeimei $IMEI
