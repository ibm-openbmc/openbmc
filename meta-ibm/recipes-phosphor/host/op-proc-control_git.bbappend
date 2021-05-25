PACKAGECONFIG ??= "${@bb.utils.contains('OBMC_MACHINE_FEATURES', 'phal', 'phal', '', d)}  \
                   ${@bb.utils.contains('OBMC_MACHINE_FEATURES', 'op-fsi', 'openfsi', '', d)} \
                  "

PACKAGECONFIG[phal] = "--enable-phal, --disable-phal --enable-p9, ipl"

PACKAGECONFIG[openfsi] = "--enable-openfsi, --disable-openfsi"
