inherit systemd
inherit useradd

USERADD_PACKAGES = "${PN}"

# add a user called httpd for the server to assume
USERADD_PARAM_${PN} = "-r -s /usr/sbin/nologin bmcweb"
GROUPADD_PARAM_${PN} = "web; redfish"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENCE;md5=a6a4edad4aed50f39a66d098d74b265b"

SRC_URI = "git://github.com/ibm-openbmc/bmcweb.git;nobranch=1"

PV = "1.0+git${SRCPV}"
SRCREV = "bc2a74570b067a0321c2cf3ef94d75c5e0883ffd"

S = "${WORKDIR}/git"

inherit meson ptest

SRC_URI += " \
    file://run-ptest \
"

DEPENDS = " \
    openssl \
    zlib \
    boost \
    boost-url \
    libpam \
    sdbusplus \
    gtest \
    nlohmann-json \
    libtinyxml2 \
    ${@bb.utils.contains('PTEST_ENABLED', '1', 'gtest', '', d)} \
    ${@bb.utils.contains('PTEST_ENABLED', '1', 'gmock', '', d)} \
"

RDEPENDS_${PN} += " \
    jsnbd \
    phosphor-mapper \
"

do_install_ptest() {
        install -d ${D}${PTEST_PATH}/test
        cp -rf ${B}*_test ${D}${PTEST_PATH}/test/
}

PACKAGECONFIG ??= ""
PACKAGECONFIG[ibm-mc-console] = "-Dibm-management-console=enabled, -Dibm-management-console=disabled, pldm, "

FILES_${PN} += "${datadir}/** "


EXTRA_OEMESON = " \
    --buildtype=minsize \
    -Dtests=${@bb.utils.contains('PTEST_ENABLED', '1', 'enabled', 'disabled', d)} \
    -Dyocto-deps=enabled \
"

EXTRA_OECMAKE = "-DBMCWEB_BUILD_UT=OFF -DYOCTO_DEPENDENCIES=ON -DBMCWEB_ENABLE_IBM_MANAGEMENT_CONSOLE=ON -DBMCWEB_ENABLE_REDFISH_DUMP_LOG=ON"
EXTRA_OEMESON = "--buildtype=minsize -Dtests=disabled -Dyocto-deps=enabled -Dredfish-dump-log=enabled"

SYSTEMD_SERVICE_${PN} += "bmcweb.service bmcweb.socket"

FULL_OPTIMIZATION = "-Os -pipe "
