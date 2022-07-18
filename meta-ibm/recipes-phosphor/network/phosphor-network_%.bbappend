FILESEXTRAPATHS:prepend := "${THISDIR}/network:"

inherit obmc-phosphor-systemd

OBMC_NETWORK_INTERFACES ?= "eth0"
OBMC_NETWORK_INTERFACES:append:p10bmc = " eth1"

FAILOVER_TMPL = "ncsi-failover@.service"
LINKSPEED_TMPL = "ncsi-linkspeed@.service"

SRC_URI += " file://ncsi-netlink-ifindex"
SRC_URI:append:ibm-ac-server = " file://${FAILOVER_TMPL}"
SRC_URI:append:mihawk = " file://${FAILOVER_TMPL}"
SRC_URI:append:p10bmc = " file://${LINKSPEED_TMPL}"

SYSTEMD_SERVICE:${PN}:append:ibm-ac-server = " ${FAILOVER_TMPL}"
SYSTEMD_SERVICE:${PN}:append:mihawk = " ${FAILOVER_TMPL}"
SYSTEMD_SERVICE:${PN}:append:p10bmc = " ${LINKSPEED_TMPL}"

FAILOVER_TGTFMT = "ncsi-failover@{0}.service"
LINKSPEED_TGTFMT = "ncsi-linkspeed@{0}.service"
FAILOVER_FMT = "../${FAILOVER_TMPL}:network.target.wants/${FAILOVER_TGTFMT}"
LINKSPEED_FMT = "../${LINKSPEED_TMPL}:network.target.wants/${LINKSPEED_TGTFMT}"

SYSTEMD_LINK:${PN}:append:ibm-ac-server = "${@compose_list(d, 'FAILOVER_FMT', 'OBMC_NETWORK_INTERFACES')}"
SYSTEMD_LINK:${PN}:append:mihawk = "${@compose_list(d, 'FAILOVER_FMT', 'OBMC_NETWORK_INTERFACES')}"
SYSTEMD_LINK:${PN}:append:p10bmc = "${@compose_list(d, 'LINKSPEED_FMT', 'OBMC_NETWORK_INTERFACES')}"

FILES:${PN} += "${libexecdir}/ncsi-netlink-ifindex"
FILES:${PN} += "${datadir}/network/*.json"

PACKAGECONFIG:append = " sync-mac"

PACKAGECONFIG:append:p10bmc = " hyp-nw-config"
PACKAGECONFIG:remove:p10bmc = "default-ipv6-accept-ra"
SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'hyp-nw-config', 'xyz.openbmc_project.Network.Hypervisor.service', '', d)}"

install_network_configuration(){
    install -d ${D}${datadir}/network/
    install -m 0644 ${WORKDIR}/inventory-object-map.json ${D}${datadir}/network/config.json
}

do_install:append() {
    install -d ${D}${libexecdir}
    install -m 0755 ${WORKDIR}/ncsi-netlink-ifindex ${D}${libexecdir}
}

SRC_URI:append:p10bmc = " file://inventory-object-map.json"
do_install:append:p10bmc(){
    install_network_configuration
}

SRC_URI:append:ibm-ac-server = " file://inventory-object-map.json"
do_install:append:ibm-ac-server() {
    install_network_configuration
}

SRC_URI:append:mihawk = " file://inventory-object-map.json"
do_install:append:mihawk() {
    install_network_configuration
}

SRC_URI:append:witherspoon-tacoma = " file://inventory-object-map.json"
do_install:append:witherspoon-tacoma(){
    install_network_configuration
}
