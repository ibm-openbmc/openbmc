SUMMARY = "Add System interface for inventory manager"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch
inherit phosphor-inventory-manager

PROVIDES += "virtual/phosphor-inventory-manager-system"
S = "${WORKDIR}"

SRC_URI = "file://system.yaml"

do_install() {
        install -D system.yaml ${D}${base_datadir}/events.d/system.yaml
}

FILES:${PN} += "${base_datadir}/events.d/system.yaml"
