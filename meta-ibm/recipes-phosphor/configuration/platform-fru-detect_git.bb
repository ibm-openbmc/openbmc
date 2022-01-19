LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "git://git@github.com/ibm-openbmc/platform-fru-detect.git;protocol=ssh;branch=main"

# Modify these as desired
PV = "0.1+git${SRCPV}"
SRCREV = "fed28fa4418b16c9b55899616b14393ff9652176"

S = "${WORKDIR}/git"

DEPENDS += "sdbusplus libgpiod phosphor-logging googletest i2c-tools"

inherit meson
inherit systemd

SYSTEMD_SERVICE:${PN} += "platform-fru-detect.service"
