SUMMARY = "ID Button pressed application"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${IBMBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit obmc-phosphor-systemd

DEPENDS += "virtual/obmc-gpio-monitor"
RDEPENDS_${PN} += "virtual/obmc-gpio-monitor"

S = "${WORKDIR}"
SRC_URI += " \
        file://toggle_identify_led.sh \
        file://99-gpio-keys.rules \
        "

do_install() {
        install -d ${D}${bindir}
        install -m 0755 ${WORKDIR}/toggle_identify_led.sh \
            ${D}${bindir}/toggle_identify_led.sh
        install -d ${D}${base_libdir}/udev/rules.d/
        install ${WORKDIR}/99-gpio-keys.rules ${D}${base_libdir}/udev/rules.d/
}

SYSTEMD_ENVIRONMENT_FILE_${PN} +="obmc/gpio/id_button"

SYSTEMD_SERVICE_${PN} += "id-button-pressed.service"
