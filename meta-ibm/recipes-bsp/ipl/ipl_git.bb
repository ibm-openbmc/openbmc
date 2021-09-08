HOMEPAGE =  "https://github.com/open-power/ipl/"

SUMMARY     = "Initial Program Load steps"
DESCRIPTION = "Provides infrastructure to run istep"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

inherit autotools

S = "${WORKDIR}/git"

SRC_URI = "git://git@github.com/open-power/ipl;branch="main""
SRCREV = "82037bdaf23ab07fc8c9aafd719d89c753be64d7"

SRC_URI += "file://enable-istep0-procedures-only-p9.patch"

IPL_EKB_DEPENDS = ""
IPL_EKB_DEPENDS:ibm-power9-cpu = "libekb"
IPL_EKB_DEPENDS:ibm-power10-cpu = "libekb-p10"
DEPENDS = " \
        ${IPL_EKB_DEPENDS} pdbg autoconf-archive guard \
        "

RDEPENDS:${PN} = "power-devtree"

EXTRA_OECONF:ibm-power9-cpu = "CHIP=p9"
EXTRA_OECONF:ibm-power10-cpu = "CHIP=p10"
