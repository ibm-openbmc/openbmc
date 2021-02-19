FILESEXTRAPATHS_prepend := "${THISDIR}/network:"
SRC_URI_append_ibm-ac-server = " file://ncsi-netlink.service"
SRC_URI_append_mihawk = " file://ncsi-netlink.service"
SRC_URI_append_mowgli = " file://ncsi-netlink.service"
SRC_URI_append_mowgli = " file://0001-Let-usb-network-be-static-ip.patch"

SYSTEMD_SERVICE_${PN}_append_ibm-ac-server = " ncsi-netlink.service"
SYSTEMD_SERVICE_${PN}_append_mihawk = " ncsi-netlink.service"
SYSTEMD_SERVICE_${PN}_append_mowgli = " ncsi-netlink.service"

do_install_append_ibm-ac-server() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ncsi-netlink.service ${D}${systemd_system_unitdir}
}
do_install_append_mihawk() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ncsi-netlink.service ${D}${systemd_system_unitdir}
}
do_install_append_mowgli() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ncsi-netlink.service ${D}${systemd_system_unitdir}
}
