#!/bin/ash

# restore all user-changable settings to defaults

if [ ! -d /mnt/mtd/etc -o ! -f /mnt/mtd/etc/init.d/rcS ] ; then
    echo "Missing files in /mnt/mtd - sying with --ignore-existing"
    rsync -ar --ignore-existing /usr/share/mtd/* /mnt/mtd
elif [ -f /mnt/sd/factory_reset ] ; then
    echo "Factory reset indicated - syncing /mnt/mtd"
    rsync -ar /usr/share/mtd/* /mnt/mtd
    rm -f /mnt/sd/factory_reset
fi

