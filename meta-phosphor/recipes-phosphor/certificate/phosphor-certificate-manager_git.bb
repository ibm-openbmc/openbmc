SUMMARY = "Phosphor Certificate Manager"
DESCRIPTION = "Manages client and server certificates"
HOMEPAGE = "https://github.com/openbmc/phosphor-certificate-manager"

PR = "r1"
PV = "0.1+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

SRC_URI = "git://github.com/ibm-openbmc/phosphor-certificate-manager;branch=OP940;protocol=https"
SRCREV = "e41fed35e55c623ac746e2f3113331215a364537"

inherit autotools \
        pkgconfig \
        obmc-phosphor-systemd

DEPENDS = " \
        phosphor-logging \
        autoconf-archive-native \
        phosphor-dbus-interfaces \
        phosphor-dbus-interfaces-native \
        sdbusplus \
        sdbusplus-native \
        sdeventplus \
        "

S = "${WORKDIR}/git"

CERT_TMPL = "phosphor-certificate-manager@.service"
SYSTEMD_SERVICE_${PN} = "${CERT_TMPL}"
