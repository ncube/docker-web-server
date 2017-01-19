FROM debian:latest
MAINTAINER Nutan Nara <nutan@ncubeschool.org>

# Install apache & PHP
RUN apt-get update && apt-get -y install \
    apache2 php5 php5-mysql php5-gd

# Enable apache mods.
RUN a2enmod rewrite

# Expose apache.
EXPOSE 80

# Tidy up
RUN apt-get -y autoremove && apt-get clean && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Init edu directory
ADD ./src /var/www/edu

# Add config files
ADD ./config/apache-config.conf /etc/apache2/sites-enabled/000-default.conf
ADD ./config/php.ini /etc/php5/apache2/php.ini
RUN echo 'Servername localhost' >> /etc/apache2/apache2.conf

# Add startup script
ADD ./init.sh /usr/bin/init.sh
RUN chmod +x /usr/bin/init.sh

CMD /usr/bin/init.sh
