FILESEXTRAPATHS_prepend := "${THISDIR}/avahi-daemon:"

SRC_URI += "file://avahi-daemon-override.conf"

FILES_avahi-daemon_append += "${systemd_system_unitdir}/avahi-daemon.service.d/avahi-daemon-override.conf"

do_install_append() {

        install -Dm 0755 ${WORKDIR}/avahi-daemon-override.conf \
        ${D}${systemd_system_unitdir}/avahi-daemon.service.d/avahi-daemon-override.conf
}
