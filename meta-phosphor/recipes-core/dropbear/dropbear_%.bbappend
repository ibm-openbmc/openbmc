# 0001-Only-load-dropbear-default-host-keys-if-a-key-is-not.patch
# has been upstreamed.  This patch can be removed once we upgrade
# to yocto 2.5 or later which will pull in the latest dropbear code.
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://dropbearkey.service \
            file://localoptions.h \
            file://dropbear.default \
            file://0001-implement-expired-password-dialog.patch \
           "

do_configure_append() {
    install -m 0644 ${WORKDIR}/localoptions.h ${B}
}

# pull in OpenSSH's /usr/libexec/sftp-server so we don't have to rely
# on the crufty old scp protocol for file transfer
RDEPENDS_${PN} += "openssh-sftp-server"
