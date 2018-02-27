#!/bin/bash

DB_USER='sams'
DB_PASSWORD='ololo'
CHK_FILE=`du -k /var/lib/mysql/squidlog/cache.MYD | cut -f1`

if [ "$CHK_FILE" -ge "5368706371" ]; # если болье или равно 5 GB
then

    /etc/init.d/squid stop

mysql --user=$DB_USER --password=$DB_PASSWORD <<EOF
USE squidlog;
TRUNCATE TABLE cache;
\q
EOF

    /etc/init.d/squid start

fi
