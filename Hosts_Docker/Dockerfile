FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools: networking, terminal browser, Python, MySQL client, SSH, FTP
RUN apt-get update && apt-get install -y \
    curl wget nano vim sudo ftp lftp \
    iproute2 iputils-ping net-tools netcat \
    nmap dnsutils iptables lsof unzip \
    python3 python3-pip lynx \
    openssh-server \
    mysql-client sshpass \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create 'worker' user with sudo
RUN useradd -m -s /bin/bash worker && echo "worker:workerp" | chpasswd && adduser worker sudo

# Copy scripts to user's home
COPY Scripts/start_worker.sh /home/worker/start_worker.sh
COPY Scripts/FTP_access.sh /home/worker/FTP_access.sh
COPY Scripts/Important_Tool.sh /home/worker/Important_Tool.sh

# Make scripts executable
RUN chmod +x /home/worker/start_worker.sh && \
    chmod +x /home/worker/FTP_access.sh && \
    chmod +x /home/worker/Important_Tool.sh

# Switch to the worker user on container start
CMD ["su", "-", "worker"]

