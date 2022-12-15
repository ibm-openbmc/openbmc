# Allow passwordless use of sudo

PACKAGECONFIG += "pam-wheel"

do_install:append () {
        sed -i 's/# \(%wheel ALL=(ALL:ALL) ALL\)/\1/' ${D}${sysconfdir}/sudoers
        # Allow members of the 'wheel' group to use passwordless sudo
        sed -i 's/# \(%wheel ALL=(ALL:ALL) NOPASSWD: ALL\)/\1/' ${D}${sysconfdir}/sudoers
}
