FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append:system1 = " file://0001-Added-PCIe-Slots-Table-in-Inventory-and-LEDs-Page.patch"
EXTRA_OENPM:witherspoon-tacoma = "-- --mode ibm"
EXTRA_OENPM:p10bmc = "-- --mode ibm"
