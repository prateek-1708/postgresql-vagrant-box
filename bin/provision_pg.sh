#!/bin/bash

PG_DIRECTORY_PATH="/var/lib/pgsql/9.5/data"
VAGRANT_DATA_DIRECTORY_PATH="/vagrant/bin/vagrant-data"

sudo yum update -y
sudo yum install -y epel-release

sudo yum install -y httpd php php-pgsql

sudo setsebool -P httpd_can_network_connect_db 1

sudo systemctl start httpd.service
sudo systemctl enable httpd.service


echo "Installing postgresql server and contrib"
rpm -Uvh http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
yum install -y postgresql95-server postgresql95

echo "Running initdb"
/usr/pgsql-9.5/bin/postgresql95-setup initdb

echo "Copying pg_hba.conf from ${VAGRANT_DATA_DIRECTORY_PATH} to ${PG_DIRECTORY_PATH}"
sudo cp ${VAGRANT_DATA_DIRECTORY_PATH}/pg_hba.conf ${PG_DIRECTORY_PATH}/pg_hba.conf

echo "Starting Postgresql"
systemctl start postgresql-9.5
systemctl enable postgresql-9.5


echo "Installing phpPgAdmin"
sudo yum -y install phpPgAdmin

sudo cp ${VAGRANT_DATA_DIRECTORY_PATH}/phpPgAdmin.inc.php /etc/phpPgAdmin/config.inc.php
sudo cp ${VAGRANT_DATA_DIRECTORY_PATH}/phpPgAdmin.conf /etc/httpd/conf.d/phpPgAdmin.conf

sudo cp ${PG_DIRECTORY_PATH}/postgresql.conf ${PG_DIRECTORY_PATH}/postgresql.conf.bak
sudo cp ${VAGRANT_DATA_DIRECTORY_PATH}/postgresql.conf ${PG_DIRECTORY_PATH}/postgresql.conf

echo "Restart Postgres and Httpd"
sudo service postgresql-9.5 restart
sudo service httpd restart

if psql -U postgres -lqt | cut -d \| -f 1 | grep -w test_db;
then
	echo "A database called 'test_db' already exists, skipping DB import"
else
    sudo -i -u postgres createdb test_db
    psql -U postgres test_db < ${VAGRANT_DATA_DIRECTORY_PATH}/sql/test_schema.sql
fi
