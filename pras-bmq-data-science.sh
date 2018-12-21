#!/bin/bash

# Cloudbreak-2.7.2 / Ambari-2.7.0 - something is install pgsq95
yum remove -y postgresql95*
# Install pgsql96
yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm
yum install -y postgresql96-server
yum install -y postgresql96-contrib
/usr/pgsql-9.6/bin/postgresql96-setup initdb
sed -i 's,#port = 5432,port = 5433,g' /var/lib/pgsql/9.6/data/postgresql.conf

systemctl enable postgresql-9.6.service
systemctl start postgresql-9.6.service

yum remove -y mysql57-community*
yum remove -y mysql56-server*
yum remove -y mysql-community*
rm -Rvf /var/lib/mysql

yum install -y epel-release
yum install -y libffi-devel.x86_64
ln -s /usr/lib64/libffi.so.6 /usr/lib64/libffi.so.5

yum install -y mysql-connector-java*
ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql-connector-java.jar

if [ $(cat /etc/system-release|grep -Po Amazon) == Amazon ]; then       	
	yum install -y mysql56-server
	service mysqld start
else
	yum localinstall -y https://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
	yum install -y mysql-community-server
	systemctl start mysqld.service
fi
chkconfig --add mysqld
chkconfig mysqld on

ln -s /usr/share/java/mysql-connector-java.jar /usr/hdp/current/hive-client/lib/mysql-connector-java.jar	
ln -s /usr/share/java/mysql-connector-java.jar /usr/hdp/current/hive-server2-hive2/lib/mysql-connector-java.jar

mysql --execute="CREATE DATABASE beast_mode_db DEFAULT CHARACTER SET utf8"
mysql --execute="CREATE USER 'bmq_user'@'localhost' IDENTIFIED BY 'Be@stM0de'"
mysql --execute="CREATE USER 'bmq_user'@'%' IDENTIFIED BY 'Be@stM0de'"
mysql --execute="GRANT ALL PRIVILEGES ON beast_mode_db.* TO 'bmq_user'@'localhost'"
mysql --execute="GRANT ALL PRIVILEGES ON beast_mode_db.* TO 'bmq_user'@'%'"
mysql --execute="GRANT ALL PRIVILEGES ON beast_mode_db.* TO 'bmq_user'@'localhost' WITH GRANT OPTION"
mysql --execute="GRANT ALL PRIVILEGES ON beast_mode_db.* TO 'bmq_user'@'%' WITH GRANT OPTION"
mysql --execute="FLUSH PRIVILEGES"
mysql --execute="COMMIT"