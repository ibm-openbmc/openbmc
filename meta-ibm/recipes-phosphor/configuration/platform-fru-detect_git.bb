LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "git://git@github.com/amboar/platform-fru-detect.git;protocol=ssh;branch=main"

# Modify these as desired
PV = "0.1+git${SRCPV}"
SRCREV = "874dc047545f661ec01e92e37f558fc4aaf7b054"

S = "${WORKDIR}/git"

DEPENDS += "sdbusplus libgpiod"

inherit meson
inherit systemd

SYSTEMD_SERVICE:${PN} += "platform-fru-detect.service"
