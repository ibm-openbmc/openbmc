HOMEPAGE = "https://github.com/openbmc/openpower-vpd-parser"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"
SRC_URI += "git://github.com/ibm-openbmc/openpower-vpd-parser;nobranch=1;protocol=https"
SRCREV = "a9038a528e29a79712bae4357f6215d6e3683d67"


# ECC private patch
# Required to  stay in 1020-ghe branch
SRC_URI += "file://ecc_impl.patch"
