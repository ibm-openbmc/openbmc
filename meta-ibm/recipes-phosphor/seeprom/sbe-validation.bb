SUMMARY = "Phosphor OpenBMC SBE Validation"
DESCRIPTION = "Phosphor OpenBMC SBE Validation"
PR = "r1"

HOMEPAGE = "http://github.ibm.com/openbmc/sbe-validation"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${PHOSPHORBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"
SRC_URI += "git://git@github.ibm.com/openbmc/sbe-validation.git;protocol=ssh"
SRCREV = "13ab183c807e097635068e3bc548cdb926d0f37c"

inherit autotools pkgconfig

DEPENDS += "autoconf-archive-native"
DEPENDS += "openssl"
RDEPENDS_${PN} += "sbe-seeprom-tool"
RDEPENDS_${PN} += "bash"

S = "${WORKDIR}/git"

do_install_append() {
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/git/sbe-validation.sh ${D}${sbindir}/sbe-validation.sh
}
