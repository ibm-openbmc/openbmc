SUMMARY = "libpldm shared library"
DESCRIPTION = "PLDM library implementing various PLDM specifications"
HOMEPAGE = "https://github.com/openbmc/libpldm"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"
SRCREV = "b0b8c8876dd20184261da8f9c6f9c89662208759"
LIBPLDM_ABI_DEVELOPMENT = "deprecated,stable,testing"
LIBPLDM_ABI_MAINTENANCE = "stable,testing"
LIBPLDM_ABI_PRODUCTION = "deprecated,stable"
PACKAGECONFIG ??= "abi-production"
PACKAGECONFIG[abi-development] = "-Dabi=${LIBPLDM_ABI_DEVELOPMENT},,,"
PACKAGECONFIG[abi-maintenance] = "-Dabi=${LIBPLDM_ABI_MAINTENANCE},,,"
PACKAGECONFIG[abi-production] = "-Dabi=${LIBPLDM_ABI_PRODUCTION},,,"
PACKAGECONFIG[oem-ibm] = "-Doem-ibm=enabled,-Doem-ibm=disabled,,"

PV = "git${SRCPV}"
PR = "r1"
SRC_URI = "git://github.com/ibm-openbmc/libpldm;branch=main;protocol=https;nobranch=1"

S = "${WORKDIR}/git"

inherit meson

EXTRA_OEMESON:append = " -Dtests=disabled"
