SUMMARY = "Phosphor GPIO monitor application"
DESCRIPTION = "Application to monitor gpio assertions"
HOMEPAGE = "http://github.com/openbmc/phosphor-gpio-monitor"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"
inherit autotools pkgconfig
inherit obmc-phosphor-dbus-service

GPIO_PACKAGES = " \
        ${PN}-monitor \
        ${PN}-presence \
"

PACKAGE_BEFORE_PN += "${GPIO_PACKAGES}"
ALLOW_EMPTY_${PN} = "1"
SYSTEMD_PACKAGES = "${GPIO_PACKAGES}"

RPROVIDES_${PN}-monitor += "virtual/obmc-gpio-monitor"
RPROVIDES_${PN}-presence += "virtual/obmc-gpio-presence"

PROVIDES += "virtual/obmc-gpio-monitor"
PROVIDES += "virtual/obmc-gpio-presence"

DEPENDS += "autoconf-archive-native"
DEPENDS += "sdbusplus sdbusplus-native"
DEPENDS += "phosphor-dbus-interfaces"
DEPENDS += "libevdev"
DEPENDS += "phosphor-logging"
DEPENDS += "systemd"

SYSTEMD_SERVICE_${PN}-monitor += "phosphor-gpio-monitor@.service"
SYSTEMD_SERVICE_${PN}-presence += "phosphor-gpio-presence@.service"

FILES_${PN}-monitor += "${bindir}/phosphor-gpio-monitor"
FILES_${PN}-monitor += "${bindir}/phosphor-gpio-util"
FILES_${PN}-presence += "${bindir}/phosphor-gpio-presence"

SRC_URI += "git://github.com/openbmc/phosphor-gpio-monitor;branch=master;protocol=https"
SRCREV = "206f0040985e27a0651a9164d7958bf347142a31"
S = "${WORKDIR}/git"
