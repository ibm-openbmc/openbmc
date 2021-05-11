EXTRA_OEMESON_append = " \
    -Dinsecure-tftp-update=enabled \
    -Dibm-management-console=enabled \
"

EXTRA_OEMESON_append_p10bmc = " \
    -Dibm-lamp-test=enabled \
"

inherit obmc-phosphor-discovery-service

REGISTERED_SERVICES_${PN} += "obmc_redfish:tcp:443:"
REGISTERED_SERVICES_${PN} += "obmc_rest:tcp:443:"
PACKAGECONFIG = "ibm-mc-console"
