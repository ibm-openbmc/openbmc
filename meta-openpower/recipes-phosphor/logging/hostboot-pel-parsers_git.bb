SUMMARY = "Hostboot PEL python parsers"
DESCRIPTION = "Used by peltool to parse Hostboot UserData sections and SRC details"
PR = "r1"
PV = "1.0+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=34400b68072d710fecd0a2940a0d1658"

S = "${WORKDIR}/git"
SRC_URI += "git://git@github.com/open-power/hostboot;branch="release-fw1020";protocol=ssh"
SRCREV = "0e01d6bd1fe946ee71c7f35539f6af10a3e9e56a"

inherit setuptools3
