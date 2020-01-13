#!/bin/sh -eux

dd if=/dev/zero of=/tmp/whitespace bs=4096k || true
rm /tmp/whitespace

dd if=/dev/zero of=/boot/whitespace bs=4096k || true
rm /boot/whitespace

sync
