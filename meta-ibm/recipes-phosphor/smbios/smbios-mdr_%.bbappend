FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "\
    file://smbios-ver3-support.patch \
    file://0001-Toggle-pcieslot-presence-based-on-current-usage.patch \
    file://0001-pcieslot-Add-slottype-by-length-support.patch \
"
