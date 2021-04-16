SUMMARY = "OpenPOWER Debug Collector"
DESCRIPTION = "Application to log error during host checkstop and watchdog timeout"

PR = "r1"
PV = "1.0+git${SRCPV}"
OP_DEBUG_COLLECTOR_PKGS = " \
                          ${PN}-openpower-dump-manager \
                          "
PACKAGE_BEFORE_PN = "${OP_DEBUG_COLLECTOR_PKGS}"

inherit pkgconfig meson \
        obmc-phosphor-dbus-service \
        obmc-phosphor-systemd \
        python3native \
        phosphor-dbus-yaml \
        openpower-dump

require ${BPN}.inc
require ${BPN}-systemd-links.inc

OPENPOWER_DUMP_DEPENDS = " \
        phosphor-dbus-interfaces \
        pdbg \
        pdata \
        ipl \
        "

DEPENDS = " \
        phosphor-logging \
        ${PYTHON_PN}-sdbus++-native \
        cli11 \
        ipl \
        "

S = "${WORKDIR}/git"

# This provides below applications that are called into in case
# of host checkstop, host watchdog and host watchdog-timeout respectively.
APPS =  " \
        checkstop \
        watchdog \
        ${@bb.utils.contains('MACHINE_FEATURES', 'phal', '', 'watchdog-timeout', d)} \
        "

DEBUG_TMPL = "openpower-debug-collector-{0}@.service"
SYSTEMD_SERVICE:${PN} += "${@compose_list(d, 'DEBUG_TMPL', 'APPS')}"

DBUS_PACKAGES = "${@bb.utils.contains('PACKAGECONFIG','openpower_dump_collection','${OP_DEBUG_COLLECTOR_PKGS}','',d)}"

DBUS_SERVICE:${PN}-openpower-dump-manager = "${@bb.utils.contains('PACKAGECONFIG', 'openpower_dump_collection', 'org.open_power.Dump.Manager.service', '', d)}"

# Do not depend on phosphor-logging for native build
DEPENDS:remove:class-native = "phosphor-logging"

# Do not depend on phosphor-logging for native SDK build
DEPENDS:remove:class-nativesdk = "phosphor-logging ipl"

PACKAGECONFIG ??= ""
PACKAGECONFIG[openpower_dump_collection] = " \
        -Ddump-collection=enabled  \
        -DHB_DUMP_COLLECTION_PATH=${hostboot_dump_temp_path} \
        -DHW_DUMP_COLLECTION_PATH=${hardware_dump_temp_path}, \
        -Ddump-collection=disabled, \
        ${OPENPOWER_DUMP_DEPENDS}, \
"

# Remove packages which doesn't build with nativesdk
DEPENDS:remove:class-nativesdk = " \
        phosphor-dbus-interfaces \
        sdbusplus \
        pdbg \
        pdata \
        ipl \
        "

