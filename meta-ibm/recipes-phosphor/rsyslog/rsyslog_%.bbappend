FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:p10bmc = "file://rsyslog.conf \
                          file://rsyslog.logrotate \
                          file://rotate-event-logs.service \
                          file://rotate-event-logs.sh \
                          file://rsyslog-override.conf \
"
FILES:${PN}:append:p10bmc = " ${systemd_system_unitdir}/rsyslog.service.d/rsyslog-override.conf"

PACKAGECONFIG:append:p10bmc = " imjournal"

do_install:append:p10bmc() {
        install -m 0644 ${WORKDIR}/rotate-event-logs.service ${D}${systemd_system_unitdir}
        install -d ${D}${systemd_system_unitdir}/rsyslog.service.d
        install -m 0644 ${WORKDIR}/rsyslog-override.conf \
                        ${D}${systemd_system_unitdir}/rsyslog.service.d/rsyslog-override.conf
        install -d ${D}${bindir}
        install -m 0755 ${WORKDIR}/rotate-event-logs.sh ${D}/${bindir}/rotate-event-logs.sh
        rm ${D}${sysconfdir}/rsyslog.d/imjournal.conf
}

SYSTEMD_SERVICE:${PN}:append:p10bmc = " rotate-event-logs.service"
