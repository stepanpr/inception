# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: emabel <emabel@student.21-school.ru>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/16 02:51:35 by emabel            #+#    #+#              #
#    Updated: 2021/08/27 03:03:45 by emabel           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update

# установка пакетов
RUN apk add --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ vsftpd openssl

# создание ssl сертификата
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -subj \
    "/C=RU/ST=Moscow/L=Moscow/O=21school/OU=emabel/CN=emabel.42.fr" -keyout \
	/etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

# копирование конфигурации vsftpd и скрипта
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
ADD start.sh ./
# установка пароля пользователя
RUN adduser -D emabel && echo "emabel:qwerty" | chpasswd

# set listening port
EXPOSE 20 21 21100

# start
ENTRYPOINT ["sh", "start.sh"]