FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

HOST_FW_LICENSE = "Proprietary"

VERSION:p10bmc ?= "1030.2249.20221130a"

SRC_URI:append:p10bmc = " file://host-fw-elements_lids.json"
SRC_URI:append:p10bmc = " file://image-hostfw-${VERSION}"

FILES:${PN}:append:p10bmc = " ${datadir}/hostfw/elements.json"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

do_compile:append() {
    install -m 0440 ${S}/image-hostfw-${VERSION} ${B}/image/hostfw-a
    install -m 0440 ${S}/image-hostfw-${VERSION} ${B}/image/hostfw-b
    install -m 0440 ${S}/image-hostfw-${VERSION} ${B}/update/image-hostfw
}

do_install:append:p10bmc() {
    install -d ${D}/${datadir}/hostfw
    install -m 0644 ${S}/host-fw-elements_lids.json ${D}/${datadir}/hostfw/elements.json
}
