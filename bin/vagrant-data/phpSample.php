<?php

error_reporting( E_ALL );
ini_set('display_errors', '1');

// create connection to pg
$postgresConnection = pg_connect("host='localhost' port='5432' user='test_user' password='password' dbname='test_db'");

// check if connection is working or not
if (pg_connection_status($postgresConnection)) {
	echo "Connection successfull";
	echo pg_fetch_row(pg_query($postgresConnection, "SELECT * FROM pg_type LIMIT 1" ))[0];
} else {
	echo "Cannot connect to PG check it sebool for httpd flags. Thanks !!w"
}


