#!/bin/bash

# Degiskenler
setupdir="/root/scripts"

echo -en "Domain adını giriniz ve [ENTER] basın\n"
echo -en "Ornek :  google.com\n"
read domain

if [ -z $domain ] ;then
echo -e "Eksik Bilgi Girdiniz\n"
exit 0;
else

/usr/bin/clear
fi

setupdir="/root/script"
wwwdir="/var/www"
email="reklamdortuc@gmail.com"
apikey="a701411296f1cedbceaa370de424c51407cd1"
log="/var/log/nginx"

for deger in $domain 
do

echo "--------------------------------------"
echo "Wordpress  aciliyor."
echo "Domain        :$deger"

/bin/mkdir -p $wwwdir/$deger
/bin/chown www-data:www-data $wwwdir/$deger
/bin/tar -zxvf /root/script/template.tar.gz -C $wwwdir/$deger > /dev/null
/bin/cp -a /root/script/nginx_template /etc/nginx/sites-available/$deger
/bin/ln -s /etc/nginx/sites-available/$deger /etc/nginx/sites-enabled/
/bin/sed -i "s/domain/$deger/" /etc/nginx/sites-available/$deger

#dbveri=`echo $deger|cut -d"." -f1`
#$dbveri=`sed 's/./_/' $deger`
dbveri=`echo $deger|sed 's/\./_/g'|cut -c1-14`
echo $dbveri

# mysql islemleri
/usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "create database $dbveri"
/usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "CREATE USER $dbveri@localhost IDENTIFIED BY 'g.42!5gvpEk41Z34+';"
/usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "GRANT ALL PRIVILEGES ON $dbveri.* TO $dbveri@localhost;"


/bin/sed -i "s/xxxXxxx/$deger/g" $setupdir/template_db.sql
#/bin/sed -i "s/dizin/$deger/g" $setupdir/template_db.sql
/usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "use $dbveri"
/usr/bin/mysql -u root -pg.42!5gvpEk41Z34+ -e "use $dbveri;\. /root/script/template_db.sql"

/bin/sed -i "s/veritabaniismi/$dbveri/" $wwwdir/$deger/wp-config.php
/bin/sed -i "s/kullaniciadi/$dbveri/" $wwwdir/$deger/wp-config.php
/bin/sed -i "s/parola/g.42!5gvpEk41Z34+/" $wwwdir/$deger/wp-config.php
/bin/cp -a $setupdir/template_db.arsiv.sql  $setupdir/template_db.sql 

#$setupdir/cloudflare.sh $email $apikey CREATE $deger A 146.185.136.218  0
/bin/touch $log/$deger.access.log
#/usr/sbin/useradd -m $deger -s /bin/false
#/bin/ln -s /var/www/$deger.$domain /home/$deger
#chown $deger:$deger /home/$deger
done

/etc/init.d/nginx restart
