SUMMARY = "Copy error yaml files to known path for elog parsing"
PR = "r1"

inherit native
inherit obmc-phosphor-license
inherit phosphor-dbus-yaml

require sbe-validation.inc

S = "${WORKDIR}/git"

do_install_append() {
    SRC=${S}/xyz/openbmc_project/SBE
    DEST=${D}${yaml_dir}/xyz/openbmc_project/SBE
    install -d ${DEST}
    install ${SRC}/*.errors.yaml ${DEST}
    install ${SRC}/*.metadata.yaml ${DEST}
}
