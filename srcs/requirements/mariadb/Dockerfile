# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnarimat <nnarimat@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/22 10:42:09 by nnarimatsu        #+#    #+#              #
#    Updated: 2025/07/28 10:23:37 by nnarimat         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt install -y mariadb-server && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
    # delete metadata from apt update

COPY tools/setup_db.sh /setup_db.sh

RUN chmod +x /setup_db.sh

EXPOSE 3306
# mariadb's default port

ENTRYPOINT ["/setup_db.sh"]
# "mysqld_safe" -> script that starts the real MariaDB server 
# "--datadir=/var/lib/mysql" -> path to db, volumues