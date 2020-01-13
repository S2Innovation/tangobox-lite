#!/bin/sh -eux

sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

systemctl stop apt-daily.timer;
systemctl stop apt-daily-upgrade.timer
systemctl disable apt-daily.timer
systemctl disable apt-daily-upgrade.timer
systemctl mask apt-daily.service
systemctl mask apt-daily-upgrade.service
systemctl daemon-reload
