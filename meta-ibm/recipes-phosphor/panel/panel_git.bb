SUMMARY = "IBM Panel Service"
DESCRIPTION = "Panel Daemon which manages the control panel button events and panel functions"

PR = "r0"
PV = "1.0+git${SRCPV}"

inherit meson pkgconfig
inherit systemd

require panel.inc

DEPENDS += "sdbusplus"
DEPENDS += "systemd"
DEPENDS += "pldm"

S = "${WORKDIR}/git"

EXTRA_OEMESON := "-Dtests=disabled"
SYSTEMD_SERVICE:${PN} += "com.ibm.panel.service"
