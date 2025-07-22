# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: nnarimatsu <nnarimatsu@student.codam.nl      +#+                      #
#                                                    +#+                       #
#    Created: 2025/07/22 10:27:49 by nnarimatsu    #+#    #+#                  #
#    Updated: 2025/07/22 19:05:34 by nnarimatsu    ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

NAME = inception

all: up

up: pass-check
	docker-compose -f srcs/docker-compose.yml up -d --build
# -f: specifies the config path
# up: building up the containers
# -d: detached mode (run containers in background)
# --build: build images even its already exist

pass-check:
	@if [ ! -f secrets/db_password.txt ] || [ ! -f secrets/db_root_password.txt ]; then \
		echo "Missing secret files: secrets/db_password.txt and secrets/db_root_password.txt are needed."; \
		exit 1; \
	fi

# check validation for input
# @if [ $$(wc -l < secrets/db_password.txt) -ne 1 ]; then \
# 	echo "db_password.txt must be exactly one line (no newlines)."; \
# 	exit 1; \
# fi
# @if [ $$(wc -l < secrets/db_root_password.txt) -ne 1 ]; then \
# 	echo "db_root_password.txt must be exactly one line (no newlines)."; \
# 	exit 1; \
# fi

down:
	docker-compose -f srcs/docker-compose.yml down
# down: stops and removes containered created by up

re: down up	

.PHONY: all up pass-check down re
# not actual file but command name