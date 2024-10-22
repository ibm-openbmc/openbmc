FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:system1 = " file://0001-SPL-ast2600-hardcode-emmc-boot.patch"
