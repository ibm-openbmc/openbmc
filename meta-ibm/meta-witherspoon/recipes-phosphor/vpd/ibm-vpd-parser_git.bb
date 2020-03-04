SUMMARY = "Parser for IBM based IPZ and Keyword format FRU VPD"
DESCRIPTION = "Parse FRU VPD and update into DBUS"
PR = "r1"
PV = "1.0+git${SRCPV}"

inherit meson pkgconfig
inherit obmc-phosphor-systemd

DEPENDS += "sdbusplus"
DEPENDS += "phosphor-logging"
DEPENDS += "autoconf-archive-native"
DEPENDS += "cli11"
DEPENDS += "nlohmann-json"

require ${PN}.inc

SRC_URI += " file://70-ibm-vpd-parser.rules"
SRC_URI += " file://vpd_inventory.json"

S = "${WORKDIR}/git"

SYSTEMD_SERVICE_${PN} := "ibm-vpd-parser@.service"
SYSTEMD_SERVICE_${PN} += "system-vpd.service"
EXTRA_OEMESON := " -Dibm-parser=enabled -Dtests=disabled "

FILES_${PN} += "${datadir}/vpd/*.json"

do_install_append() {
    install -d ${D}/${base_libdir}/udev/rules.d/
    install -d ${D}${datadir}/vpd/
    install ${WORKDIR}/70-ibm-vpd-parser.rules ${D}/${base_libdir}/udev/rules.d/
    install ${WORKDIR}/*.json ${D}${datadir}/vpd/
}
