RDEPENDS:${PN} += "pflash"

SYSTEMD_SERVICE:${PN} += "openpower-pnor-update@.service"
SYSTEMD_SERVICE:${PN}:remove:df-phosphor-mmc += "openpower-pnor-update@.service"

