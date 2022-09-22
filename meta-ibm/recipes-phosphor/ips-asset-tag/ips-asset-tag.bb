SUMMARY = "Add persistent configuration of AssetTag for IPS"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

inherit allarch obmc-phosphor-systemd

SRC_URI:append:p10bmc = " \
        file://ips-asset-tag.path \
        file://ips-update-asset-tag.service \
        file://ips-recover-asset-tag.service \
        file://ips-asset-tag.sh \
        "

SYSTEMD_SERVICE:${PN}:append:p10bmc = " ips-asset-tag.path"
SYSTEMD_SERVICE:${PN}:append:p10bmc = " ips-update-asset-tag.service"
SYSTEMD_SERVICE:${PN}:append:p10bmc = " ips-recover-asset-tag.service"

do_install:append:p10bmc() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/ips-asset-tag.sh ${D}${bindir}/ips-asset-tag.sh
}
