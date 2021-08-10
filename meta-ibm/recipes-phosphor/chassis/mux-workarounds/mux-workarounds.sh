#!/bin/sh
set -eu

reset_bus_4() {
    i2cset -f -y 0 0x61 7 0x15 b
    sleep 0.1
    i2cset -f -y 0 0x61 7 0x55 b
    sleep 0.1
}

reset_buses_5_6_and_14() {
    i2cset -f -y 0 0x61 8 0x10 b
    sleep 0.1
    i2cset -f -y 0 0x61 8 0x55 b
    sleep 0.1
}

reset_bus_15() {
    i2cset -f -y 0 0x61 9 0x54 b
    sleep 0.1
    i2cset -f -y 0 0x61 9 0x55 b
    sleep 0.1
}

# everest system only
if [ $(fw_printenv fitconfig | grep everest) ]; then
    gpiopath="/sys/bus/platform/drivers/gpio-keys-polled"
    drvpath="/sys/bus/i2c/drivers/pca954x"

    # remove gpio dependencies
    echo gpio-keys-polled > $gpiopath/unbind

    # bus 4
    if [ -e $drvpath/4-0070 ]; then echo 4-0070 > $drvpath/unbind; fi
    reset_bus_4
    echo 4-0070 > $drvpath/bind

    # buses 5, 6, and 14
    if [ -e $drvpath/5-0070 ]; then echo 5-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/6-0070 ]; then echo 6-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/14-0070 ]; then echo 14-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/14-0071 ]; then echo 14-0071 > $drvpath/unbind; fi
    reset_buses_5_6_and_14
    echo 5-0070 > $drvpath/bind
    echo 6-0070 > $drvpath/bind
    echo 14-0070 > $drvpath/bind
    echo 14-0071 > $drvpath/bind

    # bus 15
    if [ -e $drvpath/15-0070 ]; then echo 15-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/15-0071 ]; then echo 15-0071 > $drvpath/unbind; fi
    if [ -e $drvpath/15-0072 ]; then echo 15-0072 > $drvpath/unbind; fi
    reset_bus_15
    echo 15-0070 > $drvpath/bind
    echo 15-0071 > $drvpath/bind
    echo 15-0072 > $drvpath/bind

    echo gpio-keys-polled > $gpiopath/bind
fi
