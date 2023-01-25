FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:p10bmc = " file://mctp"
SRC_URI:append:p10bmc = " file://service-override.conf"
SRC_URI:append:witherspoon-tacoma = " file://mctp"

PACKAGECONFIG:append:p10bmc = " astlpc-raw-kcs"
PACKAGECONFIG:append:witherspoon-tacoma = " astlpc-raw-kcs"

FILES:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'astlpc-raw-kcs', \
    " ${systemd_system_unitdir}/mctp-demux.service.d/service-override.conf ", '', d)}"

do_install:append:p10bmc() {
     install -d ${D}${sysconfdir}/default
     install -m 0644 ${WORKDIR}/mctp ${D}${sysconfdir}/default/mctp
     install -d ${D}${systemd_system_unitdir}/mctp-demux.service.d
     install -D -m 0644 ${WORKDIR}/service-override.conf ${D}${systemd_system_unitdir}/mctp-demux.service.d/
}
