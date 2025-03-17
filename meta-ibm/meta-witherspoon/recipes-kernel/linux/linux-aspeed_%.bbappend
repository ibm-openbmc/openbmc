FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_ibm-ac-server = " file://witherspoon.cfg"
SRC_URI_append_mihawk += " file://mihawk.cfg"
SRC_URI_append_mowgli += " file://mowgli.cfg"
