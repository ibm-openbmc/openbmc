SUMMARY = "Phosphor IPMI plugin for the Host I/O Mapping Protocol"
HOMEPAGE = "https://github.com/openbmc/openpower-host-ipmi-flash"
PR = "r1"
PV = "0.1+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=ff331e820fda701d36a8f0efc98adc58"

inherit autotools pkgconfig
inherit obmc-phosphor-ipmiprovider-symlink

DEPENDS += "phosphor-ipmi-host"
DEPENDS += "autoconf-archive-native"
DEPENDS += "sdbusplus sdbusplus-native"
DEPENDS += "phosphor-logging"
DEPENDS += "phosphor-dbus-interfaces phosphor-dbus-interfaces-native"
DEPENDS += "openpower-dbus-interfaces openpower-dbus-interfaces-native"

TARGET_CFLAGS += "-fpic"

HOSTIPMI_PROVIDER_LIBRARY += "libhiomap.so"

S = "${WORKDIR}/git"

SRC_URI += "git://github.com/openbmc/openpower-host-ipmi-flash;branch=master;protocol=https"
SRCREV = "d4b7f5e4819aa6e3ddb165a80149dd1a1c1649d7"

FILES_${PN}_append = " ${libdir}/ipmid-providers/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/host-ipmid/lib*${SOLIBS}"
FILES_${PN}-dev_append = " ${libdir}/ipmid-providers/lib*${SOLIBSDEV} ${libdir}/ipmid-providers/*.la"
