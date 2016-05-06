
base="base"
sites=`cat ./list.txt`

for site in $sites
do
if [ "$site" = "." ]
then
continue
fi
ftp -n <<**
open ip
user login pass
bin
get $site.tar
bye
**
tar xvf $site.tar -C /var/www/$base/
rm $site.tar
echo $site done
done

