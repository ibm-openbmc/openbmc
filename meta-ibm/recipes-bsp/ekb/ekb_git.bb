SUMMARY     = "To get hardware procedures attributes xml files"
DESCRIPTION = "To boot the server hwp attributes also required and those attributes will be include in power specific system device tree"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

require ekb_p10.inc

SRC_URI = "${EKB_URI}"
SRCREV = "${EKB_REV}"

S = "${WORKDIR}/git"

BBCLASSEXTEND = "native"

do_install() {

    mkdir -p ${D}${datadir}/${BPN}

    # Copying all required hwp's attributes xml file with respective directory structures
    (cd ${S} && cp --parents ${REQ_ATTRS_XMLS} ${D}${datadir}/${BPN})
}
