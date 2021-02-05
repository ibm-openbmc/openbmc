HOMEPAGE = "https://github.com/openbmc/witherspoon-pfault-analysis"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"
SRC_URI += "git://github.com/ibm-openbmc/witherspoon-pfault-analysis;branch=OP940"
SRCREV = "ea97f2bd04b010ab8a4dfa078825e5cf69ab3887"

DEPENDS += "i2c-tools"

