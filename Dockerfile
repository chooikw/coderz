FROM php:7.4-cli

RUN apt-get update \
    && apt-get install -y git mariadb-client zlib1g-dev libpng-dev libzip-dev libmagickwand-dev libjpeg-dev libmcrypt-dev sudo iproute2
    

RUN printf "\n" | pecl install imagick mcrypt

# Install php-mysql driver
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install mysqli pdo pdo_mysql gd exif zip bcmath
RUN docker-php-ext-enable imagick mcrypt
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt install nodejs
RUN curl -fsSL https://code-server.dev/install.sh | sh


RUN apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN npm i -g cross-env

ARG USER=coderz
ARG UID=1000
ARG GID=1000

RUN useradd -m ${USER} --uid=${UID}
RUN groupmod -g ${GID} coderz

USER ${UID}:${GID}
WORKDIR /home/coderz

EXPOSE 8080 8000 8001

CMD ["code-server"]




