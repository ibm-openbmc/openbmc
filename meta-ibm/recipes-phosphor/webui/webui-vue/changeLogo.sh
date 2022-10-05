#!/bin/sh -e

model=($(busctl get-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.Asset SubModel))
DIR=/usr/share/www/img
CSS_DIR=/usr/share/www/css
if [ "${model[1]}" = '"S0"' ]  || [ "${model[1]}" = '"D0"' ]; then
    echo "Using IBM logo"
elif [ "${model[1]}" = '"J0"' ]; then
    echo "loading IPS logo"
    mount --bind ${DIR}/inspur-login-logo.svg.gz ${DIR}/login-company-logo.svg.gz
    mount --bind ${DIR}/inspur-logo-header.svg.gz ${DIR}/logo-header.svg.gz
    mount --bind ${DIR}/blankLogo.svg.gz  /usr/share/www/bee-2-light.svg.gz
    mount --bind ${CSS_DIR}/ips.app.css.gz  ${CSS_DIR}/app.css.gz
else
    echo "loading OEM logo"
    mount --bind ${DIR}/blankLogo.svg.gz ${DIR}/login-company-logo.svg.gz
    mount --bind ${DIR}/blankLogo.svg.gz ${DIR}/logo-header.svg.gz
    mount --bind ${DIR}/blankLogo.svg.gz  /usr/share/www/bee-2-light.svg.gz
fi
