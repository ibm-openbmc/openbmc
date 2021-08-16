PROVIDES += "ibm-acf"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

SRC_URI = "git://github.com/ibm-openbmc/ibm-acf"
SRCREV = "282f896795e7be7d4851597088e7095cbe2e4ca0"

inherit meson

S = "${WORKDIR}/git"

DEPENDS = " \
    openssl \
    libpam \
    sdbusplus \
    json-c \
"

do_install_append(){
    install -d ${D}/${sysconfdir}/acf
    install -m 755 ${WORKDIR}/git/subprojects/ce-login/p10-celogin-lab-pub.der \
                   ${D}/${sysconfdir}/acf/ibmacf-dev.key
}


FILES_${PN} += " ${base_libdir}/security/* \
                 ${sysconfdir}/acf/*"
