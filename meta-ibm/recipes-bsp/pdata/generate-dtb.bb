SUMMARY     = "Device tree blob file generation"
DESCRIPTION = "Generating DTB file by using pdata and libekb in native build"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

DEPENDS = "pdata-native libekb-p10-native"

do_install() {

    DTB_FILE_NAME=power-target.dtb
    DTB_FILE_INSTALL_PATH=${D}${sysconfdir}/pdata/

    ${STAGING_BINDIR_NATIVE}/attributes create ${STAGING_DATADIR_NATIVE}/p10.dtb ${STAGING_DATADIR_NATIVE}/p10_attributes.db ${STAGING_DATADIR_NATIVE}/${DTB_FILE_NAME}

    install -d ${DTB_FILE_INSTALL_PATH}

    install -m 0755 ${STAGING_DATADIR_NATIVE}/${DTB_FILE_NAME} ${DTB_FILE_INSTALL_PATH}${DTB_FILE_NAME}
}
