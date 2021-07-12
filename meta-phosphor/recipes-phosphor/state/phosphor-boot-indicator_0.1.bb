SUMMARY = "Phosphor Boot Indicator"
DESCRIPTION = "Phosphor Boot Indicator provides notification that the BMC \
userspace has reached a state where network management services are available."
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

RDEPENDS:${PN} += "libgpiod"

BOOT_INDICATOR_NAME ??= "bmc-management-ready"
SYSTEMD_SUBSTITUTIONS += "BOOT_INDICATOR_NAME:${BOOT_INDICATOR_NAME}:${PN}.service"

inherit obmc-phosphor-systemd
