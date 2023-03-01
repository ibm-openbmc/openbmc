OBMC_IMAGE_EXTRA_INSTALL:append:ibm-ac-server = " mboxd max31785-msl phosphor-msl-verify liberation-fonts uart-render-controller first-boot-set-hostname"
OBMC_IMAGE_EXTRA_INSTALL:append:p10bmc = " mboxd"

IMAGE_FEATURES:append = " obmc-dbus-monitor"

# remove so things fit in available flash space
IMAGE_FEATURES:remove:witherspoon = "obmc-user-mgmt-ldap"
IMAGE_FEATURES:remove:witherspoon = "obmc-telemetry"

# Remove unused rsyslog service in P10BMC
IMAGE_FEATURES:remove:p10bmc = "obmc-remote-logging-mgmt"

# Generic IPMI FRU vpd collection not needed on p10bmc
IMAGE_FEATURES:remove:p10bmc = "obmc-fru-ipmi"

# Optionally configure IBM service accounts
#
# To configure your distro, add the following line to its config:
#     DISTRO_FEATURES += "ibm-service-account-policy"
#
# The service account policy is as follows:
#   root - The root account remains present.  It is needed for internal
#     accounting purposes and for debugging service access.
#   admin - Provides administrative control over the BMC.  The role is
#     SystemAdministrator.  Admin users have access to interfaces including:
#     Redfish, REST APIs, Web.  No access to the BMC via: the BMC's physical
#     console, SSH to the BMC's command line.
#     IPMI access is not granted by default, but admins can authorize
#     themselves and enable the IPMI service.
#     The admin has access to the host console: ssh -p2200 admin@${bmc}.
#     The admin account does not have a home directory.
#   service - Provides IBM service and support representatives (SSRs, formerly
#     known as customer engineers or CEs) access to the BMC.  The role is
#     OemIBMServiceAgent.  The service user has full admin access, plus access
#     to BMC interfaces intended only to service the BMC and host, including
#     SSH access to the BMC's command line.
#     The service account is not authorized to IPMI because of the inherent
#     security weakness in the IPMI spec and also because the IPMI
#     implementation was not enhanced to use the ACF support.
#     The service account does not have a home directory.  The home directory is
#     set to / (the root directory) to allow dropbear ssh connections.

# Override defaults from meta-phosphor/conf/distro/include/phosphor-defaults.inc

# The password hash used here is the traditional 0penBmc password.

# Add groups "wheel" and "shellaccess" (before adding to accounts).
IBM_EXTRA_USERS_PARAMS += " \
  groupadd wheel; \
  groupadd shellaccess; \
  groupadd hostconsoleaccess; \
  groupadd hypervisorconsoleaccess; \
  groupadd priv-oemibmserviceagent; \
  "

IBM_EXTRA_USERS_PARAMS += " \
  usermod -p '\$6\$UGMqyqdG\$GqTb3tXPFx9AJlzTw/8X5RoW2Z.100dT.acuk8AFJfNQYr.ZRL8itMIgLqsdq46RNHgiv78XayOSl.IbR4DFU.' root; \
  usermod --groups priv-oemibmserviceagent,hypervisorconsoleaccess,hostconsoleaccess,shellaccess,redfish,web,root root; \
  usermod --lock root; \
  "

# Add the "admin" account.
IBM_EXTRA_USERS_PARAMS += " \
  useradd -M -d / --groups hostconsoleaccess,priv-admin,redfish,web -s /bin/sh admin; \
  usermod -p '\$6\$kkSXteT7FmlZdKMQ\$e4w/O1sXkPwi9Pzu2ZjKq/l2wZm4JScj7bsVvuPzb6aA6creBixr/7pl0GDWQLpt4nklSNbij8Yttr7esIlfQ0' admin; \
  passwd-expire admin; \
  "

# Add the "service" account.
IBM_EXTRA_USERS_PARAMS += " \
  useradd --groups priv-oemibmserviceagent,hostconsoleaccess,hypervisorconsoleaccess,redfish,web,wheel,shellaccess service; \
  "

# This is recipe specific to ensure it takes effect.
EXTRA_USERS_PARAMS:pn-obmc-phosphor-image += "${@bb.utils.contains('DISTRO_FEATURES', 'ibm-service-account-policy', "${IBM_EXTRA_USERS_PARAMS}", '', d)}"

# The service account needs sudo.
IMAGE_INSTALL:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ibm-service-account-policy', 'sudo', '', d)}"
IMAGE_INSTALL:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ibm-service-account-policy', 'ibm-acf', '', d)}"
