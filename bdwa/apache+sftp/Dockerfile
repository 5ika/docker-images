FROM ubuntu:16.04
LABEL maintainer="Tim Izzo (twitter.com/5ika_)"

ENV USER_PASSWORD change_me
ENV USER_NAME deer

# Installation des paquets
RUN apt-get update && apt-get -y install wget git nano openssh-server \
	curl bzip2 apache2 php-cli libapache2-mod-php sqlite3 \
	php-mysqlnd php-tidy php-curl php-zip php-mbstring php-sqlite3 \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Installation de composer
COPY composer-installer.sh .
RUN ./composer-installer.sh && mv composer.phar /usr/bin/composer

# Importation de la configuration
COPY apache2.conf /etc/apache2/apache2.conf
COPY default-site.conf /etc/apache2/sites-enabled/000-default.conf
COPY default-php.ini /etc/php/7.0/apache2
COPY sshd_config /etc/ssh/sshd_config
COPY banner.txt /etc/issue.net

# Configuration de Apache
RUN a2enmod rewrite
RUN a2enmod headers

# Add user
RUN useradd -ms /bin/bash --groups www-data ${USER_NAME}

# Initialisation du dossier des sources
RUN chown -R ${USER_NAME}:www-data /var/www/html
RUN ln -s /var/www/html /home/${USER_NAME}/web
WORKDIR /var/www/html
VOLUME /var/www/html

EXPOSE 22 80

CMD echo ${USER_NAME}:${USER_PASSWORD} | chpasswd && \
	/etc/init.d/ssh start && \
	/etc/init.d/apache2 start && \
	tail -f /var/log/apache2/*
