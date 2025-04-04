# Utiliser une image de base officielle PHP avec Apache
FROM php:8.3-fpm

# Installer les dépendances
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libpq-dev \
    libzip-dev \
    zip \
    curl \
    && docker-php-ext-install intl pdo pdo_mysql zip opcache

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copier les fichiers de l'application
WORKDIR /var/www/symfony
COPY symfony /var/www/symfony

# Installer les dépendances Symfony
RUN composer install --prefer-dist --no-scripts --no-dev --no-progress --no-interaction

# Changer les permissions pour l'utilisateur web
RUN chown -R www-data:www-data /var/www/symfony

# Exposer le port 9000 pour PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM
CMD ["php-fpm"]



