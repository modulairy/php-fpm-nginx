FROM php:7.3-fpm-alpine3.14

RUN apk update && apk upgrade && apk add bash
RUN apk add git
RUN locale-gen nl_NL.UTF-8

WORKDIR /var/www/localhost/htdocs

RUN apk add nginx

COPY nginx /etc/nginx
COPY index.php /var/www/localhost/htdocs

COPY start-container /usr/local/bin/
RUN chmod +x /usr/local/bin/start-container

COPY php.ini /usr/local/etc/php/php.ini
RUN chmod 644 /usr/local/etc/php/php.ini

RUN chmod 775 /var/www/localhost/htdocs

RUN export PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin

EXPOSE 80
EXPOSE 9000
STOPSIGNAL SIGTERM

CMD ["start-container"]
