#!/bin/bash

# --------------------------------------------
# Automated setup for Nginx with SSL on Kali
# Created by Valerii Bykovskii
# Note: Replace SSL certificate fields below with your own data before running!
# --------------------------------------------

# Step 1: Install nginx and openssl
sudo apt update
sudo apt install nginx openssl -y

# Step 2: Generate self-signed SSL certificate
# ⚠️ Edit fields: Country, State, City, Org, Email if needed
sudo openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/C=KG/ST=Chuy/L=Bishkek/O=ValeriiCorp/CN=valerii.local/emailAddress=val@val.local"

# Step 3: Create a custom HTML page
echo "<!DOCTYPE html>
<html>
  <head><title>Valerii Nginx Server</title></head>
  <body>
    <h1>It works, powered by Valerii Bykovskii</h1>
  </body>
</html>" | sudo tee /var/www/html/index.html > /dev/null

# Step 4: Configure Nginx to use SSL
NGINX_CONF="/etc/nginx/sites-available/valerii_ssl"
sudo tee "$NGINX_CONF" > /dev/null <<EOF
server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate     /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Step 5: Enable the config and disable default
sudo ln -s "$NGINX_CONF" /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default

# Step 6: Test and reload Nginx
sudo nginx -t && sudo systemctl reload nginx

echo "Nginx with SSL is now running. Visit https://127.0.0.1"
