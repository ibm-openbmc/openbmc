FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"


SRC_URI:append:p10bmc = " \
    file://0001-i2c-Allow-throttling-of-transfers-to-client-devices.patch \
    file://0002-pmbus-ucd9000-Throttle-SMBus-transfers-to-avoid-poor.patch \
    file://0003-ucd9000-Add-a-throttle-delay-attribute-in-debugfs.patch \
    file://0004-fsi-run-clock-at-100MHz.patch \
    file://0005-pmbus-core-Add-a-one-shot-retry-in-pmbus_set_page.patch \
    file://0006-pmbus-max31785-Add-a-local-pmbus_set_page-implementa.patch \
    file://0007-pmbus-max31785-Retry-enabling-fans-after-writing-MFR.patch \
    file://0008-ARM-dts-aspeed-Rainier-Add-fan-controller-properties.patch \
    file://0009-ARM-dts-aspeed-Everest-Add-fan-controller-properties.patch \
    file://0010-ARM-dts-aspeed-Rainier-4U-Delete-fan-dual-tach-prope.patch \
    file://0011-ARM-dts-aspeed-Add-Rainier-2U-and-4U-device-trees-fo.patch \
    file://0012-ARM-dts-aspeed-Everest-and-Rainier-Add-bmc-managemen.patch \
    file://0013-ARM-dts-aspeed-everest-Specify-I2C8-mux-reset-gpio.patch \
    file://0014-hwmon-occ-Delay-hwmon-registration-until-user-reques.patch \
    file://0015-leds-pca955x-throttle-i2c-transfers.patch \
    file://0016-hwmon-occ-Lock-mutex-in-shutdown-to-prevent-race-wit.patch \
    file://0017-spi-fsi-Increase-timeout-and-ensure-status-is-checke.patch \
    file://0018-ARM-dts-aspeed-Fix-pca9551-nodes-on-Rainier-182.patch \
    file://0019-ipmi-kcs-Poll-OBF-briefly-to-reduce-OBE-latency-183.patch \
    file://0020-watchdog-aspeed-Add-pre-timeout-interrupt-support.patch \
    file://0021-ARM-dts-aspeed-Setup-watchdog-pre-timeout-interrupt.patch \
    file://0022-ARM-dts-aspeed-p10bmc-Set-watchdog-pre-timeout-inter.patch \
    "

SRC_URI:append:ibm-ac-server = " file://witherspoon.cfg"
SRC_URI:append:p10bmc = " file://p10bmc.cfg"
SRC_URI:append:mihawk = " file://mihawk.cfg"
SFCLIENT_SIGN_ENABLE ?= "0"

python __anonymous() {
    if d.getVar('SFCLIENT_SIGN_ENABLE') == '1':
        check_var_names = [
            'SF_PKCS11_CONFIG',
            'SSH_AUTH_SOCK',
            'SSH_AGENT_PID',
        ]
        check_vars = []
        for name in check_var_names:
            check_vars.append(d.getVar(name))
        if not all(check_vars):
            bb.fatal('Signing with sfclient but one of {} is unset'.format(
                ', '.join(check_var_names)))

        spl_sign_key = d.getVar('SPL_SIGN_KEYNAME')
        uboot_sign_key = d.getVar('UBOOT_SIGN_KEYNAME')
        d.setVar('SPL_SIGN_KEYDIR', 'object={}'.format(spl_sign_key))
        d.setVar('SPL_MKIMAGE_SIGN_ARGS', '-N pkcs11')
        d.setVar('UBOOT_SIGN_KEYDIR', 'object={}'.format(uboot_sign_key))
        d.setVar('UBOOT_MKIMAGE_SIGN_ARGS', '-N pkcs11')
        depends = d.getVar('DEPENDS')
        depends += ' sfclient-native libp11-native'
        d.setVar('DEPENDS', depends)
}
