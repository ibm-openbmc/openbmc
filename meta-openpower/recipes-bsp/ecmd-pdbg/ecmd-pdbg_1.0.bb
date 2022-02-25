SUMMARY     = "eCMD plugin with pdbg backend"
DESCRIPTION = "The glue code necessary for pdbg to be used as an eCMD plugin"
PR = "r1"
PV = "1.0+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34400b68072d710fecd0a2940a0d1658"

inherit meson
inherit pkgconfig

SRC_URI = "git://git@github.com/open-power/ecmd-pdbg.git"
SRCREV = "ca1563c536b941b0a7516b899f7be44c37588b8b"

S = "${WORKDIR}/git"

DEPENDS = "pdbg zlib libyaml ipl"

FILES:${PN} += "${prefix}/help"

EXTRA_OEMESON = " \
        -Dchip=p10 \
        "
