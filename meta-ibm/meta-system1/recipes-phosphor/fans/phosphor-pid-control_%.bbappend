FILESEXTRAPATHS:prepend := "${THISDIR}:"

SRC_URI:append = " \
    file://pidctl \
    "

do_install:append () {
    install -m 0755 -D ${WORKDIR}/pidctl ${D}${bindir}
}
