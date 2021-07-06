PACKAGECONFIG ??= "${@bb.utils.filter('OBMC_MACHINE_FEATURES', 'phal op-fsi', d)}"

PACKAGECONFIG[phal] = "-Dphal=enabled, -Dphal=disabled -Dp9=enabled, ipl pdata"

PACKAGECONFIG[op-fsi] = "-Dopenfsi=enabled, -Dopenfsi=disabled"
