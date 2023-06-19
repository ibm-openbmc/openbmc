SUMMARY = "Hostboot PEL python parsers"
DESCRIPTION = "Used by peltool to parse Hostboot UserData sections and SRC details"
PR = "r1"
PV = "1.0+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=34400b68072d710fecd0a2940a0d1658"

S = "${WORKDIR}/git"
SRC_URI:p10bmc = "git://git@github.com/open-power/hostboot;branch="master-p10";protocol=ssh"
SRCREV = "445bb0a11651680d48cc7e4d15e9e36c5e9d226b"

inherit setuptools3
