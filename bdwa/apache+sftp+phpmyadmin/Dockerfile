FROM 5ika/bdwa-apache:latest
LABEL maintainer="Tim Izzo (twitter.com/5ika_)"

ENV RANDOM_SECRET jAFYZvzpJKzGR9AsG2AWhUYTEZBSw5EP
ENV PHPMYADMIN_VERSION 4.7.4

WORKDIR /var/www
RUN wget https://files.phpmyadmin.net/phpMyAdmin/$PHPMYADMIN_VERSION/phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz \
  && tar xvfz phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz \
  && mv phpMyAdmin-$PHPMYADMIN_VERSION-all-languages phpmyadmin \
  && rm phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz \
  && chown www-data:www-data -R phpmyadmin \
  && cd phpmyadmin \
  && cp config.sample.inc.php config.inc.php \
  && sed -i "s/localhost/db/g" config.inc.php \
  && sed -i "s/\$cfg\['blowfish_secret'\] = ''/\$cfg\['blowfish_secret'\] = '$RANDOM_SECRET'/g" config.inc.php
WORKDIR /var/www/html

COPY add-apache.conf /tmp
RUN cat /tmp/add-apache.conf >> /etc/apache2/apache2.conf && rm /tmp/add-apache.conf
