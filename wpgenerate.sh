#!/bin/bash

domain=$@;

setupdir="/root/script"
wwwdir="/var/www"
email="reklamdortuc@gmail.com"
apikey="a701411296f1cedbceaa370de424c51407cd1"
log="/var/log/nginx"


deger=$domain

echo "--------------------------------------"
echo "Wordpress  aciliyor."
echo "Domain        :$deger"


/bin/mkdir -p $wwwdir/$deger
/bin/chown www-data:www-data $wwwdir/$deger
sudo /bin/tar -zxvf /root/script/template.tar.gz -C $wwwdir/$deger > /dev/null
sudo /bin/cp /root/script/nginx_template /etc/nginx/sites-available/$deger
sudo /bin/ln -s /etc/nginx/sites-available/$deger /etc/nginx/sites-enabled/
sudo /bin/sed -i "s/domain/$deger/" /etc/nginx/sites-available/$deger

dbveri=`echo $domain|sudo sed 's/\./_/g'|cut -c1-14`

echo "$dbveri"

sudo /usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "create database $dbveri"
sudo /usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "CREATE USER $dbveri@localhost IDENTIFIED BY 'g.42!5gvpEk41Z34+';"
sudo /usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "GRANT ALL PRIVILEGES ON $dbveri.* TO $dbveri@localhost;"

sudo /bin/sed -i "s/xxxXxxx/$deger/g" $setupdir/template_db.sql
sudo /usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "use $dbveri"
sudo /usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "use $dbveri;\. /root/script/template_db.sql"

sudo /bin/sed -i "s/veritabaniismi/$dbveri/" $wwwdir/$deger/wp-config.php
sudo /bin/sed -i "s/kullaniciadi/$dbveri/" $wwwdir/$deger/wp-config.php
sudo /bin/sed -i 's/parola/g.42!5gvpEk41Z34+/g' $wwwdir/$deger/wp-config.php
sudo /bin/cp -a $setupdir/template_db.arsiv.sql  $setupdir/template_db.sql 

sudo /bin/touch $log/$deger.access.log

sudo /usr/sbin/nginx -s reload

#sudo /etc/init.d/nginx restart

