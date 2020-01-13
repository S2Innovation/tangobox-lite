#!/bin/sh -eux

apt-get install -y \
  tree cmake git openjdk-8-jdk docker.io \
  mariadb-server mariadb-client \
  python3-pip python3-numpy python3-six python3-pyqt5.qtsvg \
  omniidl zlib1g-dev libzmq3-dev libomniorb4-dev libcos4-dev \
  libboost-python-dev libmariadb-dev libmariadbclient-dev \
  qttools5-dev

ln -s /usr/lib/x86_64-linux-gnu/libboost_python37.so \
  /usr/lib/x86_64-linux-gnu/libboost_python-py37.so

dpkg -i /var/tmp/packages/tango-source-distribution_9.3.4-rc3-dev_amd64.deb
pip3 install /var/tmp/packages/pytango-9.3.1-cp37-cp37m-linux_x86_64.whl

ldconfig

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
apt-add-repository 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main'
apt-get update
apt-get install -y codium

su tango-cs -c 'codium --install-extension ms-python.python'

cd /usr/local/share/tango/db
echo "create user 'tango'@'localhost' identified by 'secret'" | mysql
echo "grant all on tango.* to 'tango'@'localhost'" | mysql
echo "source create_db.sql" | mysql

pip3 install itango guidata Cython
pip3 install taurus[taurus-qt,taurus-tango,taurus-qt-editor]

su tango-cs -c 'ipython profile create'

rsync -r /var/tmp/filesystem/ /

useradd --system tango
usermod -a -G docker tango-cs

systemctl enable tango.target
