#!/bin/bash

set -e

sudo -u vagrant mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh

# Generate SSH keys for the vagrant user if they don't already exist
if [ ! -f /home/vagrant/.ssh/id_ed25519 ]; then
    sudo -u vagrant ssh-keygen \
        -t ed25519 \
        -N "" \
        -f /home/vagrant/.ssh/id_ed25519
fi