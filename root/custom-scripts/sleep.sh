#!/bin/sh
# ZLT S12 Pro Sleep Mode

# turn off all leds
/etc/init.d/led stop
for file in /sys/class/leds/*/brightness
do
        echo 0 > $file
done
lua -l tz.led -e 'led_module.led_all_off()'

# uncommnet code below to keep yellow power led on
# echo default-on > /sys/class/leds/yellow:power/trigger


# Stop all interfaces
wifi down
for i in $(ifconfig | grep "Link encap:" | sed 's/Link.*//')
do
        ifconfig $i down
done

# Kill lots of services
killall uhttpd lua dropbear hostapd sftp-server pppd ntpd odhcpd vsftpd dnsmasq ntpd radiusd radvd dhcrelay

# remove lots of modules
# loop for 10 times to rmmod some high-dependent modules
for j in $(seq 0 10)
do
        for i in $(find /lib/modules | grep ko)
        do
                rmmod $i
        done
done

# stop all the services except crond
for i in $(ls /etc/init.d/ | grep -v cron)
do
        /etc/init.d/$i stop
done
# "umount stop" includes sync and umount all

# shut down usb power
echo 0 > /sys/class/gpio/gpio30/value
echo 0 > /sys/class/gpio/gpio45/value
echo 0 > /sys/class/gpio/gpio47/value