SUMMARY     = "eCMD plugin with pdbg backend"
DESCRIPTION = "The glue code necessary for pdbg to be used as an eCMD plugin"
PR = "r1"
PV = "1.0+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34400b68072d710fecd0a2940a0d1658"

inherit meson
inherit pkgconfig

require recipes-bsp/ecmd/libecmd.inc

SRCREV_FORMAT = "ecmd-pdbg"

SRCREV_ecmd_pdbg = "9ffe38b592cb13e751627cfc71265191a9244a7e"
SRCREV_ecmd = "${ECMD_REV}"

SRC_URI = "git://git@github.com/open-power/ecmd-pdbg.git;branch=master;protocol=https;name=ecmd_pdbg;protocol=https \
           ${ECMD_URI};name=ecmd;destsuffix=git/ecmd \
           "


S = "${WORKDIR}/git"

DEPENDS = "pdbg zlib libyaml ipl"

PACKAGECONFIG ??= "${@bb.utils.filter('MACHINE_FEATURES', 'phal', d)}"
PACKAGECONFIG[phal] = "-Djournal=enabled, -Djournal=disabled, systemd"

FILES:${PN} += "${prefix}/help"

EXTRA_OEMESON = " \
        -Dchip=p10 \
        "
