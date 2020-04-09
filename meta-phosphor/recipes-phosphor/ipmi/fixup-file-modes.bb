SUMMARY = "Fixup ipmi file permissions"
DESCRIPTION = "Fixup ipmi file permissions"
PR = "r1"
HOMEPAGE = "http://github.com/openbmc/meta-phosphor"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${IBMBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd
inherit obmc-phosphor-systemd

# Add a service to change the file modes (permission bits) for files
# related to IPMI users.  Other users should have no access.
# A service is needed (contrasted with changing the permissions in the
# read-only firmware image) because the file may have been modified in
# a read-write overlay, so a firmware update will not change the modes.

# This service can be removed in the first release X where the
# incorrect permissions are not set in any release along any upgrade
# path to release X.

SERVICE = "fixup-file-modes.service"
SYSTEMD_SERVICE_${PN} += " ${SERVICE}"
