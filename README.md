docker-apache-phpmyadmin
=================

Base docker image to run PhpMyAdmin on Apache 2.

* Ubuntu 14.04
* PHP 5
* Apache 2
* MySQL 5.5
* PHPMyAdmin 4.5.3.1 (configurable with Environment Variable)

Building the base image
-----------------------

To create the base image `mmorejon/apache-phpmyadmin`, execute the following command on the docker-apache-phpmyadmin folder:

    docker build -t mmorejon/apache-phpmyadmin .


Running your Apache+PhpMyadmin docker image
------------------------------------

First start `tutum/mysql` image. To run the image:

`docker run -d --name phpmyadmin-mysql -e MYSQL_PASS="mypass" tutum/mysql`

Start your `mmorejon/apache-phpmyadmin` image binding the external ports 80 in all interfaces to your container and linking it with `phpmyadmin-mysql`:

`docker run -d --link phpmyadmin-mysql:mysql -e MYSQL_PASSWORD="mypass" --name phpmyadmin -p 80:80 mmorejon/apache-phpmyadmin`

Test your deployment:

    curl http://localhost/

You can use the file `docker-compose.yml` in order to do it easerly.


Loading your custom PhpMyAdmin
-----------------------------------

`PHPMYADMIN_DIR`: use this value to set the specific web path.

`docker run -d -e PHPMYADMIN_DIR="/app/phpmyadmin" --link phpmyadmin-mysql:mysql -e MYSQL_PASSWORD="mypass" --name phpmyadmin -p 80:80 mmorejon/apache-phpmyadmin`

Test your deployment:

    curl http://localhost/phpmyadmin


`PHPMYADMIN_VERSION`: change this value before build the image to download an specific version of PhpMyAdmin.
