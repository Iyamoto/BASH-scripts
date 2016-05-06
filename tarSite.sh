#!/bin/bash

DA=`/bin/date +%F`

bases="domains"

for base in $bases
do
cd /var/www/$base
sites=`ls -l | awk -F " " '{print $8}'`
for site in $sites
do
if [ "$site" = "." ]
then
continue
fi

tar -czf /usr/bu/move/$site.tar.gz $site

ftp -n <<**
open IP
user login pass
bin
put /usr/bu/move/$site.tar.gz $site.tar.gz
bye
**
#rm /usr/bu/$site.tar
echo "Site $site done"
done
done

