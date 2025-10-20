#!/bin/bash

# apache-setup.sh
# Bash script to automate Apache + Certbot setup on Amazon Linux 2
# Make sure to run as root or with sudo

# Exit immediately if a command exits with a non-zero status
set -e

echo "🔧 Updating system packages..."
sudo yum update -y

echo "🌐 Installing Apache (httpd)..."
sudo yum install -y httpd

echo "🚀 Starting and enabling Apache..."
sudo systemctl start httpd
sudo systemctl enable httpd

echo "🔐 Installing Certbot and mod_ssl..."
# Enable EPEL repo for Amazon Linux 2
sudo amazon-linux-extras enable epel -y
sudo yum install -y epel-release
sudo yum install -y certbot python2-certbot-apache mod_ssl

# Prompt user for domain
read -p "🌍 Enter your domain name (e.g., example.com): " DOMAIN

# Prompt user for email (for Let's Encrypt registration)
read -p "📧 Enter your email for SSL certificate registration: " EMAIL

echo "🧪 Running Certbot to obtain and install SSL certificate..."
sudo certbot --apache -d "$DOMAIN" --non-interactive --agree-tos -m "$EMAIL" --redirect

echo "⏰ Setting up daily Certbot renewal cron job..."
# This is handled automatically by Certbot on most systems,
# but we can ensure it with a cron job
(crontab -l 2>/dev/null; echo "0 3 * * * /usr/bin/certbot renew --quiet") | crontab -

echo "✅ Apache and SSL setup complete!"
echo "🌐 Visit https://moodtracker.khalidhashim.com/ to verify your secure website."
