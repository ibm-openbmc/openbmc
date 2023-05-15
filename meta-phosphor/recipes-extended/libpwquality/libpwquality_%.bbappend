# This is based on OpenBMC's copy of the libpwquality recipe.
# PACKAGECONFIG:remove = "python-bindings"

# Install pam_pwquality.so in /lib/security (default /usr/lib/security)
EXTRA_OECONF += "--with-securedir=${base_libdir}/security"
FILES:${PN} += "${base_libdir}/security/pam_pwquality.so"

do_install:append() {
    # Install /etc/security/pwquality.conf
    # Uncomment selected parameters and set default values.  Omit spaces for
    # compatibility with phosphor-user-manager.
    install -d ${D}${sysconfdir}/security
    install -m 644 ${S}/src/pwquality.conf ${D}${sysconfdir}/security/pwquality.conf
    sed -i -e '/^# enforce_for_root/s/^# //' \
        -e '/^# unlock_time =/s/.*/unlock_time=0/' \
        -e '/^# usercheck =/s/.*/usercheck=1/' \
        -e '/^# minlen =/s/.*/minlen=8/' \
        -e '/^# difok =/s/.*/difok=0/' \
        -e '/^# lcredit =/s/.*/lcredit=0/' \
        -e '/^# ocredit =/s/.*/ocredit=0/' \
        -e '/^# dcredit =/s/.*/dcredit=0/' \
        -e '/^# ucredit =/s/.*/ucredit=0/' \
        -e '/^# minclass =/s/.*/minclass=2/' \
        ${D}${sysconfdir}/security/pwquality.conf
}
