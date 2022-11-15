#!/bin/sh

subModel=($(busctl get-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.Asset SubModel))

if [ "${subModel[1]}" = '"J0"' ]; then
    echo "Loading ibm-asset-tag.sh: "$1
    if [ "$1" == "update" ]; then
        assetTag=($(busctl get-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.AssetTag AssetTag))
        assetTag=`echo ${assetTag[1]} | sed 's/\"//g'`
        /sbin/fw_setenv ipsAssetTag ${assetTag}
    elif [ "$1" == "recover" ]; then
        assetTag=($(/sbin/fw_printenv ipsAssetTag | awk -F= '{print $2}'))
        busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.AssetTag AssetTag s ${assetTag}
    fi
fi
