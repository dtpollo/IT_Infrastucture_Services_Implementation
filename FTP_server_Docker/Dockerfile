FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only required tools for FTP
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    vsftpd \
    curl wget nano vim sudo \
    iputils-ping net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create admin user with sudo
RUN useradd -m -s /bin/bash admin && echo "admin:ftpp" | chpasswd && adduser admin sudo

# Create FTP groups
RUN groupadd ftp_read && \
    groupadd ftp_write && \
    groupadd ftp_admin && \
    echo "/sbin/nologin" >> /etc/shells

# Create users, assign them to groups, and restrict shell access
RUN useradd -m -d /home/ftpuser1 -s /sbin/nologin -g ftp_read ftpuser1 && \
    useradd -m -d /home/ftpuser2 -s /sbin/nologin -g ftp_write ftpuser2 && \
    useradd -m -d /home/ftpuser3 -s /sbin/nologin -g ftp_admin ftpuser3 && \
    echo "ftpuser1:user1p" | chpasswd && \
    echo "ftpuser2:user2p" | chpasswd && \
    echo "ftpuser3:user3p" | chpasswd


# Create anonymous access folder
RUN mkdir -p /home/externalusers && \
    chmod 755 /home/externalusers && \
    chown root:root /home/externalusers


# Create directories for each group
RUN mkdir -p /srv/ftp_read /srv/ftp_write /srv/ftp_admin && \
    chown ftpuser1:ftp_read /srv/ftp_read && chmod 755 /srv/ftp_read && \
    chown ftpuser2:ftp_write /srv/ftp_write && chmod 755 /srv/ftp_write && \
    chown ftpuser3:ftp_admin /srv/ftp_admin && chmod 755 /srv/ftp_admin

# Copy vsftpd config files
COPY vsftpd.conf /etc/vsftpd.conf
COPY vsftpd.userlist /etc/vsftpd.userlist

# Copy README file to each user home
COPY README.txt /home/ftpuser1/
COPY README.txt /home/ftpuser2/
COPY README.txt /home/ftpuser3/
COPY README.txt /home/externalusers/

# ==> Set permissions <===
# ftpuser1: read-only
RUN chown root:ftp_read /home/ftpuser1 && \
    chmod 750 /home/ftpuser1
# ftpuser2: read/write
RUN chown ftpuser2:ftp_write /home/ftpuser2 && \
    chmod 770 /home/ftpuser2
# ftpuser3: full control
RUN chown ftpuser3:ftp_admin /home/ftpuser3 && \
    chmod 770 /home/ftpuser3

# Set file permissions per user/group
RUN chown ftpuser1:ftp_read /home/ftpuser1/README.txt && chmod 640 /home/ftpuser1/README.txt && \
    chown ftpuser2:ftp_write /home/ftpuser2/README.txt && chmod 660 /home/ftpuser2/README.txt && \
    chown ftpuser3:ftp_admin /home/ftpuser3/README.txt && chmod 770 /home/ftpuser3/README.txt

# Copy startup script
COPY start_server.sh /start_server.sh
RUN chmod +x /start_server.sh 

# Expose FTP ports
EXPOSE 20 21

# Start FTP service
CMD ["/start_server.sh"]

