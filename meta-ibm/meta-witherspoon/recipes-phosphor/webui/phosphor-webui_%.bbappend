inherit obmc-phosphor-systemd

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_mowgli-oem += " file://0001-Change-IBM-logo-to-OpenBmc-logo.patch"

SRC_URI_append_mowgli += " \ 
                            file://changeLogo.sh \
                            file://change-logo.service \
                            file://blankLogo.svg \
                            "

SYSTEMD_SERVICE_${PN}_append_mowgli = " change-logo.service"

do_install_append_mowgli() {

if [ -e ${WORKDIR}/blankLogo.svg ]; then
	gzip ${WORKDIR}/blankLogo.svg
fi
	install -m 0755 ${WORKDIR}/blankLogo.svg.gz ${D}${datadir}/www/app/assets/images
	install -m 0755 ${WORKDIR}/change-logo.service ${D}${datadir}/www
	install -m 0755 ${WORKDIR}/changeLogo.sh ${D}${datadir}/www
}