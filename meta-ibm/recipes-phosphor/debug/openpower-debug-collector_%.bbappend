PACKAGECONFIG_append_p10bmc += "${@bb.utils.contains('OBMC_MACHINE_FEATURES', 'phal', 'openpower_dump_collection', '', d)}"
