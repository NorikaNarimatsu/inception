# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: nnarimatsu <nnarimatsu@student.codam.nl      +#+                      #
#                                                    +#+                       #
#    Created: 2025/07/22 10:27:49 by nnarimatsu    #+#    #+#                  #
#    Updated: 2025/07/22 10:33:38 by nnarimatsu    ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

NAME = inception

all: up

up: 
	docker-compose -f srcs/docker-compose.yml up -d --build
	# -f: specifies the config path
	# up: building up the containers
	# -d: detached mode (run containers in background)
	# --build: 
down:
	docker-compose -f srcs/docker-compose.yml down
	# down: stops and removes containered created by up

re:
	down up	

.PHONY: all up down re # not actual file but command name