#
# PhpMyAdmin Dockerfile
#

FROM apache2-php5

MAINTAINER Manuel Morejón <manuel.morejon.85@gmail.com>

ENV PMA_SECRET          blowfish_secret
ENV PMA_USERNAME        pma
ENV PMA_PASSWORD        password
ENV MYSQL_USERNAME      admin
ENV MYSQL_PASSWORD      password

ENV PHPMYADMIN_VERSION  4.5.3.1
ENV PHPMYADMIN_DIR      /app

# Download phpMyAdmin package
RUN \
# Update index
  apt-get update && \

# Install components
  apt-get install -y \
  mysql-client \
  libapache2-mod-auth-mysql \
  php5-mysql \
  wget \
  zip \
  unzip \
  tar && \

# Clean instalation files.
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

  wget https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.bz2 && \
  tar -xvjf phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.bz2 && \
  rm phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.bz2 && \
  mv phpMyAdmin-${PHPMYADMIN_VERSION}-english /phpmyadmin

# Include external sources
ADD sources/config.inc.php /phpmyadmin/
ADD sources/create_user.sql /
ADD sources/phpmyadmin-start /usr/local/bin/
ADD sources/phpmyadmin-firstrun /usr/local/bin/

# Add execute permissions
RUN \
  chmod +x /usr/local/bin/phpmyadmin-start && \
  chmod +x /usr/local/bin/phpmyadmin-firstrun

EXPOSE 80

CMD phpmyadmin-start
