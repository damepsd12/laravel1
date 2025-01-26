# Utiliser une image PHP officielle avec Composer
FROM php:8.1-fpm

# Installer les extensions PHP nécessaires
RUN apt-get update && apt-get install -y \
    libzip-dev unzip \
    && docker-php-ext-install zip pdo pdo_mysql

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copier les fichiers de l'application dans le conteneur
COPY . /var/www

# Définir le répertoire de travail
WORKDIR /var/www

# Installer les dépendances avec Composer
RUN composer install --no-dev --optimize-autoloader

# Donner les permissions nécessaires
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage /var/www/bootstrap/cache

# Exposer le port
EXPOSE 9000

# Commande de démarrage
CMD ["php-fpm"]
