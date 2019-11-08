HOMEPAGE =  "https://github.com/open-power/pdata/"

SUMMARY     = "POWER Host data management"
DESCRIPTION = "Device tree based POWER host data management"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

S = "${WORKDIR}/git"

inherit autotools \
        perlnative

SRC_URI = "git://git@github.com/open-power/pdata;branch="main""
SRCREV = "200483615035f954bdfbac855458a287a307a3ef"

DEPENDS = "pdbg \
           libxml-simple-perl-native \
           libxml-libxml-perl-native \
           ekb-native \
           autoconf-archive"

BBCLASSEXTEND = "native"

PDATA_CONFARG = ""
PDATA_CONFARG_ibm-power9-cpu = "CHIP=p9"
PDATA_CONFARG_ibm-power10-cpu = "CHIP=p10"
EXTRA_OECONF = "--enable-gen_attrsinfo ${PDATA_CONFARG}"

EXTRA_OEMAKE = "EKB=${STAGING_DATADIR_NATIVE}/ekb/"
