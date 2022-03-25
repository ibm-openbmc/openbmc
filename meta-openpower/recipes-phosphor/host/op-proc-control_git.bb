SUMMARY = "OpenPower procedure control"
DESCRIPTION = "Provides procedures that run against the host chipset"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

S = "${WORKDIR}/git"

inherit autotools obmc-phosphor-utils pkgconfig pythonnative
inherit systemd

SRC_URI += "git://github.com/ibm-openbmc/openpower-proc-control;branch=OP940;protocol=https"
SRCREV = "bfa88ed112efdabd6b9589da0100ee9e9c0d716e"

DEPENDS += " \
        autoconf-archive-native \
        phosphor-logging \
        phosphor-dbus-interfaces \
        openpower-dbus-interfaces \
        pdbg \
        "

TEMPLATE = "pcie-poweroff@.service"
INSTANCE_FORMAT = "pcie-poweroff@{}.service"
INSTANCES = "${@compose_list(d, 'INSTANCE_FORMAT', 'OBMC_CHASSIS_INSTANCES')}"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "${TEMPLATE} ${INSTANCES}"
SYSTEMD_SERVICE_${PN} +=  " \
                         xyz.openbmc_project.Control.Host.NMI.service \
                         "
