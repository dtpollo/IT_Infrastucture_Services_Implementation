FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install SSH and basic tools
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo iputils-ping net-tools \
    sshpass \
    nano vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create 'admin' user with sudo access
RUN useradd -m -s /bin/bash admin && echo "admin:sshp" | chpasswd && adduser admin sudo

# Replace default SSH config (enables only public key auth)
COPY sshd_config /etc/ssh/sshd_config

# Copy README file to admin’s home
COPY README.txt /home/admin/README.txt
RUN chown admin:admin /home/admin/README.txt && chmod 640 /home/admin/README.txt

# Copy SSH start script
COPY start_ssh_server.sh /start_ssh_server.sh
RUN chmod +x /start_ssh_server.sh

# Expose SSH port
EXPOSE 22

# Run SSH server
CMD ["/start_ssh_server.sh"]

