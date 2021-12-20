#!/bin/bash -e
# Purpose: Upgrade pre-release BMCs with items needed for IBM service user
# This can be removed when there is no longer a direct upgrade path for BMCs
# which were installed with pre-release images.

# Create groups if not already present
for i in shellaccess hostconsoleaccess hypervisorconsoleaccess priv-oemibmserviceagent; do
    if grep -q $i /etc/group; then
        echo "$i already exists"
    else
        echo "$i does not exist, add it"
        groupadd -f $i
    fi
done

# Add the root user to the groups
for i in shellaccess hostconsoleaccess hypervisorconsoleaccess; do
    if id -nG root | grep -q $i; then
        echo "root already in $i"
    else
        echo "root not in group $i, add it"
        usermod -a -G $i root
    fi
done

# Change the root user to priv-oemibmserviceagent, but only if it is priv-admin
if id -nG root | grep -q "priv-admin"; then
    echo "Changing root from priv-admin to priv-oemibmserviceagent"
    usermod -G $(id -nG root | sed s/priv-admin/priv-oemibmserviceagent/ | tr ' ' ',') root
else
    echo "root not in priv-admin"
fi

# Add the service user to the groups
for i in shellaccess hostconsoleaccess hypervisorconsoleaccess; do
    if id -nG service | grep -q $i; then
        echo "service already in $i"
    else
        echo "service not in group $i, add it"
        usermod -a -G $i service
    fi
done

# Change the service user to priv-oemibmserviceagent if it is priv-admin
if id -nG service | grep -q "priv-admin"; then
    echo "Changing service from priv-admin to priv-oemibmserviceagent"
    usermod -G $(id -nG service | sed s/priv-admin/priv-oemibmserviceagent/ | tr ' ' ',') service
else
    echo "service not in priv-admin"
fi

# Populate the service user's home directory, if not already present
if ! test -d /home/service; then
    echo "Adding /home/service directory"
    mkdir /home/service/
    echo "/usr/bin/sudo -s;exit" >/home/service/.profile 
    chown service:service /home/service /home/service/.profile 
    usermod --home /home/service service
else
    echo "/home/service directory already exists"
fi
