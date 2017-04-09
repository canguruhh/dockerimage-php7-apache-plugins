# Dockerfile
FROM php:7.0-apache

MAINTAINER Sven <canguruhh@mutzl.org>

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install mcrypt
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install -j$(nproc) mcrypt

# Install zip
RUN apt-get install -y zlib1g-dev
RUN docker-php-ext-install -j$(nproc) zip

# Install xsl
RUN apt-get install -y libxslt1-dev libxml2-dev
RUN docker-php-ext-install -j$(nproc) xsl

# Install intl
RUN apt-get install -y libicu-dev
RUN pecl install intl
RUN docker-php-ext-install -j$(nproc) intl

# Install PDO 
# RUN apt-get install -y freetds-dev php5-sybase 
# RUN docker-php-ext-install pdo 
RUN docker-php-ext-install pdo_mysql mysqli && apt-get install -y libpq-dev
RUN docker-php-ext-install pdo_pgsql
# RUN apt-get install -y libsqlite3-dev 
# RUN docker-php-ext-install pdo_sqlite
