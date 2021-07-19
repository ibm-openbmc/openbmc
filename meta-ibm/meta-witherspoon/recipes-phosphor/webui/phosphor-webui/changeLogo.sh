#!/bin/sh

model=($(busctl get-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system/chassis/motherboard/bmc xyz.openbmc_project.Inventory.Decorator.Asset Model))
echo ${model[1]}
DIR=/usr/share/www/app/assets/images
if [ "${model[1]}" = '"OEM"' ]
   then
		mount --bind ${DIR}/blankLogo.svg.gz ${DIR}/logo.svg.gz
		mount --bind ${DIR}/blankLogo.svg.gz ${DIR}/BuiltOnOpenBMC.svg.gz
fi


