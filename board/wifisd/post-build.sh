#!/bin/bash

# This script is automatically run just before image building.
# Use it to modify the rootfs before everything is assembled into an image.
# $1 is the path to the rootfs that's about to be built into an image.

cd "$1"

# Move /root to /usr/share/mtd/root so it ends up in /mnt/mtd/root
mv root usr/share/mtd/
ln -s /mnt/mtd/root root

# Move /etc to /usr/share/mtd/etc so it ends up in /mnt/mtd/etc
rm -rf etc/network
mv etc usr/share/mtd/
mkdir etc
cp usr/share/mtd/etc/inittab etc
cp usr/share/mtd/etc/fstab etc

