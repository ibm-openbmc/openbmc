HOMEPAGE =  "https://github.com/open-power/guard"
SUMMARY     = "GUARD the faulty components"
DESCRIPTION = "Provide a way to GUARD the faulty component from the system"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

inherit meson

S = "${WORKDIR}/git"

SRC_URI = "git://git@github.com/open-power/guard;branch="main""
SRCREV = "a3e00936866864705cce80e2c7947d3b75fdf045"

DEPENDS = "cli11"

PACKAGECONFIG ??= "${@bb.utils.filter('OBMC_MACHINE_FEATURES', 'phal', d)}"
PACKAGECONFIG[phal] = "-Ddevtree=enabled, -Ddevtree=disabled, pdata pdbg"
