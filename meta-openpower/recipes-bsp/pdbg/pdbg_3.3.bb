SUMMARY     = "PowerPC FSI Debugger"
DESCRIPTION = "pdbg allows JTAG-like debugging of the host POWER processors"
LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI += "git://github.com/open-power/pdbg.git"
SRCREV = "af93bdf1fec460940b81aa4bb80e86d360fffe00"

DEPENDS += "dtc-native"

S = "${WORKDIR}/git"

inherit autotools

BBCLASSEXTEND = "native"
