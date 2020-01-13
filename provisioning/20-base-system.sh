#!/bin/sh -eux

apt-get update
apt-get install -y --no-install-recommends lubuntu-desktop
apt-get install -y ark featherpad firefox qpdfview

reboot
