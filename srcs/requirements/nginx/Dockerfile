# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: nnarimatsu <nnarimatsu@student.codam.nl      +#+                      #
#                                                    +#+                       #
#    Created: 2025/07/22 10:42:45 by nnarimatsu    #+#    #+#                  #
#    Updated: 2025/07/22 22:19:07 by nnarimatsu    ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN	apt update && \
	apt install -y nginx openssl curl procps && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*

RUN	rm -rf /etc/nginx/sites-enabled/default

RUN	mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=NL/ST=Test/L=Amsterdam/O=Inception/OU=Student/CN=nnarimat.42.fr"

COPY conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
# nginx is running in the foreground