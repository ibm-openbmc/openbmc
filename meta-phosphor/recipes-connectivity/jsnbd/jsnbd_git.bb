SUMMARY = "Network Block Device Proxy"
HOMEPAGE = "https://github.com/openbmc/jsnbd"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENCE;md5=3b83ef96387f14655fc854ddc3c6bd57"

inherit autotools pkgconfig

DEPENDS += "json-c"
DEPENDS += "udev"

RDEPENDS_${PN} += "nbd-client"

S = "${WORKDIR}/git"

SRC_URI = "git://github.com/openbmc/jsnbd;branch=master;protocol=https"
SRCREV = "bcc6cc5bcadb20005ae03c8c4a4eb87006f0d222"

NBD_PROXY_CONFIG_JSON ??= "${S}/config.sample.json"

do_install_append() {
    install -d ${D}${sysconfdir}/nbd-proxy/
    install -m 0644 ${NBD_PROXY_CONFIG_JSON} ${D}${sysconfdir}/nbd-proxy/config.json
}
