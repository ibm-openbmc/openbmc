FILESEXTRAPATHS:prepend:p10bmc := "${THISDIR}/${PN}/audit:"

SRC_URI:append:p10bmc = "                  \
        file://auditd.conf                 \
        file://rules.d/20-filter-BPF.rules \
"

do_install:append:p10bmc () {

  # Install own configuration of auditd
  # controls size of log file and how much to preserve
  install -m 0644 ${WORKDIR}/auditd.conf ${D}${sysconfdir}/audit/

  # Install custom rules to support reloading of audit rules in runtime
  install -m 0644 ${WORKDIR}/rules.d/20-filter-BPF.rules \
      ${D}${sysconfdir}/audit/rules.d/

  # Add custom rules to default rules
  cat ${WORKDIR}/rules.d/20-filter-BPF.rules >> \
      ${D}${sysconfdir}/audit/audit.rules

}

PACKAGE_WRITE_DEPS:auditd:append:p10bmc = " ${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd-systemctl-native','',d)}"

pkg_postinst:auditd:append:p10bmc () {
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        # Prevent audit events going into the journal log 
        systemctl --root=$D mask systemd-journald-audit.socket
    fi
}

FILES:auditd:append:p10bmc = " ${sysconfdir}/audit/*"
