FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only required tools for DHCP
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    iproute2 iputils-ping net-tools \
    isc-dhcp-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create admin user (optional)
RUN useradd -m -s /bin/bash admin && echo "admin:dhcpp" | chpasswd && adduser admin sudo

# Set network interface for DHCP
RUN echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

# Copy DHCP config file
COPY dhcpd.conf /etc/dhcp/dhcpd.conf

# Expose DHCP port
EXPOSE 67/udp

# Start DHCP and open terminal
CMD service isc-dhcp-server start && bash

