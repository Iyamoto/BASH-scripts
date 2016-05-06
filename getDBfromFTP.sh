#!/bin/sh

DATABASE=$1

ftp -n <<**
open IP
user login pass
bin
get $DATABASE.tar.gz
bye
**

tar -xzf $DATABASE.tar.gz
mysql -u root -pPASS < user.$DATABASE.sql
mysql -u root -pPASS < craft.$DATABASE.sql
mysql -u root -pPASS $DATABASE < $DATABASE.sql

rm $DATABASE.tar.gz
rm user.$DATABASE.sql
rm craft.$DATABASE.sql
rm $DATABASE.sql

