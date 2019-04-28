#!/bin/sh
set -e
echo "starting httpd"
exec /usr/sbin/httpd -D FOREGROUND
