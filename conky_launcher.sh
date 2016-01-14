#!/bin/bash

DIR=~/conkyconf/

writeToKernel() {
    echo "<1>[Conky] $1" | sudo tee /dev/kmsg
}

launch() {
    RUN=`ps aux | grep conky | grep $1`

    if [ -z "$RUN" ]; then
        conky -c $DIR$1 &
        writeToKernel "started $1"
    else
        writeToKernel "$1 is already running"
    fi
}

main() {
    launch "kernel_rc"
    launch "system_rc"
    launch "battery_rc"
    launch "temperature_rc"
    launch "cooling_rc"
    launch "load_rc"
    launch "memory_rc"
    launch "io_rc"
    launch "storage_rc"
    launch "network_rc"
}

writeToKernel "Called by $USER@$HOSTNAME"
main
