SUMMARY = "I2C Mux Device Workarounds"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch
inherit obmc-phosphor-systemd

RDEPENDS_${PN} += "i2c-tools"

S = "${WORKDIR}"

SRC_URI += "file://mux-workarounds.sh"

do_install() {
        install -d ${D}${bindir}
        install -m 0755 ${S}/mux-workarounds.sh ${D}${bindir}/mux-workarounds.sh
}

SYSTEMD_SERVICE_${PN} := "mux-workarounds.service"
