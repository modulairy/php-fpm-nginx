FROM php:8.2-fpm-alpine3.17

RUN apk update && apk upgrade && apk add bash
RUN apk add git

WORKDIR /var/www/localhost/htdocs

RUN apk add nginx

COPY nginx /etc/nginx
COPY index.php /var/www/localhost/htdocs

COPY start-container /usr/local/bin/

RUN chmod +x /usr/local/bin/start-container

RUN chmod 775 /var/www/localhost/htdocs

RUN export PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin

EXPOSE 80
EXPOSE 9000
STOPSIGNAL SIGTERM

CMD ["start-container"]
