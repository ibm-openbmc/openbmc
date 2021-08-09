EXTRA_OECMAKE_append = " \
    -DBMCWEB_INSECURE_ENABLE_REDFISH_FW_TFTP_UPDATE=ON \
    -DBMCWEB_INSECURE_DISABLE_CSRF_PREVENTION=ON \
"

FILESEXTRAPATHS_prepend_mowgli := "${THISDIR}/${PN}:"
SRC_URI_append_mowgli = " file://0001-Revert-Add-concurrent-KVM-sessions-support.patch"
