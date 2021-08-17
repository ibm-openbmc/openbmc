ALT_RMCPP_IFACE_mihawk = "eth1"
SYSTEMD_SERVICE_${PN}_append_mihawk += " \
    ${PN}@${ALT_RMCPP_IFACE}.service \
    ${PN}@${ALT_RMCPP_IFACE}.socket \
    "

ALT_RMCPP_IFACE_p10bmc = "eth1"
SYSTEMD_SERVICE_${PN}_append_p10bmc += " \
    ${PN}@${ALT_RMCPP_IFACE}.service \
    ${PN}@${ALT_RMCPP_IFACE}.socket \
    "
