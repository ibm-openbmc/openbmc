SUMMARY = "Phosphor OpenBMC SBE Validation"
DESCRIPTION = "Phosphor OpenBMC SBE Validation"
PR = "r1"

require sbe-validation.inc
inherit autotools pkgconfig pythonnative

DEPENDS += "autoconf-archive-native"
DEPENDS += "openssl"
DEPENDS += "phosphor-logging sdbusplus sdbus++-native"
RDEPENDS_${PN} += "sbe-seeprom-tool phosphor-logging sdbusplus"
RDEPENDS_${PN} += "bash"

S = "${WORKDIR}/git"

do_install_append() {
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/git/sbe-validation.sh ${D}${sbindir}/sbe-validation.sh
}
