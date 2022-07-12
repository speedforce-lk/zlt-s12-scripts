#!/bin/sh

# This will turn off all LEDS you can turn it back by rebooting or running the turn off script
/etc/init.d/led stop
for file in /sys/class/leds/*/brightness
do
        echo 0 > $file
done
lua -l tz.led -e 'led_module.led_all_off()'


# Uncomment all the code below to have breathing light on power LED
#LED="blue:power"
#DELAY_ON=1000
#DELAY_OFF=15000
#cd /sys/class/leds/$LED
#echo timer > trigger
#echo $DELAY_ON > delay_on
#echo $DELAY_OFF > delay_off