SUMMARY = "Power Supply firmware images"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

SRC_URI = "git://github.com/ibm-openbmc/device-images;branch=main;protocol=https"
SRCREV = "dc244dbebf6c53d226b127ddb1f288a153046273"

FILES:${PN} = "${datadir}/obmc/psu"
S = "${WORKDIR}/git"

FILES:${PN}:append = " 51E9.hex 51DA.hex"

do_install() {
        install -d ${D}/${datadir}/obmc/psu
        install -m 0444  ${S}/51E9.hex ${D}/${datadir}/obmc/psu/51E9.hex
        install -m 0444  ${S}/51DA.hex ${D}/${datadir}/obmc/psu/51DA.hex
}
