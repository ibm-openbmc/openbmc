#!/bin/bash -e

# Create groups if not available
for i in web ipmi redfish priv-admin priv-operator priv-user priv-callback; do
    if grep -q $i /etc/group; then
        echo "$i already exists"
    else
        echo "$i does not exist, add it"
        groupadd -f $i
    fi
done

# Root needs to be a member of these groups
for i in ipmi web redfish priv-admin; do
    if id -nG root | grep -q $i; then
        echo "root already in $i"
    else
        echo "root not in group $i, add it"
        usermod -a -G $i root
    fi
done
