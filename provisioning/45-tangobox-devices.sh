#!/bin/sh -eux

systemctl start tango.target

sleep 5

tango_admin --add-server Starter/`hostname -s` Starter tango/admin/`hostname -s`
tango_admin --add-property tango/admin/`hostname -s` StartDsPath /usr/bin,/usr/local/bin
tango_put_server_info TangoTest/test tangobox 1 1
