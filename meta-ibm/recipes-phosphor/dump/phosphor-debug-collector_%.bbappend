FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

inherit openpower-dump

PACKAGECONFIG_append_p10bmc = " host-dump-transport-pldm"
PACKAGECONFIG_append_witherspoon-tacoma = " host-dump-transport-pldm"

PACKAGECONFIG_append_p10bmc = " openpower-dumps-extension"
PACKAGECONFIG_append_witherspoon-tacoma = " openpower-dumps-extension"

# dump-extensions/openpower-dumps/create_openpower_dump_dirs.service
DIR_CRT_SVC ?= "create_openpower_dump_dirs.service"
SYSTEMD_SERVICE_${PN}-manager += "${DIR_CRT_SVC}"

SYSTEMD_SUBSTITUTIONS_append_p10bmc += "HOSTBOOT_DUMP_PATH:${hostboot_dump_path}:${DIR_CRT_SVC}"
SYSTEMD_SUBSTITUTIONS_append_witherspoon-tacoma += "HOSTBOOT_DUMP_PATH:${hostboot_dump_path}:${DIR_CRT_SVC}"

EXTRA_OEMESON_append_p10bmc += "-DHOSTBOOT_DUMP_PATH=${hostboot_dump_path}"
EXTRA_OEMESON_append_p10bmc += "-DHOSTBOOT_DUMP_TMP_FILE_DIR=${hostboot_dump_temp_path}"

SRC_URI += "file://plugins.d/ibm_elogall"
SRC_URI += "file://plugins.d/pels"

install_ibm_plugins() {

    install -m 0755 ${WORKDIR}/plugins.d/ibm_elogall ${D}${dreport_plugin_dir}
    install -m 0755 ${WORKDIR}/plugins.d/pels ${D}${dreport_plugin_dir}

}

#Link in the plugins so dreport run them at the appropriate time
python link_ibm_plugins() {

    workdir = d.getVar('WORKDIR', True)
    script = os.path.join(workdir, 'plugins.d', 'ibm_elogall')
    install_dreport_user_script(script, d)

    script = os.path.join(workdir, 'plugins.d', 'pels')
    install_dreport_user_script(script, d)
}

#Install dump header script from dreport/ibm.d to dreport/include.d
install_dreport_header() {
    install -d ${D}${dreport_include_dir}
    install -m 0755 ${S}/tools/dreport.d/ibm.d/gendumpheader ${D}${dreport_include_dir}/
}

#Install ibm bad vpd script from dreport/ibm.d to dreport/plugins.d
install_ibm_bad_vpd() {
    install -d ${D}${dreport_plugin_dir}
    install -m 0755 ${S}/tools/dreport.d/ibm.d/badvpd ${D}${dreport_plugin_dir}
}

#Link in the plugins so dreport run them at the appropriate time based on the plugin type
python link_ibm_bad_vpd() {
    sourcedir = d.getVar('S', True)
    script = os.path.join(sourcedir, "tools", "dreport.d", "ibm.d", "badvpd")
    install_dreport_user_script(script, d)
}

IBM_INSTALL_POSTFUNCS = "install_ibm_plugins link_ibm_plugins"
IBM_INSTALL_POSTFUNCS_p10bmc += "install_dreport_header install_ibm_bad_vpd link_ibm_bad_vpd"

do_install[postfuncs] += "${IBM_INSTALL_POSTFUNCS}"
