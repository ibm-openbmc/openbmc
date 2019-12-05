PACKAGES += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'simicsfs', 'packagegroup-base-simicsfs', '', d)} \
    "

SUMMARY:packagegroup-base-simicsfs = "simicsfs filesystem support"
RDEPENDS:packagegroup-base-simicsfs = "simicsfs-fuse"

RDEPENDS:packagegroup-base:append = " \
    ${@bb.utils.contains('COMBINED_FEATURES', 'simicsfs', 'packagegroup-base-simicsfs', '', d)} \
    "
