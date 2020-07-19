SUMMARY     = "Using power specific system device tree from pnor partition"
DESCRIPTION = "To boot the power server using device tree from pnor partition"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

# TODO: Need to remove pdata depends if any of bmc application is dependent with pdata.
# Added for testing to check to meta data generation for attributes use to read/write
# from power specific system device tree.
DEPENDS = "pdata"

PDATA_DTB_PATH="${datadir}/pdata"
FILES:${PN} += "${PDATA_DTB_PATH}"

#jffs2 workaround
FILESEXTRAPATHS_append := "${THISDIR}/files:"

do_install() {

    DTB_FILE_ENV=power-target.sh
    DTB_FILE_CONF_PATH=${D}${PDATA_DTB_PATH}

    install -d ${DTB_FILE_CONF_PATH}
    install -m 744 ${THISDIR}/files/${DTB_FILE_ENV} ${DTB_FILE_CONF_PATH}/${DTB_FILE_ENV}
    install -d ${D}${sysconfdir}/profile.d
    ln -s ${PDATA_DTB_PATH}/${DTB_FILE_ENV} ${D}${sysconfdir}/profile.d/${DTB_FILE_ENV}
}
