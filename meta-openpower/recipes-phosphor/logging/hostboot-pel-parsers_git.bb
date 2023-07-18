SUMMARY = "Hostboot PEL python parsers"
DESCRIPTION = "Used by peltool to parse Hostboot UserData sections and SRC details"
PR = "r1"
PV = "1.0+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=34400b68072d710fecd0a2940a0d1658"

S = "${WORKDIR}/git"
SRC_URI:p10bmc = "git://git@github.com/open-power/hostboot;branch="release-fw1050";protocol=ssh"
SRCREV = "1cb7de9e2c9a21c8747f4a6035a1733e04d89ea1"

inherit setuptools3
