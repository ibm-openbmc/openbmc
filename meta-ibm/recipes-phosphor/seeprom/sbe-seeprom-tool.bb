SUMMARY = "Phosphor OpenBMC SBE I2C Read Tool"
DESCRIPTION = "Phosphor OpenBMC SBE I2C Read Tool"
PR = "r1"

HOMEPAGE = "http://github.ibm.com/openbmc/sbe-seeprom-tool"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${PHOSPHORBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"
SRC_URI += "git://git@github.ibm.com/openbmc/sbe-seeprom-tool.git;protocol=ssh"
SRCREV = "20c735678d4666e12a91195e7e0d51f7ad507345"

inherit pkgconfig

TARGET_CC_ARCH += "${LDFLAGS}"

S = "${WORKDIR}/git"

FILES_${PN} = "${sbindir}/seeprom"

do_install() {
         install -d ${D}${sbindir}
         install -m 0755 seeprom ${D}${sbindir}
}
