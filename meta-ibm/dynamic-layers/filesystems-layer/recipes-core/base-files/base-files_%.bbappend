dirs755_append = " \
    ${@bb.utils.contains('COMBINED_FEATURES', 'simicsfs', '/host', '', d)} \
    "
