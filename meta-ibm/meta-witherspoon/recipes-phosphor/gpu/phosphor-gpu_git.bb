SUMMARY = "Phosphor GPU"
DESCRIPTION = "phosphor-gpu is the gpu sensor reading"

inherit autotools pkgconfig
inherit obmc-phosphor-dbus-service
inherit obmc-phosphor-systemd
inherit phosphor-dbus-yaml
inherit pythonnative

DEPENDS += "sdbusplus"
DEPENDS += "phosphor-dbus-interfaces"
DEPENDS += "sdeventplus"
DEPENDS += "phosphor-logging"
DEPENDS += "sdbusplus-native"
DEPENDS += "autoconf-archive-native"
DEPENDS += "nlohmann-json"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

SRC_URI := "git://github.com/wistron-corporation/phosphor-gpu.git;protocol=git"
SRCREV := "f634dc0677de4a4776f832c68685345634004820"
S = "${WORKDIR}/git"

DBUS_SERVICE_${PN} += "xyz.openbmc_project.gpu.manager.service"

