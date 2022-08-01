#!/bin/sh

model=($(busctl get-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.Asset SubModel))
DIR=/usr/share/www/img
if [ "${model}" = '"S0"' || "${model}" = '"D0"' ]; then
    echo "Using IBM logo"
elif [ "${model}" = '"J0"' ]; then
    echo "loading IPS logo"
    mount --bind ${DIR}/inspur-login-logo.svg.gz ${DIR}/login-company-logo.svg.gz
    mount --bind ${DIR}/inspur-logo-header.svg.gz ${DIR}/logo-header.svg.gz
else
    mount --bind ${DIR}/blankLogo.svg.gz ${DIR}/login-company-logo.svg.gz
    mount --bind ${DIR}/blankLogo.svg.gz ${DIR}/logo-header.svg.gz
fi
