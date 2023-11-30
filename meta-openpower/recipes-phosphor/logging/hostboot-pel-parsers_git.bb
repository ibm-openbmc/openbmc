SUMMARY = "Hostboot PEL python parsers"
DESCRIPTION = "Used by peltool to parse Hostboot UserData sections and SRC details"
PR = "r1"
PV = "1.0+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=34400b68072d710fecd0a2940a0d1658"

RDEPENDS:${PN} = "bash"

S = "${WORKDIR}/git"
SRC_URI:p10bmc = "git://git@github.com/open-power/hostboot;branch="master-p10";protocol=ssh"
SRCREV = "9d80f58e3ccf9e494ed204c7d63d8e708fccdc4a"

inherit setuptools3
