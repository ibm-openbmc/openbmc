#!/bin/sh

SubModel=($(busctl get-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system/chassis/motherboard/bmc xyz.openbmc_project.Inventory.Decorator.Asset SubModel))
echo "SubModel="${SubModel[1]}

if [ "${SubModel[1]}" = '"ETH"' ]
   then
		echo "SubModel="${SubModel[1]}" was detected, so first-boot-set-mac@eth1.service is disabled"
		systemctl disable first-boot-set-mac@eth1.service 
fi
