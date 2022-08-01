SUMMARY = "OpenPOWER PEL parser python modules"

DESCRIPTION = \
    "This is a common repository that can contain PEL parser python modules \
    from multiple subsystems (BMC, Hostboot, etc.)."

HOMEPAGE = "https://github.com/ibm-openbmc/openpower-pel-parsers"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=fa818a259cbed7ce8bc2a22d35a464fc"

PR = "r1"
PV = "0.1+git${SRCPV}"

SRC_URI = "git://github.com/ibm-openbmc/openpower-pel-parsers;branch=master"
SRCREV = "65b6f12db986c9c8ff628aa1f045d85ec8cd5ffe"

S = "${WORKDIR}/git"

inherit setuptools3

RDEPENDS:${PN} += "${PYTHON_PN}-core"
RDEPENDS:${PN} += "${PYTHON_PN}-json"
RDEPENDS:${PN} += "${PYTHON_PN}-math"
RDEPENDS:${PN} += "${PYTHON_PN}-shell"

