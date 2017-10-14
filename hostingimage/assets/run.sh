#! /bin/bash

DIR="/var/lib/mysql"
service mysql stop
service apache2 stop
sleep 10 
echo "Checking for already populated db"
if [ "$(ls -A $DIR)" ]; then
     echo "old DB found."
else
     echo "No db found, creating std"
     cp -rp /tmp/database/* /var/lib/mysql/ 
fi
if [ $safemode="off" ]; then
	echo "safe_mode: off" > /etc/php5/apache/php.ini
fi

echo "Starting services"
service mysql start
service apache2 start
rm -rf /tmp/database
tail -f /var/log/apache2/access.log
