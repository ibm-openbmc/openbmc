FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SYSTEMD_LINK_phosphor-msl-verify_append_ibm-ac-server = " ../phosphor-msl-verify.service:obmc-chassis-poweron@0.target.requires/phosphor-msl-verify.service"
SYSTEMD_LINK_phosphor-msl-verify_append_mihawk = " ../phosphor-msl-verify.service:obmc-chassis-poweron@0.target.requires/phosphor-msl-verify.service"
SYSTEMD_OVERRIDE_${PN} += "phosphor-dbus-monitor-snmp.conf:phosphor-dbus-monitor.service.d/phosphor-dbus-monitor-snmp.conf"
