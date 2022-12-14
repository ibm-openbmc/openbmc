DESCRIPTION = "jsmn is a minimalistic JSON parser in C"
HOMEPAGE = "https://github.com/zserge/jsmn"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5adc94605a1f7a797a9a834adbe335e3"

SRC_URI = "git://github.com/zserge/jsmn;branch=master;protocol=https"
SRCREV = "25647e692c7906b96ffd2b05ca54c097948e879c"

S = "${WORKDIR}/git"

FILES:${PN} = "${S}/jsmn.h"

# header-only repo
do_compile[noexec] = "1"

do_install(){
    install -d ${D}${includedir}
    install -m 0755 ${S}/jsmn.h ${D}${includedir}/
}
