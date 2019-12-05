PACKAGES += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'simicsfs', 'packagegroup-base-simicsfs', '', d)} \
    "

SUMMARY_packagegroup-base-simicsfs = "simicsfs filesystem support"
RDEPENDS_packagegroup-base-simicsfs = "simicsfs-fuse"

RDEPENDS_packagegroup-base_append = " \
    ${@bb.utils.contains('COMBINED_FEATURES', 'simicsfs', 'packagegroup-base-simicsfs', '', d)} \
    "
