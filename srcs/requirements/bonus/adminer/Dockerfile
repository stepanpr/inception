
FROM		debian:buster

LABEL		maintainer="emabel"

RUN			apt-get update && apt-get upgrade && apt-get install \
			-y wget php libapache2-mod-php php-curl php-cli php-mysql php7.3 php7.3-fpm \
			php7.3-cli php7.3-pgsql php7.3-sqlite
RUN 		mkdir /var/www/wordpress/
RUN			mkdir -p /run/php/
COPY		adminer.php /
COPY		start.sh /
EXPOSE  	9000/tcp
ENTRYPOINT 	[ "sh", "start.sh" ]