FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append:ibm-ac-server = " file://TPMEnable-default-true.override.yml"
SRC_URI:append:ibm-ac-server = " file://ClearHostSecurityKeys-default-zero.override.yml"
SRC_URI:append:mihawk = " file://TPMEnable-default-true.override.yml"
SRC_URI:append = " file://ibm_settings.override.yml"
SRC_URI:append:p10bmc = " file://BootMode-default-setup.override.yml"
SRC_URI:append:p10bmc += " file://HostTarget-default-PowerVM.override.yml"
SRC_URI:append:p10bmc = " file://TPMEnable-default-true.override.yml"
SRC_URI:append:witherspoon-tacoma = " file://BootMode-default-setup.override.yml"
SRC_URI:append:witherspoon-tacoma += " file://HostTarget-default-PowerVM.override.yml"

SRC_URI:append:p10bmc = " file://disable-Host-Tpm.service \
                          file://disableHostTpm.sh \
                        "

SYSTEMD_SERVICE:${PN}:append:p10bmc = " disable-Host-Tpm.service"

do_install:append:p10bmc() {
    install -m 0755 ${WORKDIR}/disableHostTpm.sh ${D}${bindir}/
}