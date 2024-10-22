FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
PACKAGECONFIG:append:ibm-ac-server = " associations"
SRC_URI:append:ibm-ac-server = " file://associations.json"
DEPENDS:append:ibm-ac-server = " inventory-cleanup"

PACKAGECONFIG:append:p10bmc = " associations"
DEPENDS:remove:p10bmc = " phosphor-inventory-manager-assettag"
SRC_URI:append:p10bmc = " \
    file://ibm,rainier-2u_associations.json \
    file://ibm,rainier-4u_associations.json \
    file://ibm,everest_associations.json \
    file://ibm,blueridge-2u_associations.json \
    file://ibm,blueridge-4u_associations.json \
    file://ibm,fuji_associations.json \
    "

SRC_URI:append:system1 = " \
    file://system1-board.bin \
    file://system1-board-sys1.bin \
    file://system1-board-sys2.bin \
    file://system1-board-sys3.bin \
    file://system1-board-sys4.bin \
    file://system1-mudflap.bin \
    "

do_install:append:system1() {
    install -d ${D}${base_datadir}
    install -m 0644 ${WORKDIR}/system1-board.bin ${D}${base_datadir}/system1-board.bin
    install -m 0644 ${WORKDIR}/system1-board-sys1.bin ${D}${base_datadir}/system1-board-sys1.bin
    install -m 0644 ${WORKDIR}/system1-board-sys2.bin ${D}${base_datadir}/system1-board-sys2.bin
    install -m 0644 ${WORKDIR}/system1-board-sys3.bin ${D}${base_datadir}/system1-board-sys3.bin
    install -m 0644 ${WORKDIR}/system1-board-sys4.bin ${D}${base_datadir}/system1-board-sys4.bin
    install -m 0644 ${WORKDIR}/system1-mudflap.bin ${D}${base_datadir}/system1-mudflap.bin
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
    install -m 0755 ${WORKDIR}/ibm,blueridge-2u_associations.json ${D}${base_datadir}/ibm,blueridge-2u_associations.json
    install -m 0755 ${WORKDIR}/ibm,blueridge-4u_associations.json ${D}${base_datadir}/ibm,blueridge-4u_associations.json
    install -m 0755 ${WORKDIR}/ibm,fuji_associations.json ${D}${base_datadir}/ibm,fuji_associations.json
}
