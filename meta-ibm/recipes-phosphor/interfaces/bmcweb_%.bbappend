EXTRA_OEMESON:append = " \
    -Dinsecure-tftp-update=enabled \
    -Dibm-management-console=enabled \
    -Dredfish-allow-deprecated-power-thermal=disabled \
    -Dredfish-new-powersubsystem-thermalsubsystem=enabled \
    -Dredfish-dump-log=enabled \
    -Dredfish-oem-manager-fan-data=disabled \
"

EXTRA_OEMESON:append:p10bmc = " \
    -Dmutual-tls-auth=disabled \
    -Dkvm=disabled \
    -Dvm-websocket=disabled \
"

EXTRA_OEMESON:append:witherspoon-tacoma = " \
    -Dmutual-tls-auth=disabled \
    -Dkvm=disabled \
    -Dvm-websocket=disabled \
"

EXTRA_OEMESON_append_rainier = " \
    -Dibm-lamp-test=enabled \
"

inherit obmc-phosphor-discovery-service

REGISTERED_SERVICES:${PN} += "obmc_redfish:tcp:443:"
REGISTERED_SERVICES:${PN} += "obmc_rest:tcp:443:"
PACKAGECONFIG = "ibm-mc-console"
