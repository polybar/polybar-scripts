#!/bin/sh

if /opt/lampp/xampp status | grep -q "Apache...ok"; then
	status_apache="#11"
else
	status_apache="#12"
fi

if opt/lampp/xampp status |grep -q "MySQL...ok"; then
	status_mysql="#21"
else
	status_mysql="#22"
fi

if /opt/lampp/xampp status | grep -q "ProFTPD...ok"; then
	status_ftp="#31"
else
	status_ftp="#32"
fi

echo "$status_apache $status_mysql $status_ftp"
