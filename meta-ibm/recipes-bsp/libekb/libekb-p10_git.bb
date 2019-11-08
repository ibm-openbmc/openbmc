HOMEPAGE =  "https://github.com/open-power/libekb_p10"

SUMMARY     = "Hardware Procedure Framework"
DESCRIPTION = "Provides infrastructure to run hardware procedures"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

S = "${WORKDIR}/git"

require recipes-bsp/ekb/ekb_p10.inc

inherit autotools \
        python3native \
        perlnative

SRCREV_FORMAT = "libekb_ekb"

SRCREV_libekb = "a68c2f610243d3f128f561c4451135241aedbf6b"
SRCREV_ekb = "${EKB_REV}"

SRC_URI = "git://git@github.com/open-power/libekb_p10;branch="main";name=libekb \
           ${EKB_URI};name=ekb;destsuffix=git/ekb \
           "

DEPENDS = "pdbg libxml-simple-perl-native"

# During compilation race condition issue is happening, so getting different
# different error due to make targets rule dependency ( mostly found auto code generation ).
# Hence, forcing this recipe to run make tool with single job
# instead in multi-job which is control by bitbake based on cpu.
# TODO ibm/openbmc/issues/278 : Actual fix should be in libekb makefile.
# Need to revisit once fixed in libekb makefile
PARALLEL_MAKE = "-j 1"

BBCLASSEXTEND = "native"
