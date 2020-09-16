#!/bin/bash
# #########################################################
# Script to run on mowgli BMC to unbind/bind the ir35221
# driver's devices

status=0
max_retries=3
driver_path="/sys/bus/i2c/drivers/ir35221/"
platform_path="/sys/devices/platform/ahb/ahb:apb/ahb:apb:bus@1e78a000/"

unbind_driver () {
    echo $1 > $driver_path/unbind
}

bind_driver () {
    device=$1
    tries=0

    until [ $tries -ge $max_retries ]; do
        tries=$((tries+1))
        ret=0
        echo $device > $driver_path/bind || ret=$?
        if [ $ret -ne 0 ]; then
            echo "VRM $1 bind failed. Try $tries"
            sleep 1
        else
            tries=$((max_retries+1))
        fi
    done

    #Script will return a nonzero value if any binds fail.
    if [ $ret -ne 0 ]; then
        status=$ret
    fi
}

if [ "$1" = "unbind" ]
then
    if [ -e $driver_path/4-0028 ]
    then
        unbind_driver "4-0028"
    fi

    if [ -e $driver_path/4-0029 ]
    then
        unbind_driver "4-0029"
    fi
elif [ "$1" = "bind" ]
then
    if [ -e $platform_path/1e78a140.i2c-bus/i2c-4/4-0028 ]
    then
        bind_driver "4-0028"
    fi

    if [ -e $platform_path/1e78a140.i2c-bus/i2c-4/4-0029 ]
    then
        bind_driver "4-0029"
    fi

fi

exit $status
