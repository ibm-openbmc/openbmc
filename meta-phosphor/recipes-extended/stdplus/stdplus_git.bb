SUMMARY = "Common C++ functions"
DESCRIPTION = "Common C++ functions."
HOMEPAGE = "http://github.com/openbmc/stdplus"
PR = "r1"
PV = "0.1+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

inherit meson pkgconfig

EXTRA_OEMESON = " \
        -Dexamples=false \
        -Dtests=disabled \
        "

SRC_URI += "git://github.com/openbmc/stdplus;branch=master;protocol=https"
SRCREV = "7d75a48513560d8735bb3d795bb8872af276ee43"

S = "${WORKDIR}/git"
