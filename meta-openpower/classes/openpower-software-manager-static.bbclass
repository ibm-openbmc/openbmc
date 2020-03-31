RDEPENDS_${PN} += "pflash"

SYSTEMD_SERVICE_${PN} += "openpower-pnor-update@.service"
SYSTEMD_SERVICE_${PN}_remove_df-phosphor-mmc += "openpower-pnor-update@.service"

