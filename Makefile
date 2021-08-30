

VOLUMES = /home/emabel/data
PATH_TO_YAML = ./srcs/docker-compose.yaml

all: setup

#подготовка к установке
setup: 								
	echo "frontweb" | sudo -S service nginx stop 
	echo "frontweb" | sudo -S service mysql stop
	mkdir -p ${VOLUMES}/db/ && mkdir -p ${VOLUMES}/wp/ && mkdir -p ${VOLUMES}/portfolio/
	docker-compose -f $(PATH_TO_YAML) --env-file ./srcs/.env up --build
# режим демона docker-compose docker-compose -f $(PATH_TO_YAML) --env-file ./srcs/.env up --build -d

#запуск контейнеров
up:
	docker-compose -f $(PATH_TO_YAML) --env-file ./srcs/.env up


#остановка контейнеров
down: 
	docker-compose -f $(PATH_TO_YAML) down

#остановка, очистка и удаление volumes в контейнерах
clean: down  
	docker system prune -a --volumes
	
#остановка, очистка и удаление volumes в контейнерах и в ~/data
fclean: down clean
	echo "frontweb" | sudo -S rm -Rf ${VOLUMES}

#полное удаление + повторная установка
re: fclean setup

#комманды из чек-листа
subj:
	bash reload.sh
# docker stop $(docker ps -qa) && \
# docker rm $(docker ps -qa) && \
# docker rmi -f $(docker images -qa) && \
# docker volume rm $(docker volume ls -q) && \
# docker network rm $(docker network ls -q) 2>/dev/null



ps:
	docker-compose -f $(PATH_TO_YAML) ps

.PHONY:	all up down re ps rm
