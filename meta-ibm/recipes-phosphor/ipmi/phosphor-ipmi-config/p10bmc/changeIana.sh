#!/bin/sh -e

model=($(busctl get-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.Asset SubModel))
DIR=/usr/share/ipmi-providers
if [ "${model[1]}" = '"S0"' ]  || [ "${model[1]}" = '"D0"' ]; then
    echo "Using IBM IANA"
elif [ "${model[1]}" = '"J0"' ]; then
    echo "loading IPS IANA"
    mount --bind ${DIR}/dev_id_ips.json ${DIR}/dev_id.json
else
    echo "loading OEM IANA"
fi