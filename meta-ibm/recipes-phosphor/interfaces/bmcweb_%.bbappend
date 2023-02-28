EXTRA_OEMESON:append = " \
    -Dinsecure-tftp-update=enabled \
    -Dibm-management-console=enabled \
    -Dredfish-allow-deprecated-power-thermal=disabled \
    -Dredfish-new-powersubsystem-thermalsubsystem=enabled \
    -Dredfish-dump-log=enabled \
    -Dredfish-oem-manager-fan-data=disabled \
    -Dinsecure-enable-redfish-query=enabled \
"

EXTRA_OEMESON:append:p10bmc = " \
    -Dibm-led-extensions=enabled \
    -Dhw-isolation=enabled \
    -Dhypervisor-serial-socket=enabled \
    -Dbmc-shell-socket=enabled \
    -Dredfish-license=enabled \
    -Dibm-usb-code-update=enabled \
    -Dmutual-tls-auth=disabled \
    -Dkvm=disabled \
    -Dvm-websocket=disabled \
"

EXTRA_OEMESON:append:witherspoon-tacoma = " \
    -Dmutual-tls-auth=disabled \
    -Dkvm=disabled \
    -Dvm-websocket=disabled \
    -Dhypervisor-serial-socket=enabled \
"

inherit obmc-phosphor-discovery-service

REGISTERED_SERVICES:${PN} += "obmc_redfish:tcp:443:"
REGISTERED_SERVICES:${PN} += "obmc_rest:tcp:443:"
