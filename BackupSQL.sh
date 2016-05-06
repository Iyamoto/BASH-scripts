#!/usr/local/bin/bash

# Change to MySQL data directory
cd /var/db/mysql
DAY=`/bin/date +%A`
ARRAY=`find * -type d -prune`
#DATABASE=$1

mkdir -p /usr/bu/$DAY
cd /usr/bu/$DAY

for DBASE in `echo $ARRAY`
do
DATABASE=`echo $DBASE | sed s/@002d/-/g`
echo $DATABASE
echo "CREATE DATABASE /*!32312 IF NOT EXISTS*/ \`$DATABASE\` /*!40100 DEFAULT CHARACTER SET latin1 */;" > craft.$DATABASE.sql
/usr/bu/sqluser.sh | grep $DATABASE > user.$DATABASE.sql
mysqldump -u root -pPASS -B $DATABASE > $DATABASE.sql
tar -czf /usr/bu/$DAY/$DATABASE.tar.gz $DATABASE.sql user.$DATABASE.sql craft.$DATABASE.sql

ftp -n <<**
open IP
user login pass
bin
put /usr/bu/$DAY/$DATABASE.tar.gz $DATABASE.tar.gz
bye
**

rm $DATABASE.sql
rm user.$DATABASE.sql
rm craft.$DATABASE.sql
rm $DATABASE.tar.gz

echo done
done

