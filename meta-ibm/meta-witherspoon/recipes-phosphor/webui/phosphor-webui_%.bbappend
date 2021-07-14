inherit obmc-phosphor-systemd

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_mowgli-oem += " file://0001-Change-IBM-logo-to-OpenBmc-logo.patch"

SRC_URI_append_mowgli += " \ 
                            file://ChangeLogo.sh \
                            file://change-logo.service \
                            file://openBMC.svg \
                            file://TitleOpenBMC.svg \
                            "

SYSTEMD_SERVICE_${PN}_append_mowgli = " change-logo.service"

do_install_append_mowgli() {
if [ -e ${WORKDIR}/openBMC.svg ]; then
	gzip ${WORKDIR}/openBMC.svg
	gzip ${WORKDIR}/TitleOpenBMC.svg
fi
	install -m 0755 ${WORKDIR}/openBMC.svg.gz ${D}${datadir}/www/app/assets/images
	install -m 0755 ${WORKDIR}/TitleOpenBMC.svg.gz ${D}${datadir}/www/app/assets/images
	install -m 0755 ${WORKDIR}/change-logo.service ${D}${datadir}/www
	install -m 0755 ${WORKDIR}/ChangeLogo.sh ${D}${datadir}/www
}