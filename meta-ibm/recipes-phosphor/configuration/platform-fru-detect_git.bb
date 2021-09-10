LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "git://git@github.com/ibm-openbmc/platform-fru-detect.git;protocol=ssh;branch=main"

# Modify these as desired
PV = "0.1+git${SRCPV}"
SRCREV = "0b401f51db52602156aa7f64998a54f6b64bf242"

S = "${WORKDIR}/git"

DEPENDS += "sdbusplus libgpiod phosphor-logging googletest i2c-tools"

inherit meson pkgconfig
inherit systemd

SYSTEMD_SERVICE:${PN} += "platform-fru-detect.service"
