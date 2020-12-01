#update and install pakckage that need to
apt-get update
apt-get install -y
#wget is a computer program that retrieves content from web servers.
apt-get install -y wget
# nginx is a web server
apt-get install -y nginx
# php-fpm works better/faster with less resources || php-mysql is just one of the best en most used versions of php
apt-get install -y php-fpm php-mysql
# install data base asked by 19 (it is the same as MySQL)
apt-get install -y mariadb-server
# install module php for wordpress 
#cURL alow us to receive and send information via the URL syntax
#php-gd allows php to manipulate images like gif, pdf, jpeg, ...
#php-intl alow programers to Internationaliz some code for differente countries 
#php-mbstring allow use to manage non-ASCII strings and handle conversion between the possible encoding pairs
#php-soap (Simple Object Access Protocol) SOAP is a format for sending and receiving messages
#XML Extensible Markup Language XML is used to structure, store and transport data from one system to another. XML is similar to HTML.
#xmlrpc. php allows remote connection to WordPress
#ZIP is an archive file format that supports lossless data compression
apt-get install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
service nginx start 
mv nginx.conf /etc/nginx/sites-available/nginx.conf       # rendre disponible de fichier nginx cong
# symlink to enable our nginx.conf
ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/  #active la conf de ton site
unlink /etc/nginx/sites-enabled/default                                #desactiver le fichier default (au cas ou)
mkdir var/www/mysite
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/* var/www/mysite
mv wp-config.php var/www/mysite #(donne tout les acces a wordpress sur site/ ce connecter par ex. a une base de donner)
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz
tar xvf phpMyAdmin-4.9.0.1-english.tar.gz
mkdir /var/www/mysite/phpmyadmin
mv phpMyAdmin-4.9.0.1-english/* /var/www/mysite/phpmyadmin/
mv start.sql /var/www/
service mysql start
mysql < /var/www/start.sql
#create the self-signed certificate
openssl req -x509 -out localhost.crt -keyout localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
mv localhost.crt /etc/ssl/certs/
mv localhost.key /etc/ssl/certs/
service nginx restart
service php7.3-fpm start
service mysql restart