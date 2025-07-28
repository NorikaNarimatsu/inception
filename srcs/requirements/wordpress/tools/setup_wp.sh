#!/bin/bash

set -e # stop at error
set -x # print command

# if [ ! -f /var/www/html/index.php ]; then
#     cp -a /wordpress-src/. /var/www/html/
# fi

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

echo "[INFO] Waiting for MariaDB at $DB_HOST..."
until mysqladmin ping -h "$DB_HOST" -P 3306 -u "$DB_ADMIN" -p"$(cat /run/secrets/db_root_password)" --silent; do
	sleep 1
done
echo "[INFO] MariaDB is ready."

echo "[INFO] Checking if WordPress is already installed..."
if ! wp core is-installed --path=/var/www/html --allow-root; then
	echo "[INFO] Installing WordPress with a master user..."
	wp core install --path=/var/www/html \
		--url="https://${DOMAIN_NAME}" \
		--title="mdraper - Inception project" \
		--admin_user="${DB_ADMIN}" \
		--admin_password="$(cat /run/secrets/db_root_password)" \
		--admin_email="${DB_ADMIN_EMAIL}" \
		--skip-email \
		--allow-root
else
	echo "[INFO] WordPress already installed."
fi

echo "[INFO] Creating Wordpress user..."
if ! wp user get "${DB_USER}" --path=/var/www/html --allow-root &> /dev/null; then
	wp user create "${DB_USER}" "${DB_USER_EMAIL}" --role=editor \
	--user_pass="$(cat /run/secrets/db_password)" \
	--path=/var/www/html --allow-root
fi

echo "[INFO] Installing a theme to website..."
wp theme install inspiro --activate --path="/var/www/html/" --allow-root

echo "[INFO] Starting php-fpm..."
php-fpm7.4 -F