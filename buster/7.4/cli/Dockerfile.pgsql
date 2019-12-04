
ARG distribution=""
ARG release=""
ARG codename=""
ARG variant=""
ARG php_version=""

FROM php:${php_version:+${php_version}-}${variant:+${variant}-}${codename:+${codename}}

MAINTAINER Rodrigo Cabral <rodrixcornell@gmail.com.br>

ENV TIMEZONE="America/Manaus" \
	LC_ALL="C.UTF-8" \
	LANG="pt_BR.utf8" \
	LANGUAGE="pt_BR:pt"

RUN set -xe \
	&& echo $TIMEZONE | tee /etc/timezone \
	&& curl -#L https://getcomposer.org/composer.phar -o '/usr/local/bin/composer' && chmod +x /usr/local/bin/composer \
	&& apt-get update -y && apt-get upgrade -yq --no-install-recommends \
	&& apt-get install -y --no-install-recommends git locales software-properties-common \
	&& localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8 \
	&& locale-gen pt_BR.UTF-8 \
	&& apt-get install -y --no-install-recommends \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
		libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	\
	&& docker-php-source extract \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-configure pgsql --with-pgsql=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd bcmath exif pgsql pdo_pgsql \
	&& docker-php-ext-enable gd bcmath exif pgsql pdo_pgsql \
	&& docker-php-source delete \
	&& apt-get purge -y locales software-properties-common && apt-get autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* && rm -rf /usr/lib/python3 \
	&& apt-get update -y && apt-get upgrade -yq --no-install-recommends && apt-get autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Use the default production configuration
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
# Override with custom pgsql settings
# COPY config/pgsql.ini $PHP_INI_DIR/conf.d/
# COPY config/pdo_pgsql.ini $PHP_INI_DIR/conf.d/
