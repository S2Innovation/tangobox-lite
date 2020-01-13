#!/bin/sh -eux

apt-get -y clean

find /var/cache -type f -exec rm -rf {} \;
find /var/log -type f -exec truncate --size=0 {} \;

truncate -s 0 /etc/machine-id

rm -rf /tmp/* /var/tmp/*

export HISTSIZE=0
rm -f /root/.wget-hsts
