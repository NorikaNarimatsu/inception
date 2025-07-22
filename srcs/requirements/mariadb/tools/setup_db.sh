#! /bin/bash 
# Use Bash to interpret this script”

# We can check the executions: docker logs mariadb
set -e # stop at error
set -x # print command

mysqld_safe --datadir=/var/lib/mysql &
# '&' is important: Runs it in the background, so the script can continue to the next steps

until mariadb -u root -e "SELECT 1;" &>/dev/null; do sleep 1
done
# Keeps trying every second until the query succeeds
# mariadb -u root -e "SELECT 1 -> Query Check
# &>/dev/null -> suppress stdout and stderr to avoid spam in console


DB_PASS=$(cat /run/secrets/db_password)
DB_ADMIN_PASS=$(cat /run/secrets/db_root_password)

# Below setting up heredoc with the closing keyword of EOF
mariadb -u root << EOF

CREATE DATABASE IF NOT EXISTS wordpress_db;

CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
CREATE USER IF NOT EXISTS '${DB_ADMIN}'@'%' IDENTIFIED BY '${DB_ADMIN_PASS}';

GRANT ALL PRIVILEGES ON wordpress_db.* TO '${DB_USER}'@'%';
GRANT ALL PRIVILEGES ON wordpress_db.* TO '${DB_ADMIN}'@'%';

FLUSH PRIVILEGES;
EOF

mysqladmin -u root shutdown
# shut down the background mysql 

exec mysqld_safe --datadir=/var/lib/mysql
# exec is important to start sql in foreground
# -> Replaces the current Bash process (PID 1) with the mysqld_safe process.