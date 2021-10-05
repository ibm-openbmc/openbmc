PACKAGECONFIG:append:p10bmc = " ibm-hypervisor-cert"
PACKAGECONFIG:append:witherspoon-tacoma = " ibm-hypervisor-cert"
PACKAGECONFIG:append:p10bmc = " ibm-acf "
PACKAGECONFIG:append:witherspoon-tacoma = " ibm-acf "
DEPENDS += " ibm-acf "
PACKAGECONFIG[ibm-acf] = "-Dacf-cert-extension=enabled,-Dacf-cert-extension=disabled"

SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'ibm-acf', 'bmc-acf-manager.service', '', d)}"
