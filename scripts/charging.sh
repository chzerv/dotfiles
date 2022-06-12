#!/bin/sh

/usr/bin/powerprofilesctl set balanced && \
    echo 1 > /sys/devices/system/cpu/cpufreq/boost
