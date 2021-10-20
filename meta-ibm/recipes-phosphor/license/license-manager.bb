SUMMARY     = "License manager"
DESCRIPTION = "Provide a way to upload new license key"
PR = "r1"
PV = "1.0+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

SRC_URI = "git://github.com/ibm-openbmc/license-manager.git;nobranch=1"
SRCREV = "3d56ee1fd128d69d6f04de27fa0d16b76c69fd18"

inherit meson systemd

DEPENDS = " \
     phosphor-dbus-interfaces \
     phosphor-logging \
     sdeventplus \
     sdbusplus \
"

S = "${WORKDIR}/git"

SYSTEMD_SERVICE:${PN} = "license-manager.service"

