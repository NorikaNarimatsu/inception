# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: nnarimatsu <nnarimatsu@student.codam.nl      +#+                      #
#                                                    +#+                       #
#    Created: 2025/07/22 10:43:14 by nnarimatsu    #+#    #+#                  #
#    Updated: 2025/07/22 19:23:42 by nnarimatsu    ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
# do not open interactive prompts, but just default option

RUN apt update && \
    apt install -y php php-fpm php-mysql curl tar && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

RUN	curl -O https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && \
	mkdir -p /var/www/html && \
	cp -r wordpress/* /var/www/html/ && \
	rm -rf wordpress latest.tar.gz
#download wordpress compressed file, unpack, make directry, move the content & delete original file

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf
# listen = 9000 tells php-fpm to accept requests on TCP port 9000.
# NGINX connects to WordPress at wordpress:9000

COPY tools/setup_wp.sh /setup_wp.sh

RUN chmod +x /setup_wp.sh

ENTRYPOINT ["/setup_wp.sh"]
