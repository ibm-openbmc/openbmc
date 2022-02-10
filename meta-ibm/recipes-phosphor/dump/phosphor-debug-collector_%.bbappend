FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

inherit openpower-dump

PACKAGECONFIG:append:p10bmc = " host-dump-transport-pldm"
PACKAGECONFIG:append:witherspoon-tacoma = " host-dump-transport-pldm"


PACKAGECONFIG:append:p10bmc = " openpower-dumps-extension"
PACKAGECONFIG:append:witherspoon-tacoma = " openpower-dumps-extension"

EXTRA_OEMESON:append:p10bmc += "-DHOSTBOOT_DUMP_PATH=${hostboot_dump_path}"
EXTRA_OEMESON:append:p10bmc += "-DHOSTBOOT_DUMP_TMP_FILE_DIR=${hostboot_dump_temp_path}"

EXTRA_OEMESON:append:p10bmc += "-DHARDWARE_DUMP_PATH=${hardware_dump_path}"
EXTRA_OEMESON:append:p10bmc += "-DHARDWARE_DUMP_TMP_FILE_DIR=${hardware_dump_temp_path}"

#Dump values is in KB
EXTRA_OEMESON:append:p10bmc += "-DBMC_DUMP_MAX_SIZE=20480"
EXTRA_OEMESON:append:p10bmc += "-DBMC_DUMP_TOTAL_SIZE=409600"

SYSTEMD_SERVICE:${PN}-manager += "clear_hostdumps_poweroff.service"

SRC_URI += "file://plugins.d/ibm_elogall"
SRC_URI += "file://plugins.d/pels"

install_ibm_plugins() {
    install ${S}/tools/dreport.d/ibm.d/plugins.d/* ${D}${dreport_plugin_dir}/
}

#Link in the plugins so dreport run them at the appropriate time
python link_ibm_plugins() {
    source = d.getVar('S', True)
    source_path = os.path.join(source, "tools", "dreport.d", "ibm.d", "plugins.d")
    op_plugins = os.listdir(source_path)
    for op_plugin in op_plugins:
        op_plugin_name = os.path.join(source_path, op_plugin)
        install_dreport_user_script(op_plugin_name, d)
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

#Install gendumpinfo script from dreport/ibm.d to dreport/include.d
install_gendumpinfo() {
    install -d ${D}${dreport_include_dir}
    install -m 0755 ${S}/tools/dreport.d/ibm.d/gendumpinfo ${D}${dreport_include_dir}/
}

IBM_INSTALL_POSTFUNCS = "install_ibm_plugins link_ibm_plugins"
IBM_INSTALL_POSTFUNCS:p10bmc += "install_dreport_header install_ibm_bad_vpd link_ibm_bad_vpd install_gendumpinfo"

do_install[postfuncs] += "${IBM_INSTALL_POSTFUNCS}"
