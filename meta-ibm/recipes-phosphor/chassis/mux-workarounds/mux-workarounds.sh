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
    mux4=
    mux5=
    mux6=
    mux140=
    mux141=
    mux150=
    mux151=
    mux152=
    echo "Detected everest system; performing I2C mux workarounds"

    gpiopath="/sys/bus/platform/drivers/gpio-keys-polled"
    drvpath="/sys/bus/i2c/drivers/pca954x"

    # remove gpio dependencies
    echo gpio-keys-polled > $gpiopath/unbind

    # bus 4
    if [ -e $drvpath/4-0070 ]; then mux4=1; echo 4-0070 > $drvpath/unbind; fi
    reset_bus_4
    if [ -n "$mux4" ]; then echo 4-0070 > $drvpath/bind; fi

    # buses 5, 6, and 14
    if [ -e $drvpath/5-0070 ]; then mux5=1; echo 5-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/6-0070 ]; then mux6=1; echo 6-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/14-0070 ]; then mux140=1; echo 14-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/14-0071 ]; then mux141=1; echo 14-0071 > $drvpath/unbind; fi
    reset_buses_5_6_and_14
    if [ -n "$mux5" ]; then echo 5-0070 > $drvpath/bind; fi
    if [ -n "$mux6" ]; then echo 6-0070 > $drvpath/bind; fi
    if [ -n "$mux140" ]; then echo 14-0070 > $drvpath/bind; fi
    if [ -n "$mux141" ]; then echo 14-0071 > $drvpath/bind; fi

    # bus 15
    if [ -e $drvpath/15-0070 ]; then mux150=1; echo 15-0070 > $drvpath/unbind; fi
    if [ -e $drvpath/15-0071 ]; then mux151=1; echo 15-0071 > $drvpath/unbind; fi
    if [ -e $drvpath/15-0072 ]; then mux152=1; echo 15-0072 > $drvpath/unbind; fi
    reset_bus_15
    if [ -n "$mux150" ]; then  echo 15-0070 > $drvpath/bind; fi
    if [ -n "$mux151" ]; then  echo 15-0071 > $drvpath/bind; fi
    if [ -n "$mux152" ]; then  echo 15-0072 > $drvpath/bind; fi

    echo gpio-keys-polled > $gpiopath/bind
fi
