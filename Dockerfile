FROM php:7.3-fpm
RUN apt-get clean && apt-get update && apt-get install -y locales && apt-get install -y bash
RUN apt-get install -y git
RUN locale-gen nl_NL.UTF-8 && dpkg-reconfigure locales

WORKDIR /var/www/localhost/htdocs

RUN apt-get install -y nginx

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
