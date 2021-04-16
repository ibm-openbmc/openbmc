FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

inherit openpower-dump

PACKAGECONFIG:append:p10bmc = " host-dump-transport-pldm"
PACKAGECONFIG:append:witherspoon-tacoma = " host-dump-transport-pldm"


PACKAGECONFIG:append:p10bmc = " openpower-dumps-extension"
PACKAGECONFIG:append:witherspoon-tacoma = " openpower-dumps-extension"

EXTRA_OEMESON:append:p10bmc += "-DHOSTBOOT_DUMP_PATH=${hostboot_dump_path}"
EXTRA_OEMESON:append:p10bmc += "-DHOSTBOOT_DUMP_TMP_FILE_DIR=${hostboot_dump_temp_path}"

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

IBM_INSTALL_POSTFUNCS = "install_ibm_plugins link_ibm_plugins"
IBM_INSTALL_POSTFUNCS:p10bmc += "install_dreport_header"

do_install[postfuncs] += "${IBM_INSTALL_POSTFUNCS}"
