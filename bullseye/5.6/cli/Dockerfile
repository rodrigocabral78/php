
ARG distribution=""
ARG release=""
ARG codename=""
ARG variant=""
ARG php_version=""

# FROM php:${php_version:+${php_version}-}${variant:+${variant}-}${codename:+${codename}}
FROM ${distribution}:${codename}

MAINTAINER Rodrigo Cabral <rodrigo.cabral_ti@live.com>

# ARG ORACLE_LATEST=${oracle_latest}

ENV TZ="America/Manaus" \
	LC_ALL="C.UTF-8" \
	LANG="pt_BR.utf8" \
	LANGUAGE="pt_BR:pt" \
	PHP_VERSION="5.6.40" \
	PHP_VERSION_MIN="5.6" \
	PHP_LIBS="bcmath cli curl gd imagick intl mbstring redis sqlite* xml zip"

RUN set +xe \
	&& echo $TZ | tee /etc/timezone \
	&& apt-get update -y && apt-get upgrade -yq --no-install-recommends \
	&& apt-get install -y --no-install-recommends \
	locales \
	software-properties-common \
	apt-transport-https \
	lsb-release \
	ca-certificates \
	curl \
	&& localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8 \
	&& locale-gen pt_BR.UTF-8 \
	\
	&& curl -fsSL https://packages.sury.org/php/apt.gpg -o /etc/apt/trusted.gpg.d/php.gpg \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/ondrej-php.list \
	&& apt-get update -y && apt-get upgrade -yq --no-install-recommends \
	for LIB in ${PHP_LIBS}; do echo php${PHP_VERSION_MIN}-${LIB}; LIBS+="php${PHP_VERSION_MIN}-${LIB} "; done \
	&& apt-get install -y --no-install-recommends \
		${LIBS} \
	&& curl -sSi https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& php -v \
	\
	&& apt-get purge -y locales software-properties-common \
	&& apt-get autoclean && apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/oracle* /usr/lib/python3 \
	&& apt-get update -y && apt-get upgrade -yq --no-install-recommends \
	&& apt-get autoclean && apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

# Use the default production configuration
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
# Override with custom mysql settings
# COPY config/mysql.ini $PHP_INI_DIR/conf.d/
# COPY config/pdo_mysql.ini $PHP_INI_DIR/conf.d/

CMD ["php", "-a"]