#!/bin/sh
# everest system only
if [ $(fw_printenv fitconfig | grep everest) ]; then
    echo "Detected everest system; performing I2C mux workarounds"

    gpiopath="/sys/bus/platform/drivers/gpio-keys-polled"
    drvpath="/sys/bus/i2c/drivers/pca954x"

    # remove gpio dependencies
    echo gpio-keys-polled > $gpiopath/unbind

    # bus 14
    if [ -e $drvpath/14-0070 ]; then echo 14-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/14-0071 ]; then echo 14-0071 > $drvpath/unbind; fi

    i2cset -f -y 0 0x61 8 0x15 b
    sleep 0.1
    i2cset -f -y 0 0x61 8 0x55 b
    sleep 0.1

    echo 14-0070 > $drvpath/bind
    echo 14-0071 > $drvpath/bind

    # bus 15
    if [ -e $drvpath/15-0070 ]; then echo 15-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/15-0071 ]; then echo 15-0071 > $drvpath/unbind; fi
    if [ -e $drvpath/15-0072 ]; then echo 15-0072 > $drvpath/unbind; fi
    
    i2cset -f -y 0 0x61 9 0x54 b
    sleep 0.1
    i2cset -f -y 0 0x61 9 0x55 b
    sleep 0.1

    echo 15-0070 > $drvpath/bind
    echo 15-0071 > $drvpath/bind
    echo 15-0072 > $drvpath/bind

    echo gpio-keys-polled > $gpiopath/bind
fi
