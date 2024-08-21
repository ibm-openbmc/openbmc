SUMMARY = "IBM UPS monitoring application"
DESCRIPTION = "IBM UPS monitoring application"
PV = "1.0+git${SRCPV}"
PR = "r1"
HOMEPAGE = "https://github.com/ibm-openbmc/ibm-ups"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"
SRC_URI = "git://github.com/ibm-openbmc/ibm-ups;nobranch=1;protocol=https"
SRCREV = "beb8b136b6029f1ee9ba4824d12112d80388e159"

inherit meson
inherit pkgconfig
inherit systemd

S = "${WORKDIR}/git"

DEPENDS += "cli11"
DEPENDS += "phosphor-dbus-interfaces"
DEPENDS += "phosphor-logging"
DEPENDS += "sdbusplus"
DEPENDS += "sdeventplus"
DEPENDS += "stdplus"

SYSTEMD_SERVICE:${PN} = "ibm-ups.service"
FILES:${PN} = "${bindir}/ibm-ups"
