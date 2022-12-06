FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
PACKAGECONFIG:append:ibm-ac-server = " associations"
SRC_URI:append:ibm-ac-server = " file://associations.json"
DEPENDS:append:ibm-ac-server = " inventory-cleanup"

PACKAGECONFIG:append:p10bmc = " associations"
DEPENDS:append:p10bmc = " phosphor-inventory-manager-system"
DEPENDS:append:p10bmc = " inventory-cleanup"
DEPENDS:remove:p10bmc = " phosphor-inventory-manager-assettag"
SRC_URI:append:p10bmc = " \
    file://ibm,rainier-2u_associations.json \
    file://ibm,rainier-4u_associations.json \
    file://ibm,everest_associations.json \
    "

SYSTEMD_SERVICE:${PN}:append:p10bmc += "obmc-clear-all-fault-leds-and-remove-crit-association@.service"

# Copies config file having arguments for clear-all-fault-leds.sh
SYSTEMD_ENVIRONMENT_FILE:${PN}:append:p10bmc +="obmc/led/clear-all/faults/config"

pkg_postinst:${PN}:p10bmc () {
    # Needed this to run as part of BMC boot
    mkdir -p $D$systemd_system_unitdir/multi-user.target.wants
    LINK_CLEAR="$D$systemd_system_unitdir/multi-user.target.wants/obmc-clear-all-fault-leds-and-remove-crit-association@true.service"
    TARGET_CLEAR="../obmc-clear-all-fault-leds-and-remove-crit-association@.service"
    ln -s $TARGET_CLEAR $LINK_CLEAR

    # Needed this to run as part of Power On
    mkdir -p $D$systemd_system_unitdir/obmc-chassis-poweron@0.target.wants
    LINK_CLEAR="$D$systemd_system_unitdir/obmc-chassis-poweron@0.target.wants/obmc-clear-all-fault-leds-and-remove-crit-association@true.service"
    TARGET_CLEAR="../obmc-clear-all-fault-leds-and-remove-crit-association@.service"
    ln -s $TARGET_CLEAR $LINK_CLEAR
}

pkg_prerm:${PN}:p10bmc () {
    LINK_CLEAR="$D$systemd_system_unitdir/multi-user.target.wants/obmc-clear-all-fault-leds-and-remove-crit-association@true.service"
    rm $LINK_CLEAR

    LINK_CLEAR="$D$systemd_system_unitdir/obmc-chassis-poweron@0.target.wants/obmc-clear-all-fault-leds-and-remove-crit-association@true.service"
    rm $LINK_CLEAR
}


do_install:append:ibm-ac-server() {
    install -d ${D}${base_datadir}
    install -m 0755 ${WORKDIR}/associations.json ${D}${base_datadir}/associations.json
}

do_install:append:p10bmc() {
    install -d ${D}${base_datadir}
    install -m 0755 ${WORKDIR}/ibm,rainier-2u_associations.json ${D}${base_datadir}/ibm,rainier-2u_associations.json
    install -m 0755 ${WORKDIR}/ibm,rainier-4u_associations.json ${D}${base_datadir}/ibm,rainier-4u_associations.json
    install -m 0755 ${WORKDIR}/ibm,everest_associations.json ${D}${base_datadir}/ibm,everest_associations.json
}
