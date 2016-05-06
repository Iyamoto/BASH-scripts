#!/usr/local/bin/bash

categ="brush"

names=`ls /usr/local/www/apache22/data/$categ/`

for name in $names
do
sed -i '' s/#RewriteCond/RewriteCond/ /usr/local/www/apache22/data/$categ/$name/.htaccess
sed -i '' s/#RewriteRule/RewriteRule/ /usr/local/www/apache22/data/$categ/$name/.htaccess

echo $name
done

