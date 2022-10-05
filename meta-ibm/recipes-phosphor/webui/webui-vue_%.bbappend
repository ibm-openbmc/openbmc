FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

EXTRA_OENPM:witherspoon-tacoma = "-- --mode ibm"
EXTRA_OENPM:p10bmc = "-- --mode ibm"

inherit obmc-phosphor-systemd

SRC_URI:append:p10bmc = " \
        file://changeLogo.sh \
        file://change-logo.service \
        file://inspur-login-logo.svg \
        file://inspur-logo-header.svg \
        file://blankLogo.svg \
        file://ips.app.css \
        "

SYSTEMD_SERVICE:${PN}:append:p10bmc = " change-logo.service"

do_install:append:p10bmc() {
    gzip -f -k ${WORKDIR}/inspur-login-logo.svg
    gzip -f -k ${WORKDIR}/inspur-logo-header.svg
    gzip -f -k ${WORKDIR}/blankLogo.svg
    gzip -f -k ${WORKDIR}/ips.app.css

    install -m 0755 ${WORKDIR}/inspur-login-logo.svg.gz ${D}${datadir}/www/img
    install -m 0755 ${WORKDIR}/inspur-logo-header.svg.gz ${D}${datadir}/www/img
    install -m 0755 ${WORKDIR}/blankLogo.svg.gz ${D}${datadir}/www/img
    install -m 0755 ${WORKDIR}/changeLogo.sh ${D}${datadir}/www
    install -m 0755 ${WORKDIR}/ips.app.css.gz ${D}${datadir}/www/css
}
