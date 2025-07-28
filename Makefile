# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnarimat <nnarimat@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/22 10:27:49 by nnarimatsu        #+#    #+#              #
#    Updated: 2025/07/28 11:19:35 by nnarimat         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception
DATA_DIR	:=	/home/nnarimat/data


all: up

up: pass-check
	@mkdir -p $(DATA_DIR)/mariadb_data
	@mkdir -p $(DATA_DIR)/wordpress_data
	docker-compose -f srcs/docker-compose.yml up -d --build
# -f: specifies the config path
# up: building up the containers
# -d: detached mode (run containers in background)
# --build: build images even its already exist

pass-check:
	@mkdir -p secrets
	@if [ ! -f secrets/db_password.txt ]; then \
		echo "[ERROR] Missing: secrets/db_password.txt"; \
		echo "→ Please create this file with your database user password."; \
		touch secrets/db_password.txt; \
	fi
	@if [ ! -f secrets/db_root_password.txt ]; then \
		echo "[ERROR] Missing: secrets/db_root_password.txt"; \
		echo "→ Please create this file with your database root password."; \
		touch secrets/db_root_password.txt; \
	fi
	@if [ ! -s secrets/db_password.txt ] || [ ! -s secrets/db_root_password.txt ]; then \
		echo "[INFO] Secrets exist, but at least one is empty. Edit the file(s) before continuing."; \
		exit 1; \
	fi

down:
	docker-compose -f srcs/docker-compose.yml down
# down: stops and removes containered created by up

clean: down
	@rm -rf $(DATA_DIR)/mariadb_data/*
	@rm -rf $(DATA_DIR)/wordpress_data/*
	
re: down up	

.PHONY: all up pass-check down clean re
# not actual file but command name