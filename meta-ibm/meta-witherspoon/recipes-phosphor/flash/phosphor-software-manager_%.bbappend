BMC_RW_MTD_ibm-ac-server = "bmc"
BMC_RW_MTD_mihawk = "bmc"
BMC_RW_MTD_mowgli = "bmc"
BMC_RO_MTD_ibm-ac-server = "alt-bmc+bmc"
BMC_RO_MTD_mihawk = "alt-bmc+bmc"
BMC_RO_MTD_mowgli = "alt-bmc+bmc"
BMC_KERNEL_MTD_ibm-ac-server = "bmc"
BMC_KERNEL_MTD_mihawk = "bmc"
BMC_KERNEL_MTD_mowgli = "bmc"

# Enable signature verification
PACKAGECONFIG_append_ibm-ac-server = " verify_signature"
PACKAGECONFIG_append_mihawk = " verify_signature"
PACKAGECONFIG_append_mowgli = " verify_signature"

# Enable sync of persistent files to the alternate BMC chip
PACKAGECONFIG_append_ibm-ac-server = " sync_bmc_files"
PACKAGECONFIG_append_mihawk = " sync_bmc_files"
PACKAGECONFIG_append_mowgli = " sync_bmc_files"
