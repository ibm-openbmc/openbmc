SUMMARY     = "Device tree blob file generation"
DESCRIPTION = "Generating DTB file by using pdata and libekb in native build"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

DEPENDS = "pdata-native ${@getlibekb_depend(d)}-native"
PDATA_DTB_PATH="${datadir}/pdata"
FILES:${PN} += "${PDATA_DTB_PATH}"

#jffs2 workaround
FILESEXTRAPATHS_append := "${THISDIR}/files:"
SRC_URI = "file://tmp-pdata.service"

inherit systemd phal
SYSTEMD_SERVICE_${PN} += "tmp-pdata.service"

do_install() {

    DTB_FILE_NAME=power-target.dtb
    DTB_FILE_ENV=power-target.sh
    DTB_FILE_INSTALL_PATH=${D}${sysconfdir}/pdata/
    DTB_FILE_CONF_PATH=${D}${PDATA_DTB_PATH}

    ${STAGING_BINDIR_NATIVE}/attributes create ${STAGING_DATADIR_NATIVE}/${TARGET_PROC}.dtb ${STAGING_DATADIR_NATIVE}/${TARGET_PROC}_attributes.db ${STAGING_DATADIR_NATIVE}/${DTB_FILE_NAME}

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/tmp-pdata.service ${D}${systemd_unitdir}/system

    install -d ${DTB_FILE_INSTALL_PATH}

    install -m 0755 ${STAGING_DATADIR_NATIVE}/${DTB_FILE_NAME} ${DTB_FILE_INSTALL_PATH}${DTB_FILE_NAME}

    install -d ${DTB_FILE_CONF_PATH}
    install -m 744 ${THISDIR}/files/${DTB_FILE_ENV} ${DTB_FILE_CONF_PATH}/${DTB_FILE_ENV}
    install -d ${D}${sysconfdir}/profile.d
    ln -s ${PDATA_DTB_PATH}/${DTB_FILE_ENV} ${D}${sysconfdir}/profile.d/${DTB_FILE_ENV}
}
