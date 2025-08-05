# Use long-term supported Ubuntu base
FROM ubuntu:22.04

# Disable interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

# Install PHP 7.4 and dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    curl \
    tzdata \
 && add-apt-repository ppa:ondrej/php -y \
 && apt-get update && apt-get install -y \
    apache2 \
    mysql-client \
    php7.4 \
    php7.4-cli \
    php7.4-common \
    php7.4-mysql \
    php7.4-xml \
    php7.4-curl \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-bcmath \
    libapache2-mod-php7.4 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Enable Apache modules
RUN a2enmod rewrite

# Copy application files
COPY Employee-Management/ /var/www/html/

# Copy Apache config
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Set permissions (secure but accessible)
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set working directory
WORKDIR /var/www/html

# Expose web port
EXPOSE 80

# Start Apache in foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
