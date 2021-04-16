EXTRA_OEMESON:append:p10bmc = " -Dhostboot-dump-collection=enabled "
PACKAGECONFIG:append:p10bmc = "${@bb.utils.contains('MACHINE_FEATURES', 'phal', 'openpower_dump_collection', '', d)}"
