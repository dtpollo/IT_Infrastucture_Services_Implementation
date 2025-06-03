FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, SSH, and basic tools
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	apache2 \
	curl wget nano vim sudo \
	iputils-ping net-tools netcat \
	nmap dnsutils iptables \
	lsof unzip

# Create admin user with sudo
RUN useradd -m -s /bin/bash admin && echo "admin:webp" | chpasswd && adduser admin sudo

# Copy the website files to the Apache web root
COPY ./web_page/index.html /var/www/html/index.html
COPY ./web_page/style.css /var/www/html/style.css

# Set correct permissions for the web folder
RUN chmod -R 755 /var/www/html

# Copy startup script for the web server
COPY start_web_server.sh /start_web_server.sh
RUN chmod +x /start_web_server.sh

# Expose HTTP port
EXPOSE 80

# Start Apache (and any other services from the script)
CMD ["/start_web_server.sh"]



