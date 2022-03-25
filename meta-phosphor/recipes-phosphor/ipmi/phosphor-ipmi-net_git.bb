SUMMARY = "Phosphor Network IPMI Daemon"
DESCRIPTION = "Daemon to support IPMI protocol over network"
HOMEPAGE = "https://github.com/openbmc/phosphor-net-ipmid"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

inherit autotools pkgconfig
inherit systemd

DEPENDS += "autoconf-archive-native"
DEPENDS += "cli11"
DEPENDS += "phosphor-mapper"
DEPENDS += "systemd"
DEPENDS += "phosphor-ipmi-host"


SRC_URI += "git://github.com/ibm-openbmc/phosphor-net-ipmid;branch=OP940;protocol=https"
SRC_URI += "file://ipmi-net-firewall.sh"
SRCREV = "1f722357c223413924355f3a26b1409739373f90"

S = "${WORKDIR}/git"

do_install_append() {
            install -m 0755 ${WORKDIR}/ipmi-net-firewall.sh \
            ${D}${bindir}/ipmi-net-firewall.sh
}

FILES_${PN} += " \
        ${systemd_system_unitdir}/${PN}@.service \
        ${systemd_system_unitdir}/${PN}@.socket \
        "

# If RMCPP_IFACE is not set by bbappend, set it to default
DEFAULT_RMCPP_IFACE = "eth0"
RMCPP_IFACE ?= "${DEFAULT_RMCPP_IFACE}"

# install parameterized service and socket files
SYSTEMD_SERVICE_${PN} = " \
        ${PN}@${RMCPP_IFACE}.service \
        ${PN}@${RMCPP_IFACE}.socket \
        "

# To add another RMCPP interface, add similar lines to the
# following lines in a bbappend:
#
# ALT_RMCPP_IFACE = "eth1"
# SYSTEMD_SERVICE_${PN} += " \
#     ${PN}@${ALT_RMCPP_IFACE}.service \
#     ${PN}@${ALT_RMCPP_IFACE}.socket \
#     "

# Also, be sure to enable a corresponding entry in the channel
# config file with the same 'name' as the interfaces above
# Override the default phosphor-ipmi-config.bb with a bbappend

