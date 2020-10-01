SUMMARY     = "PowerPC FSI Debugger"
DESCRIPTION = "pdbg allows JTAG-like debugging of the host POWER processors"
LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

PV = "3.0+git${SRCPV}"

SRC_URI += "git://github.com/open-power/pdbg.git"
SRCREV = "v3.0"
SRC_URI += "file://libpdbg-Add-processor-type-to-libsbefifo-implementation.patch"
SRC_URI += "file://libpdbg-Add-proc-type.patch"

DEPENDS += "dtc-native"

S = "${WORKDIR}/git"

inherit autotools

BBCLASSEXTEND = "native"
