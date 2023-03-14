EXTRA_OEMESON:append = " \
    -Dinsecure-tftp-update=enabled \
    -Dibm-management-console=enabled \
    -Dredfish-dump-log=enabled \
    -Dredfish-allow-deprecated-power-thermal=disabled \
    -Dredfish-oem-manager-fan-data=disabled \
    -Dbmcweb-logging=error \
    -Dredfish-bmc-journal=disabled \
    -Dinsecure-ignore-content-type=enabled \
"

EXTRA_OEMESON:append:p10bmc = " \
    -Dmutual-tls-auth=disabled \
    -Dkvm=disabled \
    -Dvm-websocket=disabled \
    -Daudit-events=enabled \
"

EXTRA_OEMESON:append:witherspoon-tacoma = " \
    -Dmutual-tls-auth=disabled \
    -Dkvm=disabled \
    -Dvm-websocket=disabled \
"

EXTRA_OEMESON:append:system1 = " \
     -Dhttp-body-limit=400 \
     -Dredfish-dbus-log=enabled \
"

EXTRA_OEMESON:append:sbp1 = " \
     -Dhttp-body-limit=400 \
     -Dredfish-dbus-log=enabled \
"

DEPENDS:append:p10bmc = " audit"
RDEPENDS:${PN}:append:p10bmc = " auditd"

inherit obmc-phosphor-discovery-service

REGISTERED_SERVICES:${PN} += "obmc_redfish:tcp:443:"
REGISTERED_SERVICES:${PN} += "obmc_rest:tcp:443:"
