

FROM alpine:3.12
LABEL		maintainer="emabel"
RUN \
		apk add --no-cache nginx && \
		mkdir -p /run/nginx && \
		mkdir -p /var/www/portfolio
COPY 	 /site/ /site/
ADD	 	 start.sh ./
COPY	./nginx.conf /etc/nginx/http.d/default.conf
RUN		ln -fs /etc/nginx/http.d/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80/tcp
ENTRYPOINT [ "sh", "start.sh" ]

