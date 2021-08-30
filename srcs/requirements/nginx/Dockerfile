FROM		alpine:3.12
LABEL		maintainer="emabel"

RUN		apk update && apk add --no-cache openssl && apk add --no-cache nginx
COPY		./srcs/nginx.conf /etc/nginx/http.d/default.conf
RUN		ln -fs /etc/nginx/http.d/default.conf /etc/nginx/conf.d/default.conf
RUN		openssl req -x509 -nodes						\
		-subj '/C=RU/ST=MOSCOW/L=MOSCOW/O=emabel/CN=localhost'			\
		-days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl.key		\
		-out /etc/ssl/certs/ssl.crt
RUN		mkdir -p /run/nginx 

WORKDIR		/app
EXPOSE		443
ENTRYPOINT	["nginx", "-g", "daemon off;"]
