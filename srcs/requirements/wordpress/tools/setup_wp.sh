#!/bin/bash

set -e # stop at error
set -x # print command

# Create wp-config.php from sample
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

DB_PASS=$(cat /run/secrets/db_password)

sed -i "s/database_name_here/${DB_NAME}/" /var/www/html/wp-config.php
sed -i "s/username_here/${DB_USER}/" /var/www/html/wp-config.php
sed -i "s/password_here/${DB_PASS}/" /var/www/html/wp-config.php
sed -i "s/localhost/${DB_HOST}/" /var/www/html/wp-config.php
#Update the parameters in  /var/www/html/wp-config.php

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
# chown- Changes owner of all files to www-data
# ‘-R’ = recursive (apply to all subfolders/files)
# 755  Owner: read/write/execute & Group & Other: read/write
# to check: # ls -l /var/www/html
exec php-fpm7.4 -F