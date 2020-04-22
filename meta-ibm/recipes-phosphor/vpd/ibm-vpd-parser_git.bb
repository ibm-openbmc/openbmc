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
DEPENDS += "phosphor-dbus-interfaces"

require ${PN}.inc

SRC_URI += " file://70-ibm-vpd-parser.rules"
SRC_URI += " file://vpd_inventory.json"
SRC_URI += " file://com.ibm.vpd.Editor.service"

S = "${WORKDIR}/git"

SYSTEMD_SERVICE_${PN} := "ibm-vpd-parser@.service"
SYSTEMD_SERVICE_${PN} += "system-vpd.service"
SYSTEMD_SERVICE_${PN} += "dbus-com.ibm.vpd.Editor.service"
EXTRA_OEMESON := " -Dibm-parser=enabled -Dtests=disabled -Dkwd-editor=enabled"

FILES_${PN} += "${datadir}/vpd/*.json"
FILES_${PN} += "${datadir}/dbus-1/system-services/*.service"

do_install_append() {
    install -d ${D}/${base_libdir}/udev/rules.d/
    install -d ${D}${datadir}/vpd/
    install -d ${D}${datadir}/dbus-1/system-services
    install ${WORKDIR}/70-ibm-vpd-parser.rules ${D}/${base_libdir}/udev/rules.d/
    install ${WORKDIR}/*.json ${D}${datadir}/vpd/
    install -m 0644 ${WORKDIR}/com.ibm.vpd.Editor.service ${D}/${datadir}/dbus-1/system-services
}
