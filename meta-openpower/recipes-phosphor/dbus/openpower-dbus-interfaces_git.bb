SUMMARY = "Open POWER DBus Interfaces"
DESCRIPTION = "Generated bindings, using sdbus++, for the openpower YAML"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
inherit pythonnative
inherit phosphor-dbus-yaml

DEPENDS += "autoconf-archive-native"
DEPENDS += "sdbus++-native"

SRC_URI += "git://github.com/ibm-openbmc/openpower-dbus-interfaces;branch=OP940;protocol=https"
SRCREV = "c6d7984fa6d4d1bf51fd2bb91eb44d630f891f87"

DEPENDS_remove_class-native = "sdbus++-native"
DEPENDS_remove_class-nativesdk = "sdbus++-native"

PACKAGECONFIG ??= "libopenpower_dbus"
PACKAGECONFIG[libopenpower_dbus] = " \
        --enable-libopenpower_dbus, \
        --disable-libopenpower_dbus, \
        systemd sdbusplus, \
        libsystemd sdbusplus \
        "

PACKAGECONFIG_remove_class-native = "libopenpower_dbus"
PACKAGECONFIG_remove_class-nativesdk = "libopenpower_dbus"

BBCLASSEXTEND += "native nativesdk"
