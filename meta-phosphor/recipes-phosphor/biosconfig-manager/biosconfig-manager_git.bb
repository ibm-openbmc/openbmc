SUMMARY = "Remote BIOS Configuration via BMC"
DESCRIPTION = "Provides ability for the user to view and modify the \
              BIOS setup configuration parameters remotely via BMC at any Host state. \
              Modifications to the parameters take place upon the next system reboot or \
              immediate based on the host firmware."
HOMEPAGE = "https://github.com/openbmc/bios-settings-mgr"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=bcd9ada3a943f58551867d72893cc9ab"

SRC_URI = "git://git@github.ibm.com/openbmc/bios-settings-mgr.git;nobranch=1;protocol=ssh"
SRCREV = "d8b88d7a158164359dcf301b4ac81de73cc4a3c4"

inherit meson pkgconfig systemd

S = "${WORKDIR}/git"
SYSTEMD_SERVICE_${PN} = "xyz.openbmc_project.biosconfig_manager.service"

DEPENDS = " \
    boost \
    phosphor-dbus-interfaces \
    phosphor-logging \
    sdbusplus \
    systemd \
    "