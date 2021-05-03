FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://plugins.d/guard"

DEBUG_COLLECTOR_PKGS += "${PN}-opdreport"

RDEPENDS_${PN}-opdreport += " bash gzip "

FILES_${PN}-opdreport += "${bindir}/opdreport"

install_openpower_plugins() {
    install -m 0755 ${WORKDIR}/plugins.d/guard ${D}${dreport_plugin_dir}
}

#Link in the plugins so dreport run them at the appropriate time
python link_openpower_plugins() {
    workdir = d.getVar('WORKDIR', True)
    script = os.path.join(workdir, 'plugins.d', 'guard')
    install_dreport_user_script(script, d)
}

install_openpower_dump_script() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/dump-extensions/openpower-dumps/opdreport \
                    ${D}${bindir}/opdreport
}

DEBUG_COLLECTOR_INSTALL_POSTFUNCS ?= ""
DEBUG_COLLECTOR_INSTALL_POSTFUNCS_df-openpower ?= " \
    install_openpower_plugins \
    link_openpower_plugins \
    install_openpower_dump_script \
"

do_install[postfuncs] += "${DEBUG_COLLECTOR_INSTALL_POSTFUNCS}"
