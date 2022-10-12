#!/bin/sh

if sudo /opt/lampp/xampp status | grep -q "Apache is running."; then
    status_apache="#11"
else
    status_apache="#12"
fi

if sudo /opt/lampp/xampp status | grep -q "MySQL is running."; then
    status_mysql="#21"
else
    status_mysql="#22"
fi

if sudo /opt/lampp/xampp status | grep -q "ProFTPD is running."; then
    status_ftp="#31"
else
    status_ftp="#32"
fi

echo "$status_apache $status_mysql $status_ftp"
