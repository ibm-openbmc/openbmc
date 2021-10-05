EXTRA_OEMESON:append = " \
    -Dinsecure-tftp-update=enabled \
    -Dibm-management-console=enabled \
    -Dredfish-allow-deprecated-power-thermal=disabled \
    -Dredfish-new-powersubsystem-thermalsubsystem=enabled \
    -Drest=disabled \
"

EXTRA_OEMESON:append:p10bmc = " \
    -Dibm-lamp-test=enabled \
    -Dhw-isolation=enabled \
    -Dhypervisor-serial-socket=enabled \
    -Dredfish-license=enabled \
"

EXTRA_OEMESON:append:witherspoon-tacoma = " \
    -Dhypervisor-serial-socket=enabled \
"

inherit obmc-phosphor-discovery-service

REGISTERED_SERVICES:${PN} += "obmc_redfish:tcp:443:"
REGISTERED_SERVICES:${PN} += "obmc_rest:tcp:443:"
PACKAGECONFIG = "ibm-mc-console"
