FROM ubuntu:16.04
LABEL maintainer="Tim Izzo (twitter.com/5ika_)"

ENV USER_PASSWORD chatbot

# Installation des paquets
RUN apt-get update && apt-get -y install wget git openssh-server \
	curl bzip2 apache2 php-cli libapache2-mod-php sqlite3 \
	php-mysqlnd php-tidy php-curl php-zip php-mbstring php-sqlite3 \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Importation de la configuration
COPY apache2.conf /etc/apache2/apache2.conf
COPY default-site.conf /etc/apache2/sites-enabled/000-default.conf
COPY default-php.ini /etc/php/7.0/apache2
COPY sshd_config /etc/ssh/sshd_config

# Configuration de Apache
RUN a2enmod rewrite
RUN a2enmod headers

# Installation de composer
COPY composer-installer.sh .
RUN ./composer-installer.sh && mv composer.phar /usr/bin/composer

# Création du dossier source
RUN rm -rf /var/www/html/*
WORKDIR /var/www/html
RUN git clone https://github.com/MessengersIO/messengersio-php.git . \
	&& chown -R www-data:www-data /var/www/html && chmod g+w -R /var/www/html \
	&& composer install
VOLUME /var/www/html

# Add user
RUN useradd -ms /bin/bash --home /var/www/html/samples/TheBigHack/ --groups www-data bighack

EXPOSE 80 22

CMD echo bighack:${USER_PASSWORD} | chpasswd && \
	/etc/init.d/ssh start && \
	/etc/init.d/apache2 start && \
	tail -f /var/log/apache2/*
