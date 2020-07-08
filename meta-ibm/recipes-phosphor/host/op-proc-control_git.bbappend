PACKAGECONFIG ??= "${@bb.utils.filter('OBMC_MACHINE_FEATURES', 'phal op-fsi', d)}"

PACKAGECONFIG[phal] = "--enable-phal, --disable-phal --enable-p9, ipl pdata"

PACKAGECONFIG[op-fsi] = "--enable-openfsi, --disable-openfsi"
