# This is based on OpenBMC's copy of the libpwquality recipe.
# PACKAGECONFIG:remove = "python-bindings"

# Install pam_pwquality.so in /lib/security (default /usr/lib/security)
EXTRA_OECONF += "--with-securedir=${base_libdir}/security"
FILES:${PN} += "${base_libdir}/security/pam_pwquality.so"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
        file://pwquality.conf \
        "

do_install:append() {
    # Install /etc/security/pwquality.conf
    install -d ${D}${sysconfdir}/security
    install -m 0644 ${WORKDIR}/pwquality.conf ${D}/etc/security
}
