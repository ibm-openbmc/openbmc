#!/bin/sh

# Get the value of the root env variable found in /proc/cmdline
get_root() {
    local root="$(cat /proc/cmdline)"
    root="${root##* root=PARTLABEL=}"
    root="${root%% *}"
    [ "${root}" != "" ] && echo "${root}"
}

fslist="proc sys dev run"
rodir=/mnt/rofs
cd /
mkdir -p $fslist
mount dev dev -tdevtmpfs
mount sys sys -tsysfs
mount proc proc -tproc
mount tmpfs run -t tmpfs -o mode=755,nodev

# Wait up to 5s for the mmc device to appear. Continue even if the count is
# exceeded. A failure will be caught later like in the mount command.
mmcdev="/dev/mmcblk0"
count=0
while [ $count -lt 5 ]; do
    if [ -e "${mmcdev}" ]; then
        break
    fi
    sleep 1
    count=$((count + 1))
done

# Move the secondary GPT to the end of the device if needed. Look for the GPT
# header signature "EFI PART" located 512 bytes from the end of the device.
if ! tail -c 512 "${mmcdev}" | hexdump -C -n 8 | grep -q "EFI PART"; then
    sgdisk -e "${mmcdev}"
    partprobe
fi

# There eMMC GPT labels for the rootfs are rofs-a and rofs-b, and the label for
# the read-write partition is rwfs. Run udev to make the partition labels show 
# up. Mounting by label allows for partition numbers to change if needed.
udevd --daemon
udevadm trigger --type=devices --action=add
udevadm settle --timeout=10

mkdir -p $rodir
if ! mount /dev/disk/by-partlabel/"$(get_root)" $rodir -t ext4 -o ro; then
    /bin/sh
fi

# Determine if a factory reset has been requested
mkdir -p /var/lock
resetval=$(fw_printenv -n rwreset 2>/dev/null)
gpiopresent=$(gpiofind factory-reset-toggle)
gpioval=$(gpioget $gpiopresent)
# Prevent unnecessary resets on first boot
if [ -n "$gpiopresent" ] && [ -z "$resetval" ]; then
    fw_setenv rwreset $gpioval
    resetval=$gpioval
    mkdir -p /var/lib/openpower-pnor-code-mgmt
    echo "First boot" > /var/lib/openpower-pnor-code-mgmt/reset-done
fi
rwfsdev="/dev/disk/by-partlabel/rwfs"
if ([ -z "$gpiopresent" ] && [ -n "$resetval" ]) ||
        ([ -n "$gpiopresent" ] && [ "$resetval" != "$gpioval" ]); then
    echo "Factory reset requested."
    if ! mkfs.ext4 -F "${rwfsdev}"; then
        echo "Reformat for factory reset failed."
        /bin/sh
    # Perform a bios reset only if a gpio change triggered the reset
    else
        if [ "$resetval" = "0" ] || [ "$resetval" = "1" ]; then
            echo "Performing bios reset."
            mkdir -p /media/hostfw
            mount /dev/disk/by-partlabel/hostfw /media/hostfw
            mv /media/hostfw/hostfw-a /var
            mv /media/hostfw/hostfw-b /var
            umount /media/hostfw
            if ! mkfs.ext4 -F /dev/disk/by-partlabel/hostfw; then
                echo "Bios reset failed."
                /bin/sh
            fi
            mount /dev/disk/by-partlabel/hostfw /media/hostfw
            mv /var/hostfw-a /media/hostfw
            mv /var/hostfw-b /media/hostfw
            umount /media/hostfw
        fi
        if [ -n "$gpiopresent" ]; then
            fw_setenv rwreset $gpioval
        else
            fw_setenv rwreset
        fi
        echo "Formatting of rwfs is complete."
    fi
fi

fsck.ext4 -p "${rwfsdev}"
if ! mount "${rwfsdev}" $rodir/var -t ext4 -o rw; then
    /bin/sh
fi

rm -rf $rodir/var/persist/etc-work/
mkdir -p $rodir/var/persist/etc $rodir/var/persist/etc-work $rodir/var/persist/home/root
mount overlay $rodir/etc -t overlay -o lowerdir=$rodir/etc,upperdir=$rodir/var/persist/etc,workdir=$rodir/var/persist/etc-work

for f in $fslist; do
    mount --move $f $rodir/$f
done

exec switch_root $rodir /sbin/init
