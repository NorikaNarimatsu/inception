# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnarimat <nnarimat@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/22 10:43:14 by nnarimatsu        #+#    #+#              #
#    Updated: 2025/07/28 10:22:07 by nnarimat         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
# do not open interactive prompts, but just default option

RUN apt update && \
	apt install -y php7.4 php7.4-fpm php7.4-mysql mariadb-client curl tar && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

RUN	curl -O https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && \
	mkdir -p /var/www/html && \
	mv wordpress /wordpress-src  && \
	rm -rf wordpress latest.tar.gz
#download wordpress compressed file, unpack, make directry, move the content & delete original file

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf
# listen = 9000 tells php-fpm to accept requests on TCP port 9000.
# NGINX connects to WordPress at wordpress:9000


RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp

COPY tools/setup_wp.sh /setup_wp.sh

EXPOSE 9000

RUN chmod +x /setup_wp.sh

ENTRYPOINT ["/setup_wp.sh"]

CMD ["php-fpm7.4", "-F"]