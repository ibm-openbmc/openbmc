SUMMARY     = "Power code signing framework client"
LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

SRC_URI = " \
    git://github.com/open-power/sb-signing-framework;nobranch=1;protocol=https \
    file://sfclient-socsec-helper \
    "
SRCREV = "c5238790100216e14aa4be102eb238f985ec793a"
PV = "1.0+git${SRCPV}"

S = "${WORKDIR}/git/src/client-c++"

DEPENDS = "json-c curl openssl jq"

PACKAGECONFIG ??= "pkcs11"
PACKAGECONFIG[pkcs11] = "-Dlib-pkcs11=true, -Dlib-pkcs11=false,,"

inherit meson pkgconfig lib_package

SFCLIENT_SIGN_ENABLE ?= "0"

do_configure:prepend () {
    if [ "${SFCLIENT_SIGN_ENABLE}" != "1" ]; then
        bbwarn "building ${PN} without libssh2 curl support"
    fi
}

do_install:append () {
    install ${WORKDIR}/sfclient-socsec-helper ${D}${bindir}
}

BBCLASSEXTEND = "native nativesdk"
