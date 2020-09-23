SUMMARY = "A collection of miscellaneous OpenBMC function"
HOMEPAGE = "http://github.com/openbmc/phosphor-misc"
PR = "r1"
PV = "0.1+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

inherit meson pkgconfig allarch

EXTRA_OEMESON = "-Dusb-ctrl=enabled"

SRC_URI += "git://github.com/openbmc/phosphor-misc"
SRCREV = "4285bbf84013b0469b220567d8bfccc73d809cd9"

S = "${WORKDIR}/git"