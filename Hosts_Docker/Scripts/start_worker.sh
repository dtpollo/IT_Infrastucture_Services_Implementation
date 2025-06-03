#!/bin/bash

# Generate SSH key if it doesn't exist
mkdir -p ~/.ssh
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -q -N ''
fi

# Set correct permissions for the SSH folder and keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

# Copy the public key to the server to enable passwordless SSH
sshpass -p 'sshp' ssh -o StrictHostKeyChecking=no admin@192.168.40.4 \
"mkdir -p ~/.ssh && echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys && chown -R admin:admin ~/.ssh"

echo "Key Copied!"

# Keep the terminal open
exec bash

