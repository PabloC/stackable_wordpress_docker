FROM tutum/nginx:latest
MAINTAINER Brian Christner <brian.christner@gmail.com>

# Make sure everything is updated
RUN apt-get update
RUN apt-get -y upgrade


# Install MySQL clinet Stuff
RUN apt-get -y install mysql-client

# Install Wordpress
RUN mkdir /usr/share/nginx/wordpress
RUN rm -fr /usr/share/nginx/www && git clone --depth=1 https://github.com/WordPress/WordPress.git  /usr/share/nginx/www/
RUN mv /usr/share/nginx/wordpress /usr/share/nginx/www
RUN rm -fr /usr/share/nginx/www/wordpress
RUN chown -R www-data:www-data /usr/share/nginx/www

# Add wp-config with info for Wordpress to connect to DB
ADD wp-config.php /usr/share/nginx/www/wp-config.php
RUN chmod 644 /usr/share/nginx/www/wp-config.php

# Add script to create 'wordpress' DB
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Modify permissions to allow plugin upload
RUN chmod -R 777 /usr/share/nginx/www/wp-content

# Expose environment variables
ENV DB_HOST **LinkMe**
ENV DB_PORT **LinkMe**
ENV DB_NAME wordpress
ENV DB_USER admin
ENV DB_PASS **ChangeMe**

EXPOSE 80
CMD ["/run.sh"]
