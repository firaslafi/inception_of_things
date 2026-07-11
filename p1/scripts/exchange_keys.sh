#!/bin/bash
set -e

# Generate SSH keys for both the server and worker nodes if they don't already exist
SERVER_KEY=$(vagrant ssh server -c "cat ~/.ssh/id_ed25519.pub" | tr -d '\r')
WORKER_KEY=$(vagrant ssh worker -c "cat ~/.ssh/id_ed25519.pub" | tr -d '\r')

# Add the server's public key to the worker's authorized_keys and vice versa
vagrant ssh server -c "echo '$WORKER_KEY' >> ~/.ssh/authorized_keys"

vagrant ssh worker -c "echo '$SERVER_KEY' >> ~/.ssh/authorized_keys"

echo "SSH keys exchanged successfully."