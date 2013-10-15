#!/bin/bash

# This script is automatically run just after image building.
# Use it to manipulate the already-built images.
# $1 is the path to the folder containing the images.


# We're using this to build initramfs3.gz from rootfs.cpio.gz.

# TODO: We might not need this anymore once buildroot is building our kernel

# This just prepends 0x4b41475aXXXXXXXX to rootfs.cpio.gz,
# where 0x4b41475a is a magic number and XXXXXXXX is the size
# of rootfs.cpio.gz in bytes.

IN="$1/rootfs.cpio.gz"
OUT="$1/initramfs3.gz"

# FIXME: printf gets the byte order wrong here on a big endian system
printf "0: 4b41475a%.8x" $(wc -c < "$IN") | xxd -r -g0 | cat - "$IN" > "$OUT"

