SUMMARY     = "Isolate a faulty hardware parts"
DESCRIPTION = "Provide a way to isolate faulty hardware from the system boot"
PR = "r1"
PV = "1.0+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

inherit meson \
        obmc-phosphor-dbus-service \
        phosphor-dbus-yaml

S = "${WORKDIR}/git"

SRC_URI = "git://git@github.com/ibm-openbmc/openpower-hw-isolation;branch="main""
SRCREV = "4ed4f01134a4b1c3d0593600e8833b6eacefbe0f"

DEPENDS = "sdbusplus \
           phosphor-dbus-interfaces \
           phosphor-logging \
           sdeventplus \
           pdbg \
           pdata \
           guard \
          "

DBUS_SERVICE_${PN} = "org.open_power.HardwareIsolation.service"
