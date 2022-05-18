SUMMARY     = "PowerPC FSI Debugger"
DESCRIPTION = "pdbg allows JTAG-like debugging of the host POWER processors"
LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI += "git://github.com/open-power/pdbg.git;branch=master;protocol=https"
SRCREV = "5e18ae11d2b003bc0401e654eb13d46f00870fa8"

DEPENDS += "dtc-native"

S = "${WORKDIR}/git"

inherit autotools

BBCLASSEXTEND = "native"
