SUMMARY = "IBM nginx prepare for downgrade"
DESCRIPTION = "Prepare file system for downgrade to nginx release"
PR = "r1"
HOMEPAGE = "http://github.com/openbmc/meta-ibm"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${IBMBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd
inherit obmc-phosphor-systemd

# Add a service to create the directory needed to store nginx
# certificates.  This is needed in case the BMC uses code update to go
# to a firmware image that uses nginx.  The directory must be created
# in the overlay filesystem (not in the generated file system) to
# survive the downgrade.  The service is "harmless" and only creates
# one additional subdirectory.

# This service can be removed in the first release that does not
# support a downgrade path to an OpenBMC 2.6 or earlier release.

SERVICE = "nginx-prep-downgrade.service"
SYSTEMD_SERVICE_${PN} += " ${SERVICE}"
