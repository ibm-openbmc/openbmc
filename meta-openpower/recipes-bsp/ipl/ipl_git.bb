HOMEPAGE =  "https://github.com/open-power/ipl/"

SUMMARY     = "Initial Program Load steps"
DESCRIPTION = "Provides infrastructure to run istep"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

inherit autotools pkgconfig

S = "${WORKDIR}/git"

SRC_URI = "git://git@github.com/ibm-openbmc/ipl;branch="main";protocol=https;nobranch=1"
SRCREV = "8c2272cc5a9030acc459e0ccb3f5e561511d344b"

DEPENDS = " \
        libekb pdbg autoconf-archive guard pdata \
        "

RDEPENDS:${PN} = "phal-devtree"

EXTRA_OECONF = "CHIP=p10 --enable-libphal"
