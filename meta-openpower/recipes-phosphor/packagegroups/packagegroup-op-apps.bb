SUMMARY = "OpenBMC for OpenPOWER - Applications"
PR = "r1"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
        ${PN}-chassis \
        ${PN}-fans \
        ${PN}-flash \
        ${PN}-system \
        "

PROVIDES += "virtual/obmc-chassis-mgmt"
PROVIDES += "virtual/obmc-fan-mgmt"
PROVIDES += "virtual/obmc-flash-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"

RPROVIDES_${PN}-chassis += "virtual-obmc-chassis-mgmt"
RPROVIDES_${PN}-fans += "virtual-obmc-fan-mgmt"
RPROVIDES_${PN}-flash += "virtual-obmc-flash-mgmt"
RPROVIDES_${PN}-system += "virtual-obmc-system-mgmt"

SUMMARY_${PN}-chassis = "OpenPOWER Chassis"
RDEPENDS_${PN}-chassis = " \
        obmc-phosphor-buttons-signals \
        obmc-phosphor-buttons-handler \
        obmc-op-control-power \
        obmc-host-failure-reboots \
        "
#Pull in obmc-fsi on all P9 OpenPOWER systems
RDEPENDS_${PN}-chassis += "${@bb.utils.contains('MACHINE_FEATURES', 'op-fsi', 'op-fsi', '', d)}"

#Pull in p9-cfam-override on all P9 OpenPOWER systems
RDEPENDS_${PN}-chassis += "${@bb.utils.contains('MACHINE_FEATURES', 'p9-cfam-override', 'p9-cfam-override', '', d)}"

SUMMARY_${PN}-fans = "OpenPOWER Fans"
RDEPENDS_${PN}-fans = " \
        "

SUMMARY_${PN}-flash = "OpenPOWER Flash"

RDEPENDS_${PN}-flash = " \
        openpower-software-manager\
        "
RDEPENDS_${PN}-flash_append_witherspoon-128 = " host-fw"
RDEPENDS_${PN}-flash_append_witherspoon-tacoma = " host-fw"
RDEPENDS_${PN}-flash_append_p10bmc = " host-fw"
RDEPENDS_${PN}-system_append_p10bmc = " guard"

SUMMARY_${PN}-system = "OpenPOWER System"
RDEPENDS_${PN}-system = " \
        pdbg \
        croserver \
        ${@bb.utils.contains('OBMC_MACHINE_FEATURES', 'phal', 'ecmd-pdbg', '', d)} \
        "
