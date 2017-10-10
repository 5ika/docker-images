FROM php:7-apache
LABEL maintainer="Tim Izzo (twitter.com/5ika_)"

# Install Dependencies
RUN apt-get update && apt-get install -y libpng12-0 libpng12-0-dev zlib1g-dev git \
  && docker-php-ext-install gd \
  && docker-php-ext-install zip \
  && apt-get remove -y libpng12-0-dev zlib1g-dev && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY composer-installer.sh .
RUN ./composer-installer.sh && mv composer.phar /usr/bin/composer

# Configure Apache
RUN a2enmod rewrite

# Install Grav
WORKDIR /var/www
RUN rm -rf /var/www/html \
  && git clone -b master https://github.com/getgrav/grav.git html \
  && cd html \
  && composer install --no-dev -o \
  && bin/grav install
WORKDIR /var/www/html

# Install plugins
RUN bin/gpm install -y admin
COPY add-plugins /bin/

RUN chown -R www-data:www-data .
