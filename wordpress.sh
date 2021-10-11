#!/bin/bash
yum update
yum install httpd -y
systemctl start httpd
systemctl enable httpd
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum install yum-utils -y
yum install php php-mcrypt php-mysql php-cli php-gd php-curl php-ldap php-zip php-fileinfo -y
yum -y install httpd wget rsync
yum -y install mariadb-server mariadb
yum install bash-completion -y
systemctl enable httpd.service
systemctl start httpd.service
systemctl enable mariadb
systemctl start mariadb.service
mysql -u root -e "create database wordpressdb";
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpressdb.* TO 'root'@'localhost' IDENTIFIED BY 'hybridskill@123'";
mysql -u root -phybridskill@123 -e "FLUSH PRIVILEGES;"
mysql -u root -phybridskill@123 -e "EXIT;"
wget -c https://wordpress.org/wordpress-5.0.4.tar.gz
wget https://hybridskill-training.s3.amazonaws.com/wp-config.php
tar -xzvf wordpress-5.0.4.tar.gz
rsync -av wordpress/* /var/www/html/
mv wp-config.php /var/www/html
sed -i 's/^\(SELINUX\s*=\s*\).*$/\1disabled/' /etc/selinux/config
rm -rf wordpress-5.0.4.tar.gz wordpress
find /var/www/html -type f -exec chmod 0664 {} \;
find /var/www/html -type d -exec chmod 2775 {} \;
chown -R apache:apache /var/www/html