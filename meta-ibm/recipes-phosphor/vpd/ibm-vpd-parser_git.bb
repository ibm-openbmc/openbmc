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
DEPENDS += "libgpiod"

require ${PN}.inc

SRC_URI += " file://70-ibm-vpd-parser.rules"
SRC_URI += " file://vpd_inventory.json"
SRC_URI += " file://50001001.json"
SRC_URI += " file://50001001_v2.json"
SRC_URI += " file://50001000.json"
SRC_URI += " file://50001000_v2.json"
SRC_URI += " file://50001002.json"
SRC_URI += " file://com.ibm.VPD.Manager.service"
SRC_URI += " file://50003000.json"
SRC_URI += " file://50003000_v2.json"
SRC_URI += " file://50004000.json"
SRC_URI += " file://systems.json"
SRC_URI += " file://libvpdecc.so.1.0"

S = "${WORKDIR}/git"

SYSTEMD_SERVICE:${PN} := "ibm-vpd-parser@.service"
SYSTEMD_SERVICE:${PN} += "system-vpd.service"
SYSTEMD_SERVICE:${PN} += "com.ibm.VPD.Manager.service"
EXTRA_OEMESON := " -Dibm-parser=enabled -Dtests=disabled -Dvpd-manager=enabled"

FILES:${PN} += "${datadir}/vpd/*.json"
FILES:${PN} += "${libdir}/libvpdecc.so.1.0"

do_install:append() {
    install -d ${D}/${base_libdir}/udev/rules.d/
    install -d ${D}${datadir}/vpd/
    install -d ${D}${libdir}
    install -m 0644 ${WORKDIR}/70-ibm-vpd-parser.rules ${D}/${base_libdir}/udev/rules.d/
    install ${WORKDIR}/*.json ${D}${datadir}/vpd/
    install -m 0755 ${WORKDIR}/libvpdecc.so.1.0 ${D}/${libdir}/libvpdecc.so.1.0
}
