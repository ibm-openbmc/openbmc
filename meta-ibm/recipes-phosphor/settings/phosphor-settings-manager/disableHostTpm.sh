#!/bin/sh

subModel=($(busctl get-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.Asset SubModel))

if [ "${subModel[1]}" = '"J0"' ]; then
   busctl set-property xyz.openbmc_project.Settings /xyz/openbmc_project/control/host0/TPMEnable xyz.openbmc_project.Control.TPM.Policy TPMEnable b false
fi
