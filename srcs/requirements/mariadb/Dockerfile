FROM		debian:buster
LABEL		maintainer="emabel"

RUN		apt-get update -y && apt-get upgrade -y && apt-get -y install mariadb-server
COPY		/srcs/entrypoint.sh ./entrypoint.sh
RUN		mkdir -p /var/run/mysqld &&	\
		chown -R mysql:mysql /var/run/mysqld &&	\
		rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY		./srcs/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE		3306
ENTRYPOINT	["/bin/sh", "entrypoint.sh"]
