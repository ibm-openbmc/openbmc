FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_ibm-ac-server = " file://TPMEnable-default-true.override.yml"
SRC_URI_append_ibm-ac-server += " file://ClearHostSecurityKeys-default-zero.override.yml"
SRC_URI_append_mihawk = " file://TPMEnable-default-true.override.yml"
SRC_URI_append_mowgli = " file://TPMEnable-default-true.override.yml"
# Provide a means to enable/disable openpower dbus linking
DEPENDS += "openpower-dbus-interfaces openpower-dbus-interfaces-native"
PACKAGECONFIG ??= "link-op-dbus-intfs"
PACKAGECONFIG[link-op-dbus-intfs] = " \
        --enable-link-op-dbus-intfs, \
        --disable-link-op-dbus-intfs, ,\
        "
