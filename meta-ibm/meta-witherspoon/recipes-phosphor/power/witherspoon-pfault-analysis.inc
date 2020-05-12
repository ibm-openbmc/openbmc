HOMEPAGE = "https://github.com/openbmc/witherspoon-pfault-analysis"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"
SRC_URI += "git://github.com/ibm-openbmc/witherspoon-pfault-analysis;branch=OP940"
SRCREV = "f79bf1092846f9cfb01ba50bf9cddd1c99403213"

DEPENDS += "i2c-tools"

