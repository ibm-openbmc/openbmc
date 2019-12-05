dirs755:append = " \
    ${@bb.utils.contains('COMBINED_FEATURES', 'simicsfs', '/host', '', d)} \
    "
