PACKAGECONFIG:p10bmc = "hwmontempsensor iiosensor nvmesensor adcsensor"

SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'nvmesensor', \
                                               'xyz.openbmc_project.nvmesensor.service', \
                                               '', d)}"
