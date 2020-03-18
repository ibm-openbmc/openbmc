SUMMARY = "Network Block Device Proxy"
HOMEPAGE = "https://github.com/openbmc/jsnbd"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENCE;md5=3b83ef96387f14655fc854ddc3c6bd57"

inherit autotools pkgconfig

DEPENDS += "json-c"
DEPENDS += "udev"

RDEPENDS:${PN} += "nbd-client"

S = "${WORKDIR}/git"

SRC_URI = "git://github.com/ibm-openbmc/jsnbd;nobranch=1"
SRCREV = "040e5adfb2caa2ca4c686792d1d0e2cfea3a7625"

NBD_PROXY_CONFIG_JSON ??= "${S}/config.sample.json"

do_install:append() {
    install -d ${D}${sysconfdir}/nbd-proxy/
    install -m 0644 ${NBD_PROXY_CONFIG_JSON} ${D}${sysconfdir}/nbd-proxy/config.json
}
