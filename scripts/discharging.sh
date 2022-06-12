#!/bin/sh

/usr/bin/powerprofilesctl set power-saver && \
    echo 0 > /sys/devices/system/cpu/cpufreq/boost
