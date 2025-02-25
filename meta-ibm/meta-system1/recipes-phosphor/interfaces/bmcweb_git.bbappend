FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Add-PCIeSlots-Redfish-Endpoint-for-Chassis.patch \
            file://0002-Refactor-DHCPv4-handling-in-Ethernet-interface.patch"
