#!/bin/sh
# This will LED back

echo none > /sys/class/leds/yellow:power/trigger
/etc/init.d/led start